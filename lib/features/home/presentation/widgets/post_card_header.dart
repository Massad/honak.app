import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/home/domain/entities/post.dart';
import 'package:honak/features/home/presentation/providers/follow_provider.dart';
import 'package:honak/shared/widgets/app_badge.dart';

/// Compact single-row attribution: avatar + name + verified + type badge + time/promoted + optional follow.
class CompactAttribution extends ConsumerWidget {
  final PostPage page;
  final int createdAt;
  final String pageId;
  final bool isFollowing;
  final bool isPromoted;
  final bool showFollow;
  final VoidCallback? onTap;

  /// Tiny variant for status cards: 24px avatar, inline layout.
  final bool tiny;

  /// Optional post type to show as a colored badge chip.
  final PostType? postType;

  const CompactAttribution({
    super.key,
    required this.page,
    required this.createdAt,
    required this.pageId,
    required this.isFollowing,
    required this.isPromoted,
    this.showFollow = true,
    this.onTap,
    this.tiny = false,
    this.postType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final following = ref.watch(
      followProvider((pageId: pageId, isFollowing: isFollowing)),
    );

    final avatarRadius = tiny ? 12.0 : 14.0;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: avatarRadius,
            backgroundColor: context.colorScheme.surfaceContainerHighest,
            backgroundImage:
                page.avatarUrl != null ? NetworkImage(page.avatarUrl!) : null,
            child: page.avatarUrl == null
                ? Text(
                    page.name.isNotEmpty ? page.name[0] : '',
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: tiny ? 10 : 12,
                    ),
                  )
                : null,
          ),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    page.name,
                    style: tiny
                        ? context.textTheme.bodySmall
                        : context.textTheme.labelMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (page.isVerified) ...[
                  SizedBox(width: AppSpacing.xs),
                  Icon(
                    Icons.verified,
                    size: tiny ? 12 : 14,
                    color: context.colorScheme.primary,
                  ),
                ],
                if (postType != null && !tiny) ...[
                  SizedBox(width: AppSpacing.sm),
                  PostTypeBadge(postType: postType!),
                ],
                SizedBox(width: AppSpacing.sm),
                Text(
                  isPromoted ? context.l10n.promoted : _timeAgo(createdAt),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    fontSize: tiny ? 10 : null,
                  ),
                ),
              ],
            ),
          ),
          if (showFollow && !isPromoted)
            SizedBox(
              height: 28,
              child: TextButton(
                onPressed: () => ref
                    .read(followProvider(
                            (pageId: pageId, isFollowing: isFollowing))
                        .notifier)
                    .toggle(),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                  visualDensity: VisualDensity.compact,
                ),
                child: Text(
                  following ? context.l10n.following : context.l10n.follow,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: following
                        ? context.colorScheme.onSurfaceVariant
                        : context.colorScheme.primary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Colored chip badge indicating post type.
class PostTypeBadge extends StatelessWidget {
  final PostType postType;

  const PostTypeBadge({super.key, required this.postType});

  @override
  Widget build(BuildContext context) {
    final (label, color) = _badgeData(context);
    if (label == null) return const SizedBox.shrink();

    return AppBadge.small(label: label, color: color);
  }

  (String?, Color) _badgeData(BuildContext context) {
    return switch (postType) {
      PostType.product => (context.l10n.postTypeProduct, context.colorScheme.primary),
      PostType.offer => (context.l10n.postTypeOffer, context.colorScheme.error),
      PostType.update => (context.l10n.postTypeUpdate, context.colorScheme.primary),
      PostType.status => (null, Colors.transparent), // no badge for status
      PostType.photo => (context.l10n.postTypePhoto, context.feedColors.photoBadge),
    };
  }
}

String _timeAgo(int timestamp) {
  final now = DateTime.now();
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  final diff = now.difference(date);
  if (diff.inMinutes < 60) return '${diff.inMinutes}د';
  if (diff.inHours < 24) return '${diff.inHours}س';
  return '${diff.inDays}ي';
}
