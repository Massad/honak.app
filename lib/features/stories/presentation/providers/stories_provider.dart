import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/stories/data/stories_repository.dart';
import 'package:honak/features/stories/domain/entities/story_content.dart';

final storyContentProvider = FutureProvider<List<StoryContent>>((ref) async {
  final repo = ref.read(storiesRepositoryProvider);
  return repo.getViewerContent();
});

class StoriesViewerState {
  final int businessIndex;
  final int slideIndex;
  final bool isPaused;
  final Set<String> seenStoryIds;

  const StoriesViewerState({
    this.businessIndex = 0,
    this.slideIndex = 0,
    this.isPaused = false,
    this.seenStoryIds = const {},
  });

  StoriesViewerState copyWith({
    int? businessIndex,
    int? slideIndex,
    bool? isPaused,
    Set<String>? seenStoryIds,
  }) {
    return StoriesViewerState(
      businessIndex: businessIndex ?? this.businessIndex,
      slideIndex: slideIndex ?? this.slideIndex,
      isPaused: isPaused ?? this.isPaused,
      seenStoryIds: seenStoryIds ?? this.seenStoryIds,
    );
  }
}

final storiesViewerProvider =
    NotifierProvider<StoriesViewerNotifier, StoriesViewerState>(
  StoriesViewerNotifier.new,
);

class StoriesViewerNotifier extends Notifier<StoriesViewerState> {
  @override
  StoriesViewerState build() => const StoriesViewerState();

  void setBusinessIndex(int index) {
    state = state.copyWith(businessIndex: index, slideIndex: 0);
  }

  void setSlideIndex(int index) {
    state = state.copyWith(slideIndex: index);
  }

  void nextSlide(int maxSlides) {
    if (state.slideIndex < maxSlides - 1) {
      state = state.copyWith(slideIndex: state.slideIndex + 1);
    }
  }

  void previousSlide() {
    if (state.slideIndex > 0) {
      state = state.copyWith(slideIndex: state.slideIndex - 1);
    }
  }

  void pause() {
    state = state.copyWith(isPaused: true);
  }

  void resume() {
    state = state.copyWith(isPaused: false);
  }

  void markSeen(String storyId) {
    state = state.copyWith(
      seenStoryIds: {...state.seenStoryIds, storyId},
    );
  }

  void reset() {
    state = const StoriesViewerState();
  }
}
