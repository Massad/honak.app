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
        color: Colors.white,
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                entry.packageName,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                packagePrice.toFormattedArabic(),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
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
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      Money(a.price).toFormattedArabic(),
                      style: context.textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
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
                    color: AppColors.textPrimary,
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
