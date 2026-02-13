import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/queue/domain/entities/customer_queue_entry.dart';
import 'package:honak/shared/entities/money.dart';

/// Green gradient card shown when the customer's service is ready.
class QueueReadyCard extends StatelessWidget {
  final CustomerQueueEntry entry;

  const QueueReadyCard({super.key, required this.entry});

  static const _gradientGreen = LinearGradient(
    colors: [Color(0xFF43A047), Color(0xFF2E7D32)],
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
  );

  @override
  Widget build(BuildContext context) {
    final total = Money(entry.totalPriceCents);

    return Container(
      decoration: BoxDecoration(
        gradient: _gradientGreen,
        borderRadius: AppRadius.card,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          const Icon(Icons.check_circle, size: 48, color: Colors.white),
          const SizedBox(height: AppSpacing.md),
          Text(
            'سيارتك جاهزة!',
            style: context.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Service summary
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: AppRadius.cardInner,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.packageName,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      total.toFormattedArabic(),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                if (entry.addOns.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xs),
                  ...entry.addOns.map(
                    (a) => Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: AppSpacing.xxs,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '+ ${a.name}',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            Money(a.price).toFormattedArabic(),
                            style: context.textTheme.labelSmall?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Payment methods
          if (entry.paymentMethods.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: AppRadius.cardInner,
              ),
              child: Row(
                children: [
                  const Icon(Icons.payment, size: 16, color: Colors.white70),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'ادفع عند الاستلام — ${entry.paymentMethods.join(' / ')}',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                      ),
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
