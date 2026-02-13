class PaginationMeta {
  final int total;
  final String? nextCursor;
  final bool hasMore;

  const PaginationMeta({
    required this.total,
    this.nextCursor,
    required this.hasMore,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      total: json['total'] as int? ?? 0,
      nextCursor: json['next_cursor'] as String?,
      hasMore: json['has_more'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'total': total,
        if (nextCursor != null) 'next_cursor': nextCursor,
        'has_more': hasMore,
      };
}

class PaginatedResponse<T> {
  final List<T> items;
  final PaginationMeta meta;

  const PaginatedResponse({
    required this.items,
    required this.meta,
  });
}

class PaginationParams {
  final String? cursor;
  final int limit;

  const PaginationParams({
    this.cursor,
    this.limit = 20,
  });

  Map<String, dynamic> toQueryParams() => {
        'limit': limit.toString(),
        if (cursor != null) 'cursor': cursor!,
      };
}
