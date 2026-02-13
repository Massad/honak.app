import 'package:flutter_riverpod/flutter_riverpod.dart';

final envConfigProvider = Provider<EnvConfig>((ref) => EnvConfig.mock);

enum Environment { mock, dev, prod }

enum ApiMode { mock, dev, prod }

class EnvConfig {
  final Environment environment;
  final ApiMode apiMode;
  final String apiBaseUrl;
  final bool enableAnalytics;
  final bool enableCrashReporting;

  const EnvConfig({
    required this.environment,
    required this.apiMode,
    required this.apiBaseUrl,
    required this.enableAnalytics,
    required this.enableCrashReporting,
  });

  bool get isMock => environment == Environment.mock;
  bool get isDev => environment == Environment.dev;
  bool get isProd => environment == Environment.prod;

  bool get useMockApi => apiMode == ApiMode.mock;

  static const mock = EnvConfig(
    environment: Environment.mock,
    apiMode: ApiMode.mock,
    apiBaseUrl: '',
    enableAnalytics: false,
    enableCrashReporting: false,
  );

  static const dev = EnvConfig(
    environment: Environment.dev,
    apiMode: ApiMode.dev,
    apiBaseUrl: 'https://dev-api.honak.app',
    enableAnalytics: false,
    enableCrashReporting: false,
  );

  static const prod = EnvConfig(
    environment: Environment.prod,
    apiMode: ApiMode.prod,
    apiBaseUrl: 'https://api.honak.app',
    enableAnalytics: true,
    enableCrashReporting: true,
  );
}
