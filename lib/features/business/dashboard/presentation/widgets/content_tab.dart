import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/stories/domain/entities/my_story.dart';
import 'package:honak/features/business/stories/presentation/pages/story_creator_page.dart';
import 'package:honak/features/business/stories/presentation/providers/my_stories_provider.dart';
import 'package:honak/features/business/stories/presentation/widgets/story_list_item.dart';
import 'package:honak/features/business/stories/presentation/widgets/publish_options_sheet.dart';
import 'package:honak/features/business/stories/presentation/widgets/story_preview_strip.dart';
import 'package:honak/features/stories/domain/entities/story_content.dart';
import 'package:honak/features/stories/presentation/pages/story_viewer_page.dart';
import 'package:honak/shared/providers/business_page_provider.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/empty_state.dart';
import 'package:honak/shared/widgets/error_view.dart';
import 'package:honak/shared/widgets/shimmer_loading.dart';

/// Content tab inside BusinessHomePage — Stories/Posts switcher.
/// Matches Figma ContentManager.tsx: toggle buttons, aggregate stats,
/// status badges, search, sort, then story management inline.
class ContentTab extends ConsumerStatefulWidget {
  const ContentTab({super.key});

  @override
  ConsumerState<ContentTab> createState() => _ContentTabState();
}

class _ContentTabState extends ConsumerState<ContentTab> {
  String _activeType = 'stories'; // 'stories' | 'posts'
  String _filter = 'all';
  String _sortBy = 'newest';
  String _searchQuery = '';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storiesAsync = ref.watch(myStoriesProvider);
    final statsAsync = ref.watch(aggregateStatsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(myStoriesProvider);
        ref.invalidate(aggregateStatsProvider);
      },
      child: CustomScrollView(
        slivers: [
          // ── Stories/Posts toggle ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _ContentToggle(
                      icon: Icons.auto_stories,
                      label: context.l10n.contentStories,
                      count: storiesAsync.valueOrNull?.length ?? 0,
                      isActive: _activeType == 'stories',
                      onTap: () => setState(() => _activeType = 'stories'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _ContentToggle(
                      icon: Icons.article_outlined,
                      label: context.l10n.contentPosts,
                      count: 0,
                      isActive: _activeType == 'posts',
                      onTap: () => setState(() => _activeType = 'posts'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Aggregate stats ──
          if (_activeType == 'stories')
            SliverToBoxAdapter(
              child: statsAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child:
                      ShimmerLoading(width: double.infinity, height: 120),
                ),
                error: (_, __) => const SizedBox.shrink(),
                data: (stats) => Column(
                  children: [
                    _CompactStats(
                      title: context.l10n.contentStoryStats,
                      stats: stats,
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ),
              ),
            ),

          // ── Status badges ──
          if (_activeType == 'stories')
            SliverToBoxAdapter(
              child: storiesAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (stories) {
                  final liveCount =
                      stories.where((s) => s.status == 'live').length;
                  final scheduledCount =
                      stories.where((s) => s.status == 'scheduled').length;

                  if (liveCount == 0 && scheduledCount == 0) {
                    return const SizedBox.shrink();
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.xs,
                      children: [
                        if (liveCount > 0)
                          _StatusBadge(
                            color: const Color(0xFF43A047),
                            label: context.l10n
                                .contentLiveStories(liveCount),
                          ),
                        if (scheduledCount > 0)
                          _StatusBadge(
                            color: AppColors.primary,
                            label: context.l10n
                                .contentScheduled(scheduledCount),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),

          if (_activeType == 'stories')
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.md),
            ),

          // ── Stories content ──
          if (_activeType == 'stories')
            ...storiesAsync.when(
              loading: () => [
                const SliverToBoxAdapter(child: _ContentSkeleton()),
              ],
              error: (error, _) => [
                SliverToBoxAdapter(
                  child: ErrorView(
                    message: error.toString(),
                    onRetry: () => ref.invalidate(myStoriesProvider),
                  ),
                ),
              ],
              data: (stories) {
                if (stories.isEmpty) {
                  return [
                    SliverToBoxAdapter(
                      child: EmptyState(
                        icon: Icons.auto_stories,
                        title: context.l10n.storyNoStories,
                        subtitle: context.l10n.storyNoStoriesHint,
                      ),
                    ),
                  ];
                }

                // Apply filter
                var filtered = _filter == 'all'
                    ? stories
                    : stories.where((s) => s.status == _filter).toList();

                // Apply search
                if (_searchQuery.isNotEmpty) {
                  final q = _searchQuery.toLowerCase();
                  filtered = filtered
                      .where((s) =>
                          (s.slide.text ?? '').toLowerCase().contains(q))
                      .toList();
                }

                // Apply sort
                filtered = _sortStories(filtered);

                return [
                  // Preview strip
                  SliverToBoxAdapter(
                    child: StoryPreviewStrip(
                      stories: stories
                          .where((s) =>
                              s.status == 'live' ||
                              s.status == 'scheduled')
                          .toList(),
                      onCreateTap: _openCreator,
                      onStoryTap: (story) => _previewStory(story),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: AppSpacing.lg),
                  ),

                  // Search bar + sort
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: Row(
                        children: [
                          // Search
                          Expanded(
                            child: SizedBox(
                              height: 36,
                              child: TextField(
                                controller: _searchController,
                                onChanged: (v) =>
                                    setState(() => _searchQuery = v),
                                textAlignVertical: TextAlignVertical.center,
                                style: const TextStyle(fontSize: 13),
                                decoration: InputDecoration(
                                  hintText:
                                      context.l10n.storySearchHint,
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: context.colorScheme.onSurfaceVariant,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    size: 18,
                                    color: context.colorScheme.onSurfaceVariant,
                                  ),
                                  filled: true,
                                  fillColor: context.colorScheme.surfaceContainerHighest,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          // Sort button
                          _SortButton(
                            currentSort: _sortBy,
                            onChanged: (v) =>
                                setState(() => _sortBy = v),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: AppSpacing.sm),
                  ),

                  // Filter chips
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _FilterChip(
                              label: context.l10n.storyFilterAll,
                              count: stories.length,
                              selected: _filter == 'all',
                              onTap: () =>
                                  setState(() => _filter = 'all'),
                            ),
                            const SizedBox(width: AppSpacing.sm),
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
                            const SizedBox(width: AppSpacing.sm),
                            _FilterChip(
                              label: context.l10n.storyFilterScheduled,
                              count: stories
                                  .where(
                                      (s) => s.status == 'scheduled')
                                  .length,
                              selected: _filter == 'scheduled',
                              color: AppColors.primary,
                              onTap: () =>
                                  setState(() => _filter = 'scheduled'),
                            ),
                            const SizedBox(width: AppSpacing.sm),
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
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: AppSpacing.sm),
                  ),

                  // Count + create bar
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: _openCreator,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.add,
                                    size: 14, color: Color(0xFF1A73E8)),
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
                          Text(
                            context.l10n.storyCountOf(
                                filtered.length, stories.length),
                            style: TextStyle(
                              fontSize: 11,
                              color: context
                                  .colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: AppSpacing.md),
                  ),

                  // Story list
                  if (filtered.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.xxl),
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
                        (context, index) {
                          final story = filtered[index];
                          return StoryListItem(
                            story: story,
                            onPreview: () => _previewStory(story),
                            onEdit: story.status == 'scheduled'
                                ? () => _editStory(story)
                                : null,
                            onPublishNow: story.status == 'scheduled'
                                ? () => _publishNow(story)
                                : null,
                            onShare: story.status == 'live'
                                ? () => _shareStory(story)
                                : null,
                            onRepublish: story.status == 'expired'
                                ? () => _republishStory(story)
                                : null,
                            onDelete: () {
                              ref
                                  .read(myStoriesProvider.notifier)
                                  .deleteStory(story.id);
                              context.showSnackBar(context.l10n.storyDelete);
                            },
                          );
                        },
                        childCount: filtered.length,
                      ),
                    ),
                ];
              },
            ),

          // ── Posts placeholder ──
          if (_activeType == 'posts')
            SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyState(
                icon: Icons.article_outlined,
                title: context.l10n.contentPostsComingSoon,
                subtitle: '',
              ),
            ),

          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.xxl * 2),
          ),
        ],
      ),
    );
  }

  // ── Sort logic (matches Figma 7 options, using 6 for MVP) ──

  List<MyStory> _sortStories(List<MyStory> stories) {
    final sorted = List<MyStory>.from(stories);
    switch (_sortBy) {
      case 'oldest':
        sorted.sort((a, b) =>
            (a.createdAt ?? '').compareTo(b.createdAt ?? ''));
      case 'most_views':
        sorted.sort((a, b) => b.stats.views.compareTo(a.stats.views));
      case 'most_shares':
        sorted.sort((a, b) => b.stats.shares.compareTo(a.stats.shares));
      case 'most_messages':
        sorted.sort(
            (a, b) => b.stats.messages.compareTo(a.stats.messages));
      case 'most_reach':
        sorted.sort(
            (a, b) => b.stats.uniqueReach.compareTo(a.stats.uniqueReach));
      default: // newest
        sorted.sort((a, b) =>
            (b.createdAt ?? '').compareTo(a.createdAt ?? ''));
    }
    return sorted;
  }

  // ── Action handlers ──

  void _openCreator() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const StoryCreatorPage()),
    );
  }

  void _previewStory(MyStory story) {
    final bizContext = ref.read(businessContextProvider);
    final content = StoryContent(
      id: bizContext?.page.id ?? '',
      name: bizContext?.page.name ?? '',
      avatar: bizContext?.page.avatarUrl,
      stories: [story.slide],
    );
    Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        opaque: true,
        pageBuilder: (_, __, ___) => StoryViewerPage(
          businesses: [content],
          isAdminPreview: true,
        ),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  void _editStory(MyStory story) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => StoryCreatorPage(
          editStory: story,
          onSaved: (id) {
            ref.read(myStoriesProvider.notifier).updateStory(id);
          },
        ),
      ),
    );
  }

  void _publishNow(MyStory story) {
    ref.read(myStoriesProvider.notifier).publishNow(story.id);
    context.showSnackBar(context.l10n.storyPublished);
  }

  void _shareStory(MyStory story) {
    context.showSnackBar(context.l10n.storyShareCopied);
  }

  void _republishStory(MyStory story) {
    showAppSheet<String>(
      context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                Text(
                  ctx.l10n.storyRepublishChoiceTitle,
                  style: ctx.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  ctx.l10n.storyRepublishChoiceSubtitle,
                  style: ctx.textTheme.bodySmall?.copyWith(
                    color: ctx.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: Text(ctx.l10n.storyEditAndRepublish),
            onTap: () => Navigator.pop(ctx, 'edit'),
          ),
          ListTile(
            leading: const Icon(Icons.replay),
            title: Text(ctx.l10n.storyRepublishAsIs),
            onTap: () => Navigator.pop(ctx, 'as_is'),
          ),
          SizedBox(height: AppSpacing.md),
        ],
      ),
    ).then((choice) {
      if (choice == null || !mounted) return;
      if (choice == 'edit') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => StoryCreatorPage(
              editStory: story,
              onSaved: (id) {
                // After editing, show publish options for republish
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
                          id,
                          audience: audience,
                          scheduledAt: scheduledAt,
                        );
                    context.showSnackBar(isScheduled
                        ? context.l10n.storyRepublishScheduled
                        : context.l10n.storyRepublished);
                  },
                );
              },
            ),
          ),
        );
      } else {
        // Republish as-is — go straight to publish options
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
            context.showSnackBar(isScheduled
                ? context.l10n.storyRepublishScheduled
                : context.l10n.storyRepublished);
          },
        );
      }
    });
  }
}

