import 'package:honak/features/explore/domain/entities/page_summary.dart';
import 'package:honak/features/home/domain/entities/nearby_page.dart';
import 'package:honak/features/home/domain/entities/post.dart';
import 'package:honak/features/home/domain/entities/story.dart';
import 'package:honak/shared/api/api_client.dart';

class FeedRepository {
  final ApiClient _api;

  FeedRepository(this._api);

  Future<List<Post>> getFeed() async {
    final response = await _api.get<List<Post>>(
      '/v1/feed',
      fromJson: (json) => (json as List)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to load feed');
  }

  Future<List<Story>> getStories() async {
    final response = await _api.get<List<Story>>(
      '/v1/feed/stories',
      fromJson: (json) => (json as List)
          .map((e) => Story.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to load stories');
  }

  Future<List<PageSummary>> getSuggestedPages() async {
    final response = await _api.get<List<PageSummary>>(
      '/v1/feed/suggested',
      fromJson: (json) => (json as List)
          .map((e) => PageSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to load suggestions');
  }

  Future<List<NearbyPage>> getNearbyPages() async {
    final response = await _api.get<List<NearbyPage>>(
      '/v1/feed/nearby',
      fromJson: (json) => (json as List)
          .map((e) => NearbyPage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to load nearby pages');
  }
}
