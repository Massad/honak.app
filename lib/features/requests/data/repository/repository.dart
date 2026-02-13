import 'package:honak/features/requests/domain/entities/entities.dart';
import 'package:honak/shared/api/api_client.dart';

class RequestRepository {
  final ApiClient _api;

  RequestRepository(this._api);

  Future<List<CustomerRequest>> getMyRequests({String? status}) async {
    final path = status != null
        ? '/v1/requests/$status'
        : '/v1/requests';
    final response = await _api.get<List<CustomerRequest>>(
      path,
      fromJson: (json) => (json as List)
          .map((e) => CustomerRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to load requests');
  }

  Future<CustomerRequest> getRequestDetail(String id) async {
    final response = await _api.get<CustomerRequest>(
      '/v1/requests/$id',
      fromJson: (json) =>
          CustomerRequest.fromJson(json as Map<String, dynamic>),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to load request');
  }

  Future<Map<String, dynamic>> createRequest(
    Map<String, dynamic> data,
  ) async {
    final response = await _api.post<Map<String, dynamic>>(
      '/v1/requests',
      body: data,
      fromJson: (json) => json as Map<String, dynamic>,
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to create request');
  }

  Future<void> cancelRequest(String id) async {
    await _api.post<void>('/v1/requests/$id/cancel');
  }

  Future<void> editRequest(String id, Map<String, dynamic> changes) async {
    await _api.patch<void>(
      '/v1/requests/$id',
      body: changes,
    );
  }
}
