import 'package:flutter/material.dart';
import 'package:honak/config/business_type_config.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/shared/domain/entities/biz_item.dart';
import 'package:honak/shared/widgets/app_badge.dart';
import 'package:honak/shared/widgets/app_image.dart';

class ItemCard extends StatelessWidget {
  final BizItem item;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final ItemManagementConfig? config;
  final bool isSelected;
  final bool selectModeActive;

  const ItemCard({
    super.key,
    required this.item,
    this.onTap,
    this.onLongPress,
    this.config,
    this.isSelected = false,
    this.selectModeActive = false,
  });

  bool get _isInactive =>
      item.status == 'out_of_stock' || item.status == 'hidden';

  int? get _durationMinutes {
    final v = item.properties['duration_minutes'];
    return v is int ? v : null;
  }

  String? _variantSummary(BuildContext context) {
    final parts = <String>[];
    if (config != null) {
      for (final prop in config!.properties) {
        if (prop.type == ItemPropertyType.chipList) {
          final val = item.properties[prop.id];
          if (val is List && val.isNotEmpty) {
            parts.add('${val.length} ${prop.labelAr}');
          }
        }
      }
    }
    final dur = _durationMinutes;
    if (dur != null) parts.add('$dur ${context.l10n.bizItemMinutes}');
    return parts.isEmpty ? null : parts.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final showImage = config?.hasImage ?? true;
    final showPrice = (config?.hasPrice ?? true) && item.price != null;
    final showCategory =
        (config?.hasCategory ?? true) && item.categoryName != null;
    final showStock = _shouldShowStock;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.03)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.surfaceContainerLow,
          ),
          boxShadow: isSelected
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Opacity(
          opacity: _isInactive ? 0.5 : 1.0,
          child: Padding(
            padding: const EdgeInsetsDirectional.all(AppSpacing.md),
            child: Row(
              children: [
                // -- Selection checkbox --
                if (selectModeActive) ...[
                  Icon(
                    isSelected
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    size: 22,
                    color:
                        isSelected ? AppColors.primary : Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                ],

                // -- Image thumbnail --
                if (showImage) ...[
                  _ItemImage(item: item),
                  const SizedBox(width: AppSpacing.md),
                ],

                // -- Info column --
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name + status badge
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (item.status != 'active') ...[
                            const SizedBox(width: AppSpacing.sm),
                            _StatusBadge(status: item.status),
                          ],
                        ],
                      ),

                      // Price row
                      if (showPrice) ...[
                        const SizedBox(height: 2),
                        _PriceRow(item: item),
                      ],

                      // Discount badges
                      if (item.discountPercent != null &&
                          item.discountPercent! > 0) ...[
                        const SizedBox(height: AppSpacing.xs),
                        _DiscountBadges(item: item),
                      ],

                      // Variant summary
                      Builder(builder: (context) {
                        final summary = _variantSummary(context);
                        if (summary == null) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            summary,
                            style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        );
                      }),

                      // Category tag
                      if (showImage && showCategory) ...[
                        const SizedBox(height: AppSpacing.xs),
                        AppBadge.small(
                          label: item.categoryName!,
                          color: AppColors.primary,
                          pill: true,
                        ),
                      ],
                    ],
                  ),
                ),

                // Stock indicator pill
                if (showStock) ...[
                  const SizedBox(width: AppSpacing.sm),
                  _StockPill(stock: item.stock!),
                ],

                // Chevron (hidden in select mode)
                if (!selectModeActive)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: AppSpacing.sm),
                    child: Icon(
                      Icons.chevron_left,
                      size: 20,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool get _shouldShowStock {
    if (config == null || item.stock == null) return false;
    return config!.quantityMode == QuantityMode.perItem ||
        config!.quantityMode == QuantityMode.perVariant;
  }
}

// ===============================================================
// Image thumbnail -- 60x60 rounded
// ===============================================================

class _ItemImage extends StatelessWidget {
  final BizItem item;

  const _ItemImage({required this.item});

  @override
  Widget build(BuildContext context) {
    final imageUrl = item.images.isNotEmpty ? item.images.first : null;

    return Stack(
      children: [
        AppImage(
          url: imageUrl,
          width: 60,
          height: 60,
          borderRadius: AppRadius.cardInner,
          placeholderIcon: Icons.inventory_2_outlined,
        ),
        // Discount badge overlay
        if (item.discountPercent != null && item.discountPercent! > 0)
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.md),
                  bottomRight: Radius.circular(AppRadius.sm),
                ),
              ),
              child: Text(
                '${item.discountPercent}%-',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ===============================================================
// Status badge -- active/out_of_stock/hidden
// ===============================================================

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (label, color) = switch (status) {
      'active' => (l10n.bizItemAvailable, AppColors.success),
      'out_of_stock' => (l10n.bizItemOutOfStock, AppColors.warning),
      'hidden' => (l10n.bizItemHidden, Theme.of(context).colorScheme.onSurfaceVariant),
      _ => (l10n.bizItemUnknown, Theme.of(context).colorScheme.onSurfaceVariant),
    };

    return AppBadge.small(label: label, color: color, pill: true);
  }
}

// ===============================================================
// Price row -- current + original (strikethrough)
// ===============================================================

class _PriceRow extends StatelessWidget {
  final BizItem item;

  const _PriceRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final hasDiscount =
        item.discountPercent != null && item.originalPrice != null;

    final priceColor = hasDiscount
        ? AppColors.error
        : item.status == 'active'
            ? AppColors.primary
            : context.colorScheme.onSurface;

    return Row(
      children: [
        Text(
          item.price?.toFormattedArabic() ?? '',
          style: context.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: priceColor,
          ),
        ),
        if (hasDiscount) ...[
          const SizedBox(width: AppSpacing.sm),
          Text(
            item.originalPrice!.toFormattedArabic(),
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              decoration: TextDecoration.lineThrough,
              decorationColor: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

// ===============================================================
// Discount badges -- percentage + limited time
// ===============================================================

class _DiscountBadges extends StatelessWidget {
  final BizItem item;

  const _DiscountBadges({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Discount percentage badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Text(
            '-${item.discountPercent}٪',
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: AppColors.error,
            ),
          ),
        ),
        // Limited time badge
        if (item.discountEnds != null) ...[
          const SizedBox(width: AppSpacing.xs),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time,
                  size: 7,
                  color: Colors.orange.shade700,
                ),
                const SizedBox(width: 2),
                Text(
                  context.l10n.bizItemLimited,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

// ===============================================================
// Stock indicator pill
// ===============================================================

class _StockPill extends StatelessWidget {
  final int stock;

  const _StockPill({required this.stock});

  @override
  Widget build(BuildContext context) {
    final (label, bgColor, textColor) = stock > 10
        ? ('$stock', AppColors.success.withValues(alpha: 0.1), AppColors.success)
        : stock > 0
            ? ('$stock',
                AppColors.warning.withValues(alpha: 0.1), AppColors.warning)
            : (context.l10n.bizItemSoldOut,
                AppColors.error.withValues(alpha: 0.1), AppColors.error);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
