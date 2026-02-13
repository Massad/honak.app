import 'package:honak/features/explore/domain/entities/page_summary.dart';
import 'package:honak/features/home/domain/entities/nearby_page.dart';
import 'package:honak/features/home/domain/entities/post.dart';

sealed class FeedItem {
  const FeedItem();
}

class FeedPost extends FeedItem {
  final Post post;
  const FeedPost(this.post);
}

class FeedSuggestedPages extends FeedItem {
  final List<PageSummary> pages;
  const FeedSuggestedPages(this.pages);
}

class FeedNearYou extends FeedItem {
  final List<NearbyPage> pages;
  const FeedNearYou(this.pages);
}