// ═══════════════════════════════════════════════════════════════
// Sort button with popup menu — matches Figma 7 sort options
// ═══════════════════════════════════════════════════════════════

class _SortButton extends StatelessWidget {
  final String currentSort;
  final ValueChanged<String> onChanged;

  const _SortButton({required this.currentSort, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onChanged,
      offset: const Offset(0, 36),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      itemBuilder: (_) => [
        _sortItem(context, 'newest', context.l10n.storySortNewest),
        _sortItem(context, 'oldest', context.l10n.storySortOldest),
        _sortItem(context, 'most_views', context.l10n.storySortMostViews),
        _sortItem(context, 'most_shares', context.l10n.storySortMostShares),
        _sortItem(
            context, 'most_messages', context.l10n.storySortMostMessages),
        _sortItem(context, 'most_reach', context.l10n.storySortMostReach),
      ],
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.sort,
          size: 18,
          color: context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  PopupMenuItem<String> _sortItem(
      BuildContext context, String value, String label) {
    final isSelected = currentSort == value;
    return PopupMenuItem(
      value: value,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: isSelected ? AppColors.primary : null,
          fontWeight: isSelected ? FontWeight.w600 : null,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Content type toggle button — Stories/Posts
// ═══════════════════════════════════════════════════════════════

class _ContentToggle extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final bool isActive;
  final VoidCallback onTap;

  const _ContentToggle({
    required this.icon,
    required this.label,
    required this.count,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive
          ? AppColors.primary.withValues(alpha: 0.1)
          : context.colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm + 2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  isActive ? AppColors.primary : context.colorScheme.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: isActive
                    ? AppColors.primary
                    : context.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  label,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: isActive
                        ? AppColors.primary
                        : context.colorScheme.onSurfaceVariant,
                    fontWeight:
                        isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              if (count > 0) ...[
                const SizedBox(width: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primary.withValues(alpha: 0.2)
                        : context.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$count',
                    style: TextStyle(
                      fontSize: 10,
                      color: isActive
                          ? AppColors.primary
                          : context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Compact aggregate stats — matches Figma ContentManager
// ═══════════════════════════════════════════════════════════════

class _CompactStats extends StatelessWidget {
  final String title;
  final Map<String, dynamic> stats;

  const _CompactStats({required this.title, required this.stats});

  @override
  Widget build(BuildContext context) {
    final totalViews = stats['total_views_this_month'] ?? 0;
    final totalShares = stats['total_shares_this_month'] ?? 0;
    final totalMessages = stats['total_messages_this_month'] ?? 0;
    final growth = stats['growth_vs_last_month'] ?? 0;
    final bestTime = stats['best_posting_time'] ?? '';
    final bestDay = stats['best_posting_day'] ?? '';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bar_chart, size: 14, color: AppColors.primary),
              const SizedBox(width: AppSpacing.xs),
              Text(
                title,
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // 3-column stats
          Row(
            children: [
              _StatMini(
                icon: Icons.visibility,
                value: _formatNumber(totalViews as int),
                label: context.l10n.contentViews,
                color: AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.sm),
              _StatMini(
                icon: Icons.share,
                value: _formatNumber(totalShares as int),
                label: context.l10n.contentShares,
                color: const Color(0xFF43A047),
              ),
              const SizedBox(width: AppSpacing.sm),
              _StatMini(
                icon: Icons.chat_bubble_outline,
                value: _formatNumber(totalMessages as int),
                label: context.l10n.contentMessages,
                color: const Color(0xFFFF9800),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Quick insight strip
          Container(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: context.colorScheme.surfaceContainerHighest),
              ),
            ),
            child: Row(
              children: [
                if (growth > 0) ...[
                  const Icon(Icons.trending_up,
                      size: 10, color: Color(0xFF43A047)),
                  const SizedBox(width: 2),
                  Text(
                    '+$growth٪',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF43A047),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                ],
                const Icon(Icons.auto_awesome,
                    size: 10, color: Color(0xFFFF9800)),
                const SizedBox(width: 2),
                Flexible(
                  child: Text(
                    '${context.l10n.storyBestTime}: $bestDay $bestTime',
                    style: TextStyle(
                      fontSize: 10,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }
}

class _StatMini extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatMini({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, size: 12, color: color),
            const SizedBox(height: 2),
            Text(
              value,
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style:
                  TextStyle(fontSize: 9, color: context.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Status badge — live/scheduled indicators
// ═══════════════════════════════════════════════════════════════

class _StatusBadge extends StatelessWidget {
  final Color color;
  final String label;

  const _StatusBadge({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: color),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Filter chip
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
// Loading skeleton
// ═══════════════════════════════════════════════════════════════

class _ContentSkeleton extends StatelessWidget {
  const _ContentSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          const ShimmerLoading(width: double.infinity, height: 80),
          SizedBox(height: AppSpacing.lg),
          const ShimmerLoading(width: double.infinity, height: 140),
          SizedBox(height: AppSpacing.lg),
          ...List.generate(
            3,
            (_) => Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.md),
              child: const ShimmerLoading(
                width: double.infinity,
                height: 90,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
