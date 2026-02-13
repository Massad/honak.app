import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';
import 'package:honak/shared/widgets/cached_image.dart';
import 'package:honak/shared/widgets/money_text.dart';
import 'package:honak/shared/widgets/price_change_badge.dart';

/// Horizontal list-style card for menu items.
/// Shows image, title, description, size/option chips, price, and cart controls.
class MenuItemCard extends StatelessWidget {
  final Item item;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  /// Called when "\u0625\u0636\u0627\u0641\u0629" is tapped on items with options.
  /// When non-null, the card shows an "\u0625\u0636\u0627\u0641\u0629" button instead of a stepper.
  final VoidCallback? onAdd;

  /// Active price change to show as badge overlay on the image.
  final PriceChange? activePriceChange;

  const MenuItemCard({
    super.key,
    required this.item,
    required this.quantity,
    required this.onQuantityChanged,
    this.onAdd,
    this.activePriceChange,
  });

  bool get _hasOptions => item.optionGroups.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image with price badge
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: CachedImage(
                          imageUrl: item.images.isNotEmpty
                              ? item.images.first
                              : null,
                          fit: BoxFit.cover,
                          placeholderIcon: Icons.restaurant_outlined,
                        ),
                      ),
                    ),
                    if (activePriceChange != null)
                      PositionedDirectional(
                        top: -4,
                        start: -4,
                        child: PriceChangeBadge(
                          priceChange: activePriceChange!,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: AppSpacing.md),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.nameAr,
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (item.descriptionAr != null &&
                          item.descriptionAr!.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          item.descriptionAr!,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      // Size/option chips
                      if (_hasOptions) ...[
                        const SizedBox(height: AppSpacing.xs),
                        Wrap(
                          spacing: AppSpacing.xxs,
                          runSpacing: AppSpacing.xxs,
                          children: item.optionGroups
                              .map(
                                (g) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.xs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    g.labelAr,
                                    style: context.textTheme.labelSmall
                                        ?.copyWith(
                                      color: Colors.orange.shade800,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                      const SizedBox(height: AppSpacing.sm),
                      // Price + cart controls
                      Row(
                        children: [
                          MoneyText(
                            money: item.price,
                            style: context.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.primary,
                            ),
                          ),
                          const Spacer(),
                          if (item.inStock)
                            _hasOptions && onAdd != null
                                ? _MenuAddButton(
                                    quantity: quantity,
                                    onTap: onAdd!,
                                  )
                                : _MenuCartControls(
                                    quantity: quantity,
                                    onChanged: onQuantityChanged,
                                  ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Out-of-stock overlay
          if (!item.inStock)
            Positioned.fill(
              child: Container(
                color: Colors.white.withValues(alpha: 0.7),
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '\u0646\u0641\u0630',
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.onErrorContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Shows "\u0625\u0636\u0627\u0641\u0629" button for items with options.
class _MenuAddButton extends StatelessWidget {
  final int quantity;
  final VoidCallback onTap;

  const _MenuAddButton({required this.quantity, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Badge(
        isLabelVisible: quantity > 0,
        label: Text('$quantity'),
        offset: const Offset(-4, -4),
        child: FilledButton.tonal(
          onPressed: onTap,
          style: FilledButton.styleFrom(
            backgroundColor: context.colorScheme.primary.withValues(alpha: 0.08),
            foregroundColor: context.colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            visualDensity: VisualDensity.compact,
          ),
          child: const Text('\u0625\u0636\u0627\u0641\u0629'),
        ),
      ),
    );
  }
}

class _MenuCartControls extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;

  const _MenuCartControls({
    required this.quantity,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (quantity == 0) {
      return SizedBox(
        height: 32,
        child: FilledButton.tonal(
          onPressed: () => onChanged(1),
          style: FilledButton.styleFrom(
            backgroundColor: context.colorScheme.primary.withValues(alpha: 0.08),
            foregroundColor: context.colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            visualDensity: VisualDensity.compact,
          ),
          child: const Text('\u0625\u0636\u0627\u0641\u0629'),
        ),
      );
    }

    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => onChanged(quantity - 1),
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(
                Icons.remove,
                size: 18,
                color: context.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: Text(
              '$quantity',
              style: context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          InkWell(
            onTap: () => onChanged(quantity + 1),
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(
                Icons.add,
                size: 18,
                color: context.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
