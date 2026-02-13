class PaginatedList<T> {
  final List<T> items;
  final int total;
  final String? nextCursor;
  final bool hasMore;

  const PaginatedList({
    required this.items,
    required this.total,
    this.nextCursor,
    required this.hasMore,
  });

  const PaginatedList.empty()
      : items = const [],
        total = 0,
        nextCursor = null,
        hasMore = false;

  PaginatedList<T> copyWithAppended(PaginatedList<T> next) {
    return PaginatedList<T>(
      items: [...items, ...next.items],
      total: next.total,
      nextCursor: next.nextCursor,
      hasMore: next.hasMore,
    );
  }
}
