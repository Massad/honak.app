import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';

/// 3-column colored stat cards for directory quick stats.
class DirectoryStatsGrid extends StatelessWidget {
  final DirectoryStats stats;

  const DirectoryStatsGrid({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              icon: Icons.storefront,
              // "\u0639\u0644\u0649 \u0647\u0646\u0627\u0643" = على هناك
              label: '\u0639\u0644\u0649 \u0647\u0646\u0627\u0643',
              value: '${stats.onHonak}/${stats.totalTenants}',
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _StatCard(
              icon: Icons.access_time,
              // "\u0645\u0641\u062a\u0648\u062d \u0627\u0644\u0622\u0646" = مفتوح الآن
              label: '\u0645\u0641\u062a\u0648\u062d \u0627\u0644\u0622\u0646',
              value: '${stats.openNow}',
              color: Colors.green,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _StatCard(
              icon: Icons.layers,
              // "\u0637\u0648\u0627\u0628\u0642" = طوابق
              label: '\u0637\u0648\u0627\u0628\u0642',
              value: '${stats.floors}',
              color: Colors.purple,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: AppRadius.cardInner,
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
