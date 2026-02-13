import 'package:honak/shared/entities/paginated_list.dart';

mixin PaginationMixin<T> {
  PaginatedList<T> _paginatedList = const PaginatedList.empty();
  bool _isLoadingMore = false;

  PaginatedList<T> get paginatedList => _paginatedList;
  List<T> get items => _paginatedList.items;
  bool get hasMore => _paginatedList.hasMore;
  bool get isLoadingMore => _isLoadingMore;
  String? get nextCursor => _paginatedList.nextCursor;

  void resetPagination() {
    _paginatedList = const PaginatedList.empty();
    _isLoadingMore = false;
  }

  void setPaginatedList(PaginatedList<T> list, {bool append = false}) {
    if (append) {
      _paginatedList = _paginatedList.copyWithAppended(list);
    } else {
      _paginatedList = list;
    }
    _isLoadingMore = false;
  }

  void setLoadingMore(bool loading) {
    _isLoadingMore = loading;
  }
}
