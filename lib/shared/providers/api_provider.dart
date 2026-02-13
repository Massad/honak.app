import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/config/env.dart';
import 'package:honak/shared/api/api_client.dart';
import 'package:honak/shared/api/dio_api_client.dart';
import 'package:honak/shared/api/mock_api_client.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  final env = ref.read(envConfigProvider);
  return switch (env.apiMode) {
    ApiMode.mock => MockApiClient(),
    ApiMode.dev => DioApiClient(baseUrl: env.apiBaseUrl),
    ApiMode.prod => DioApiClient(baseUrl: env.apiBaseUrl),
  };
});
