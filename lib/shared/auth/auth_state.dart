import 'package:honak/shared/entities/user.dart';

sealed class AuthState {
  const AuthState();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class Authenticated extends AuthState {
  final User user;
  final String accessToken;

  const Authenticated({required this.user, required this.accessToken});
}

class AuthGuest extends AuthState {
  const AuthGuest();
}

class Unauthenticated extends AuthState {
  final String? reason;

  const Unauthenticated({this.reason});
}
