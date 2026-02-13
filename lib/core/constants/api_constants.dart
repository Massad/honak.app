abstract final class ApiConstants {
  static const String apiVersion = 'v1';
  static const String basePath = '/$apiVersion';
  static const String adminBasePath = '/admin';

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 15);

  static const String contentTypeJson = 'application/json';
  static const String contentTypeMultipart = 'multipart/form-data';

  static const String authorizationHeader = 'Authorization';
  static const String bearerPrefix = 'Bearer';
  static const String acceptLanguageHeader = 'Accept-Language';
}
