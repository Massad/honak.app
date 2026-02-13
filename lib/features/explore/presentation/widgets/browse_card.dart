import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/explore/domain/entities/page_summary.dart';
import 'package:honak/features/explore/presentation/widgets/smart_badge.dart';
import 'package:honak/features/home/presentation/providers/follow_provider.dart';
import 'package:honak/features/pages/presentation/widgets/shared/follow_button.dart';
import 'package:honak/features/stories/presentation/utils/story_launcher.dart';
import 'package:honak/shared/widgets/story_ring_avatar.dart';

/// Rich business card for category browse list.
class BrowseCard extends ConsumerWidget {
  final PageSummary page;

  const BrowseCard({super.key, required this.page});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFollowing = ref.watch(
      followProvider((pageId: page.id, isFollowing: page.isFollowing)),
    );

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.card,
        side: BorderSide(color: Colors.grey.shade100),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Main content — tappable
          InkWell(
            onTap: () => context.push(Routes.pagePath(page.slug)),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Square image — opens stories if available
                  _buildImage(context, ref),
                  const SizedBox(width: AppSpacing.md),
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildNameRow(context, ref, isFollowing),
                        const SizedBox(height: 2),
                        _buildSubtitle(context),
                        const SizedBox(height: AppSpacing.sm),
                        _buildBadgesRow(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Product category chips
          if (page.productCategories.isNotEmpty) _buildCategoryChips(context),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context, WidgetRef ref) {
    return StoryRingAvatar(
      imageUrl: page.avatarUrl,
      name: page.name,
      size: 80,
      borderRadius: AppRadius.cardInner,
      hasStories: page.hasActiveStories,
      onTap: page.hasActiveStories
          ? () => openStoryViewer(context, ref, pageId: page.id)
          : null,
      placeholder: Icon(
        Icons.storefront_outlined,
        color: context.colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildNameRow(BuildContext context, WidgetRef ref, bool isFollowing) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Flexible(
                child: Text(
                  page.name,
                  style: context.textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (page.isVerified) ...[
                const SizedBox(width: AppSpacing.xxs),
                Icon(
                  Icons.verified,
                  size: 14,
                  color: context.colorScheme.primary,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        FollowButton(
          isFollowing: isFollowing,
          onFollowChanged: (level) {
            final notifier = ref.read(
              followProvider(
                (pageId: page.id, isFollowing: page.isFollowing),
              ).notifier,
            );
            if (level == null && isFollowing) {
              notifier.toggle(); // unfollow
            } else if (level != null && !isFollowing) {
              notifier.toggle(); // follow
            }
          },
          variant: FollowButtonVariant.outline,
          pageName: page.name,
        ),
      ],
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    final parts = <String>[];
    if (page.businessTypeName != null) parts.add(page.businessTypeName!);
    if (page.subCategory != null) parts.add(page.subCategory!);

    final isFollowOnly =
        page.archetype == 'follow_only' || page.archetype == 'directory';

    if (!isFollowOnly) {
      if (page.distance != null) parts.add(page.distance!);
    } else if (page.location?.area != null) {
      parts.add(page.location!.area!);
    }

    return Row(
      children: [
        Expanded(
          child: Text(
            parts.join(' · '),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (!isFollowOnly) ...[
          const SizedBox(width: AppSpacing.xs),
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: page.isOpen
                  ? const Color(0xFF43A047)
                  : const Color(0xFFE53935),
            ),
          ),
          const SizedBox(width: AppSpacing.xxs),
          Text(
            page.isOpen ? 'متاح' : 'مغلق',
            style: TextStyle(
              fontSize: 12,
              color: page.isOpen
                  ? const Color(0xFF43A047)
                  : const Color(0xFFE53935),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildBadgesRow(BuildContext context) {
    final primary = getPrimaryBadge(page);
    final secondary = getSecondaryBadge(page);
    final hasTrustMetric = page.trustMetrics.isNotEmpty;

    if (primary == null && secondary == null && !hasTrustMetric) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        if (hasTrustMetric) _buildMetricPill(context),
        if (primary != null) BadgeChip(badge: primary),
        if (secondary != null) BadgeChip(badge: secondary),
      ],
    );
  }

  Widget _buildMetricPill(BuildContext context) {
    final metric = page.trustMetrics.first;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: AppRadius.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.trending_up, size: 10, color: Color(0xFF43A047)),
          const SizedBox(width: 2),
          Text(
            '${metric.value} ${metric.label}',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips(BuildContext context) {
    final categories = page.productCategories.take(5).toList();
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        10,
      ),
      child: Row(
        children: [
          Icon(
            Icons.label_outline,
            size: 10,
            color: Colors.grey.shade300,
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories
                    .map((cat) => Padding(
                          padding:
                              const EdgeInsetsDirectional.only(end: 6),
                          child: GestureDetector(
                            onTap: () =>
                                context.push(Routes.pagePath(page.slug)),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: AppRadius.pill,
                                border: Border.all(
                                  color: Colors.grey.shade100,
                                ),
                              ),
                              child: Text(
                                cat,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

