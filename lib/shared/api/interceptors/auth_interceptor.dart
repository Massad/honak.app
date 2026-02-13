import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;
  final Dio _dio;

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _refreshPath = '/v1/auth/refresh';

  bool _isRefreshing = false;
  final List<({RequestOptions options, ErrorInterceptorHandler handler})>
      _pendingRequests = [];

  AuthInterceptor(this._storage, this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.read(key: _accessTokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    if (err.requestOptions.path == _refreshPath) {
      await _clearTokens();
      handler.next(err);
      return;
    }

    if (_isRefreshing) {
      _pendingRequests.add((options: err.requestOptions, handler: handler));
      return;
    }

    _isRefreshing = true;

    try {
      final refreshToken = await _storage.read(key: _refreshTokenKey);
      if (refreshToken == null) {
        await _clearTokens();
        handler.next(err);
        _rejectPending(err);
        return;
      }

      final response = await _dio.post<Map<String, dynamic>>(
        _refreshPath,
        data: {'refresh_token': refreshToken},
      );

      final data = response.data;
      if (data == null) {
        await _clearTokens();
        handler.next(err);
        _rejectPending(err);
        return;
      }

      final newAccessToken = data['access_token'] as String?;
      final newRefreshToken = data['refresh_token'] as String?;

      if (newAccessToken == null) {
        await _clearTokens();
        handler.next(err);
        _rejectPending(err);
        return;
      }

      await _storage.write(key: _accessTokenKey, value: newAccessToken);
      if (newRefreshToken != null) {
        await _storage.write(key: _refreshTokenKey, value: newRefreshToken);
      }

      final retryResponse = await _retryRequest(err.requestOptions, newAccessToken);
      handler.resolve(retryResponse);
      _retryPending(newAccessToken);
    } on DioException {
      await _clearTokens();
      handler.next(err);
      _rejectPending(err);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<Response<dynamic>> _retryRequest(
    RequestOptions options,
    String token,
  ) {
    options.headers['Authorization'] = 'Bearer $token';
    return _dio.fetch(options);
  }

  void _retryPending(String token) {
    for (final pending in _pendingRequests) {
      _retryRequest(pending.options, token).then(
        pending.handler.resolve,
        onError: (Object e) {
          if (e is DioException) {
            pending.handler.next(e);
          }
        },
      );
    }
    _pendingRequests.clear();
  }

  void _rejectPending(DioException err) {
    for (final pending in _pendingRequests) {
      pending.handler.next(err);
    }
    _pendingRequests.clear();
  }

  Future<void> _clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
}
