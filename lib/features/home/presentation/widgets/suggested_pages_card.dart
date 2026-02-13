import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/explore/domain/entities/page_summary.dart';
import 'package:honak/features/home/presentation/providers/follow_provider.dart';
import 'package:honak/shared/widgets/cached_image.dart';
import 'package:honak/shared/widgets/story_ring_avatar.dart';

class SuggestedPagesCard extends StatelessWidget {
  final List<PageSummary> pages;

  const SuggestedPagesCard({super.key, required this.pages});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.cardPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.suggestedPages,
            style: context.textTheme.titleSmall,
          ),
          SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: pages.length,
              separatorBuilder: (_, __) => SizedBox(width: AppSpacing.md),
              itemBuilder: (context, index) =>
                  _SuggestedPageMiniCard(page: pages[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuggestedPageMiniCard extends ConsumerWidget {
  final PageSummary page;

  const _SuggestedPageMiniCard({required this.page});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFollowing = ref.watch(
      followProvider((pageId: page.id, isFollowing: page.isFollowing)),
    );

    return GestureDetector(
      onTap: () => context.push(Routes.pagePath(page.slug)),
      child: SizedBox(
        width: 140,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedImage(
                imageUrl: page.coverUrl,
                width: 140,
                height: 60,
                fit: BoxFit.cover,
              ),
              SizedBox(height: AppSpacing.sm),
              StoryRingAvatar(
                imageUrl: page.avatarUrl,
                name: page.name,
                radius: 20,
                hasStories: page.hasActiveStories,
              ),
              SizedBox(height: AppSpacing.xs),
              Padding(
                padding: AppSpacing.paddingH(AppSpacing.sm),
                child: Text(
                  page.name,
                  style: context.textTheme.labelSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.sm),
                child: SizedBox(
                  height: 28,
                  child: TextButton(
                    onPressed: () => ref
                        .read(followProvider(
                                (pageId: page.id, isFollowing: page.isFollowing))
                            .notifier)
                        .toggle(),
                    style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      visualDensity: VisualDensity.compact,
                      backgroundColor: isFollowing
                          ? null
                          : context.colorScheme.primary.withValues(alpha: 0.1),
                    ),
                    child: Text(
                      isFollowing
                          ? context.l10n.following
                          : context.l10n.follow,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: isFollowing
                            ? context.colorScheme.onSurfaceVariant
                            : context.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
