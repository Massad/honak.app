import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/explore/domain/entities/page_summary.dart';
import 'package:honak/features/home/data/repository/feed_repository.dart';
import 'package:honak/features/home/domain/entities/feed_item.dart';
import 'package:honak/features/home/domain/entities/nearby_page.dart';
import 'package:honak/features/home/domain/entities/post.dart';
import 'package:honak/features/home/domain/entities/story.dart';
import 'package:honak/shared/providers/api_provider.dart';

final feedRepositoryProvider = Provider<FeedRepository>((ref) {
  return FeedRepository(ref.read(apiClientProvider));
});

final feedPostsProvider = FutureProvider<List<Post>>((ref) async {
  final repo = ref.read(feedRepositoryProvider);
  return repo.getFeed();
});

final storiesProvider = FutureProvider<List<Story>>((ref) async {
  final repo = ref.read(feedRepositoryProvider);
  return repo.getStories();
});

final suggestedPagesProvider = FutureProvider<List<PageSummary>>((ref) async {
  final repo = ref.read(feedRepositoryProvider);
  return repo.getSuggestedPages();
});

final nearbyPagesProvider = FutureProvider<List<NearbyPage>>((ref) async {
  final repo = ref.read(feedRepositoryProvider);
  return repo.getNearbyPages();
});

final feedItemsProvider = FutureProvider<List<FeedItem>>((ref) async {
  final posts = await ref.watch(feedPostsProvider.future);
  final nearby = await ref.watch(nearbyPagesProvider.future);

  final items = <FeedItem>[];
  for (int i = 0; i < posts.length; i++) {
    items.add(FeedPost(posts[i]));
    if (i == 5 && nearby.isNotEmpty) {
      items.add(FeedNearYou(nearby));
    }
  }
  return items;
});
