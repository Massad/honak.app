import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/home/domain/entities/post.dart';
import 'package:honak/shared/widgets/app_image.dart';

import 'post_card_helpers.dart';

// ── Status → Notification-style card with warning/info variants ─────────────

class StatusCardBody extends StatelessWidget {
  final Post post;
  final VoidCallback? onPageTap;
  final bool isWarning;

  const StatusCardBody({
    super.key,
    required this.post,
    this.onPageTap,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    final feed = context.feedColors;

    final iconBgColor =
        isWarning ? feed.statusWarningIconBg : feed.statusInfoIconBg;
    final iconColor =
        isWarning ? feed.statusWarningColor : context.colorScheme.primary;
    final textColor =
        isWarning ? feed.statusWarningText : feed.statusInfoText;
    final ctaColor =
        isWarning ? feed.statusWarningColor : context.colorScheme.primary;
    final badgeLabel =
        isWarning ? context.l10n.statusAlert : context.l10n.statusAnnouncement;
    final badgeBgColor = isWarning
        ? feed.statusWarningIconBg
        : feed.statusInfoIconBg;
    final badgeTextColor = isWarning
        ? const Color(0xFF7C4700)
        : context.colorScheme.primary;

    return Padding(
      padding: EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon circle
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isWarning ? Icons.error_outline : Icons.info_outline,
              size: 18,
              color: iconColor,
            ),
          ),
          SizedBox(width: AppSpacing.md),
          // Content side
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Business info row
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
                            radius: 8,
                          ),
                          SizedBox(width: AppSpacing.xs),
                          Text(
                            post.page.name,
                            style: context.textTheme.bodySmall?.copyWith(
                              fontSize: 12,
                              color: context.colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (post.page.isVerified) ...[
                            SizedBox(width: AppSpacing.xxs),
                            Icon(Icons.verified,
                                size: 10,
                                color: context.colorScheme.primary),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm),
                    // Badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: AppSpacing.xxs,
                      ),
                      decoration: BoxDecoration(
                        color: badgeBgColor,
                        borderRadius: BorderRadius.circular(AppRadius.xxs),
                      ),
                      child: Text(
                        badgeLabel,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: 9,
                          color: badgeTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.xxs),
                // Time
                Text(
                  timeAgo(post.createdAt),
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 10,
                    color: context.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.6),
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                // Content text
                Text(
                  post.content,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    color: textColor,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppSpacing.sm),
                // CTA link: "زيارة الصفحة" + arrow
                GestureDetector(
                  onTap: onPageTap,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.l10n.visitPage,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: ctaColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: AppSpacing.xxs),
                      Icon(Icons.arrow_back, size: 10, color: ctaColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
