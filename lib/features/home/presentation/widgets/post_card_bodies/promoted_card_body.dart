import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/home/domain/entities/post.dart';
import 'package:honak/shared/widgets/app_direction.dart';
import 'package:honak/shared/widgets/app_image.dart';

// ── Promoted → Compact slate card: thumbnail + content ──────────────────────

class PromotedCardBody extends StatelessWidget {
  final Post post;
  final VoidCallback? onPageTap;
  final VoidCallback? onProductTap;

  const PromotedCardBody({
    super.key,
    required this.post,
    this.onPageTap,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = post.media.isNotEmpty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Thumbnail — 80x80
        if (hasImage)
          AppImage(
            url: post.media.first.url,
            width: 80,
            height: 80,
            borderRadius: AppRadius.image,
          ),
        if (hasImage) SizedBox(width: AppSpacing.md),
        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: avatar + name + "ممول"
              Row(
                children: [
                  GestureDetector(
                    onTap: onPageTap,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppImage.avatar(
                          url: post.page.avatarUrl,
                          name: post.page.name,
                          radius: 10,
                        ),
                        SizedBox(width: AppSpacing.sm),
                        Text(
                          post.page.name,
                          style: context.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // "ممول" label
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: AppSpacing.xxs,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9CA3AF).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppRadius.xxs),
                    ),
                    child: Text(
                      context.l10n.promoted,
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: 9,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.xs),

              // Title
              Text(
                post.content,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              // Description
              if (post.metadata?['description'] != null) ...[
                SizedBox(height: AppSpacing.xxs),
                Text(
                  post.metadata!['description'] as String,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],

              SizedBox(height: AppSpacing.sm),

              // CTA button
              GestureDetector(
                onTap: onProductTap ?? onPageTap,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(
                      color: context.colorScheme.outlineVariant
                          .withValues(alpha: 0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.l10n.visitPage,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: 10,
                          color: context.colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: AppSpacing.xxs),
                      Icon(
                        AppDirection.forwardIcon(context),
                        size: 9,
                        color: const Color(0xFF374151),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
