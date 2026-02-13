import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/home/domain/entities/post.dart';
import 'package:honak/shared/widgets/cached_image.dart';

import 'post_card_helpers.dart';

// ── Photo → Full-bleed immersive 300px image with overlays ──────────────────

class PhotoCardBody extends StatelessWidget {
  final Post post;
  final VoidCallback? onPageTap;

  const PhotoCardBody({
    super.key,
    required this.post,
    this.onPageTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = post.media.isNotEmpty;

    if (!hasImage) {
      return _buildNoImageLayout(context);
    }

    return SizedBox(
      height: 300,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Full-bleed image
          CachedImage(
            imageUrl: post.media.first.url,
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
          // Gradient overlay: from-black/60 via-transparent to-black/10
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.6),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.1),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
          // Category badge: top-start
          PositionedDirectional(
            top: AppSpacing.md,
            start: AppSpacing.md,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: context.feedColors.photoBadge.withValues(alpha: 0.8),
                borderRadius: AppRadius.pill,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.camera_alt, size: 10, color: Colors.white),
                  SizedBox(width: AppSpacing.xxs),
                  Text(
                    context.l10n.postTypePhoto,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Heart button: top-end
          PositionedDirectional(
            top: AppSpacing.md,
            end: AppSpacing.md,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
          // Bottom overlay: business info + description
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Business info
                  GestureDetector(
                    onTap: onPageTap,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor:
                              Colors.white.withValues(alpha: 0.3),
                          backgroundImage: post.page.avatarUrl != null
                              ? NetworkImage(post.page.avatarUrl!)
                              : null,
                          child: post.page.avatarUrl == null
                              ? Text(
                                  post.page.name.isNotEmpty
                                      ? post.page.name[0]
                                      : '',
                                  style: context.textTheme.labelSmall
                                      ?.copyWith(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                )
                              : null,
                        ),
                        SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      post.page.name,
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (post.page.isVerified) ...[
                                    SizedBox(width: AppSpacing.xs),
                                    Icon(Icons.verified,
                                        size: 12, color: Colors.white),
                                  ],
                                ],
                              ),
                              Text(
                                timeAgo(post.createdAt),
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontSize: 10,
                                  color:
                                      Colors.white.withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Description
                  if (post.content.isNotEmpty) ...[
                    SizedBox(height: AppSpacing.sm),
                    Text(
                      post.content,
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoImageLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Business info
        GestureDetector(
          onTap: onPageTap,
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: context.colorScheme.surfaceContainerHighest,
                backgroundImage: post.page.avatarUrl != null
                    ? NetworkImage(post.page.avatarUrl!)
                    : null,
                child: post.page.avatarUrl == null
                    ? Text(
                        post.page.name.isNotEmpty ? post.page.name[0] : '',
                        style: context.textTheme.labelSmall?.copyWith(
                          fontSize: 12,
                        ),
                      )
                    : null,
              ),
              SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  post.page.name,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        if (post.content.isNotEmpty) ...[
          SizedBox(height: AppSpacing.sm),
          Text(
            post.content,
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 14,
              color: context.colorScheme.onSurfaceVariant,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}
