import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/queue/domain/entities/customer_queue_entry.dart';
import 'package:honak/shared/entities/money.dart';

/// White card showing selected package, add-ons, and total.
/// Reused in waiting and in-progress tracker states.
class QueueSelectionSummary extends StatelessWidget {
  final CustomerQueueEntry entry;

  const QueueSelectionSummary({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final packagePrice = Money(entry.packagePriceCents);
    final total = Money(entry.totalPriceCents);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                entry.packageName,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                packagePrice.toFormattedArabic(),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          if (entry.addOns.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            ...entry.addOns.map(
              (a) => Padding(
                padding:
                    const EdgeInsetsDirectional.only(top: AppSpacing.xxs),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '+ ${a.name}',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      Money(a.price).toFormattedArabic(),
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'المجموع',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  total.toFormattedArabic(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
