import 'package:flutter/material.dart';
import 'package:honak/shared/widgets/loading_indicator.dart';

class InfiniteScrollList<T> extends StatefulWidget {
  final List<T> items;
  final bool hasMore;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;
  final Future<void> Function()? onRefresh;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget? separator;
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final EdgeInsets? padding;

  const InfiniteScrollList({
    super.key,
    required this.items,
    required this.hasMore,
    this.isLoadingMore = false,
    required this.onLoadMore,
    this.onRefresh,
    required this.itemBuilder,
    this.separator,
    this.emptyWidget,
    this.loadingWidget,
    this.padding,
  });

  @override
  State<InfiniteScrollList<T>> createState() => _InfiniteScrollListState<T>();
}

class _InfiniteScrollListState<T> extends State<InfiniteScrollList<T>> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final threshold = maxScroll * 0.8;

    if (currentScroll >= threshold &&
        widget.hasMore &&
        !widget.isLoadingMore) {
      widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty && !widget.isLoadingMore) {
      return widget.emptyWidget ?? const SizedBox.shrink();
    }

    Widget list = ListView.separated(
      controller: _scrollController,
      padding: widget.padding,
      itemCount: widget.items.length + (widget.isLoadingMore ? 1 : 0),
      separatorBuilder: (_, __) =>
          widget.separator ?? const SizedBox.shrink(),
      itemBuilder: (context, index) {
        if (index == widget.items.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: LoadingIndicator(),
          );
        }
        return widget.itemBuilder(context, widget.items[index], index);
      },
    );

    if (widget.onRefresh != null) {
      list = RefreshIndicator(onRefresh: widget.onRefresh!, child: list);
    }

    return list;
  }
}
