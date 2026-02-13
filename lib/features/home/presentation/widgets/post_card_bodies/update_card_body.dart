import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/home/domain/entities/post.dart';
import 'package:honak/shared/widgets/app_image.dart';
import 'package:honak/shared/widgets/app_badge.dart';

import 'post_card_helpers.dart';

// ── Update → White card with blue gradient accent stripe at top ──────────────

class UpdateCardBody extends StatelessWidget {
  final Post post;
  final VoidCallback? onPageTap;

  const UpdateCardBody({
    super.key,
    required this.post,
    this.onPageTap,
  });

  @override
  Widget build(BuildContext context) {
    final feed = context.feedColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Accent stripe at top
        Container(
          height: 4,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [feed.updateAccentStart, feed.updateAccentEnd],
            ),
          ),
        ),
        // Content
        Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: avatar + name + verified + time + badge
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: onPageTap,
                    child: AppImage.avatar(
                      url: post.page.avatarUrl,
                      name: post.page.name,
                      radius: 18,
                    ),
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: onPageTap,
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  post.page.name,
                                  style:
                                      context.textTheme.bodySmall?.copyWith(
                                    fontSize: 14,
                                    color: context.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (post.page.isVerified) ...[
                                SizedBox(width: AppSpacing.xs),
                                Icon(Icons.verified,
                                    size: 12,
                                    color: context.colorScheme.primary),
                              ],
                            ],
                          ),
                        ),
                        SizedBox(height: AppSpacing.xxs),
                        Text(
                          timeAgo(post.createdAt),
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 10,
                            color: context.colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Badge pill: megaphone icon + "تحديث"
                  AppBadge.small(
                    label: context.l10n.postTypeUpdate,
                    color: context.colorScheme.primary,
                    icon: Icons.campaign,
                    pill: true,
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.md),

              // Content text
              Text(
                post.content,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  color: context.colorScheme.onSurfaceVariant,
                  height: 1.6,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: AppSpacing.sm),

              // Footer: location + read more
              Container(
                padding: EdgeInsets.only(top: AppSpacing.sm),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: context.colorScheme.outlineVariant
                          .withValues(alpha: 0.2),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Location
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on,
                            size: 10,
                            color: context.colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.6)),
                        SizedBox(width: AppSpacing.xxs),
                        Text(
                          'عمّان',
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 10,
                            color: context.colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                    // Read more
                    GestureDetector(
                      onTap: onPageTap,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            context.l10n.readMore,
                            style: context.textTheme.bodySmall?.copyWith(
                              fontSize: 12,
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: AppSpacing.xxs),
                          Icon(Icons.arrow_back,
                              size: 12, color: context.colorScheme.primary),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
