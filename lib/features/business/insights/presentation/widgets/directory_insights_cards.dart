import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Insight cards for directory archetype — 7 sections showing
/// tenant stats, follower growth, floor visits, etc.
class DirectoryInsightsCards extends StatelessWidget {
  final Map<String, dynamic> insights;

  const DirectoryInsightsCards({super.key, required this.insights});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TotalTenantsCard(data: insights['total_tenants'] as Map<String, dynamic>? ?? {}),
        const SizedBox(height: AppSpacing.md),
        _FollowerGrowthCard(data: insights['follower_growth'] as Map<String, dynamic>? ?? {}),
        const SizedBox(height: AppSpacing.md),
        _OpenNowCard(data: insights['open_now'] as Map<String, dynamic>? ?? {}),
        const SizedBox(height: AppSpacing.md),
        _FloorVisitsCard(floors: insights['floor_visits'] as List<dynamic>? ?? []),
        const SizedBox(height: AppSpacing.md),
        _DirectoryViewsCard(data: insights['directory_views'] as Map<String, dynamic>? ?? {}),
        const SizedBox(height: AppSpacing.md),
        _TenantClicksCard(tenants: insights['tenant_clicks'] as List<dynamic>? ?? []),
        const SizedBox(height: AppSpacing.md),
        _TopFloorsCard(floors: insights['top_floors'] as List<dynamic>? ?? []),
      ],
    );
  }
}

// ── Shared Card Wrapper ───────────────────────────────────────────────────

class _InsightCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _InsightCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          child,
        ],
      ),
    );
  }
}

// ── 1. Total Tenants ──────────────────────────────────────────────────────

class _TotalTenantsCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const _TotalTenantsCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final claimed = (data['claimed'] as num?)?.toInt() ?? 0;
    final unclaimed = (data['unclaimed'] as num?)?.toInt() ?? 0;
    final total = claimed + unclaimed;
    final fraction = total > 0 ? claimed / total : 1.0;

    return _InsightCard(
      title: context.l10n.insightsTotalTenants,
      child: Row(
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: fraction,
                  strokeWidth: 6,
                  backgroundColor: AppColors.border,
                  valueColor: AlwaysStoppedAnimation(AppColors.primary),
                ),
                Text(
                  '$total',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Text(
              context.l10n.insightsClaimedUnclaimed(claimed, unclaimed),
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── 2. Follower Growth ────────────────────────────────────────────────────

class _FollowerGrowthCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const _FollowerGrowthCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final total = data['total'] ?? 0;
    final thisMonth = data['this_month'] ?? 0;
    final changePercent = (data['change_percent'] as num?)?.toInt() ?? 0;

    return _InsightCard(
      title: context.l10n.insightsFollowerGrowth,
      child: Row(
        children: [
          Text(
            '$total',
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: context.colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.xs),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.trending_up_rounded, size: 14, color: AppColors.success),
                const SizedBox(width: 2),
                Text(
                  '$changePercent%',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            context.l10n.insightsThisMonth(thisMonth as int),
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ── 3. Open Now ───────────────────────────────────────────────────────────

class _OpenNowCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const _OpenNowCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final open = data['open'] ?? 0;
    final total = data['total'] ?? 0;

    return _InsightCard(
      title: context.l10n.insightsOpenNow,
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            context.l10n.insightsOpenOfTotal(open as int, total as int),
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

// ── 4. Floor Visits ───────────────────────────────────────────────────────

class _FloorVisitsCard extends StatelessWidget {
  final List<dynamic> floors;

  const _FloorVisitsCard({required this.floors});

  @override
  Widget build(BuildContext context) {
    final maxVisits = floors.fold<int>(0, (max, f) {
      final visits = ((f as Map<String, dynamic>)['visits'] as num?)?.toInt() ?? 0;
      return visits > max ? visits : max;
    });

    return _InsightCard(
      title: context.l10n.insightsFloorVisits,
      child: Column(
        children: floors.map((f) {
          final map = f as Map<String, dynamic>;
          final name = map['floor'] as String? ?? '';
          final visits = (map['visits'] as num?)?.toInt() ?? 0;
          final fraction = maxVisits > 0 ? visits / maxVisits : 0.0;

          return Padding(
            padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
            child: Row(
              children: [
                SizedBox(
                  width: 72,
                  child: Text(
                    name,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.xxs),
                    child: LinearProgressIndicator(
                      value: fraction,
                      minHeight: 8,
                      backgroundColor: AppColors.border,
                      valueColor: AlwaysStoppedAnimation(AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                SizedBox(
                  width: 40,
                  child: Text(
                    '$visits',
                    textAlign: TextAlign.end,
                    style: context.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ── 5. Directory Views ────────────────────────────────────────────────────

class _DirectoryViewsCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const _DirectoryViewsCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final total = data['total'] ?? 0;
    final thisWeek = data['this_week'] ?? 0;

    return _InsightCard(
      title: context.l10n.insightsDirectoryViews,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$total',
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: context.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            context.l10n.insightsViewsThisWeek(thisWeek as int),
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ── 6. Tenant Clicks ──────────────────────────────────────────────────────

class _TenantClicksCard extends StatelessWidget {
  final List<dynamic> tenants;

  const _TenantClicksCard({required this.tenants});

  @override
  Widget build(BuildContext context) {
    return _InsightCard(
      title: context.l10n.insightsTenantClicks,
      child: Column(
        children: tenants.take(5).map((t) {
          final map = t as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: context.colorScheme.surfaceContainerHighest,
                  backgroundImage: map['logo_url'] != null
                      ? NetworkImage(map['logo_url'] as String)
                      : null,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    map['name'] as String? ?? '',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
                Text(
                  '${map['clicks'] ?? 0}',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ── 7. Top Floors ─────────────────────────────────────────────────────────

class _TopFloorsCard extends StatelessWidget {
  final List<dynamic> floors;

  const _TopFloorsCard({required this.floors});

  @override
  Widget build(BuildContext context) {
    return _InsightCard(
      title: context.l10n.insightsTopFloors,
      child: Column(
        children: floors.take(3).map((f) {
          final map = f as Map<String, dynamic>;
          final name = map['floor'] as String? ?? '';
          final visits = map['visits'] ?? 0;
          final percent = map['percent'] ?? 0;

          return Padding(
            padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
                Text(
                  '$visits',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(AppRadius.xxs),
                  ),
                  child: Text(
                    '$percent%',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
