import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/shared/widgets/money_text.dart';

/// Card for a service item in the service booking section.
/// Shows name, description, duration badge, price, and action buttons.
class ServiceItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback? onBook;

  const ServiceItemCard({super.key, required this.item, this.onBook});

  @override
  Widget build(BuildContext context) {
    final durationMinutes = item.sortOrder > 0 ? item.sortOrder : 30;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.nameAr,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                // Duration badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 12,
                        color: context.colorScheme.onSecondaryContainer,
                      ),
                      const SizedBox(width: AppSpacing.xxs),
                      Text(
                        '$durationMinutes د',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (item.descriptionAr != null &&
                item.descriptionAr!.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                item.descriptionAr!,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: AppSpacing.sm),
            // Price row
            Row(
              children: [
                MoneyText(
                  money: item.price,
                  style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                ),
                if (item.optionGroups.isNotEmpty) ...[
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    '(${item.optionGroups.length} خيارات)',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                if (!item.inStock) ...[
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xxs,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'غير متاح',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            // Action buttons
            Row(
              textDirection: TextDirection.ltr,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: item.inStock ? () {} : null,
                    child: const Text('تواصل'),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: FilledButton(
                    onPressed: item.inStock ? onBook : null,
                    child: const Text('احجز'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
