import 'package:honak/features/business/shared/domain/entities/entities.dart';
import 'package:honak/shared/api/api_client.dart';

class CatalogRepository {
  final ApiClient _api;

  CatalogRepository(this._api);

  Future<List<BizItem>> getItems(String pageId) async {
    final response = await _api.get<List<BizItem>>(
      '/v1/biz/pages/$pageId/items',
      fromJson: (json) => (json as List)
          .map((e) => BizItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to load items');
  }

  Future<List<BizCategory>> getCategories(String pageId) async {
    final response = await _api.get<List<BizCategory>>(
      '/v1/biz/pages/$pageId/categories',
      fromJson: (json) => (json as List)
          .map((e) => BizCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to load categories');
  }

  Future<BizItem> createItem(String pageId, Map<String, dynamic> data) async {
    final response = await _api.post<BizItem>(
      '/v1/biz/pages/$pageId/items',
      body: data,
      fromJson: (json) => BizItem.fromJson(json as Map<String, dynamic>),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to create item');
  }

  Future<BizItem> updateItem(
    String pageId,
    String itemId,
    Map<String, dynamic> data,
  ) async {
    final response = await _api.patch<BizItem>(
      '/v1/biz/pages/$pageId/items/$itemId',
      body: data,
      fromJson: (json) => BizItem.fromJson(json as Map<String, dynamic>),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to update item');
  }

  Future<void> deleteItem(String pageId, String itemId) async {
    await _api.delete('/v1/biz/pages/$pageId/items/$itemId');
  }
}
