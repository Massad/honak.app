import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/home/domain/entities/nearby_page.dart';
import 'package:honak/features/home/presentation/providers/follow_provider.dart';
import 'package:honak/features/pages/presentation/widgets/shared/follow_button.dart';
import 'package:honak/shared/widgets/cached_image.dart';

class NearbyPagesCard extends StatelessWidget {
  final List<NearbyPage> pages;

  const NearbyPagesCard({super.key, required this.pages});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            context.colorScheme.surface,
          ],
        ),
        border: Border.symmetric(
          horizontal: BorderSide(
            color: context.colorScheme.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                Text(
                  context.l10n.nearYou,
                  style: context.textTheme.titleSmall?.copyWith(
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: AppSpacing.xs + 2), // 6px
                Icon(
                  Icons.location_on,
                  size: 14,
                  color: context.colorScheme.primary,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    // TODO: navigate to full nearby list
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.l10n.seeAll,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.primary,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: AppSpacing.xs),
                      Icon(
                        context.isRtl
                            ? Icons.arrow_back_ios_new
                            : Icons.arrow_forward_ios,
                        size: 12,
                        color: context.colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.md),
          // Horizontal scroll
          SizedBox(
            height: 210,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              physics: const BouncingScrollPhysics(),
              itemCount: pages.length,
              separatorBuilder: (_, __) => SizedBox(width: AppSpacing.md),
              itemBuilder: (context, index) =>
                  _NearbyPageCard(page: pages[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _NearbyPageCard extends ConsumerWidget {
  final NearbyPage page;

  const _NearbyPageCard({required this.page});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFollowing = ref.watch(
      followProvider((pageId: page.id, isFollowing: page.isFollowing)),
    );

    return GestureDetector(
      onTap: () => context.push(Routes.pagePath(page.slug)),
      child: Container(
        width: 155,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: context.colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover image with badges
            SizedBox(
              width: 155,
              height: 90,
              child: Stack(
                children: [
                  // Image
                  if (page.coverUrl != null)
                    CachedImage(
                      imageUrl: page.coverUrl!,
                      width: 155,
                      height: 90,
                      fit: BoxFit.cover,
                    )
                  else
                    Container(
                      width: 155,
                      height: 90,
                      color: context.colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.storefront,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  // Open badge - top end
                  PositionedDirectional(
                    top: 8,
                    end: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs + 2, // 6px
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        context.l10n.available,
                        style: const TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  // Distance badge - bottom start
                  PositionedDirectional(
                    bottom: 8,
                    start: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs + 2, // 6px
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 8,
                            color: Colors.white,
                          ),
                          SizedBox(width: 2),
                          Text(
                            context.l10n.distanceKm(
                              page.distanceKm.toStringAsFixed(1),
                            ),
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Info section
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + verified badge
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          page.name,
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            color: context.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (page.isVerified) ...[
                        SizedBox(width: AppSpacing.xxs),
                        Icon(
                          Icons.verified,
                          size: 11,
                          color: context.colorScheme.primary,
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 2),
                  // Category + activity
                  Text(
                    page.category ?? '',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppSpacing.sm),
                  // Follow button - full width
                  SizedBox(
                    width: double.infinity,
                    child: FollowButton(
                      isFollowing: isFollowing,
                      onFollowChanged: (level) {
                        final notifier = ref.read(
                          followProvider(
                            (pageId: page.id, isFollowing: page.isFollowing),
                          ).notifier,
                        );
                        if (level == null && isFollowing) {
                          notifier.toggle();
                        } else if (level != null && !isFollowing) {
                          notifier.toggle();
                        }
                      },
                      variant: FollowButtonVariant.pill,
                      pageName: page.name,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
