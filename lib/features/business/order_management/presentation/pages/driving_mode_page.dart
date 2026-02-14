import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/domain/entities/truck.dart';
import 'package:honak/features/business/order_management/presentation/widgets/delivery_summary.dart';
import 'package:honak/features/business/order_management/presentation/widgets/driving_mode_sheets.dart';
import 'package:honak/features/business/order_management/presentation/widgets/swipe_button.dart';
import 'package:honak/features/business/order_management/presentation/widgets/walk_up_order_sheet.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// Full-screen driver interface during active delivery route.
/// Designed for one-handed, glanceable usage with big tap targets.
class DrivingModePage extends ConsumerStatefulWidget {
  final Truck truck;
  final List<QueueItem> initialQueue;
  final String pageName;
  final String productName;

  const DrivingModePage({
    super.key,
    required this.truck,
    required this.initialQueue,
    required this.pageName,
    required this.productName,
  });

  @override
  ConsumerState<DrivingModePage> createState() => _DrivingModePageState();
}

class _DrivingModePageState extends ConsumerState<DrivingModePage> {
  late List<QueueItem> _queue;
  late int _full;
  late int _empty;
  late int _reloads;
  late String _startedAt;
  int? _previewPos;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _queue = List.of(widget.initialQueue);
    _full = widget.truck.today.currentFull > 0
        ? widget.truck.today.currentFull
        : widget.truck.capacityFull;
    _empty = widget.truck.today.currentEmpty;
    _reloads = widget.truck.today.reloads;
    _startedAt = widget.truck.today.startedAt ?? DateTime.now().toIso8601String();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // ── Derived data ────────────────────────────────────────────

  QueueItem? get _currentItem =>
      _queue.cast<QueueItem?>().firstWhere(
        (q) => q!.status == QueueItemStatus.current,
        orElse: () => null,
      );

  List<QueueItem> get _deliveredItems =>
      _queue.where((q) => q.status == QueueItemStatus.delivered).toList();

  List<QueueItem> get _pendingItems {
    final pending =
        _queue.where((q) => q.status == QueueItemStatus.pending).toList();
    final ref = _referencePoint;
    pending.sort((a, b) {
      final dA = _distKm(ref, a.coordinates);
      final dB = _distKm(ref, b.coordinates);
      return dA.compareTo(dB);
    });
    return pending;
  }

  LatLng get _referencePoint {
    final current = _currentItem;
    if (current?.coordinates != null) return current!.coordinates!;
    final delivered = _deliveredItems;
    if (delivered.isNotEmpty) {
      final last = delivered.last;
      if (last.coordinates != null) return last.coordinates!;
    }
    if (widget.truck.zones.isNotEmpty) {
      final zone = widget.truck.zones.first;
      if (zone.polygon.isNotEmpty) {
        final avgLat =
            zone.polygon.map((p) => p.lat).reduce((a, b) => a + b) /
                zone.polygon.length;
        final avgLng =
            zone.polygon.map((p) => p.lng).reduce((a, b) => a + b) /
                zone.polygon.length;
        return LatLng(lat: avgLat, lng: avgLng);
      }
    }
    return const LatLng(lat: 31.955, lng: 35.873);
  }

  int get _reserved {
    final pendingQty =
        _pendingItems.fold<int>(0, (s, q) => s + q.items.fold<int>(0, (a, i) => a + i.qty));
    final currentQty = _currentItem != null
        ? _currentItem!.items.fold<int>(0, (a, i) => a + i.qty)
        : 0;
    return pendingQty + currentQty;
  }

  Truck get _updatedTruck => widget.truck.copyWith(
        today: widget.truck.today.copyWith(
          currentFull: _full,
          currentEmpty: _empty,
          deliveredCount: _deliveredItems.length,
          remainingCount: _pendingItems.length + (_currentItem != null ? 1 : 0),
          reloads: _reloads,
        ),
      );

  // ── Distance helper ─────────────────────────────────────────

  static double _distKm(LatLng? a, LatLng? b) {
    if (a == null || b == null) return 999;
    final dLat = (a.lat - b.lat) * 111;
    final dLng = (a.lng - b.lng) * 111 * cos(a.lat * pi / 180);
    return sqrt(dLat * dLat + dLng * dLng);
  }

