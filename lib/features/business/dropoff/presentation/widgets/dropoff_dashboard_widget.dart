import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/entities/money.dart';

/// Compact dashboard card showing dropoff tracking stats.
///
/// Shows a 4-column grid (received, processing, ready, delivered),
/// overdue count badge, and today's revenue. Tap navigates to the
/// orders tab (index 1 in business shell).
class DropoffDashboardWidget extends StatelessWidget {
  final int received;
  final int processing;
  final int ready;
  final int delivered;
  final int overdue;
  final int revenueTodayCents;
  final VoidCallback? onOpenBoard;

  const DropoffDashboardWidget({
    super.key,
    required this.received,
    required this.processing,
    required this.ready,
    required this.delivered,
    this.overdue = 0,
    required this.revenueTodayCents,
    this.onOpenBoard,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stats grid — 4 columns
        Row(
          children: [
            _StatTile(
              icon: Icons.inbox_rounded,
              iconColor: AppColors.secondary,
              bgColor: const Color(0xFFFFF8E1),
              value: '$received',
              valueColor: AppColors.secondary,
              label: 'مستلمة',
            ),
            const SizedBox(width: AppSpacing.sm),
            _StatTile(
              icon: Icons.settings_rounded,
              iconColor: AppColors.primary,
              bgColor: const Color(0xFFE3F2FD),
              value: '$processing',
              valueColor: AppColors.primary,
              label: 'قيد المعالجة',
            ),
            const SizedBox(width: AppSpacing.sm),
            _StatTile(
              icon: Icons.check_circle_outline,
              iconColor: AppColors.success,
              bgColor: const Color(0xFFE8F5E9),
              value: '$ready',
              valueColor: AppColors.success,
              label: 'جاهزة',
            ),
            const SizedBox(width: AppSpacing.sm),
            _StatTile(
              icon: Icons.done_all_rounded,
              iconColor: const Color(0xFF616161),
              bgColor: Theme.of(context).colorScheme.surfaceContainerLow,
              value: '$delivered',
              valueColor: const Color(0xFF616161),
              label: 'تم التسليم',
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.md),

        // Overdue alert + revenue row
        Container(
          width: double.infinity,
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            borderRadius: AppRadius.cardInner,
          ),
          child: Row(
            children: [
              // Overdue badge
              if (overdue > 0) ...[
                Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: AppRadius.pill,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 10,
                        color: AppColors.error,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '$overdue متأخر',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.error,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
              ],

              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: AppSpacing.xs + 2),
                    Text(
                      'إيراد اليوم',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                Money(revenueTodayCents).toFormattedArabic(),
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Single stat tile inside the 4-column grid.
class _StatTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String value;
  final Color valueColor;
  final String label;

  const _StatTile({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.value,
    required this.valueColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: AppRadius.cardInner,
        ),
        child: Column(
          children: [
            Icon(icon, size: 12, color: iconColor),
            const SizedBox(height: AppSpacing.xs),
            Text(
              value,
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: context.textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 9,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
