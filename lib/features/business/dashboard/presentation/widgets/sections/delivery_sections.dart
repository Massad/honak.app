import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/l10n/arb/app_localizations.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';

// ═══════════════════════════════════════════════════════════════
// Delivery Route — progress bar + area breakdown
// ═══════════════════════════════════════════════════════════════

class DeliveryRouteSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const DeliveryRouteSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final completed = (data['completed'] as num?)?.toInt() ?? 0;
    final total = (data['total'] as num?)?.toInt() ?? 1;
    final areas = data['areas'] as List? ?? [];
    final progress = total > 0 ? completed / total : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progress pill
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                context.l10n.bizDeliveryCompleted(completed, total),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: Theme.of(context).colorScheme.outlineVariant,
            valueColor: AlwaysStoppedAnimation(AppColors.primary),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        // Area rows
        ...areas.map((area) {
          final m = area as Map<String, dynamic>;
          final aCompleted = (m['completed'] as num?)?.toInt() ?? 0;
          final aTotal = (m['total'] as num?)?.toInt() ?? 0;
          final isDone = aCompleted >= aTotal && aTotal > 0;
          final isPartial = aCompleted > 0 && aCompleted < aTotal;
          final areaColor = isDone
              ? AppColors.success
              : isPartial
                  ? AppColors.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: areaColor,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '$aCompleted/$aTotal',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: areaColor,
                  ),
                ),
                const Spacer(),
                Text(
                  m['name'] as String? ?? '',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isDone ? Theme.of(context).colorScheme.onSurfaceVariant : null,
                    decoration: isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Low Stock — amber alert container (self-contained bg)
// ═══════════════════════════════════════════════════════════════

class LowStockSection extends StatelessWidget {
  final List<dynamic> items;
  const LowStockSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  context.l10n.bizStockAlert,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.amber.shade800,
                  ),
                ),
              ),
              Icon(
                Icons.warning_amber_outlined,
                size: 16,
                color: Colors.amber.shade600,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ...items.map((item) {
            final m = item as Map<String, dynamic>;
            final remaining = (m['remaining'] as num?)?.toDouble() ?? 0;
            final threshold = (m['threshold'] as num?)?.toDouble() ?? 1;
            final ratio = threshold > 0 ? remaining / threshold : 0.0;

            Color barColor;
            if (ratio < 0.25) {
              barColor = Colors.red;
            } else if (ratio < 0.5) {
              barColor = Colors.orange;
            } else {
              barColor = Colors.amber;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  // Remaining count
                  Text(
                    AppLocalizations.of(context).bizStockRemaining(remaining.toInt()),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber.shade600,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  // Bar
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: LinearProgressIndicator(
                        value: ratio.clamp(0.0, 1.0),
                        minHeight: 8,
                        backgroundColor: Colors.amber.shade100,
                        valueColor: AlwaysStoppedAnimation(barColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  // Item name
                  Expanded(
                    flex: 3,
                    child: Text(
                      m['name'] as String? ?? '',
                      style: context.textTheme.bodySmall,
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Recurring Tomorrow — auto-route preview
// ═══════════════════════════════════════════════════════════════

class RecurringTomorrowSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const RecurringTomorrowSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final totalCustomers = data['total_customers'] ?? 0;
    final totalUnits = data['total_units'] ?? 0;
    final items = data['items'] as List? ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            context.l10n.bizRecurringSummary(totalCustomers as int, totalUnits as int),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.success,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ...items.map((item) {
          final m = item as Map<String, dynamic>;
          return Container(
            margin: const EdgeInsets.only(bottom: AppSpacing.xs),
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(
                  '${m['qty'] ?? 0}×',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    m['schedule'] as String? ?? '',
                    style: TextStyle(
                      fontSize: 9,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const Spacer(),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        m['customer'] as String? ?? '',
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        m['area'] as String? ?? '',
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: AppSpacing.xs),
        Text(
          context.l10n.bizRecurringNote,
          style: TextStyle(
            fontSize: 10,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Customer Insights — severity-colored cards
// ═══════════════════════════════════════════════════════════════

class CustomerInsightsSection extends StatelessWidget {
  final List<dynamic> items;
  const CustomerInsightsSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      children: items.map((item) {
        final m = item as Map<String, dynamic>;
        final type = m['type'] as String? ?? 'info';

        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: _typeBg(type),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _typeBorder(type)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Content (RIGHT in RTL — first child)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      m['customer'] as String? ?? '',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: _typeColor(type),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      m['message'] as String? ?? '',
                      style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              // Icon circle (LEFT in RTL — last child)
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _typeBg(type),
                ),
                child: Icon(
                  _typeIcon(type),
                  size: 12,
                  color: _typeColor(type),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Color _typeColor(String type) => switch (type) {
        'warning' => Colors.amber.shade700,
        'info' => AppColors.primary,
        'positive' => AppColors.success,
        _ => Colors.grey.shade500,
      };

  Color _typeBg(String type) => switch (type) {
        'warning' => Colors.amber.shade50,
        'info' => const Color(0xFFE3F2FD),
        'positive' => const Color(0xFFE8F5E9),
        _ => Colors.grey.shade50,
      };

  Color _typeBorder(String type) => switch (type) {
        'warning' => Colors.amber.shade100,
        'info' => const Color(0xFFBBDEFB),
        'positive' => const Color(0xFFC8E6C9),
        _ => Colors.grey.shade200,
      };

  IconData _typeIcon(String type) => switch (type) {
        'warning' => Icons.warning_amber_outlined,
        'info' => Icons.notifications_outlined,
        'positive' => Icons.star_outline,
        _ => Icons.info_outline,
      };
}
