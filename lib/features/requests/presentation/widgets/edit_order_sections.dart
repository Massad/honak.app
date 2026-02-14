import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/domain/entities/customer_request.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/core/extensions/context_ext.dart';

/// Editable item state used by the edit order sheet.
class EditableItem {
  final OrderLineItem original;
  final int quantity;
  final bool removed;

  const EditableItem({
    required this.original,
    required this.quantity,
    required this.removed,
  });

  EditableItem copyWith({int? quantity, bool? removed}) => EditableItem(
        original: original,
        quantity: quantity ?? this.quantity,
        removed: removed ?? this.removed,
      );
}

/// A single item row with quantity controls and delete button.
class EditOrderItemRow extends StatelessWidget {
  final EditableItem item;
  final VoidCallback onRemove;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const EditOrderItemRow({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final lineTotal =
        (item.original.price ?? const Money.zero()) * item.quantity;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: AppRadius.cardInner,
        border:
            Border.all(color: context.colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.original.name,
                style: textTheme.bodySmall
                    ?.copyWith(color: context.colorScheme.onSurface),
              ),
              InkWell(
                onTap: onRemove,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.delete_outline,
                      size: 16, color: context.colorScheme.onSurfaceVariant),
                ),
              ),
            ],
          ),
          if (item.original.variation != null)
            Text(
              item.original.variation!,
              style: textTheme.labelSmall
                  ?.copyWith(color: AppColors.primary),
            ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  QtyButton(
                    icon: Icons.remove,
                    onTap: onDecrement,
                    isAccent: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm),
                    child: Text('${item.quantity}',
                        style: textTheme.bodySmall),
                  ),
                  QtyButton(
                    icon: Icons.add,
                    onTap: onIncrement,
                    isAccent: true,
                  ),
                ],
              ),
              Text(
                lineTotal.toFormattedArabic(),
                style: textTheme.bodySmall
                    ?.copyWith(color: context.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Quantity increment/decrement button.
class QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isAccent;

  const QtyButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.isAccent,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isAccent ? AppColors.primary : context.colorScheme.outlineVariant,
          ),
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 12,
          color: isAccent ? AppColors.primary : context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

/// Change entry data for the diff card.
class ChangeEntry {
  final String name;
  final String field;
  final String from;
  final String to;
  const ChangeEntry(this.name, this.field, this.from, this.to);
}

/// Changes diff card showing what was modified.
class EditOrderChangesDiff extends StatelessWidget {
  final List<EditableItem> items;

  const EditOrderChangesDiff({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final changes = <ChangeEntry>[];

    for (final item in items) {
      if (item.removed) {
        changes.add(
            ChangeEntry(item.original.name, 'الحالة', 'موجود', 'محذوف'));
      } else if (item.quantity != item.original.quantity) {
        changes.add(ChangeEntry(item.original.name, 'الكمية',
            '${item.original.quantity}', '${item.quantity}'));
      }
    }

    if (changes.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Container(
        padding: const EdgeInsetsDirectional.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E1),
          border: Border.all(color: const Color(0xFFFFE082)),
          borderRadius: AppRadius.cardInner,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.edit_outlined,
                    size: 13, color: Color(0xFFFF8F00)),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'التغييرات المطلوبة',
                  style: textTheme.labelSmall
                      ?.copyWith(color: const Color(0xFFFF8F00)),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ...changes.map(
              (c) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: Text(
                  '${c.name}: ${c.field} ${c.from} ← ${c.to}',
                  style: textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Total row with optional strikethrough for original price.
class EditOrderTotal extends StatelessWidget {
  final Money originalTotal;
  final Money newTotal;

  const EditOrderTotal({
    super.key,
    required this.originalTotal,
    required this.newTotal,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hasChanged = originalTotal != newTotal;

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: AppRadius.cardInner,
        border:
            Border.all(color: context.colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'المجموع',
            style: textTheme.bodySmall
                ?.copyWith(color: context.colorScheme.onSurface),
          ),
          Row(
            children: [
              if (hasChanged) ...[
                Text(
                  originalTotal.toFormattedArabic(),
                  style: textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(
                newTotal.toFormattedArabic(),
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
