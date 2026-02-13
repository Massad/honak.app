import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/shared/providers/api_provider.dart';

class FollowNotifier extends StateNotifier<bool> {
  final Ref _ref;
  final String _pageId;

  FollowNotifier(this._ref, this._pageId, bool initial) : super(initial);

  Future<void> toggle() async {
    final wasFollowing = state;
    // Optimistic update
    state = !wasFollowing;

    try {
      final api = _ref.read(apiClientProvider);
      final path = wasFollowing
          ? '/v1/pages/$_pageId/unfollow'
          : '/v1/pages/$_pageId/follow';
      await api.post(path);
    } catch (_) {
      // Revert on failure
      state = wasFollowing;
    }
  }
}

final followProvider =
    StateNotifierProvider.family<FollowNotifier, bool, ({String pageId, bool isFollowing})>(
  (ref, params) {
    return FollowNotifier(ref, params.pageId, params.isFollowing);
  },
);
