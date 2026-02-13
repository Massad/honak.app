import 'package:honak/features/business/shared/domain/entities/entities.dart';
import 'package:honak/shared/api/api_client.dart';

class RequestRepository {
  final ApiClient _api;

  RequestRepository(this._api);

  Future<List<BizRequest>> getRequests(
    String pageId, {
    String? status,
  }) async {
    final path = status != null
        ? '/v1/biz/requests/$status'
        : '/v1/biz/requests';
    final response = await _api.get<List<BizRequest>>(
      path,
      queryParams: {'page_id': pageId},
      fromJson: (json) => (json as List)
          .map((e) => BizRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to load requests');
  }

  Future<BizRequest> getRequestDetail(String requestId) async {
    final response = await _api.get<BizRequest>(
      '/v1/biz/requests/$requestId',
      fromJson: (json) => BizRequest.fromJson(json as Map<String, dynamic>),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to load request');
  }

  Future<void> acceptRequest(String requestId) async {
    await _api.post<void>('/v1/biz/requests/$requestId/accept');
  }

  Future<void> declineRequest(String requestId, String reason) async {
    await _api.post<void>(
      '/v1/biz/requests/$requestId/decline',
      body: {'reason': reason},
    );
  }

  Future<void> updateStatus(String requestId, String newStatus) async {
    await _api.patch<void>(
      '/v1/biz/requests/$requestId',
      body: {'status': newStatus},
    );
  }
}
