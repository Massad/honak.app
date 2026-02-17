import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/button.dart';

/// Dashboard section for directory archetype (malls, plazas).
/// Shows stats grid, recently linked tenants, and quick actions.
class DirectoryDashboardSection extends StatelessWidget {
  final Map<String, dynamic> data;

  const DirectoryDashboardSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final stats = data['stats'] as Map<String, dynamic>? ?? {};
    final recentlyLinked = data['recently_linked'] as List<dynamic>? ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StatsGrid(stats: stats),
        const SizedBox(height: AppSpacing.xl),
        if (recentlyLinked.isNotEmpty) ...[
          _RecentlyLinkedSection(items: recentlyLinked),
          const SizedBox(height: AppSpacing.xl),
        ],
        _QuickActions(),
      ],
    );
  }
}

// ── Stats Grid ────────────────────────────────────────────────────────────

class _StatsGrid extends StatelessWidget {
  final Map<String, dynamic> stats;

  const _StatsGrid({required this.stats});

  @override
  Widget build(BuildContext context) {
    final pageViews = stats['page_views'] as Map<String, dynamic>? ?? {};
    final newFollowers = stats['new_followers'] as Map<String, dynamic>? ?? {};
    final claimed = stats['claimed_tenants'] as Map<String, dynamic>? ?? {};
    final newWeek = stats['new_this_week'] as Map<String, dynamic>? ?? {};

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: context.l10n.insightsPageViews,
                value: '${pageViews['value'] ?? 0}',
                change: (pageViews['change'] as num?)?.toInt(),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _StatCard(
                label: context.l10n.insightsNewFollowers,
                value: '${newFollowers['value'] ?? 0}',
                change: (newFollowers['change'] as num?)?.toInt(),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: context.l10n.insightsClaimedTenants,
                value: '${claimed['claimed'] ?? 0}/${claimed['total'] ?? 0}',
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _StatCard(
                label: context.l10n.insightsNewThisWeek,
                value: '${newWeek['value'] ?? 0}',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final int? change;

  const _StatCard({
    required this.label,
    required this.value,
    this.change,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Text(
                value,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.onSurface,
                ),
              ),
              if (change != null) ...[
                const SizedBox(width: AppSpacing.xs),
                Icon(
                  change! >= 0
                      ? Icons.trending_up_rounded
                      : Icons.trending_down_rounded,
                  size: 16,
                  color: change! >= 0 ? AppColors.success : AppColors.error,
                ),
                const SizedBox(width: 2),
                Text(
                  '${change!.abs()}%',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: change! >= 0 ? AppColors.success : AppColors.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// ── Recently Linked ───────────────────────────────────────────────────────

class _RecentlyLinkedSection extends StatelessWidget {
  final List<dynamic> items;

  const _RecentlyLinkedSection({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.insightsRecentlyLinked,
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onSurface,
              ),
            ),
            if (items.length > 3)
              Button(
                onPressed: () {},
                label: 'عرض الكل',
                variant: Variant.text,
                size: ButtonSize.small,
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ...items.take(4).map((item) {
          final map = item as Map<String, dynamic>;
          return _RecentlyLinkedTile(
            name: map['name'] as String? ?? '',
            floor: map['floor'] as String? ?? '',
            unit: map['unit'] as String? ?? '',
            logoUrl: map['logo_url'] as String?,
            timeAgo: _formatTimeAgo(map['linked_at'] as int? ?? 0),
          );
        }),
      ],
    );
  }

  String _formatTimeAgo(int epochSeconds) {
    if (epochSeconds == 0) return '';
    final linked = DateTime.fromMillisecondsSinceEpoch(epochSeconds * 1000);
    final diff = DateTime.now().difference(linked);
    if (diff.inDays > 30) return 'منذ ${diff.inDays ~/ 30} شهر';
    if (diff.inDays > 0) return 'منذ ${diff.inDays} يوم';
    if (diff.inHours > 0) return 'منذ ${diff.inHours} ساعة';
    return 'الآن';
  }
}

class _RecentlyLinkedTile extends StatelessWidget {
  final String name;
  final String floor;
  final String unit;
  final String? logoUrl;
  final String timeAgo;

  const _RecentlyLinkedTile({
    required this.name,
    required this.floor,
    required this.unit,
    this.logoUrl,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: context.colorScheme.surfaceContainerHighest,
            backgroundImage: logoUrl != null ? NetworkImage(logoUrl!) : null,
            child: logoUrl == null
                ? Icon(Icons.store, size: 18, color: context.colorScheme.onSurfaceVariant)
                : null,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                Text(
                  '$floor · $unit',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            timeAgo,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Quick Actions ─────────────────────────────────────────────────────────

class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionButton(
            icon: Icons.person_add_outlined,
            label: 'إضافة مستأجر',
            onTap: () {},
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _QuickActionButton(
            icon: Icons.stars_outlined,
            label: 'تعديل المميزين',
            onTap: () {},
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _QuickActionButton(
            icon: Icons.edit_outlined,
            label: 'منشور جديد',
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.cardInner,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
          horizontal: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.06),
          borderRadius: AppRadius.cardInner,
        ),
        child: Column(
          children: [
            Icon(icon, size: 22, color: AppColors.primary),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              textAlign: TextAlign.center,
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
