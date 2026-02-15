import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_shadows.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/domain/entities/truck.dart';
import 'package:honak/features/business/order_management/presentation/pages/driving_mode_page.dart';
import 'package:honak/features/business/order_management/presentation/providers/truck_provider.dart';
import 'package:honak/shared/providers/business_page_provider.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

// ═══════════════════════════════════════════════════════════════
// Show function
// ═══════════════════════════════════════════════════════════════

void showTruckDetailOverlay(
  BuildContext context,
  Truck truck,
  String pageSlug,
) {
  showAppSheet(
    context,
    builder: (_) => _TruckDetailSheet(
      truck: truck,
      pageSlug: pageSlug,
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Constants
// ═══════════════════════════════════════════════════════════════

const _statusMap = {
  TruckStatus.onRoute: ('على المسار', AppColors.success),
  TruckStatus.notStarted: ('لم يبدأ', Color(0xFF9E9E9E)),
  TruckStatus.routeComplete: ('اكتمل', AppColors.primary),
};

const _dayLabels = [
  ('sat', 'سبت'),
  ('sun', 'أحد'),
  ('mon', 'اثنين'),
  ('tue', 'ثلاثاء'),
  ('wed', 'أربعاء'),
  ('thu', 'خميس'),
  ('fri', 'جمعة'),
];

const _dayLabelsMap = {
  'sun': 'الأحد',
  'mon': 'الاثنين',
  'tue': 'الثلاثاء',
  'wed': 'الأربعاء',
  'thu': 'الخميس',
  'fri': 'الجمعة',
  'sat': 'السبت',
};

const _allDays = ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'];

const _paymentLabels = {
  PaymentType.credits: ('رصيد', Icons.credit_card),
  PaymentType.cash: ('نقدا', Icons.payments_outlined),
  PaymentType.onAccount: ('آجل', Icons.description_outlined),
};

const _skipReasonLabels = {
  'customer_not_home': 'العميل غير موجود',
  'cant_access': 'لا يمكن الوصول',
  'customer_delay': 'طلب تأجيل',
  'out_of_stock': 'نفاد المخزون',
};

// ═══════════════════════════════════════════════════════════════
// Main Sheet
// ═══════════════════════════════════════════════════════════════

class _TruckDetailSheet extends ConsumerStatefulWidget {
  const _TruckDetailSheet({
    required this.truck,
    required this.pageSlug,
  });

  final Truck truck;
  final String pageSlug;

  @override
  ConsumerState<_TruckDetailSheet> createState() => _TruckDetailSheetState();
}

class _TruckDetailSheetState extends ConsumerState<_TruckDetailSheet> {
  int _tabIndex = 0;
  ({String by, String at})? _offDayOverride;

  bool get _isOffToday {
    final now = DateTime.now();
    final dayName = _allDays[now.weekday % 7];
    return !widget.truck.deliveryDays.contains(dayName);
  }

  bool get _effectivelyOff => _isOffToday && _offDayOverride == null;

  String? get _nextDeliveryDay {
    final now = DateTime.now();
    final currentIdx = now.weekday % 7;
    for (var offset = 1; offset <= 7; offset++) {
      final nextDay = _allDays[(currentIdx + offset) % 7];
      if (widget.truck.deliveryDays.contains(nextDay)) {
        return _dayLabelsMap[nextDay];
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final truck = widget.truck;
    final truckColor = _parseColor(truck.color);
    final status = _effectivelyOff
        ? ('عطلة اليوم', const Color(0xFF9E9E9E))
        : (_statusMap[truck.today.status] ?? ('غير معروف', Theme.of(context).colorScheme.onSurfaceVariant));
    final (statusLabel, statusColor) = status;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Drag handle
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: AppSpacing.sm),
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: context.colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),

        // Header
        _buildHeader(truck, truckColor, statusLabel, statusColor),

        // Content
        Flexible(
          child: _tabIndex == 0
              ? _OverviewTab(
                  truck: truck,
                  pageSlug: widget.pageSlug,
                  truckColor: truckColor,
                  isOffToday: _effectivelyOff,
                  nextDeliveryDay: _nextDeliveryDay,
                )
              : _ActivityTab(
                  truck: truck,
                  pageSlug: widget.pageSlug,
                  offDayOverride: _offDayOverride,
                ),
        ),

        // Bottom action
        _buildBottomAction(truck),
      ],
    );
  }

  Widget _buildHeader(
    Truck truck,
    Color truckColor,
    String statusLabel,
    Color statusColor,
  ) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        0,
      ),
      color: context.colorScheme.surface,
      child: Column(
        children: [
          // Title row
          Row(
            children: [
              // Status badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm + 2,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: AppRadius.pill,
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              // Name + driver
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        truck.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: truckColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    truck.driverName,
                    style: TextStyle(
                      fontSize: 10,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Tabs
          Row(
            children: [
              _TabChip(
                label: 'نظرة عامة',
                isActive: _tabIndex == 0,
                onTap: () => setState(() => _tabIndex = 0),
              ),
              const SizedBox(width: AppSpacing.sm),
              _TabChip(
                label: 'النشاط',
                isActive: _tabIndex == 1,
                onTap: () => setState(() => _tabIndex = 1),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }

  void _navigateToDrivingMode(Truck truck) {
    final routeData = ref.read(
      truckRouteQueueProvider((
        pageSlug: widget.pageSlug,
        truckId: truck.id,
      )),
    );
    final bizContext = ref.read(businessContextProvider);
    final queue = routeData?.queue ?? [];
    Navigator.of(context).pop(); // close overlay
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DrivingModePage(
          truck: truck,
          initialQueue: queue,
          pageName: bizContext?.page.name ?? '',
          productName: bizContext?.config?.orderLabels.itemUnit ?? 'وحدة',
        ),
      ),
    );
  }

  Widget _buildBottomAction(Truck truck) {
    // Effectively off: show amber banner + orange override button
    if (_effectivelyOff) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          border: Border(top: BorderSide(color: context.colorScheme.outlineVariant, width: 0.5)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Off-day info banner
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'الشاحنة في عطلة اليوم',
                          style: TextStyle(fontSize: 12, color: context.colorScheme.onSurface),
                        ),
                        Text(
                          _nextDeliveryDay != null
                              ? 'الطلبات ستنتقل لـ $_nextDeliveryDay'
                              : 'لا توجد أيام توصيل محددة',
                          style: TextStyle(
                            fontSize: 10,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  const Icon(Icons.calendar_today, color: AppColors.warning, size: 20),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            // Override button — orange #FF9800
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: () {
                  setState(() {
                    _offDayOverride = (
                      by: 'مستخدم النظام',
                      at: DateTime.now().toIso8601String(),
                    );
                  });
                },
                icon: const Icon(Icons.local_shipping, size: 16),
                label: const Text('بدء المسار رغم العطلة'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9800),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Normal route action (may include override reminder if overriding)
    final status = truck.today.status;
    final String label;
    final Color bgColor;

    switch (status) {
      case TruckStatus.notStarted:
        label = 'ابدأ المسار';
        bgColor = AppColors.success;
      case TruckStatus.onRoute:
        label = 'تابع المسار';
        bgColor = AppColors.primary;
      case TruckStatus.routeComplete:
        label = 'عرض الملخص';
        bgColor = const Color(0xFF9E9E9E);
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(top: BorderSide(color: context.colorScheme.outlineVariant, width: 0.5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Override reminder — exceptional operation on off day
          if (_isOffToday && _offDayOverride != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'تشغيل استثنائي — هذا يوم عطلة للشاحنة',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.amber.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Icon(Icons.warning_amber_rounded,
                      size: 12, color: const Color(0xFFFF9800)),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton.icon(
              onPressed: () => _navigateToDrivingMode(truck),
              icon: const Icon(Icons.location_on, size: 16),
              label: Text(label),
              style: FilledButton.styleFrom(
                backgroundColor: bgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Tab chip
// ═══════════════════════════════════════════════════════════════

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xs + 2,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : context.colorScheme.surfaceContainerLow,
          borderRadius: AppRadius.pill,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.white : context.colorScheme.onSurfaceVariant,
            fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Overview Tab
// ═══════════════════════════════════════════════════════════════

class _OverviewTab extends ConsumerWidget {
  const _OverviewTab({
    required this.truck,
    required this.pageSlug,
    required this.truckColor,
    required this.isOffToday,
    required this.nextDeliveryDay,
  });

  final Truck truck;
  final String pageSlug;
  final Color truckColor;
  final bool isOffToday;
  final String? nextDeliveryDay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeData = ref.watch(
      truckRouteQueueProvider((pageSlug: pageSlug, truckId: truck.id)),
    );
    final queue = routeData?.queue ?? [];

    final delivered = queue.where((q) => q.status == QueueItemStatus.delivered);
    final current = queue.where((q) => q.status == QueueItemStatus.current);
    final pending = queue.where((q) => q.status == QueueItemStatus.pending);
    final skipped = queue.where((q) => q.status == QueueItemStatus.skipped);

    final total = truck.today.deliveredCount + truck.today.remainingCount;
    final progress = total > 0 ? truck.today.deliveredCount / total : 0.0;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // Progress card
        _Card(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${truck.today.deliveredCount}/$total تسليم',
                    style: TextStyle(
                      fontSize: 10,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    'تقدم المسار',
                    style: TextStyle(
                      fontSize: 12,
                      color: context.colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              ClipRRect(
                borderRadius: AppRadius.pill,
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: context.colorScheme.surfaceContainerLow,
                  valueColor: AlwaysStoppedAnimation(truckColor),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  _StatCell(
                    value: '${delivered.length}',
                    label: 'تم التسليم',
                    color: AppColors.success,
                  ),
                  _StatCell(
                    value: '${current.length}',
                    label: 'حالي',
                    color: AppColors.primary,
                  ),
                  _StatCell(
                    value: '${pending.length}',
                    label: 'متبقي',
                    color: context.colorScheme.onSurface,
                  ),
                  _StatCell(
                    value: '${skipped.length}',
                    label: 'تخطي',
                    color: AppColors.warning,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Inventory card (only when on route)
        if (truck.today.status == TruckStatus.onRoute) ...[
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'المخزون',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '${truck.today.currentEmpty}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            'فارغ تم جمعه',
                            style: TextStyle(
                              fontSize: 10,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '${truck.today.currentFull}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: _inventoryColor(truck),
                            ),
                          ),
                          Text(
                            'ممتلئ (من ${truck.capacityFull})',
                            style: TextStyle(
                              fontSize: 10,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                ClipRRect(
                  borderRadius: AppRadius.pill,
                  child: LinearProgressIndicator(
                    value: truck.capacityFull > 0
                        ? truck.today.currentFull / truck.capacityFull
                        : 0,
                    minHeight: 6,
                    backgroundColor: context.colorScheme.surfaceContainerLow,
                    valueColor: AlwaysStoppedAnimation(_inventoryColor(truck)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // Off today notice
        if (isOffToday) ...[
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              border: Border.all(color: const Color(0xFFFFECB3)),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'الشاحنة في عطلة اليوم',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Icon(Icons.warning_amber_rounded,
                        size: 14, color: AppColors.warning),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  pending.isNotEmpty
                      ? '${pending.length} طلب سيتم ترحيلهم تلقائيا إلى ${nextDeliveryDay ?? 'يوم التوصيل القادم'}'
                      : 'لا توجد طلبات معلقة',
                  style: TextStyle(
                    fontSize: 10,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // Driver info
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'السائق',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  const Icon(Icons.person, size: 12, color: AppColors.primary),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  // Call button
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.phone,
                      size: 14,
                      color: AppColors.success,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    truck.driverPhone,
                    style: TextStyle(
                      fontSize: 11,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    truck.driverName,
                    style: TextStyle(
                      fontSize: 13,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Zones
        if (truck.zones.isNotEmpty) ...[
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'مناطق التغطية',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    const Icon(Icons.location_on,
                        size: 12, color: AppColors.primary),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                ...truck.zones.map(
                  (zone) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${zone.approximateAreaKm2} كم²',
                            style: TextStyle(
                              fontSize: 10,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            zone.name,
                            style: TextStyle(
                              fontSize: 12,
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: truckColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // Schedule
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'الجدول',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  const Icon(Icons.schedule, size: 12, color: AppColors.primary),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              if (truck.routeWindow != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${truck.routeWindow!.start} – ${truck.routeWindow!.end}',
                        style: TextStyle(
                          fontSize: 10,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        'ساعات العمل',
                        style: TextStyle(
                          fontSize: 10,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                alignment: WrapAlignment.end,
                children: _dayLabels.map((d) {
                  final (id, label) = d;
                  final isActive = truck.deliveryDays.contains(id);
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isActive ? AppColors.primary : context.colorScheme.surfaceContainerLow,
                      borderRadius: AppRadius.pill,
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 9,
                        color: isActive ? Colors.white : context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Capacity
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'السعة',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  const Icon(Icons.inventory_2_outlined,
                      size: 12, color: AppColors.primary),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${truck.capacityEmpty}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            'فوارغ',
                            style: TextStyle(
                              fontSize: 9,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${truck.capacityFull}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            'ممتلئ',
                            style: TextStyle(
                              fontSize: 9,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }

  Color _inventoryColor(Truck truck) {
    if (truck.today.currentFull > 10) return AppColors.success;
    if (truck.today.currentFull > 3) return AppColors.warning;
    return AppColors.error;
  }
}

// ═══════════════════════════════════════════════════════════════
// Activity Tab
// ═══════════════════════════════════════════════════════════════

class _ActivityTab extends ConsumerWidget {
  const _ActivityTab({
    required this.truck,
    required this.pageSlug,
    this.offDayOverride,
  });

  final Truck truck;
  final String pageSlug;
  final ({String by, String at})? offDayOverride;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeData = ref.watch(
      truckRouteQueueProvider((pageSlug: pageSlug, truckId: truck.id)),
    );
    final queue = routeData?.queue ?? [];
    final activityLog = _buildActivityLog(queue, truck, offDayOverride);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            'نشاط اليوم',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: context.colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        if (activityLog.isEmpty)
          _Card(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
                child: Column(
                  children: [
                    Icon(Icons.schedule,
                        size: 32, color: context.colorScheme.outlineVariant),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'لم يبدأ المسار بعد',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          _Card(
            child: Column(
              children: [
                for (var i = 0; i < activityLog.length; i++)
                  _ActivityEntryRow(
                    entry: activityLog[i],
                    isLast: i == activityLog.length - 1,
                  ),
              ],
            ),
          ),

        // Route history
        _RouteHistorySection(pageSlug: pageSlug),

        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Activity Entry Row
// ═══════════════════════════════════════════════════════════════

class _ActivityEntryRow extends StatelessWidget {
  const _ActivityEntryRow({
    required this.entry,
    required this.isLast,
  });

  final _ActivityEntry entry;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline connector
          SizedBox(
            width: 28,
            child: Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: entry.color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(entry.icon, size: 12, color: entry.color),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1,
                      constraints:
                          const BoxConstraints(minHeight: AppSpacing.lg),
                      color: context.colorScheme.outlineVariant,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: isLast ? 0 : AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Label + time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (entry.time.isNotEmpty)
                        Text(
                          _formatTime(entry.time),
                          style: TextStyle(
                            fontSize: 9,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      Flexible(
                        child: Text(
                          entry.label,
                          style: TextStyle(
                            fontSize: 12,
                            color: context.colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  // Detail
                  Text(
                    entry.detail,
                    style: TextStyle(
                      fontSize: 10,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.end,
                  ),

                  // Source + payment badges
                  if (entry.source != null || entry.payment != null)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.xs),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (entry.payment != null) ...[
                            _BadgeChip(
                              icon: _paymentLabels[entry.payment]?.$2 ??
                                  Icons.payments,
                              label: _paymentLabels[entry.payment]?.$1 ?? '',
                            ),
                            const SizedBox(width: AppSpacing.xs),
                          ],
                          if (entry.source != null)
                            _BadgeChip(
                              icon: _sourceIcon(entry.source!),
                              label: sourceLabels[entry.source] ?? '',
                            ),
                        ],
                      ),
                    ),

                  // Delivery note
                  if (entry.note != null && entry.note!.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: AppSpacing.xs),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E1),
                        borderRadius: BorderRadius.circular(AppRadius.xxs),
                      ),
                      child: Text(
                        '"${entry.note}"',
                        style: const TextStyle(
                          fontSize: 9,
                          color: AppColors.warning,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),

                  // Rescheduled info
                  if (entry.rescheduled != null)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.xxs),
                      child: Text(
                        entry.rescheduled == 'tomorrow'
                            ? '← تم ترحيله للغد'
                            : '← تم ترحيله إلى ${entry.rescheduled}',
                        style: TextStyle(
                          fontSize: 9,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Route History Section
// ═══════════════════════════════════════════════════════════════

class _RouteHistorySection extends ConsumerStatefulWidget {
  const _RouteHistorySection({required this.pageSlug});

  final String pageSlug;

  @override
  ConsumerState<_RouteHistorySection> createState() =>
      _RouteHistorySectionState();
}

class _RouteHistorySectionState extends ConsumerState<_RouteHistorySection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(routeHistoryProvider(widget.pageSlug));
    if (history.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        const SizedBox(height: AppSpacing.lg),
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'المسارات السابقة (${history.length})',
                style: TextStyle(
                  fontSize: 12,
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Icon(
                _expanded ? Icons.expand_less : Icons.expand_more,
                size: 14,
                color: context.colorScheme.onSurface,
              ),
            ],
          ),
        ),
        if (_expanded) ...[
          const SizedBox(height: AppSpacing.md),
          ...history.map(
            (h) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _Card(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Badges
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.success.withValues(alpha: 0.1),
                                borderRadius: AppRadius.pill,
                              ),
                              child: Text(
                                '${h.totalDelivered} تسليم',
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: AppColors.success,
                                ),
                              ),
                            ),
                            if (h.totalSkipped > 0) ...[
                              const SizedBox(width: AppSpacing.xs),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.warning.withValues(alpha: 0.1),
                                  borderRadius: AppRadius.pill,
                                ),
                                child: Text(
                                  '${h.totalSkipped} تخطي',
                                  style: const TextStyle(
                                    fontSize: 9,
                                    color: AppColors.warning,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              h.date,
                              style: TextStyle(
                                fontSize: 12,
                                color: context.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Icon(Icons.calendar_today,
                                size: 10, color: context.colorScheme.onSurfaceVariant),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${h.startedAt} – ${h.endedAt} (${h.durationMinutes ~/ 60}س ${h.durationMinutes % 60}د)',
                          style: TextStyle(
                            fontSize: 10,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          h.driver,
                          style: TextStyle(
                            fontSize: 10,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Shared widgets
// ═══════════════════════════════════════════════════════════════

class _Card extends StatelessWidget {
  const _Card({required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: context.colorScheme.surfaceContainerLow),
        boxShadow: AppShadows.sm,
      ),
      child: child,
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.value,
    required this.label,
    required this.color,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeChip extends StatelessWidget {
  const _BadgeChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLowest,
        borderRadius: AppRadius.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 8,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 2),
          Icon(icon, size: 8, color: context.colorScheme.onSurfaceVariant),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Activity log builder
// ═══════════════════════════════════════════════════════════════

class _ActivityEntry {
  const _ActivityEntry({
    required this.label,
    required this.detail,
    required this.icon,
    required this.color,
    this.time = '',
    this.source,
    this.payment,
    this.note,
    this.rescheduled,
  });

  final String label;
  final String detail;
  final IconData icon;
  final Color color;
  final String time;
  final OrderSource? source;
  final PaymentType? payment;
  final String? note;
  final String? rescheduled;
}

List<_ActivityEntry> _buildActivityLog(
  List<QueueItem> queue,
  Truck truck, [
  ({String by, String at})? offDayOverride,
]) {
  final entries = <_ActivityEntry>[];

  // Off-day override — logged before route_start since it happens first
  if (offDayOverride != null) {
    entries.add(_ActivityEntry(
      label: 'تشغيل استثنائي في يوم العطلة',
      detail: 'تم التفعيل بواسطة ${offDayOverride.by}',
      icon: Icons.warning_amber_rounded,
      color: const Color(0xFFFF9800),
      time: offDayOverride.at,
    ));
  }

  // Route start
  if (truck.today.startedAt != null) {
    entries.add(_ActivityEntry(
      label: 'بدء المسار',
      detail: 'تحميل ${truck.capacityFull} وحدة',
      icon: Icons.local_shipping,
      color: AppColors.primary,
      time: truck.today.startedAt!,
    ));
  }

  // Delivered items
  for (final q in queue.where((q) => q.status == QueueItemStatus.delivered)) {
    final exchangeInfo = _getExchangeInfo(q);
    entries.add(_ActivityEntry(
      label: 'تسليم — ${q.customerName}',
      detail:
          '${q.fullDelivered ?? 0} وحدة · ${q.emptiesCollected ?? 0} فارغ$exchangeInfo',
      icon: Icons.check_circle,
      color: AppColors.success,
      time: q.deliveredAt ?? '',
      source: q.source,
      payment: q.actualPayment ?? q.payment,
      note: q.deliveryNote,
    ));
  }

  // Skipped items
  for (final q in queue.where((q) => q.status == QueueItemStatus.skipped)) {
    entries.add(_ActivityEntry(
      label: 'تخطي — ${q.customerName}',
      detail: _skipReasonLabels[q.skipReason] ?? q.skipReason ?? 'تم التخطي',
      icon: Icons.skip_next,
      color: AppColors.warning,
      time: q.deliveredAt ?? truck.today.startedAt ?? '',
      rescheduled: q.rescheduledTo,
    ));
  }

  // Route end
  if (truck.today.endedAt != null) {
    entries.add(_ActivityEntry(
      label: 'انتهاء المسار',
      detail:
          '${truck.today.deliveredCount} تسليم · ${truck.today.currentEmpty} فارغ',
      icon: Icons.local_shipping,
      color: const Color(0xFF9E9E9E),
      time: truck.today.endedAt!,
    ));
  }

  // Sort by time
  entries.sort((a, b) => a.time.compareTo(b.time));

  return entries;
}

String _getExchangeInfo(QueueItem q) {
  final delivered = q.fullDelivered ?? 0;
  final collected = q.emptiesCollected ?? 0;
  if (delivered > 0 && collected > 0) {
    final diff = delivered - collected;
    if (diff > 0) return ' · $diff جديد (بدون فارغ)';
    if (diff < 0) return ' · ${diff.abs()} فارغ زيادة';
  }
  if (delivered > 0 && collected == 0) return ' · بدون استبدال';
  return '';
}

// ═══════════════════════════════════════════════════════════════
// Helpers
// ═══════════════════════════════════════════════════════════════

Color _parseColor(String hex) {
  final cleaned = hex.replaceAll('#', '');
  return Color(int.parse('FF$cleaned', radix: 16));
}

String _formatTime(String isoTime) {
  try {
    final dt = DateTime.parse(isoTime);
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  } catch (_) {
    return isoTime;
  }
}

IconData _sourceIcon(OrderSource source) {
  return switch (source) {
    OrderSource.recurringAuto => Icons.refresh,
    OrderSource.appOrder => Icons.smartphone,
    OrderSource.walkUp => Icons.shuffle,
    OrderSource.phoneCall => Icons.phone,
    OrderSource.whatsapp => Icons.chat,
    OrderSource.adHoc => Icons.add,
  };
}
