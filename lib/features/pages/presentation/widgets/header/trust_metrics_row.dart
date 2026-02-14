import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/trust_metric.dart';

/// Trust metrics row: 3 or fewer metrics in an evenly-spaced row,
/// more than 3 in a horizontal scroll.
/// Matches Figma: `bg-gray-50 rounded-xl p-3 border border-gray-100`
/// with label on top (12px gray) and value below (16px bold).
class TrustMetricsRow extends StatelessWidget {
  final List<TrustMetric> metrics;
  final int trustScore;

  const TrustMetricsRow({
    super.key,
    required this.metrics,
    required this.trustScore,
  });

  @override
  Widget build(BuildContext context) {
    if (metrics.isEmpty) return const SizedBox.shrink();

    if (metrics.length <= 3) {
      return Row(
        children: [
          for (int i = 0; i < metrics.length; i++) ...[
            if (i > 0) SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _MetricCard(
                label: metrics[i].label,
                value: metrics[i].value,
              ),
            ),
          ],
        ],
      );
    }

    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: metrics.length,
        separatorBuilder: (_, __) => SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final metric = metrics[index];
          return _MetricCard(label: metric.label, value: metric.value);
        },
      ),
    );
  }
}

/// Single metric card: bg-gray-50, border gray-100, rounded-xl (12px),
/// padding 12px. Label on top (12px, gray-500), value below (16px, bold).
class _MetricCard extends StatelessWidget {
  final String label;
  final String value;

  const _MetricCard({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 100),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 12,
              color: context.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: context.textTheme.bodyLarge?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
