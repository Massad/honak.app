import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_shadows.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/domain/entities/truck.dart';

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
    return Row(
      children: [
        // Stats on the left side (in RTL, visually left)
        if (activeCount > 0) ...[
          _StatsBadge(
            label: '$activeCount نشطة',
            color: AppColors.success,
            background: AppColors.success.withValues(alpha: 0.08),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
        Text(
          '$totalDelivered تسليم · $totalRemaining متبقي',
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.textHint,
          ),
        ),
        const Spacer(),
        // Title on the right side (in RTL, visually right)
        const Text(
          'الشاحنات',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textPrimary,
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
    final isOffToday = !truck.deliveryDays.contains(todayDay);
    final statusInfo = isOffToday
        ? _StatusInfo.offToday
        : _StatusInfo.fromStatus(truck.today.status);
    final total = truck.today.deliveredCount + truck.today.remainingCount;
    final progress = total > 0 ? truck.today.deliveredCount / total : 0.0;

    final truckColor = _parseColor(truck.color);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: Colors.grey.shade100),
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
                          const Icon(
                            Icons.chevron_left,
                            size: 12,
                            color: AppColors.textHint,
                          ),
                          const SizedBox(width: 4),
                          _StatusBadge(info: statusInfo),
                          const Spacer(),
                          // Truck name + driver
                          Text(
                            '${truck.name} — ${truck.driverName}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textPrimary,
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
                            const Text(
                              'الطلبات ستنتقل ليوم التوصيل القادم',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.textHint,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.calendar_today,
                              size: 9,
                              color: Colors.grey.shade400,
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
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.textHint,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: ClipRRect(
            borderRadius: AppRadius.pill,
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: Colors.grey.shade100,
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

  static const onRoute = _StatusInfo(
    label: 'على المسار',
    color: AppColors.success,
    background: Color(0x1443A047), // green-50 equivalent
  );

  static const notStarted = _StatusInfo(
    label: 'لم يبدأ',
    color: Color(0xFF9E9E9E),
    background: Color(0xFFF5F5F5),
  );

  static const routeComplete = _StatusInfo(
    label: 'اكتمل',
    color: AppColors.primary,
    background: Color(0x141A73E8), // blue-50 equivalent
  );

  static const offToday = _StatusInfo(
    label: 'عطلة اليوم',
    color: Color(0xFFBDBDBD),
    background: Color(0xFFFAFAFA),
  );

  factory _StatusInfo.fromStatus(TruckStatus status) {
    return switch (status) {
      TruckStatus.onRoute => onRoute,
      TruckStatus.notStarted => notStarted,
      TruckStatus.routeComplete => routeComplete,
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
