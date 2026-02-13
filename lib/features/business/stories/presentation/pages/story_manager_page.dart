import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/stories/domain/entities/my_story.dart';
import 'package:honak/features/business/stories/presentation/pages/story_creator_page.dart';
import 'package:honak/features/business/stories/presentation/providers/my_stories_provider.dart';
import 'package:honak/features/business/stories/presentation/widgets/publish_options_sheet.dart';
import 'package:honak/features/business/stories/presentation/widgets/story_list_item.dart';
import 'package:honak/features/business/stories/presentation/widgets/story_preview_strip.dart';
import 'package:honak/features/business/stories/presentation/widgets/story_stats_card.dart';
import 'package:honak/shared/widgets/empty_state.dart';
import 'package:honak/shared/widgets/error_view.dart';
import 'package:honak/shared/widgets/shimmer_loading.dart';

/// Story management dashboard for business owners.
/// Layout matches Figma: stats → status summary → preview strip →
/// search → count + sort bar → story list.
class StoryManagerPage extends ConsumerStatefulWidget {
  const StoryManagerPage({super.key});

  @override
  ConsumerState<StoryManagerPage> createState() => _StoryManagerPageState();
}

class _StoryManagerPageState extends ConsumerState<StoryManagerPage> {
  String _filter = 'all';
  String _sort = 'newest';
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final storiesAsync = ref.watch(myStoriesProvider);
    final statsAsync = ref.watch(aggregateStatsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(context.l10n.storyManager),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreator,
        child: const Icon(Icons.add),
      ),
      body: storiesAsync.when(
        loading: () => const _ManagerSkeleton(),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(myStoriesProvider),
        ),
        data: (stories) {
          if (stories.isEmpty) {
            return EmptyState(
              icon: Icons.auto_stories,
              title: context.l10n.storyNoStories,
              subtitle: context.l10n.storyNoStoriesHint,
            );
          }

          final filtered = _applyFilters(stories);
          final liveAndScheduled = stories
              .where(
                  (s) => s.status == 'live' || s.status == 'scheduled')
              .toList();

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(myStoriesProvider);
              ref.invalidate(aggregateStatsProvider);
            },
            child: CustomScrollView(
              slivers: [
                // ─── Stats card ───
                SliverToBoxAdapter(
                  child: statsAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (stats) => Column(
                      children: [
                        SizedBox(height: AppSpacing.md),
                        StoryStatsCard(stats: stats),
                        SizedBox(height: AppSpacing.lg),
                      ],
                    ),
                  ),
                ),

                // ─── Preview strip (with status summary header) ───
                SliverToBoxAdapter(
                  child: StoryPreviewStrip(
                    stories: liveAndScheduled,
                    onCreateTap: _openCreator,
                  ),
                ),

                SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.lg),
                ),

                // ─── Search bar ───
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: TextField(
                      onChanged: (v) => setState(() => _search = v),
                      decoration: InputDecoration(
                        hintText: context.l10n.storySearchHint,
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 20,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        filled: true,
                        fillColor: context
                            .colorScheme.surfaceContainerHighest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        isDense: true,
                      ),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.md),
                ),

                // ─── Count + sort bar + create button ───
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: Row(
                      children: [
                        // Create new inline button
                        GestureDetector(
                          onTap: _openCreator,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.add,
                                size: 14,
                                color: Color(0xFF1A73E8),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                context.l10n.storyCreateNew,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF1A73E8),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),

                        // Story count
                        Text(
                          context.l10n.storyCountOf(filtered.length, stories.length),
                          style: TextStyle(
                            fontSize: 11,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Sort button
                        PopupMenuButton<String>(
                          icon: Icon(
                            Icons.swap_vert,
                            size: 18,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          tooltip: context.l10n.storySortBy,
                          onSelected: (v) =>
                              setState(() => _sort = v),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          itemBuilder: (_) => [
                            _sortItem(
                                'newest', context.l10n.storySortNewest),
                            _sortItem(
                                'oldest', context.l10n.storySortOldest),
                            _sortItem('most_views',
                                context.l10n.storySortMostViews),
                            _sortItem('most_shares',
                                context.l10n.storySortMostShares),
                            _sortItem('most_messages',
                                context.l10n.storySortMostMessages),
                            _sortItem('most_reach',
                                context.l10n.storySortMostReach),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.sm),
                ),

                // ─── Filter chips ───
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 32,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      children: [
                        _FilterChip(
                          label: context.l10n.storyFilterAll,
                          count: stories.length,
                          selected: _filter == 'all',
                          onTap: () =>
                              setState(() => _filter = 'all'),
                        ),
                        SizedBox(width: AppSpacing.sm),
                        _FilterChip(
                          label: context.l10n.storyFilterLive,
                          count: stories
                              .where((s) => s.status == 'live')
                              .length,
                          selected: _filter == 'live',
                          color: const Color(0xFF43A047),
                          onTap: () =>
                              setState(() => _filter = 'live'),
                        ),
                        SizedBox(width: AppSpacing.sm),
                        _FilterChip(
                          label: context.l10n.storyFilterScheduled,
                          count: stories
                              .where((s) => s.status == 'scheduled')
                              .length,
                          selected: _filter == 'scheduled',
                          color: const Color(0xFF1A73E8),
                          onTap: () =>
                              setState(() => _filter = 'scheduled'),
                        ),
                        SizedBox(width: AppSpacing.sm),
                        _FilterChip(
                          label: context.l10n.storyFilterExpired,
                          count: stories
                              .where((s) => s.status == 'expired')
                              .length,
                          selected: _filter == 'expired',
                          onTap: () =>
                              setState(() => _filter = 'expired'),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.md),
                ),

                // ─── Story list ───
                if (filtered.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.xxl),
                      child: Center(
                        child: Text(
                          context.l10n.noResults,
                          style:
                              context.textTheme.bodyMedium?.copyWith(
                            color:
                                context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => StoryListItem(
                        story: filtered[index],
                        onRepublish:
                            filtered[index].status == 'expired'
                                ? () => _showRepublishSheet(
                                    filtered[index])
                                : null,
                        onDelete: () {
                          ref
                              .read(myStoriesProvider.notifier)
                              .deleteStory(filtered[index].id);
                          context.showSnackBar(
                              context.l10n.storyDelete);
                        },
                        onShare: filtered[index].status == 'live'
                            ? () {
                                context.showSnackBar(
                                  context.l10n.storyShareCopied,
                                );
                              }
                            : null,
                        onPublishNow:
                            filtered[index].status == 'scheduled'
                                ? () {
                                    ref
                                        .read(myStoriesProvider
                                            .notifier)
                                        .publishNow(
                                            filtered[index].id);
                                    context.showSnackBar(
                                      context.l10n.storyPublished,
                                    );
                                  }
                                : null,
                      ),
                      childCount: filtered.length,
                    ),
                  ),

                // Bottom padding
                SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.xxl * 2),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<MyStory> _applyFilters(List<MyStory> stories) {
    var result = _filter == 'all'
        ? stories
        : stories.where((s) => s.status == _filter).toList();

    // Search
    if (_search.isNotEmpty) {
      result = result
          .where(
            (s) =>
                (s.slide.text ?? '').contains(_search) ||
                s.status.contains(_search),
          )
          .toList();
    }

    // Sort
    switch (_sort) {
      case 'oldest':
        result.sort((a, b) =>
            (a.createdAt ?? '').compareTo(b.createdAt ?? ''));
      case 'most_views':
        result.sort(
            (a, b) => b.stats.views.compareTo(a.stats.views));
      case 'most_shares':
        result.sort(
            (a, b) => b.stats.shares.compareTo(a.stats.shares));
      case 'most_messages':
        result.sort((a, b) =>
            b.stats.messages.compareTo(a.stats.messages));
      case 'most_reach':
        result.sort((a, b) =>
            b.stats.uniqueReach.compareTo(a.stats.uniqueReach));
      default: // newest
        result.sort((a, b) =>
            (b.createdAt ?? '').compareTo(a.createdAt ?? ''));
    }

    return result;
  }

  void _showRepublishSheet(MyStory story) {
    PublishOptionsSheet.show(
      context,
      title: context.l10n.storyRepublishTitle,
      defaultAudience: story.audience,
      onConfirm: ({
        required String audience,
        required bool isScheduled,
        DateTime? scheduledAt,
      }) {
        ref.read(myStoriesProvider.notifier).republishStory(
              story.id,
              audience: audience,
              scheduledAt: scheduledAt,
            );
        if (isScheduled) {
          context.showSnackBar(
              context.l10n.storyRepublishScheduled);
        } else {
          context.showSnackBar(context.l10n.storyRepublished);
        }
      },
    );
  }

  PopupMenuItem<String> _sortItem(String value, String label) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          if (_sort == value)
            const Icon(Icons.check,
                size: 16, color: Color(0xFF1A73E8))
          else
            const SizedBox(width: 16),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  void _openCreator() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const StoryCreatorPage()),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Filter chip with count badge
// ═══════════════════════════════════════════════════════════════

class _FilterChip extends StatelessWidget {
  final String label;
  final int count;
  final bool selected;
  final Color? color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.count,
    required this.selected,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = color ?? context.colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? activeColor.withValues(alpha: 0.12)
              : context.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          border: selected
              ? Border.all(
                  color: activeColor.withValues(alpha: 0.3))
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: selected
                    ? activeColor
                    : context.colorScheme.onSurface,
                fontWeight:
                    selected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 10,
                color: selected
                    ? activeColor.withValues(alpha: 0.7)
                    : context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Skeleton loader
// ═══════════════════════════════════════════════════════════════

class _ManagerSkeleton extends StatelessWidget {
  const _ManagerSkeleton();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          const ShimmerLoading(
              width: double.infinity, height: 140),
          SizedBox(height: AppSpacing.lg),
          const ShimmerLoading(
              width: double.infinity, height: 100),
          SizedBox(height: AppSpacing.lg),
          const ShimmerLoading(
              width: double.infinity, height: 200),
          SizedBox(height: AppSpacing.lg),
          ...List.generate(
            3,
            (_) => Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.md),
              child: const ShimmerLoading(
                  width: double.infinity, height: 100),
            ),
          ),
        ],
      ),
    );
  }
}