  // ── Actions ─────────────────────────────────────────────────

  void _showToast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check, size: 12, color: Colors.white),
              const SizedBox(width: 8),
              Flexible(child: Text(message)),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: context.colorScheme.onSurface,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.pill),
          duration: const Duration(seconds: 2),
          margin: const EdgeInsetsDirectional.only(
            bottom: 100,
            start: AppSpacing.xxl,
            end: AppSpacing.xxl,
          ),
        ),
      );
  }

  void _handleDeliver(
    int fullDel,
    int emptyCol,
    PaymentType actualPayment,
    String note,
  ) {
    final current = _currentItem;
    if (current == null) return;
    final name = current.customerName;
    setState(() {
      _queue = _queue.map((q) {
        if (q.status == QueueItemStatus.current) {
          return q.copyWith(
            status: QueueItemStatus.delivered,
            deliveredAt: DateTime.now().toIso8601String(),
            fullDelivered: fullDel,
            emptiesCollected: emptyCol,
            actualPayment: actualPayment,
            deliveryNote: note.isEmpty ? null : note,
          );
        }
        return q;
      }).toList();
      _full = (_full - fullDel).clamp(0, 9999);
      _empty = _empty + emptyCol;
    });
    _showToast('تم تسليم طلب $name');
  }

  void _handleSkip(String reason, String dest) {
    final current = _currentItem;
    if (current == null) return;
    final name = current.customerName;
    setState(() {
      _queue = _queue.map((q) {
        if (q.status == QueueItemStatus.current) {
          return q.copyWith(
            status: QueueItemStatus.skipped,
            skipReason: reason,
            rescheduledTo: dest == 'tomorrow' ? 'tomorrow' : null,
          );
        }
        return q;
      }).toList();
    });
    _showToast('تم تخطي $name');
  }

  void _handleWalkUpDeliver(QueueItem item) {
    setState(() {
      final newItem = item.copyWith(
        position: _queue.length + 1,
        status: QueueItemStatus.delivered,
        deliveredAt: DateTime.now().toIso8601String(),
        fullDelivered: item.items.isNotEmpty ? item.items.first.qty : 1,
        emptiesCollected: 0,
      );
      _queue.add(newItem);
      _full = (_full - (item.items.isNotEmpty ? item.items.first.qty : 1))
          .clamp(0, 9999);
    });
    _showToast('تم تسليم طلب ${item.customerName}');
  }

  void _handleWalkUpQueue(QueueItem item) {
    setState(() {
      final newItem = item.copyWith(
        position: _queue.length + 1,
        status: QueueItemStatus.pending,
      );
      _queue.add(newItem);
    });
    _showToast('تمت إضافة ${item.customerName} للدور');
  }

  void _handleReload(int newFull, int emptiesDropped) {
    setState(() {
      _full = newFull;
      _empty = (_empty - emptiesDropped).clamp(0, 9999);
      _reloads++;
    });
    _showToast('تم التحميل \u2014 بداية جديدة');
  }

  void _handleStartNext(int position) {
    setState(() {
      _queue = _queue.map((q) {
        if (q.position == position) {
          return q.copyWith(status: QueueItemStatus.current);
        }
        return q;
      }).toList();
      _previewPos = null;
    });
    final item = _queue.cast<QueueItem?>().firstWhere(
      (q) => q!.position == position,
      orElse: () => null,
    );
    Future.delayed(const Duration(milliseconds: 50), () {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
    if (item != null) {
      _showToast('تم إخطار ${item.customerName} \u2014 جاري التوجه');
    }
  }

  void _handleStopCurrent() {
    if (_currentItem == null) return;
    setState(() {
      _queue = _queue.map((q) {
        if (q.status == QueueItemStatus.current) {
          return q.copyWith(status: QueueItemStatus.pending);
        }
        return q;
      }).toList();
    });
    _showToast('تم إلغاء التوجه \u2014 اختر التالي');
  }

  void _showSheet(Widget Function(BuildContext) builder) {
    showAppSheet(
      context,
      builder: builder,
    );
  }

  // ── Build ───────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final current = _currentItem;
    final pending = _pendingItems;
    final delivered = _deliveredItems;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.only(bottom: 100),
                children: [
                  _buildInventoryBar(),
                  if (current != null)
                    _buildCurrentCard(current)
                  else if (pending.isEmpty)
                    _buildRouteComplete(),
                  if (pending.isNotEmpty) _buildQueueSection(pending, current),
                  if (delivered.isNotEmpty) DeliveredCollapse(items: delivered),
                ],
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(bottom: BorderSide(color: context.colorScheme.outlineVariant, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.pageName,
                style: TextStyle(
                  fontSize: 14,
                  color: context.colorScheme.onSurface,
                ),
              ),
              Text(
                '${widget.truck.name} \u2014 ${widget.truck.driverName}',
                style: TextStyle(
                  fontSize: 10,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Row(
                children: [
                  Text(
                    'الخروج',
                    style: TextStyle(
                      fontSize: 12,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward,
                    size: 12,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Inventory bar ───────────────────────────────────────────

  Widget _buildInventoryBar() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        0,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: AppRadius.cardInner,
          border: Border.all(color: context.colorScheme.outlineVariant.withAlpha(100)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _inventoryItem(
              'ممتلئ',
              '$_full',
              AppColors.primary,
              Icons.water_drop,
            ),
            Container(width: 1, height: 24, color: context.colorScheme.outlineVariant),
            _inventoryItem(
              'فارغ',
              '$_empty',
              context.colorScheme.onSurfaceVariant,
              Icons.water_drop_outlined,
            ),
            Container(width: 1, height: 24, color: context.colorScheme.outlineVariant),
            _inventoryItem(
              'محجوز',
              '$_reserved',
              AppColors.secondary,
              Icons.lock_outline,
            ),
          ],
        ),
      ),
    );
  }

  Widget _inventoryItem(String label, String value, Color color, IconData icon) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        Text(label, style: TextStyle(fontSize: 9, color: context.colorScheme.onSurfaceVariant)),
      ],
    );
  }

  // ── Current delivery card ───────────────────────────────────

  Widget _buildCurrentCard(QueueItem item) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'جاري التوجه',
            style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: AppRadius.card,
              border: Border.all(color: AppColors.success, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.success.withAlpha(30),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Customer info row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.customerName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          item.items.map((i) => '${i.qty} \u00D7 ${i.name}').join(', '),
                          style: TextStyle(
                            fontSize: 12,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SourceBadge(source: item.source),
                        if (item.isNewCustomer) ...[
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withAlpha(20),
                              borderRadius: AppRadius.pill,
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 8,
                                  color: AppColors.secondary,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  'جديد',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.address,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                if (item.notes != null && item.notes!.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withAlpha(15),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Text(
                      '"${item.notes}"',
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ],
                // Badges row
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  children: [
                    if (item.recurringLabel != null)
                      _chipBadge(
                        Icons.refresh,
                        item.recurringLabel!,
                        AppColors.success,
                      ),
                    if (item.creditsRemaining != null)
                      _chipBadge(
                        Icons.credit_card,
                        'رصيد: ${item.creditsRemaining}',
                        AppColors.primary,
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                // Action buttons grid
                Row(
                  children: [
                    _actionBtn(
                      icon: Icons.navigation,
                      label: 'خريطة',
                      color: AppColors.primary,
                      textColor: Colors.white,
                      onTap: () => _showToast('قريبا\u064B'),
                    ),
                    const SizedBox(width: 8),
                    _actionBtn(
                      icon: Icons.phone,
                      label: 'اتصال',
                      color: context.colorScheme.surfaceVariant,
                      textColor: context.colorScheme.onSurface,
                      onTap: () => _showToast('قريبا\u064B'),
                    ),
                    const SizedBox(width: 8),
                    _actionBtn(
                      icon: Icons.skip_next,
                      label: 'تخطي',
                      color: AppColors.secondary.withAlpha(20),
                      textColor: AppColors.secondary,
                      onTap: () => _showSheet(
                        (_) => SkipSheet(
                          item: item,
                          onSkip: _handleSkip,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _actionBtn(
                      icon: Icons.cancel_outlined,
                      label: 'إلغاء',
                      color: AppColors.error.withAlpha(20),
                      textColor: AppColors.error,
                      onTap: _handleStopCurrent,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                // Swipe to deliver
                SwipeButton(
                  label: 'اسحب للتسليم',
                  icon: Icons.check,
                  color: AppColors.success,
                  onConfirm: () => _showSheet(
                    (_) => DeliverConfirmSheet(
                      item: item,
                      onConfirm: _handleDeliver,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionBtn({
    required IconData icon,
    required String label,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: color,
            borderRadius: AppRadius.cardInner,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: textColor),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(fontSize: 10, color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chipBadge(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: AppRadius.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 8, color: color),
          const SizedBox(width: 3),
          Text(text, style: TextStyle(fontSize: 10, color: color)),
        ],
      ),
    );
  }

  // ── Route complete ──────────────────────────────────────────

  Widget _buildRouteComplete() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
      child: Column(
        children: [
          const Icon(Icons.check, size: 40, color: AppColors.success),
          const SizedBox(height: AppSpacing.md),
          Text(
            'اكتمل المسار!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'تم تسليم جميع الطلبات',
            style: TextStyle(fontSize: 12, color: context.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  // ── Queue section ───────────────────────────────────────────

  Widget _buildQueueSection(List<QueueItem> pending, QueueItem? current) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            current != null
                ? 'الدور (${pending.length} متبقي)'
                : 'اختر التالي (${pending.length} متبقي)',
            style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 8),
          ...pending.asMap().entries.map(
            (entry) => _buildQueueItem(entry.value, entry.key, current),
          ),
        ],
      ),
    );
  }

  Widget _buildQueueItem(QueueItem item, int index, QueueItem? current) {
    final isExpanded = _previewPos == item.position;
    final ref = _referencePoint;
    final dist = _distKm(ref, item.coordinates);
    final distLabel = dist < 1
        ? '${(dist * 1000).round()}م'
        : '${dist.toStringAsFixed(1)}كم';

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          // Collapsed row
          GestureDetector(
            onTap: () =>
                setState(() => _previewPos = isExpanded ? null : item.position),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              constraints: const BoxConstraints(minHeight: 56),
              decoration: BoxDecoration(
                color: isExpanded
                    ? AppColors.primary.withAlpha(8)
                    : context.colorScheme.surface,
                border: Border.all(
                  color: isExpanded ? AppColors.primary : context.colorScheme.outlineVariant.withAlpha(100),
                ),
                borderRadius: isExpanded
                    ? const BorderRadius.vertical(
                        top: Radius.circular(AppRadius.md),
                      )
                    : AppRadius.cardInner,
              ),
              child: Row(
                children: [
                  // Position + distance
                  SizedBox(
                    width: 28,
                    child: Column(
                      children: [
                        Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          distLabel,
                          style: TextStyle(
                            fontSize: 8,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  // Customer info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                item.customerName,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: context.colorScheme.onSurface,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (item.isNewCustomer) ...[
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.star,
                                size: 9,
                                color: AppColors.secondary,
                              ),
                            ],
                            if (item.creditsRemaining != null) ...[
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withAlpha(15),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${item.creditsRemaining}',
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                            const SizedBox(width: 4),
                            SourceBadge(source: item.source, small: true),
                          ],
                        ),
                        Text(
                          '${item.items.map((i) => '${i.qty} قارورة').join(', ')} \u00B7 ${item.address.split('\u060C').first}',
                          style: TextStyle(
                            fontSize: 10,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.chevron_right,
                    size: 14,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          // Expanded preview
          if (isExpanded)
            Container(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                border: Border(
                  left: BorderSide(color: AppColors.primary),
                  right: BorderSide(color: AppColors.primary),
                  bottom: BorderSide(color: AppColors.primary),
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(AppRadius.md),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.address,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (item.notes != null && item.notes!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withAlpha(15),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Text(
                        '"${item.notes}"',
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  // Payment / recurring badges
                  Wrap(
                    spacing: 6,
                    children: [
                      if (item.recurringLabel != null)
                        _chipBadge(
                          Icons.refresh,
                          item.recurringLabel!,
                          AppColors.success,
                        ),
                      if (item.payment == PaymentType.credits)
                        _chipBadge(Icons.credit_card, 'رصيد', AppColors.primary),
                      if (item.payment == PaymentType.cash)
                        _chipBadge(
                          Icons.payments_outlined,
                          'نقدا\u064B',
                          context.colorScheme.onSurfaceVariant,
                        ),
                      if (item.payment == PaymentType.onAccount)
                        _chipBadge(
                          Icons.description_outlined,
                          'آجل',
                          context.colorScheme.onSurfaceVariant,
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  // Quick actions
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _showToast('قريبا\u064B'),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: context.colorScheme.surfaceVariant,
                              borderRadius: AppRadius.cardInner,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.navigation,
                                  size: 14,
                                  color: context.colorScheme.onSurface,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'خريطة',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: context.colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _showToast('قريبا\u064B'),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: context.colorScheme.surfaceVariant,
                              borderRadius: AppRadius.cardInner,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 14,
                                  color: context.colorScheme.onSurface,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'اتصال',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: context.colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  // Swipe to start / swap button
                  if (current == null)
                    SwipeButton(
                      label: 'اسحب لبدء التوصيل',
                      icon: Icons.navigation,
                      color: AppColors.primary,
                      onConfirm: () => _handleStartNext(item.position),
                    ),
                  if (current != null)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _queue = _queue.map((q) {
                            if (q.status == QueueItemStatus.current) {
                              return q.copyWith(
                                status: QueueItemStatus.pending,
                              );
                            }
                            if (q.position == item.position) {
                              return q.copyWith(
                                status: QueueItemStatus.current,
                              );
                            }
                            return q;
                          }).toList();
                          _previewPos = null;
                        });
                        _showToast(
                          'تم تبديل \u2014 ${item.customerName} هو التالي',
                        );
                        Future.delayed(
                          const Duration(milliseconds: 200),
                          () {
                            _scrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          },
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withAlpha(20),
                          border: Border.all(
                            color: AppColors.secondary.withAlpha(60),
                          ),
                          borderRadius: AppRadius.cardInner,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.swap_horiz,
                              size: 16,
                              color: AppColors.secondary,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'تبديل مع الطلب الحالي',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ── Bottom bar ──────────────────────────────────────────────

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(top: BorderSide(color: context.colorScheme.outlineVariant, width: 0.5)),
      ),
      child: Row(
        children: [
          // Quick order
          Expanded(
            child: GestureDetector(
              onTap: () => _showSheet(
                (_) => WalkUpOrderSheet(
                  productName: widget.productName,
                  onAddAndDeliver: _handleWalkUpDeliver,
                  onAddToQueue: _handleWalkUpQueue,
                ),
              ),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: AppRadius.cardInner,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 14, color: AppColors.white),
                    SizedBox(width: 6),
                    Text(
                      'طلب سريع',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Reload
          GestureDetector(
            onTap: () => _showSheet(
              (_) => ReloadSheet(
                capacity: widget.truck.capacityFull,
                currentEmpty: _empty,
                onReload: _handleReload,
              ),
            ),
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              decoration: BoxDecoration(
                border: Border.all(color: context.colorScheme.outlineVariant),
                borderRadius: AppRadius.cardInner,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 14,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'تحميل',
                    style: TextStyle(
                      fontSize: 12,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          // End route
          GestureDetector(
            onTap: () => _showSheet(
              (_) => DeliverySummary(
                truck: _updatedTruck,
                queue: _queue,
                startedAt: _startedAt,
                reloads: _reloads,
                onEndRoute: () => Navigator.pop(context),
              ),
            ),
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              decoration: BoxDecoration(
                color: context.colorScheme.onSurface,
                borderRadius: AppRadius.cardInner,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_shipping,
                    size: 14,
                    color: Colors.white,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'إنهاء',
                    style: TextStyle(fontSize: 12, color: AppColors.white),
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
