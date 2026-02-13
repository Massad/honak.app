import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/home/domain/entities/post.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/widgets/app_badge.dart';
import 'package:honak/shared/widgets/app_image.dart';
import 'package:honak/shared/widgets/money_text.dart';

import 'post_card_helpers.dart';

// ── Product → Horizontal card: image side + content side ────────────────────

class ProductCardBody extends StatelessWidget {
  final Post post;
  final VoidCallback? onPageTap;
  final VoidCallback? onProductTap;

  const ProductCardBody({
    super.key,
    required this.post,
    this.onPageTap,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    final itemName = post.metadata?['item_name'] as String?;
    final priceCents = post.metadata?['price_cents'] as int?;
    final hasImage = post.media.isNotEmpty;

    return Row(
      children: [
        // Image side with price badge overlay
        if (hasImage)
          SizedBox(
            width: 130,
            height: 140,
            child: Stack(
              children: [
                Positioned.fill(
                  child: AppImage(
                    url: post.media.first.url,
                    width: 130,
                    height: 140,
                  ),
                ),
                // Price badge overlay
                if (priceCents != null)
                  PositionedDirectional(
                    bottom: AppSpacing.sm,
                    start: AppSpacing.sm,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0D000000),
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: MoneyText(
                        money: Money(priceCents),
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: 11,
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        // Content side
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Business info: avatar + name + verified badge
                GestureDetector(
                  onTap: onPageTap,
                  child: Row(
                    children: [
                      AppImage.avatar(
                        url: post.page.avatarUrl,
                        name: post.page.name,
                        radius: 12,
                      ),
                      SizedBox(width: AppSpacing.xs),
                      Flexible(
                        child: Text(
                          post.page.name,
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (post.page.isVerified) ...[
                        SizedBox(width: AppSpacing.xxs),
                        Icon(Icons.verified,
                            size: 11, color: context.colorScheme.primary),
                      ],
                    ],
                  ),
                ),
                // Product title
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (itemName != null)
                      Text(
                        itemName,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                          color: context.colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    SizedBox(height: AppSpacing.xs),
                    // "منتج جديد" badge
                    AppBadge.small(
                      label: context.l10n.postTypeProduct,
                      color: context.colorScheme.primary,
                      icon: Icons.shopping_bag_outlined,
                    ),
                  ],
                ),
                // CTA row: time + add button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      timeAgo(post.createdAt),
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: 10,
                        color: context.colorScheme.onSurfaceVariant
                            .withValues(alpha: 0.6),
                      ),
                    ),
                    GestureDetector(
                      onTap: onProductTap,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary,
                          borderRadius:
                              BorderRadius.circular(AppRadius.sm),
                        ),
                        child: Text(
                          context.l10n.addProduct,
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
