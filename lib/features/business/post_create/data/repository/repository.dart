import 'package:honak/features/business/shared/domain/entities/entities.dart';
import 'package:honak/shared/api/api_client.dart';

class PostRepository {
  final ApiClient _api;

  PostRepository(this._api);

  Future<BizPost> createPost(
    String pageId,
    Map<String, dynamic> data,
  ) async {
    final response = await _api.post<BizPost>(
      '/v1/biz/pages/$pageId/posts',
      body: data,
      fromJson: (json) => BizPost.fromJson(json as Map<String, dynamic>),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to create post');
  }
}
