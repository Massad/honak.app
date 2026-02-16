import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/domain/entities/truck.dart';
import 'package:honak/features/business/order_management/presentation/providers/truck_provider.dart';
import 'package:honak/features/business/order_management/presentation/widgets/truck_detail_overlay.dart';
import 'package:honak/features/business/page_settings/domain/entities/team_member.dart';
import 'package:honak/features/business/page_settings/presentation/providers/team_provider.dart';
import 'package:honak/shared/providers/business_page_provider.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

// ═══════════════════════════════════════════════════════════════
// TruckManagerSection — inline truck management for Manage tab.
// Shows compact truck cards with edit capability.
// ═══════════════════════════════════════════════════════════════

const _dayLabels = {
  'sun': 'أحد',
  'mon': 'اثنين',
  'tue': 'ثلاثاء',
  'wed': 'أربعاء',
  'thu': 'خميس',
  'fri': 'جمعة',
  'sat': 'سبت',
};

const _allDays = ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'];

const _statusMap = <TruckStatus, (String, Color)>{
  TruckStatus.onRoute: ('على المسار', AppColors.success),
  TruckStatus.notStarted: ('لم يبدأ', Color(0xFF9E9E9E)),
  TruckStatus.routeComplete: ('اكتمل', AppColors.primary),
};

class TruckManagerSection extends ConsumerWidget {
  const TruckManagerSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bizContext = ref.watch(businessContextProvider);
    if (bizContext == null) return const SizedBox.shrink();

    final pageSlug = bizContext.page.slug;
    final trucksAsync = ref.watch(truckDeliveryDataProvider(pageSlug));

