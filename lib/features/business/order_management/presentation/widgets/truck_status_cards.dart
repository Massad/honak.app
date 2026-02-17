import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/l10n/arb/app_localizations.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_shadows.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/domain/entities/truck.dart';
import 'package:honak/shared/widgets/app_direction.dart';

// ═══════════════════════════════════════════════════════════════
// TruckStatusCards — compact truck status display for orders page
// header. Shows summary row + vertically stacked truck cards.
// ═══════════════════════════════════════════════════════════════

class TruckStatusCards extends StatelessWidget {
  final List<Truck> trucks;
  final ValueChanged<Truck> onSelectTruck;
  final int activeCount;
  final int totalDelivered;
  final int totalRemaining;

  const TruckStatusCards({
    super.key,
    required this.trucks,
    required this.onSelectTruck,
    required this.activeCount,
    required this.totalDelivered,
    required this.totalRemaining,
  });

  @override
  Widget build(BuildContext context) {
    if (trucks.isEmpty) return const SizedBox.shrink();

    final dayNames = ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'];
    final todayDay = dayNames[DateTime.now().weekday % 7];

    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.lg,
        end: AppSpacing.lg,
        bottom: AppSpacing.md,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Header row ──────────────────────────────────────
          _HeaderRow(
            activeCount: activeCount,
            totalDelivered: totalDelivered,
            totalRemaining: totalRemaining,
          ),
          const SizedBox(height: AppSpacing.sm),

          // ── Truck cards ─────────────────────────────────────
          ...trucks.map(
            (truck) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _TruckCard(
                truck: truck,
                todayDay: todayDay,
                onTap: () => onSelectTruck(truck),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Header: truck icon + title (right) | stats badges (left)
// ─────────────────────────────────────────────────────────────

class _HeaderRow extends StatelessWidget {
  final int activeCount;
  final int totalDelivered;
  final int totalRemaining;

  const _HeaderRow({
    required this.activeCount,
    required this.totalDelivered,
    required this.totalRemaining,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        // Stats on the left side (in RTL, visually left)
        if (activeCount > 0) ...[
          _StatsBadge(
            label: l10n.bizReqTrucksActive(activeCount),
            color: AppColors.success,
            background: AppColors.success.withValues(alpha: 0.08),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
        Text(
          l10n.bizReqTrucksStats(totalDelivered, totalRemaining),
          style: TextStyle(
            fontSize: 10,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        // Title on the right side (in RTL, visually right)
        Text(
          l10n.bizReqTrucks,
          style: TextStyle(
            fontSize: 12,
            color: context.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 6),
        const Icon(
          Icons.local_shipping_outlined,
          size: 14,
          color: AppColors.primary,
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Individual truck card
// ─────────────────────────────────────────────────────────────

class _TruckCard extends StatelessWidget {
  final Truck truck;
  final String todayDay;
  final VoidCallback onTap;

  const _TruckCard({
    required this.truck,
    required this.todayDay,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isOffToday = !truck.deliveryDays.contains(todayDay);
    final statusInfo = isOffToday
        ? _StatusInfo.offToday(l10n)
        : _StatusInfo.fromStatus(truck.today.status, l10n);
    final total = truck.today.deliveredCount + truck.today.remainingCount;
    final progress = total > 0 ? truck.today.deliveredCount / total : 0.0;

    final truckColor = _parseColor(truck.color);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          boxShadow: AppShadows.sm,
        ),
        clipBehavior: Clip.hardEdge,
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Colored end-border (right side in RTL)
              Container(width: 3, color: truckColor),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Top row: name + driver (right), status badge + chevron (left)
                      Row(
                        children: [
                          // Status badge + chevron
                          Icon(
                            AppDirection.chevronEndIcon(context),
                            size: 12,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          _StatusBadge(info: statusInfo),
                          const Spacer(),
                          // Truck name + driver
                          Text(
                            '${truck.name} — ${truck.driverName}',
                            style: TextStyle(
                              fontSize: 12,
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),

                      // Progress bar or off-day message
                      if (total > 0 && !isOffToday)
                        _ProgressRow(
                          progress: progress,
                          delivered: truck.today.deliveredCount,
                          total: total,
                        )
                      else if (isOffToday)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              l10n.bizReqTruckOrdersDeferred,
                              style: TextStyle(
                                fontSize: 10,
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.calendar_today,
                              size: 9,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Progress bar + count text
// ─────────────────────────────────────────────────────────────

class _ProgressRow extends StatelessWidget {
  final double progress;
  final int delivered;
  final int total;

  const _ProgressRow({
    required this.progress,
    required this.delivered,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$delivered/$total',
          style: TextStyle(
            fontSize: 10,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: ClipRRect(
            borderRadius: AppRadius.pill,
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Status badge (pill)
// ─────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final _StatusInfo info;

  const _StatusBadge({required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: info.background,
        borderRadius: AppRadius.pill,
      ),
      child: Text(
        info.label,
        style: TextStyle(
          fontSize: 9,
          color: info.color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Stats badge (header)
// ─────────────────────────────────────────────────────────────

class _StatsBadge extends StatelessWidget {
  final String label;
  final Color color;
  final Color background;

  const _StatsBadge({
    required this.label,
    required this.color,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadius.pill,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Status info — maps TruckStatus to label / colors
// ─────────────────────────────────────────────────────────────

class _StatusInfo {
  final String label;
  final Color color;
  final Color background;

  const _StatusInfo({
    required this.label,
    required this.color,
    required this.background,
  });

  static _StatusInfo onRoute(AppLocalizations l10n) => _StatusInfo(
    label: l10n.bizReqTruckOnRoute,
    color: AppColors.success,
    background: const Color(0x1443A047), // green-50 equivalent
  );

  static _StatusInfo notStarted(AppLocalizations l10n) => _StatusInfo(
    label: l10n.bizReqTruckNotStarted,
    color: const Color(0xFF9E9E9E),
    background: const Color(0xFFF5F5F5),
  );

  static _StatusInfo routeComplete(AppLocalizations l10n) => _StatusInfo(
    label: l10n.bizReqTruckComplete,
    color: AppColors.primary,
    background: const Color(0x141A73E8), // blue-50 equivalent
  );

  static _StatusInfo offToday(AppLocalizations l10n) => _StatusInfo(
    label: l10n.bizReqTruckOffToday,
    color: const Color(0xFFBDBDBD),
    background: const Color(0xFFFAFAFA),
  );

  static _StatusInfo fromStatus(TruckStatus status, AppLocalizations l10n) {
    return switch (status) {
      TruckStatus.onRoute => onRoute(l10n),
      TruckStatus.notStarted => notStarted(l10n),
      TruckStatus.routeComplete => routeComplete(l10n),
    };
  }
}

// ─────────────────────────────────────────────────────────────
// Hex color parser
// ─────────────────────────────────────────────────────────────

Color _parseColor(String hex) {
  final cleaned = hex.replaceFirst('#', '');
  final value = int.tryParse(cleaned, radix: 16);
  if (value == null) return AppColors.primary;
  return Color(0xFF000000 | value);
}
