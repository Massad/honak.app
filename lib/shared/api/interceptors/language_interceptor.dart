import 'package:dio/dio.dart';

class LanguageInterceptor extends Interceptor {
  String _locale;

  LanguageInterceptor({String locale = 'ar'}) : _locale = locale;

  void updateLocale(String locale) => _locale = locale;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept-Language'] = _locale;
    handler.next(options);
  }
}
