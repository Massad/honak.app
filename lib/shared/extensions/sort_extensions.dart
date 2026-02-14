extension SortByOrder<T> on List<T> {
  /// Sorts in-place by sortOrder ascending (lowest first).
  void sortByOrder(int Function(T) orderOf) {
    sort((a, b) => orderOf(a).compareTo(orderOf(b)));
  }

  /// Returns a new sorted list by sortOrder ascending.
  List<T> sortedByOrder(int Function(T) orderOf) {
    return [...this]..sortByOrder(orderOf);
  }
}
