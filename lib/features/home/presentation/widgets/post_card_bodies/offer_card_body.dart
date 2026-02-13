import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/home/domain/entities/post.dart';
import 'package:honak/shared/widgets/cached_image.dart';

import 'post_card_helpers.dart';

// ── Offer → Full-width gradient RED banner with image side ──────────────────

class OfferCardBody extends StatelessWidget {
  final Post post;
  final VoidCallback? onPageTap;

  const OfferCardBody({
    super.key,
    required this.post,
    this.onPageTap,
  });

  @override
  Widget build(BuildContext context) {
    final expiresAt = post.metadata?['expires_at'] as int?;
    final isExpired = expiresAt != null &&
        DateTime.fromMillisecondsSinceEpoch(expiresAt * 1000)
            .isBefore(DateTime.now());
    final hasImage = post.media.isNotEmpty;

    return Opacity(
      opacity: isExpired ? 0.5 : 1.0,
      child: SizedBox(
        height: 130,
        child: Row(
          children: [
            // Text side
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Business header (dark mode)
                    GestureDetector(
                      onTap: onPageTap,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.5),
                                width: 1.5,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor:
                                  Colors.white.withValues(alpha: 0.2),
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
                                        fontSize: 8,
                                        color: Colors.white,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                          SizedBox(width: AppSpacing.xs),
                          Flexible(
                            child: Text(
                              post.page.name,
                              style: context.textTheme.bodySmall?.copyWith(
                                fontSize: 10,
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Icon row: flame + "عرض خاص"
                    Row(
                      children: [
                        Icon(Icons.local_fire_department,
                            size: 14, color: const Color(0xFFFFF176)),
                        SizedBox(width: AppSpacing.xxs),
                        Text(
                          context.l10n.specialOffer,
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 10,
                            color: const Color(0xFFFFF176),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    // Content text
                    if (post.content.isNotEmpty)
                      Flexible(
                        child: Text(
                          post.content,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    // CTA row: button + expiry
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onPageTap,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                              vertical: AppSpacing.sm,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(14),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x0D000000),
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Text(
                              context.l10n.shopNow,
                              style: context.textTheme.bodySmall?.copyWith(
                                fontSize: 12,
                                color: const Color(0xFFE53935),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: AppSpacing.sm),
                        if (expiresAt != null)
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.access_time,
                                    size: 10,
                                    color: Colors.white
                                        .withValues(alpha: 0.7)),
                                SizedBox(width: AppSpacing.xxs),
                                Flexible(
                                  child: Text(
                                    offerExpiryText(context.l10n, expiresAt),
                                    style:
                                        context.textTheme.bodySmall?.copyWith(
                                      fontSize: 10,
                                      color: Colors.white
                                          .withValues(alpha: 0.7),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Image side (if has image)
            if (hasImage)
              SizedBox(
                width: 120,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CachedImage(
                        imageUrl: post.media.first.url,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Gradient overlay for blending
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: AlignmentDirectional.centerEnd,
                            end: AlignmentDirectional.centerStart,
                            colors: [
                              Colors.transparent,
                              const Color(0xFFE53935).withValues(alpha: 0.8),
                            ],
                          ),
                        ),
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
