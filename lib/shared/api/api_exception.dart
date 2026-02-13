import 'package:honak/shared/api/api_error.dart';

sealed class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, {this.statusCode});

  @override
  String toString() =>
      '$runtimeType(message: $message, statusCode: $statusCode)';
}

class NetworkException extends ApiException {
  const NetworkException([super.message = 'No internet connection']);
}

class ServerException extends ApiException {
  const ServerException([
    super.message = 'Internal server error',
    int? statusCode,
  ]) : super(statusCode: statusCode ?? 500);
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException([super.message = 'Unauthorized'])
      : super(statusCode: 401);
}

class ValidationException extends ApiException {
  final List<FieldError> errors;

  const ValidationException({
    String message = 'Validation failed',
    required this.errors,
  }) : super(message, statusCode: 422);

  String? errorForField(String field) {
    for (final error in errors) {
      if (error.field == field) return error.message;
    }
    return null;
  }
}

class NotFoundException extends ApiException {
  const NotFoundException([super.message = 'Resource not found'])
      : super(statusCode: 404);
}

class TimeoutException extends ApiException {
  const TimeoutException([super.message = 'Request timed out'])
      : super(statusCode: 408);
}

class RateLimitException extends ApiException {
  final int? retryAfter;

  const RateLimitException({
    String message = 'Too many requests',
    this.retryAfter,
  }) : super(message, statusCode: 429);
}

class UnknownException extends ApiException {
  final Object? originalError;

  const UnknownException([
    super.message = 'An unexpected error occurred',
    this.originalError,
  ]);
}
