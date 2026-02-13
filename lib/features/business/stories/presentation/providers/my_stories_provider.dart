import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/stories/data/story_management_repository.dart';
import 'package:honak/features/business/stories/domain/entities/my_story.dart';
import 'package:honak/features/business/stories/domain/entities/story_stats.dart';

final myStoriesProvider =
    AsyncNotifierProvider<MyStoriesNotifier, List<MyStory>>(
  MyStoriesNotifier.new,
);

class MyStoriesNotifier extends AsyncNotifier<List<MyStory>> {
  @override
  Future<List<MyStory>> build() async {
    final repo = ref.read(storyManagementRepositoryProvider);
    return repo.getMyStories();
  }

  /// Add a newly created story to the top of the list.
  void addStory(MyStory story) {
    final current = state.valueOrNull ?? [];
    state = AsyncData([story, ...current]);
  }

  /// Remove a story by ID.
  void deleteStory(String id) {
    final current = state.valueOrNull ?? [];
    state = AsyncData(current.where((s) => s.id != id).toList());
  }

  /// Move a scheduled story to live immediately.
  void publishNow(String id) {
    final current = state.valueOrNull ?? [];
    final idx = current.indexWhere((s) => s.id == id);
    if (idx == -1) return;
    final now = DateTime.now();
    final updated = current[idx].copyWith(
      status: 'live',
      scheduledAt: null,
      createdAt: now.toIso8601String(),
      expiresAt: now.add(const Duration(hours: 24)).toIso8601String(),
    );
    state = AsyncData([
      for (int i = 0; i < current.length; i++)
        if (i == idx) updated else current[i],
    ]);
  }

  /// Mark a story as updated (mock — in real backend this would PATCH).
  void updateStory(String id) {
    // In mock mode, just trigger a rebuild so the UI refreshes.
    // The actual content changes live in storyCreatorProvider state.
    final current = state.valueOrNull ?? [];
    state = AsyncData([...current]);
  }

  /// Re-publish an expired story (as live or scheduled).
  void republishStory(
    String id, {
    required String audience,
    DateTime? scheduledAt,
  }) {
    final current = state.valueOrNull ?? [];
    final idx = current.indexWhere((s) => s.id == id);
    if (idx == -1) return;
    final now = DateTime.now();
    final updated = current[idx].copyWith(
      status: scheduledAt != null ? 'scheduled' : 'live',
      audience: audience,
      createdAt: now.toIso8601String(),
      expiresAt: scheduledAt == null
          ? now.add(const Duration(hours: 24)).toIso8601String()
          : null,
      scheduledAt: scheduledAt?.toIso8601String(),
      stats: const StoryStats(),
    );
    state = AsyncData([
      for (int i = 0; i < current.length; i++)
        if (i == idx) updated else current[i],
    ]);
  }
}

final aggregateStatsProvider =
    FutureProvider<Map<String, dynamic>>((ref) async {
  final repo = ref.read(storyManagementRepositoryProvider);
  return repo.getAggregateStats();
});
