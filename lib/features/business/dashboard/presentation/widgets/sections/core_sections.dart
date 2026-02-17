import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/l10n/arb/app_localizations.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';

String formatJod(dynamic amount) {
  if (amount == null) return '0';
  final jod = (amount as num) / 100;
  if (jod == jod.truncateToDouble()) return jod.toInt().toString();
  return jod.toStringAsFixed(2);
}

// ═══════════════════════════════════════════════════════════════
// Today's Summary — completed, upcoming, cancelled, revenue
// ═══════════════════════════════════════════════════════════════

class TodaySummarySection extends StatelessWidget {
  final Map<String, dynamic> data;
  const TodaySummarySection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SummaryChip(
          label: context.l10n.bizSummaryCompleted,
          value: '${data['completed'] ?? 0}',
          color: AppColors.success,
        ),
        const SizedBox(width: AppSpacing.sm),
        SummaryChip(
          label: context.l10n.bizSummaryUpcoming,
          value: '${data['upcoming'] ?? 0}',
          color: AppColors.primary,
        ),
        const SizedBox(width: AppSpacing.sm),
        SummaryChip(
          label: context.l10n.bizSummaryCancelled,
          value: '${data['cancelled'] ?? 0}',
          color: AppColors.error,
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${formatJod(data['revenue'])} ${context.l10n.bizRevenueCurrency}',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.success,
              ),
            ),
            Text(
              context.l10n.bizSummaryTodayRevenue,
              style: context.textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SummaryChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const SummaryChip({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(label, style: TextStyle(fontSize: 9, color: color)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Today's Revenue — total + breakdown
// ═══════════════════════════════════════════════════════════════

class TodayRevenueSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const TodayRevenueSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final items = data['items'] as List? ?? [];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.bizRevenueServicesCount((data['completed_count'] as num?)?.toInt() ?? 0),
              style: context.textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              '${formatJod(data['total'])} ${context.l10n.bizRevenueCurrency}',
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.success,
              ),
            ),
          ],
        ),
        if (items.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          const Divider(height: 1),
          const SizedBox(height: AppSpacing.sm),
          ...items.map((item) {
            final m = item as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Text(
                    m['time'] as String? ?? '',
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    '${formatJod(m['amount'])} ${AppLocalizations.of(context).bizRevenueCurrency}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.success,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    m['service'] as String? ?? '',
                    style: context.textTheme.bodySmall,
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Pending Requests — orange cards
// ═══════════════════════════════════════════════════════════════

class PendingRequestsSection extends StatelessWidget {
  final List<dynamic> items;
  const PendingRequestsSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      children: items.map((item) {
        final m = item as Map<String, dynamic>;
        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.orange.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    m['date'] as String? ?? '',
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    m['time'] as String? ?? '',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange.shade700,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    m['customer'] as String? ?? '',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    m['service'] as String? ?? '',
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
