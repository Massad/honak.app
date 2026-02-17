import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/entities/money.dart';

/// Compact queue status widget for the business dashboard.
///
/// Shows a 4-column stats grid (waiting, in-progress, completed, revenue),
/// current average wait time, and a tap-to-open action.
class QueueDashboardWidget extends StatelessWidget {
  final int waiting;
  final int inProgress;
  final int completed;
  final int avgWaitMin;
  final int revenueTodayCents;
  final VoidCallback? onOpenBoard;

  const QueueDashboardWidget({
    super.key,
    required this.waiting,
    required this.inProgress,
    required this.completed,
    required this.avgWaitMin,
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
              icon: Icons.access_time,
              iconColor: const Color(0xFFFF9800),
              bgColor: const Color(0xFFFFF8E1),
              value: '$waiting',
              valueColor: const Color(0xFFFF9800),
              label: context.l10n.queueLabelWaiting,
            ),
            const SizedBox(width: AppSpacing.sm),
            _StatTile(
              icon: Icons.play_arrow,
              iconColor: AppColors.primary,
              bgColor: const Color(0xFFE3F2FD),
              value: '$inProgress',
              valueColor: AppColors.primary,
              label: context.l10n.queueInProgress,
            ),
            const SizedBox(width: AppSpacing.sm),
            _StatTile(
              icon: Icons.check_circle_outline,
              iconColor: AppColors.success,
              bgColor: const Color(0xFFE8F5E9),
              value: '$completed',
              valueColor: AppColors.success,
              label: context.l10n.queueCompleted,
            ),
            const SizedBox(width: AppSpacing.sm),
            _StatTile(
              icon: Icons.trending_up,
              iconColor: const Color(0xFF9C27B0),
              bgColor: const Color(0xFFF3E5F5),
              value: Money(revenueTodayCents).toJodString(),
              valueColor: const Color(0xFF9C27B0),
              label: context.l10n.queueRevenueJod,
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.md),

        // Wait time indicator
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
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: AppSpacing.xs + 2),
                    Text(
                      context.l10n.queueCurrentWaitTime,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                context.l10n.queueApproxMinutes(avgWaitMin),
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
