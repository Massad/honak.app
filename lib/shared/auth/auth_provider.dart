import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:honak/shared/api/api_client.dart';
import 'package:honak/shared/api/api_exception.dart';
import 'package:honak/shared/auth/auth_service.dart';
import 'package:honak/shared/auth/auth_state.dart';
import 'package:honak/shared/entities/user.dart';
import 'package:honak/shared/providers/api_provider.dart';
import 'package:honak/shared/providers/app_mode_provider.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(const FlutterSecureStorage());
});

final authProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});

class AuthNotifier extends AsyncNotifier<AuthState> {
  late AuthService _authService;
  late ApiClient _apiClient;

  @override
  FutureOr<AuthState> build() async {
    _authService = ref.read(authServiceProvider);
    _apiClient = ref.read(apiClientProvider);
    return _initialize();
  }

  Future<AuthState> _initialize() async {
    // Check guest mode first
    final isGuest = await _authService.isGuestMode();
    if (isGuest) return const AuthGuest();

    final hasTokens = await _authService.hasTokens();
    if (!hasTokens) return const Unauthenticated();

    try {
      final response = await _apiClient.get<User>(
        '/v1/me',
        fromJson: (json) => User.fromJson(json as Map<String, dynamic>),
      );

      if (response.isSuccess && response.data != null) {
        final token = await _authService.getAccessToken();
        return Authenticated(user: response.data!, accessToken: token ?? '');
      }

      return const Unauthenticated(reason: 'session_expired');
    } on UnauthorizedException {
      await _authService.clearAll();
      return const Unauthenticated(reason: 'session_expired');
    } catch (_) {
      final token = await _authService.getAccessToken();
      final userId = await _authService.getUserId();
      if (token != null && userId != null) {
        return Authenticated(
          user: User(id: userId, phone: '', name: ''),
          accessToken: token,
        );
      }
      return const Unauthenticated();
    }
  }

  /// Step 1: Send OTP to phone number.
  /// Returns the request_id needed for verification.
  Future<String> sendOtp(String phone, {AppMode mode = AppMode.customer}) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/v1/auth/otp',
      body: {'phone': phone, 'mode': mode.name},
      fromJson: (json) => json as Map<String, dynamic>,
    );

    if (response.isSuccess && response.data != null) {
      return response.data!['request_id'] as String;
    }

    throw UnknownException(
      response.error?.message ?? 'Failed to send OTP',
    );
  }

  /// Step 2: Verify OTP code.
  /// On success, stores tokens and sets authenticated state.
  /// Returns the authenticated User.
  Future<User> verifyOtp(String requestId, String code) async {
    state = const AsyncValue.data(AuthLoading());

    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/v1/auth/verify',
        body: {'request_id': requestId, 'code': code},
        fromJson: (json) => json as Map<String, dynamic>,
      );

      if (response.isSuccess && response.data != null) {
        final data = response.data!;
        final accessToken = data['access_token'] as String;
        final refreshToken = data['refresh_token'] as String;
        final userJson = data['user'] as Map<String, dynamic>;
        final user = User.fromJson(userJson);

        await _authService.clearAll(); // Clear any guest mode
        await _authService.saveTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
        await _authService.saveUserId(user.id);

        state = AsyncValue.data(
          Authenticated(user: user, accessToken: accessToken),
        );

        return user;
      }

      final errorMsg = response.error?.message ?? 'Verification failed';
      state = const AsyncValue.data(Unauthenticated());
      throw UnknownException(errorMsg);
    } catch (e) {
      if (e is ApiException) rethrow;
      state = const AsyncValue.data(Unauthenticated());
      rethrow;
    }
  }

  /// Step 3: Complete profile for new users.
  Future<void> completeProfile(String name) async {
    final currentState = state.valueOrNull;
    if (currentState is! Authenticated) return;

    final response = await _apiClient.patch<User>(
      '/v1/me',
      body: {'name': name},
      fromJson: (json) => User.fromJson(json as Map<String, dynamic>),
    );

    if (response.isSuccess && response.data != null) {
      state = AsyncValue.data(
        Authenticated(
          user: response.data!,
          accessToken: currentState.accessToken,
        ),
      );
    }
  }

  /// Browse as guest without logging in.
  Future<void> browseAsGuest() async {
    await _authService.setGuestMode(true);
    state = const AsyncValue.data(AuthGuest());
  }

  Future<void> logout() async {
    await ref.read(appModeProvider.notifier).reset();
    await _authService.clearAll();
    state = const AsyncValue.data(Unauthenticated());
  }

  Future<void> refreshUser() async {
    try {
      final response = await _apiClient.get<User>(
        '/v1/me',
        fromJson: (json) => User.fromJson(json as Map<String, dynamic>),
      );

      if (response.isSuccess && response.data != null) {
        final currentState = state.valueOrNull;
        if (currentState is Authenticated) {
          state = AsyncValue.data(
            Authenticated(
              user: response.data!,
              accessToken: currentState.accessToken,
            ),
          );
        }
      }
    } catch (_) {
      // Silently fail — keep current state
    }
  }

  bool get isGuest => state.valueOrNull is AuthGuest;
  bool get isAuthenticated => state.valueOrNull is Authenticated;

  User? get currentUser {
    final s = state.valueOrNull;
    return s is Authenticated ? s.user : null;
  }
}

/// Convenience provider for checking if the current user needs profile setup.
final needsProfileSetupProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider).valueOrNull;
  if (authState is Authenticated) {
    return authState.user.needsProfileSetup || authState.user.name.isEmpty;
  }
  return false;
});
