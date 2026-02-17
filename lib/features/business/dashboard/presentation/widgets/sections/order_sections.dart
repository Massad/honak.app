import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/l10n/arb/app_localizations.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';

// ═══════════════════════════════════════════════════════════════
// Active Queue — preparing/waiting orders for restaurants/cafes
// ═══════════════════════════════════════════════════════════════

class ActiveQueueSection extends StatelessWidget {
  final List<dynamic> items;
  const ActiveQueueSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...items.map((item) {
          final m = item as Map<String, dynamic>;
          final status = m['status'] as String? ?? 'waiting';
          final isPreparing = status == 'preparing';
          final customer = m['customer'] as String? ?? '';
          final orderItems = m['items'] as String? ?? '';

          return Container(
            margin: const EdgeInsets.only(bottom: AppSpacing.sm),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: isPreparing
                  ? Colors.orange.shade50
                  : Theme.of(context).colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                // Time or "بانتظار"
                Text(
                  isPreparing
                      ? (m['time'] as String? ?? '')
                      : context.l10n.bizQueueWaiting,
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                // Customer — items (single line)
                Expanded(
                  child: Text(
                    '$customer — $orderItems',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                // Status dot
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isPreparing
                        ? Colors.orange
                        : Theme.of(context).colorScheme.outline,
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
// Unavailable Items — red alert container (self-contained bg)
// ═══════════════════════════════════════════════════════════════

class UnavailableItemsSection extends StatelessWidget {
  final List<dynamic> items;
  const UnavailableItemsSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context).bizUnavailableItems(items.length),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.red.shade700,
                  ),
                ),
              ),
              Icon(
                Icons.cancel_outlined,
                size: 16,
                color: Colors.red.shade400,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: items.map((item) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  item as String? ?? '',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.red.shade700,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            AppLocalizations.of(context).bizUnavailableReactivate,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.red.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Best Sellers — ranked list with trend arrows
// ═══════════════════════════════════════════════════════════════

class BestSellersSection extends StatelessWidget {
  final List<dynamic> items;
  const BestSellersSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      children: List.generate(items.length, (i) {
        final m = items[i] as Map<String, dynamic>;
        final trend = m['trend'] as String? ?? 'same';
        final count = m['count'] ?? 0;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              // Rank circle (RIGHT in RTL)
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i < 3
                      ? AppColors.success.withValues(alpha: 0.1)
                      : Theme.of(context).colorScheme.surfaceContainerLow,
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: i < 3 ? AppColors.success : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              // Item name (CENTER — fills available space)
              Expanded(
                child: Text(
                  m['name'] as String? ?? '',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              // Trend arrow + count (LEFT in RTL)
              Icon(
                _trendIcon(trend),
                size: 14,
                color: _trendColor(trend),
              ),
              const SizedBox(width: 4),
              Text(
                '$count',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: _trendColor(trend),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  IconData _trendIcon(String trend) => switch (trend) {
        'up' => Icons.arrow_upward,
        'down' => Icons.arrow_downward,
        _ => Icons.remove,
      };

  Color _trendColor(String trend) => switch (trend) {
        'up' => AppColors.success,
        'down' => AppColors.error,
        _ => Colors.grey.shade500,
      };
}
