import 'package:honak/shared/api/api_client.dart';

class DashboardRepository {
  final ApiClient _api;

  DashboardRepository(this._api);

  Future<Map<String, dynamic>> getDashboardStats(String pageId) async {
    final response = await _api.get<Map<String, dynamic>>(
      '/v1/biz/pages/$pageId/dashboard',
    );
    return response.data ?? {};
  }
}
