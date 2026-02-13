import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreFilterState {
  final String? category;
  final double? maxDistanceKm;
  final double? minRating;
  final ExploreSortBy sortBy;

  const ExploreFilterState({
    this.category,
    this.maxDistanceKm,
    this.minRating,
    this.sortBy = ExploreSortBy.popular,
  });

  int get activeCount {
    int count = 0;
    if (category != null) count++;
    if (maxDistanceKm != null) count++;
    if (minRating != null) count++;
    if (sortBy != ExploreSortBy.popular) count++;
    return count;
  }

  bool get hasActiveFilters => activeCount > 0;

  ExploreFilterState copyWith({
    String? category,
    double? maxDistanceKm,
    double? minRating,
    ExploreSortBy? sortBy,
    bool clearCategory = false,
    bool clearDistance = false,
    bool clearRating = false,
  }) {
    return ExploreFilterState(
      category: clearCategory ? null : (category ?? this.category),
      maxDistanceKm:
          clearDistance ? null : (maxDistanceKm ?? this.maxDistanceKm),
      minRating: clearRating ? null : (minRating ?? this.minRating),
      sortBy: sortBy ?? this.sortBy,
    );
  }

  static const empty = ExploreFilterState();
}

enum ExploreSortBy { popular, nearest, highestRated }

class ExploreFilterNotifier extends Notifier<ExploreFilterState> {
  @override
  ExploreFilterState build() => ExploreFilterState.empty;

  void update(ExploreFilterState newState) => state = newState;

  void reset() => state = ExploreFilterState.empty;
}

final exploreFilterProvider =
    NotifierProvider<ExploreFilterNotifier, ExploreFilterState>(
  ExploreFilterNotifier.new,
);
