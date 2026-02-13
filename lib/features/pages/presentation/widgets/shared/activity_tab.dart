import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/features/pages/presentation/providers/page_detail_providers.dart';
import 'package:honak/features/pages/presentation/widgets/shared/activity_post_card.dart';
import 'package:honak/shared/widgets/error_view.dart';
import 'package:honak/shared/widgets/skeleton/skeleton.dart';

/// Enhanced activity tab with custom filter chips and uniform post cards.
class ActivityTab extends ConsumerStatefulWidget {
  final String pageId;
  final String pageSlug;
  final Archetype archetype;
  final List<String> pinnedPosts;

  const ActivityTab({
    super.key,
    required this.pageId,
    required this.pageSlug,
    this.archetype = Archetype.followOnly,
    this.pinnedPosts = const [],
  });

  @override
  ConsumerState<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends ConsumerState<ActivityTab> {
  String _selectedFilter = 'all';

  List<({String id, String label})> get _filters {
    return switch (widget.archetype) {
      Archetype.catalogOrder || Archetype.menuOrder => [
          (id: 'all', label: '\u0627\u0644\u0643\u0644'),
          (id: 'product', label: '\u0645\u0646\u062a\u062c\u0627\u062a'),
          (id: 'offer', label: '\u0639\u0631\u0648\u0636'),
          (id: 'update', label: '\u062a\u062d\u062f\u064a\u062b\u0627\u062a'),
          (id: 'photo', label: '\u0635\u0648\u0631'),
        ],
      Archetype.serviceBooking => [
          (id: 'all', label: '\u0627\u0644\u0643\u0644'),
          (id: 'offer', label: '\u0639\u0631\u0648\u0636'),
          (id: 'update', label: '\u062a\u062d\u062f\u064a\u062b\u0627\u062a'),
          (id: 'photo', label: '\u0635\u0648\u0631'),
        ],
      _ => [
          (id: 'all', label: '\u0627\u0644\u0643\u0644'),
          (id: 'update', label: '\u062a\u062d\u062f\u064a\u062b\u0627\u062a'),
          (id: 'photo', label: '\u0635\u0648\u0631'),
        ],
    };
  }

  @override
  Widget build(BuildContext context) {
    final postsAsync = ref.watch(pagePostsProvider(widget.pageId));

    return postsAsync.when(
      loading: () => const SingleChildScrollView(
        child: SkeletonFeedPost(count: 3),
      ),
      error: (error, _) => ErrorView(
        message: error.toString(),
        onRetry: () => ref.invalidate(pagePostsProvider(widget.pageId)),
      ),
      data: (posts) {
        if (posts.isEmpty) return _emptyState(context);

        final filtered = _selectedFilter == 'all'
            ? posts
            : posts.where((p) => p.type == _selectedFilter).toList();

        final pinned = filtered
            .where((p) => widget.pinnedPosts.contains(p.id))
            .toList();
        final regular = filtered
            .where((p) => !widget.pinnedPosts.contains(p.id))
            .toList();

        final allPosts = [...pinned, ...regular];

        return CustomScrollView(
          slivers: [
            // Filter chips
            SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.sm,
                  ),
                  itemCount: _filters.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final filter = _filters[index];
                    final selected = _selectedFilter == filter.id;
                    return _FilterChip(
                      label: filter.label,
                      selected: selected,
                      onTap: () =>
                          setState(() => _selectedFilter = filter.id),
                    );
                  },
                ),
              ),
            ),

            // Posts with 12px spacing
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final post = allPosts[index];
                    return Padding(
                      padding: EdgeInsetsDirectional.only(
                        bottom: index < allPosts.length - 1
                            ? AppSpacing.md
                            : 0,
                      ),
                      child: ActivityPostCard(
                        post: post,
                        isPinned: widget.pinnedPosts.contains(post.id),
                        onTap: () =>
                            context.push(Routes.postPath(post.id)),
                      ),
                    );
                  },
                  childCount: allPosts.length,
                ),
              ),
            ),

            // Bottom padding
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.lg),
            ),
          ],
        );
      },
    );
  }

  Widget _emptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.article_outlined,
              size: 48,
              color: context.colorScheme.outlineVariant,
            ),
            SizedBox(height: AppSpacing.lg),
            Text(
              '\u0644\u0645 \u064a\u0646\u0634\u0631 \u0628\u0639\u062f',
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              '\u062a\u0627\u0628\u0639 \u0647\u0630\u0647 \u0627\u0644\u0635\u0641\u062d\u0629 \u0644\u062a\u0643\u0648\u0646 \u0623\u0648\u0644 \u0645\u0646 \u064a\u0639\u0644\u0645',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom pill-shaped filter chip matching Figma design.
class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(9999),
          border: selected
              ? null
              : Border.all(color: Colors.grey.shade200),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: selected ? AppColors.white : Colors.grey.shade500,
            fontWeight: selected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