    return trucksAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(AppSpacing.xxl),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => _ErrorState(
        onRetry: () => ref.invalidate(truckDeliveryDataProvider(pageSlug)),
      ),
      data: (data) {
        final trucks = data?.trucks ?? [];
        return _TruckList(
          trucks: trucks,
          pageSlug: pageSlug,
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Truck list — inline rendering with cards
// ═══════════════════════════════════════════════════════════════

class _TruckList extends ConsumerWidget {
  const _TruckList({
    required this.trucks,
    required this.pageSlug,
  });

  final List<Truck> trucks;
  final String pageSlug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayDay = _allDays[DateTime.now().weekday % 7];

    if (trucks.isEmpty) {
      return _EmptyState(onAdd: () => _showAddSheet(context));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Inline header with add button + summary
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg, AppSpacing.xl, AppSpacing.lg, AppSpacing.sm,
          ),
          child: Row(
            children: [
              Text(
                '${trucks.length} شاحنة · إدارة السائقين والسعة وأيام التوصيل',
                style: TextStyle(
                  fontSize: 10,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => _showAddSheet(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, size: 14, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        'إضافة شاحنة',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Truck cards
        for (final truck in trucks)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.sm,
            ),
            child: _TruckCard(
              truck: truck,
              todayDay: todayDay,
              onTap: () => showTruckDetailOverlay(context, truck, pageSlug),
              onEdit: () => _showEditSheet(context, truck),
            ),
          ),

        // Add dashed button
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg, AppSpacing.xs, AppSpacing.lg, AppSpacing.xxl,
          ),
          child: GestureDetector(
            onTap: () => _showAddSheet(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: context.colorScheme.outlineVariant,
                  style: BorderStyle.solid,
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 14, color: context.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 6),
                  Text(
                    'إضافة شاحنة جديدة',
                    style: TextStyle(
                      fontSize: 12,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showAddSheet(BuildContext context) {
    showAppSheet(
      context,
      builder: (_) => const _TruckEditSheet(isNew: true),
    );
  }

  void _showEditSheet(BuildContext context, Truck truck) {
    showAppSheet(
      context,
      builder: (_) => _TruckEditSheet(truck: truck),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Truck card — compact with color stripe
// ═══════════════════════════════════════════════════════════════

class _TruckCard extends StatelessWidget {
  const _TruckCard({
    required this.truck,
    required this.todayDay,
    required this.onTap,
    required this.onEdit,
  });

  final Truck truck;
  final String todayDay;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final truckColor = _parseColor(truck.color);
    final isOffToday = !truck.deliveryDays.contains(todayDay);
    final (statusLabel, statusColor) = isOffToday
        ? ('عطلة اليوم', const Color(0xFF9E9E9E))
        : (_statusMap[truck.today.status] ?? ('لم يبدأ', const Color(0xFF9E9E9E)));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: context.colorScheme.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Color stripe (end side for RTL)
            Container(
              width: 4,
              constraints: const BoxConstraints(minHeight: 100),
              decoration: BoxDecoration(
                color: truckColor,
                borderRadius: const BorderRadiusDirectional.only(
                  topEnd: Radius.circular(AppRadius.md),
                  bottomEnd: Radius.circular(AppRadius.md),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  children: [
                    // Name + status + edit
                    Row(
                      children: [
                        // Status badge + edit
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.1),
                            borderRadius: AppRadius.pill,
                          ),
                          child: Text(
                            statusLabel,
                            style: TextStyle(
                              fontSize: 9,
                              color: statusColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: onEdit,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: context.colorScheme.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(Icons.edit, size: 11,
                                color: context.colorScheme.onSurfaceVariant),
                          ),
                        ),
                        const Spacer(),
                        // Name + driver
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              truck.name,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: context.colorScheme.onSurface,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  truck.driverName,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: context.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(Icons.people, size: 9,
                                    color: context.colorScheme.onSurfaceVariant),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Stats grid
                    Row(
                      children: [
                        _StatBox(
                          value: '${truck.capacityFull}',
                          label: 'سعة ممتلئ',
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        _StatBox(
                          value: '${truck.zones.length}',
                          label: 'مناطق',
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        _StatBox(
                          value: '${truck.deliveryDays.length}',
                          label: 'أيام',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Delivery day chips
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        for (final d in _allDays)
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 2),
                            child: Container(
                              width: 24,
                              height: 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: truck.deliveryDays.contains(d)
                                    ? AppColors.primary
                                    : context.colorScheme
                                        .surfaceContainerLow,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                _dayLabels[d]?[0] ?? d[0],
                                style: TextStyle(
                                  fontSize: 8,
                                  color: truck.deliveryDays.contains(d)
                                      ? Colors.white
                                      : context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
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
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: context.colorScheme.onSurface,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 8,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Edit/Add Sheet
// ═══════════════════════════════════════════════════════════════

class _TruckEditSheet extends ConsumerStatefulWidget {
  const _TruckEditSheet({
    this.truck,
    this.isNew = false,
  });

  final Truck? truck;
  final bool isNew;

  @override
  ConsumerState<_TruckEditSheet> createState() => _TruckEditSheetState();
}

class _TruckEditSheetState extends ConsumerState<_TruckEditSheet> {
  late String _name;
  late int _capacityFull;
  late int _capacityEmpty;
  late List<String> _deliveryDays;
  late String _routeStart;
  late String _routeEnd;
  late Set<String> _selectedDriverIds;

  @override
  void initState() {
    super.initState();
    final t = widget.truck;
    _name = t?.name ?? 'شاحنة جديدة';
    _capacityFull = t?.capacityFull ?? 30;
    _capacityEmpty = t?.capacityEmpty ?? 30;
    _deliveryDays = List.of(t?.deliveryDays ?? ['sun', 'mon', 'tue', 'wed', 'thu']);
    _routeStart = t?.routeWindow?.start ?? '08:00';
    _routeEnd = t?.routeWindow?.end ?? '14:00';
    _selectedDriverIds = Set.of(t?.assignedDriverIds ?? []);
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final teamMembers = ref.watch(teamProvider).valueOrNull ?? [];

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
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.md,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerLow,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, size: 14,
                      color: context.colorScheme.onSurfaceVariant),
                ),
              ),
              const Spacer(),
              Text(
                widget.isNew ? 'إضافة شاحنة' : 'تعديل الشاحنة',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),

        const Divider(height: 1),

        // Content
        Flexible(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              // Name
              _FieldLabel('اسم الشاحنة'),
              const SizedBox(height: AppSpacing.xs),
              TextFormField(
                initialValue: _name,
                onChanged: (v) => _name = v,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: context.colorScheme.surfaceContainerLow,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    borderSide: BorderSide(color: context.colorScheme.outlineVariant),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    borderSide: BorderSide(color: context.colorScheme.outlineVariant),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md, vertical: AppSpacing.md,
                  ),
                ),
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Team member drivers (if available)
              if (teamMembers.isNotEmpty) ...[
                _FieldLabel('السائقون (من الفريق)'),
                const SizedBox(height: AppSpacing.sm),
                ...teamMembers.map((m) => _TeamMemberRow(
                  member: m,
                  isSelected: _selectedDriverIds.contains(m.id),
                  onToggle: () => setState(() {
                    if (_selectedDriverIds.contains(m.id)) {
                      _selectedDriverIds.remove(m.id);
                    } else {
                      _selectedDriverIds.add(m.id);
                    }
                  }),
                )),
                const SizedBox(height: AppSpacing.lg),
              ],

              // Capacities
              Row(
                children: [
                  Expanded(
                    child: _CapacityControl(
                      label: 'سعة — ممتلئ',
                      value: _capacityFull,
                      onChanged: (v) => setState(() => _capacityFull = v),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _CapacityControl(
                      label: 'سعة — فارغ',
                      value: _capacityEmpty,
                      onChanged: (v) => setState(() => _capacityEmpty = v),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Delivery days
              _FieldLabel('أيام التوصيل'),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  for (final d in _allDays)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: d == _allDays.first ? 0 : 3,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_deliveryDays.contains(d)) {
                                _deliveryDays.remove(d);
                              } else {
                                _deliveryDays.add(d);
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: _deliveryDays.contains(d)
                                  ? AppColors.primary
                                  : context.colorScheme.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              _dayLabels[d] ?? d,
                              style: TextStyle(
                                fontSize: 10,
                                color: _deliveryDays.contains(d)
                                    ? Colors.white
                                    : context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Route window
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _FieldLabel('بداية المسار'),
                        const SizedBox(height: AppSpacing.xs),
                        _TimeField(
                          value: _routeStart,
                          onChanged: (v) => setState(() => _routeStart = v),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _FieldLabel('نهاية المسار'),
                        const SizedBox(height: AppSpacing.xs),
                        _TimeField(
                          value: _routeEnd,
                          onChanged: (v) => setState(() => _routeEnd = v),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Zones (read-only)
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: context.colorScheme.outlineVariant),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '${widget.truck?.zones.length ?? 0} مناطق',
                          style: TextStyle(
                            fontSize: 10,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'مناطق التغطية',
                              style: TextStyle(
                                fontSize: 12,
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(Icons.location_on, size: 11,
                                color: context.colorScheme.onSurfaceVariant),
                          ],
                        ),
                      ],
                    ),
                    if (widget.truck != null)
                      for (final z in widget.truck!.zones) ...[
                        const Divider(height: 16),
                        Row(
                          children: [
                            Text(
                              '${z.approximateAreaKm2} كم²',
                              style: TextStyle(
                                fontSize: 10,
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              z.name,
                              style: TextStyle(
                                fontSize: 10,
                                color: context.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ],
                    if (widget.truck?.zones.isEmpty ?? true) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'لم يتم رسم مناطق بعد — سيتوفر في التطبيق قريباً',
                        style: TextStyle(
                          fontSize: 10,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Save / Delete buttons
              Row(
                textDirection: TextDirection.ltr,
                children: [
                  if (!widget.isNew)
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _showToast('تم حذف الشاحنة');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                        ),
                        child: Icon(Icons.delete_outline, size: 18, color: AppColors.error),
                      ),
                    ),
                  if (!widget.isNew) const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: btn.Button(
                      onPressed: _name.trim().isEmpty
                          ? null
                          : () {
                              Navigator.pop(context);
                              _showToast(widget.isNew
                                  ? 'تمت إضافة الشاحنة'
                                  : 'تم حفظ التغييرات');
                            },
                      label: 'حفظ',
                      icon: const btn.ButtonIcon(Icons.check, size: 14),
                      size: btn.ButtonSize.large,
                      expand: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Sub-widgets
// ═══════════════════════════════════════════════════════════════

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _CapacityControl extends StatelessWidget {
  const _CapacityControl({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _RoundButton(
                icon: Icons.remove,
                onTap: value > 1 ? () => onChanged(value - 5) : null,
              ),
              SizedBox(
                width: 40,
                child: Text(
                  '$value',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ),
              _RoundButton(
                icon: Icons.add,
                onTap: () => onChanged(value + 5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          shape: BoxShape.circle,
          border: Border.all(color: context.colorScheme.outlineVariant),
        ),
        child: Icon(icon, size: 12,
            color: onTap != null
                ? context.colorScheme.onSurface
                : context.colorScheme.outlineVariant),
      ),
    );
  }
}

class _TimeField extends StatelessWidget {
  const _TimeField({
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final parts = value.split(':');
        final hour = int.tryParse(parts[0]) ?? 8;
        final minute = int.tryParse(parts.length > 1 ? parts[1] : '0') ?? 0;
        final picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: hour, minute: minute),
        );
        if (picked != null) {
          onChanged(
            '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}',
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: context.colorScheme.outlineVariant),
        ),
        child: Row(
          children: [
            Icon(Icons.access_time, size: 14,
                color: context.colorScheme.onSurfaceVariant),
            const SizedBox(width: AppSpacing.sm),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: context.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamMemberRow extends StatelessWidget {
  const _TeamMemberRow({
    required this.member,
    required this.isSelected,
    required this.onToggle,
  });

  final TeamMember member;
  final bool isSelected;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.all(AppSpacing.sm + 2),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.06)
              : context.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.3)
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            // Checkbox
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : context.colorScheme.outline,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 10, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: AppSpacing.sm),
            // Avatar
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerLow,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                (member.name.isNotEmpty ? member.name[0] : '?'),
                style: TextStyle(
                  fontSize: 10,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    '${member.role ?? ''} · ${member.phone ?? ''}',
                    style: TextStyle(
                      fontSize: 9,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Empty state
// ═══════════════════════════════════════════════════════════════

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl, vertical: AppSpacing.xxxl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerLow,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.local_shipping_outlined,
              size: 30,
              color: context.colorScheme.outlineVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'لم تضف شاحنات بعد',
            style: TextStyle(
              fontSize: 12,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          btn.Button(
            onPressed: onAdd,
            label: 'إضافة شاحنة',
            icon: const btn.ButtonIcon(Icons.add, size: 14),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Error state
// ═══════════════════════════════════════════════════════════════

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: AppColors.error.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'خطأ في تحميل الشاحنات',
            style: TextStyle(color: context.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.lg),
          btn.Button(
            onPressed: onRetry,
            label: 'إعادة المحاولة',
            icon: const btn.ButtonIcon(Icons.refresh, size: 18),
            variant: btn.Variant.text,
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Helpers
// ═══════════════════════════════════════════════════════════════

Color _parseColor(String hex) {
  final cleaned = hex.replaceAll('#', '');
  return Color(int.parse('FF$cleaned', radix: 16));
}
