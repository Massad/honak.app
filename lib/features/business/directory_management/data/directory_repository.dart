import 'package:honak/features/business/directory_management/domain/entities/directory_manage_data.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant.dart';
import 'package:honak/shared/api/api_client.dart';

class DirectoryRepository {
  final ApiClient _api;

  DirectoryRepository(this._api);

  Future<DirectoryManageData> getDirectoryManageData(String pageId) async {
    final response = await _api.get<DirectoryManageData>(
      '/v1/biz/pages/$pageId/directory',
      fromJson: (json) =>
          DirectoryManageData.fromJson(json as Map<String, dynamic>),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to load directory data');
  }

  Future<Tenant> addTenant(String pageId, Map<String, dynamic> data) async {
    final response = await _api.post<Tenant>(
      '/v1/biz/pages/$pageId/directory/tenants',
      body: data,
      fromJson: (json) => Tenant.fromJson(json as Map<String, dynamic>),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to add tenant');
  }

  Future<Tenant> updateTenant(
    String pageId,
    String tenantId,
    Map<String, dynamic> data,
  ) async {
    final response = await _api.patch<Tenant>(
      '/v1/biz/pages/$pageId/directory/tenants/$tenantId',
      body: data,
      fromJson: (json) => Tenant.fromJson(json as Map<String, dynamic>),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to update tenant');
  }

  Future<void> deleteTenant(String pageId, String tenantId) async {
    await _api.delete('/v1/biz/pages/$pageId/directory/tenants/$tenantId');
  }

  Future<void> sendInvite(
    String pageId,
    String tenantId,
    String targetPageId,
  ) async {
    await _api.post(
      '/v1/biz/pages/$pageId/directory/tenants/$tenantId/invite',
      body: {'target_page_id': targetPageId},
    );
  }

  Future<void> unlinkTenant(String pageId, String tenantId) async {
    await _api
        .delete('/v1/biz/pages/$pageId/directory/tenants/$tenantId/link');
  }

  Future<void> updateFloors(
    String pageId,
    List<Map<String, dynamic>> floors,
  ) async {
    await _api.patch(
      '/v1/biz/pages/$pageId/directory/floors',
      body: {'floors': floors},
    );
  }

  Future<void> updateCategories(
    String pageId,
    List<String> categories,
  ) async {
    await _api.patch(
      '/v1/biz/pages/$pageId/directory/categories',
      body: {'categories': categories},
    );
  }

  Future<void> updateAmenities(
    String pageId,
    List<String> amenities,
  ) async {
    await _api.patch(
      '/v1/biz/pages/$pageId/directory/amenities',
      body: {'amenities': amenities},
    );
  }

  Future<void> updateFeatured(
    String pageId,
    List<String> tenantIds,
  ) async {
    await _api.patch(
      '/v1/biz/pages/$pageId/directory/featured',
      body: {'tenant_ids': tenantIds},
    );
  }
}
