import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/directory_management/domain/entities/directory_manage_stats.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant_status.dart';

/// Stats row — 5 compact cards in a single horizontal row.
///
/// Matches Figma: جديد | غير مربوط | مدعو | مربوط | إجمالي
/// Tapping a stat card filters the tenant list by that status.
class TenantDirectoryStats extends StatelessWidget {
  final DirectoryManageStats stats;
  final String? activeFilter;
  final ValueChanged<String?> onFilterChanged;

  const TenantDirectoryStats({
    super.key,
    required this.stats,
    required this.activeFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _StatItem(
        label: TenantStatus.newTenant.label,
        count: stats.newThisWeek,
        color: TenantStatus.newTenant.color,
        bgColor: TenantStatus.newTenant.color.withValues(alpha: 0.08),
        filterKey: 'new',
      ),
      _StatItem(
        label: TenantStatus.unclaimed.label,
        count: stats.unclaimed,
        color: TenantStatus.unclaimed.color,
        bgColor: TenantStatus.unclaimed.color.withValues(alpha: 0.08),
        filterKey: 'unclaimed',
      ),
      _StatItem(
        label: TenantStatus.invited.label,
        count: stats.invited,
        color: TenantStatus.invited.color,
        bgColor: TenantStatus.invited.color.withValues(alpha: 0.08),
        filterKey: 'invited',
      ),
      _StatItem(
        label: TenantStatus.claimed.label,
        count: stats.claimed,
        color: TenantStatus.claimed.color,
        bgColor: TenantStatus.claimed.color.withValues(alpha: 0.08),
        filterKey: 'claimed',
      ),
      _StatItem(
        label: 'إجمالي',
        count: stats.total,
        color: context.colorScheme.onSurface,
        bgColor: context.colorScheme.surfaceContainerHighest,
        filterKey: null,
      ),
    ];

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: Row(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            if (i > 0) const SizedBox(width: AppSpacing.xs),
            Expanded(child: _buildCard(context, items[i])),
          ],
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, _StatItem item) {
    final isActive = activeFilter == item.filterKey;

    return GestureDetector(
      onTap: () => onFilterChanged(
        isActive ? null : item.filterKey,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isActive ? item.color.withValues(alpha: 0.12) : item.bgColor,
          borderRadius: AppRadius.cardInner,
          border: isActive
              ? Border.all(color: item.color, width: 1.5)
              : Border.all(color: Colors.transparent),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${item.count}',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: item.color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.label,
              style: context.textTheme.labelSmall?.copyWith(
                color: item.color.withValues(alpha: 0.8),
                fontSize: 10,
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

class _StatItem {
  final String label;
  final int count;
  final Color color;
  final Color bgColor;
  final String? filterKey;

  const _StatItem({
    required this.label,
    required this.count,
    required this.color,
    required this.bgColor,
    required this.filterKey,
  });
}
