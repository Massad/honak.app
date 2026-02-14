import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/directory_management/domain/entities/directory_manage_stats.dart';

/// Visual progress bar showing claimed vs invited tenant coverage.
///
/// Displays a segmented bar (green = claimed, orange = invited)
/// with percentage and "X من Y وحدة" label.
class TenantCoverageBar extends StatelessWidget {
  final DirectoryManageStats stats;

  const TenantCoverageBar({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final total = stats.total;
    if (total == 0) return SizedBox.shrink();

    final claimedFraction = stats.claimed / total;
    final invitedFraction = stats.invited / total;
    final combinedPercent =
        ((claimedFraction + invitedFraction) * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Percentage + label
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$combinedPercent% تغطية',
              style: context.textTheme.titleSmall,
            ),
            Text(
              '${stats.claimed + stats.invited} من $total وحدة',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        // Segmented bar
        ClipRRect(
          borderRadius: AppRadius.pill,
          child: SizedBox(
            height: 8,
            child: Row(
              children: [
                if (claimedFraction > 0)
                  Flexible(
                    flex: (claimedFraction * 1000).round(),
                    child: Container(color: const Color(0xFF16A34A)),
                  ),
                if (invitedFraction > 0)
                  Flexible(
                    flex: (invitedFraction * 1000).round(),
                    child: Container(color: const Color(0xFFF59E0B)),
                  ),
                Flexible(
                  flex: ((1 - claimedFraction - invitedFraction) * 1000)
                      .round()
                      .clamp(0, 1000),
                  child: Container(
                    color: context.colorScheme.surfaceContainerHighest,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Legend
        Row(
          children: [
            _LegendDot(
              color: Color(0xFF16A34A),
              label: 'مربوط (${stats.claimed})',
            ),
            const SizedBox(width: AppSpacing.lg),
            _LegendDot(
              color: Color(0xFFF59E0B),
              label: 'مدعو (${stats.invited})',
            ),
            SizedBox(width: AppSpacing.lg),
            _LegendDot(
              color: context.colorScheme.surfaceContainerHighest,
              label: 'غير مربوط (${stats.unclaimed})',
            ),
          ],
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
