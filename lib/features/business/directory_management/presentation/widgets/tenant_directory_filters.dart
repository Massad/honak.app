import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/directory_management/domain/entities/directory_manage_stats.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant_status.dart';

/// Horizontal status filter chips + search bar for tenant directory.
class TenantDirectoryFilters extends StatelessWidget {
  final DirectoryManageStats stats;
  final String? activeStatusFilter;
  final ValueChanged<String?> onStatusFilterChanged;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;

  const TenantDirectoryFilters({
    super.key,
    required this.stats,
    required this.activeStatusFilter,
    required this.onStatusFilterChanged,
    required this.searchQuery,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Status filter chips
        SizedBox(
          height: 36,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.lg,
            ),
            children: [
              _FilterChip(
                label: 'الكل',
                count: stats.total,
                isActive: activeStatusFilter == null,
                color: context.colorScheme.onSurface,
                onTap: () => onStatusFilterChanged(null),
              ),
              const SizedBox(width: AppSpacing.sm),
              _FilterChip(
                label: TenantStatus.claimed.label,
                count: stats.claimed,
                isActive: activeStatusFilter == 'claimed',
                color: TenantStatus.claimed.color,
                onTap: () => onStatusFilterChanged(
                  activeStatusFilter == 'claimed' ? null : 'claimed',
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              _FilterChip(
                label: TenantStatus.newTenant.label,
                count: stats.newThisWeek,
                isActive: activeStatusFilter == 'new',
                color: TenantStatus.newTenant.color,
                onTap: () => onStatusFilterChanged(
                  activeStatusFilter == 'new' ? null : 'new',
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              _FilterChip(
                label: TenantStatus.invited.label,
                count: stats.invited,
                isActive: activeStatusFilter == 'invited',
                color: TenantStatus.invited.color,
                onTap: () => onStatusFilterChanged(
                  activeStatusFilter == 'invited' ? null : 'invited',
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              _FilterChip(
                label: TenantStatus.unclaimed.label,
                count: stats.unclaimed,
                isActive: activeStatusFilter == 'unclaimed',
                color: TenantStatus.unclaimed.color,
                onTap: () => onStatusFilterChanged(
                  activeStatusFilter == 'unclaimed' ? null : 'unclaimed',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Search bar + filter icon
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.lg,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: AppRadius.button,
                ),
                child: Icon(
                  Icons.tune,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'ابحث عن متجر أو رقم وحدة...',
              hintStyle: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              prefixIcon: Icon(
                Icons.search,
                size: 20,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 18,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      onPressed: () => onSearchChanged(''),
                    )
                  : null,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerLowest,
              border: OutlineInputBorder(
                borderRadius: AppRadius.button,
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: AppRadius.button,
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: AppRadius.button,
                borderSide: const BorderSide(
                  color: Color(0xFF1A73E8),
                  width: 1,
                ),
              ),
            ),
          ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final int count;
  final bool isActive;
  final Color color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.count,
    required this.isActive,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? color.withValues(alpha: 0.12)
              : context.colorScheme.surfaceContainerHighest,
          borderRadius: AppRadius.pill,
          border: isActive
              ? Border.all(color: color.withValues(alpha: 0.4))
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive ? color : context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              '($count)',
              style: TextStyle(
                fontSize: 11,
                color: isActive
                    ? color.withValues(alpha: 0.7)
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
