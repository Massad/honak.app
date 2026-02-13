import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';

/// Persistent header delegate for the page detail tab bar.
///
/// Accepts a dynamic [tabs] list and a [tabController], allowing
/// the tab bar to adapt to each archetype's tab configuration.
class PageTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;
  final List<Tab> tabs;

  PageTabBarDelegate({
    required this.tabController,
    required this.tabs,
  });

  @override
  double get minExtent => 48;

  @override
  double get maxExtent => 48;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          top: BorderSide(color: Colors.grey.shade100),
        ),
      ),
      child: TabBar(
        controller: tabController,
        tabs: tabs,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant PageTabBarDelegate oldDelegate) {
    return tabController != oldDelegate.tabController ||
        tabs.length != oldDelegate.tabs.length;
  }
}
