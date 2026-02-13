import 'package:dio/dio.dart';

import 'package:honak/shared/api/api_client.dart';
import 'package:honak/shared/api/api_error.dart';
import 'package:honak/shared/api/api_exception.dart';
import 'package:honak/shared/api/api_response.dart';

class DioApiClient implements ApiClient {
  final Dio _dio;

  DioApiClient({required String baseUrl})
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 15),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));

  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  @override
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParams,
    T Function(dynamic json)? fromJson,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParams,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  @override
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic body,
    T Function(dynamic json)? fromJson,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        path,
        data: body,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  @override
  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic body,
    T Function(dynamic json)? fromJson,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        path,
        data: body,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  @override
  Future<ApiResponse<T>> patch<T>(
    String path, {
    dynamic body,
    T Function(dynamic json)? fromJson,
  }) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        path,
        data: body,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  @override
  Future<ApiResponse<void>> delete(String path) async {
    try {
      await _dio.delete<Map<String, dynamic>>(path);
      return const ApiResponse<void>();
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  ApiResponse<T> _handleResponse<T>(
    Response<Map<String, dynamic>> response,
    T Function(dynamic json)? fromJson,
  ) {
    final json = response.data;
    if (json == null) {
      return const ApiResponse();
    }

    return ApiResponse.fromJson(json, fromJson);
  }

  ApiException _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();
      case DioExceptionType.connectionError:
        return const NetworkException();
      case DioExceptionType.badResponse:
        return _mapStatusCode(e);
      case DioExceptionType.cancel:
        return const UnknownException('Request cancelled');
      case DioExceptionType.badCertificate:
        return const NetworkException('Certificate verification failed');
      case DioExceptionType.unknown:
        return UnknownException(
          e.message ?? 'An unexpected error occurred',
          e.error,
        );
    }
  }

  ApiException _mapStatusCode(DioException e) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;

    ApiError? apiError;
    if (data is Map<String, dynamic> && data.containsKey('error')) {
      apiError = ApiError.fromJson(data['error'] as Map<String, dynamic>);
    }

    final message = apiError?.message ?? e.message ?? 'Request failed';

    if (statusCode == 401) {
      return UnauthorizedException(message);
    } else if (statusCode == 404) {
      return NotFoundException(message);
    } else if (statusCode == 422) {
      return ValidationException(
        message: message,
        errors: apiError?.details ?? const [],
      );
    } else if (statusCode == 429) {
      return RateLimitException(
        message: message,
        retryAfter: apiError?.retryAfter,
      );
    } else if (statusCode != null && statusCode >= 500) {
      return ServerException(message, statusCode);
    } else {
      return ServerException(message, statusCode);
    }
  }
}
