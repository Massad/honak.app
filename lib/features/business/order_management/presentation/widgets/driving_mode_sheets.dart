import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/domain/entities/truck.dart';

// ═══════════════════════════════════════════════════════════════
// Constants
// ═══════════════════════════════════════════════════════════════

const _paymentOptions = [
  (id: PaymentType.cash, label: 'نقدا\u064B', icon: Icons.payments_outlined),
  (id: PaymentType.credits, label: 'رصيد', icon: Icons.credit_card),
  (id: PaymentType.onAccount, label: 'آجل', icon: Icons.description_outlined),
];

String paymentLabel(PaymentType type) {
  switch (type) {
    case PaymentType.cash:
      return 'نقدا\u064B';
    case PaymentType.credits:
      return 'رصيد';
    case PaymentType.onAccount:
      return 'آجل';
  }
}

// ═══════════════════════════════════════════════════════════════
// SourceBadge
// ═══════════════════════════════════════════════════════════════

class SourceBadge extends StatelessWidget {
  final OrderSource source;
  final bool small;

  const SourceBadge({super.key, required this.source, this.small = false});

  static const _sourceConfig = {
    OrderSource.recurringAuto: (
      label: 'تلقائي',
      icon: Icons.refresh,
      color: Color(0xFF7B1FA2),
    ),
    OrderSource.appOrder: (
      label: 'طلب تطبيق',
      icon: Icons.smartphone,
      color: AppColors.primary,
    ),
    OrderSource.walkUp: (
      label: 'طلب شارع',
      icon: Icons.person,
      color: AppColors.success,
    ),
    OrderSource.phoneCall: (
      label: 'اتصال',
      icon: Icons.phone,
      color: AppColors.secondary,
    ),
    OrderSource.balcony: (
      label: 'بلكونة',
      icon: Icons.home_outlined,
      color: Color(0xFF00897B),
    ),
    OrderSource.whatsapp: (
      label: 'واتساب',
      icon: Icons.chat,
      color: Color(0xFF25D366),
    ),
    OrderSource.adHoc: (
      label: 'يدوي',
      icon: Icons.add,
      color: AppColors.textSecondary,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final config = _sourceConfig[source] ??
        (label: source.name, icon: Icons.add, color: AppColors.textSecondary);

    if (small) {
      return Icon(config.icon, size: 10, color: AppColors.textHint);
    }

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: config.color.withAlpha(20),
        borderRadius: AppRadius.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(config.icon, size: 8, color: config.color),
          const SizedBox(width: 3),
          Text(
            config.label,
            style: TextStyle(fontSize: 8, color: config.color),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// DeliveredCollapse — collapsed list of completed deliveries
// ═══════════════════════════════════════════════════════════════

class DeliveredCollapse extends StatefulWidget {
  final List<QueueItem> items;

  const DeliveredCollapse({super.key, required this.items});

  @override
  State<DeliveredCollapse> createState() => _DeliveredCollapseState();
}

class _DeliveredCollapseState extends State<DeliveredCollapse> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
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
          GestureDetector(
            onTap: () => setState(() => _open = !_open),
            child: Row(
              children: [
                Icon(
                  _open ? Icons.expand_less : Icons.expand_more,
                  size: 10,
                  color: AppColors.textHint,
                ),
                const SizedBox(width: 6),
                Text(
                  'تم التسليم (${widget.items.length})',
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
          if (_open)
            Opacity(
              opacity: 0.6,
              child: Column(
                children: widget.items.map((d) {
                  final totalQty =
                      d.items.fold<int>(0, (s, i) => s + i.qty);
                  return Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppRadius.cardInner,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check,
                          size: 12,
                          color: AppColors.success,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          d.customerName,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '$totalQty وحدة',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textHint,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// SheetHeader — shared header for bottom sheets
// ═══════════════════════════════════════════════════════════════

class _SheetHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onClose;

  const _SheetHeader({
    required this.title,
    this.subtitle,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onClose,
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Counter widget — ± buttons with centered value
// ═══════════════════════════════════════════════════════════════

class _Counter extends StatelessWidget {
  final String label;
  final int value;
  final ValueChanged<int> onChanged;
  final Color incrementColor;
  final int step;
  final int min;

  const _Counter({
    required this.label,
    required this.value,
    required this.onChanged,
    this.incrementColor = AppColors.primary,
    this.step = 1,
    this.min = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _circleButton(
              icon: Icons.remove,
              color: AppColors.surfaceVariant,
              iconColor: AppColors.textPrimary,
              onTap: () => onChanged((value - step).clamp(min, 9999)),
            ),
            SizedBox(
              width: 48,
              child: Text(
                '$value',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            _circleButton(
              icon: Icons.add,
              color: incrementColor,
              iconColor: AppColors.white,
              onTap: () => onChanged(value + step),
            ),
          ],
        ),
      ],
    );
  }

  Widget _circleButton({
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, size: 16, color: iconColor),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// DeliverConfirmSheet
// ═══════════════════════════════════════════════════════════════

class DeliverConfirmSheet extends StatefulWidget {
  final QueueItem item;
  final void Function(
    int fullDelivered,
    int emptiesCollected,
    PaymentType actualPayment,
    String note,
  ) onConfirm;

  const DeliverConfirmSheet({
    super.key,
    required this.item,
    required this.onConfirm,
  });

  @override
  State<DeliverConfirmSheet> createState() => _DeliverConfirmSheetState();
}

class _DeliverConfirmSheetState extends State<DeliverConfirmSheet> {
  late int _fullDel;
  late int _emptyCol;
  late PaymentType _payment;
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final qty = widget.item.items.fold<int>(0, (s, i) => s + i.qty);
    _fullDel = qty;
    _emptyCol = qty;
    _payment = widget.item.payment;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final qty = widget.item.items.fold<int>(0, (s, i) => s + i.qty);
    final paymentChanged = _payment != widget.item.payment;
    final exchangeUnits = _fullDel.clamp(0, _emptyCol);
    final newUnits = (_fullDel - _emptyCol).clamp(0, _fullDel);
    final hasExchangeDiff = _fullDel > 0 && _emptyCol < _fullDel;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SheetHeader(
            title: 'تأكيد التسليم',
            onClose: () => Navigator.pop(context),
          ),
          // Customer info
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: AppRadius.cardInner,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.customerName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$qty قارورة \u00B7 ${widget.item.address.split('\u060C').first}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Counters row
          Row(
            children: [
              Expanded(
                child: _Counter(
                  label: 'ممتلئ تم تسليمه',
                  value: _fullDel,
                  onChanged: (v) => setState(() => _fullDel = v),
                  incrementColor: AppColors.primary,
                ),
              ),
              Expanded(
                child: _Counter(
                  label: 'فوارغ تم جمعها',
                  value: _emptyCol,
                  onChanged: (v) => setState(() => _emptyCol = v),
                  incrementColor: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          // Exchange diff info
          if (hasExchangeDiff) ...[
            const SizedBox(height: AppSpacing.lg),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.secondary.withAlpha(20),
                border: Border.all(color: AppColors.secondary.withAlpha(40)),
                borderRadius: AppRadius.cardInner,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.warning_amber,
                        size: 12,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'فرق الاستبدال',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (exchangeUnits > 0)
                    _infoRow(
                      'استبدال (فارغ \u2194 ممتلئ)',
                      '$exchangeUnits وحدة',
                      AppColors.success,
                    ),
                  _infoRow(
                    'جديد (بدون فارغ)',
                    '$newUnits وحدة',
                    AppColors.secondary,
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          // Payment selector
          Row(
            children: _paymentOptions.map((opt) {
              final active = _payment == opt.id;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _payment = opt.id),
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: active ? AppColors.primary : AppColors.surfaceVariant,
                        borderRadius: AppRadius.cardInner,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            opt.icon,
                            size: 13,
                            color: active ? AppColors.white : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            opt.label,
                            style: TextStyle(
                              fontSize: 12,
                              color: active ? AppColors.white : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          if (paymentChanged) ...[
            const SizedBox(height: 6),
            Text(
              'تم تغيير الدفع من ${paymentLabel(widget.item.payment)} إلى ${paymentLabel(_payment)}',
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.secondary,
              ),
            ),
          ],
          if (_payment == PaymentType.credits &&
              widget.item.creditsRemaining != null) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(
                  Icons.credit_card,
                  size: 10,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  'رصيد: ${widget.item.creditsRemaining} \u2190 ${(widget.item.creditsRemaining! - _fullDel).clamp(0, 9999)} بعد التأكيد',
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          // Note
          TextField(
            controller: _noteController,
            decoration: InputDecoration(
              hintText: 'ملاحظة (اختياري)',
              hintStyle: const TextStyle(
                fontSize: 14,
                color: AppColors.textHint,
              ),
              filled: true,
              fillColor: AppColors.surfaceVariant,
              border: OutlineInputBorder(
                borderRadius: AppRadius.cardInner,
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Confirm button
          SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                widget.onConfirm(
                  _fullDel,
                  _emptyCol,
                  _payment,
                  _noteController.text,
                );
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check, size: 16),
              label: const Text('تأكيد التسليم'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.cardInner,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 10, color: color)),
          Text(
            value,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// SkipSheet
// ═══════════════════════════════════════════════════════════════

class SkipSheet extends StatefulWidget {
  final QueueItem item;
  final void Function(String reason, String destination) onSkip;

  const SkipSheet({super.key, required this.item, required this.onSkip});

  @override
  State<SkipSheet> createState() => _SkipSheetState();
}

class _SkipSheetState extends State<SkipSheet> {
  String _reason = 'customer_not_home';
  String _dest = 'tomorrow';
  final _otherController = TextEditingController();

  @override
  void dispose() {
    _otherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SheetHeader(
            title: 'تخطي التوصيل؟',
            onClose: () => Navigator.pop(context),
          ),
          // Customer info
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: AppRadius.cardInner,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.customerName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${widget.item.items.map((i) => '${i.qty} قارورة').join(', ')} \u00B7 ${widget.item.address.split('\u060C').first}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Reasons
          ...skipReasons.map((r) {
            final (id, label) = r;
            final selected = _reason == id;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () => setState(() => _reason = id),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primary.withAlpha(15)
                        : AppColors.surface,
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : AppColors.divider,
                    ),
                    borderRadius: AppRadius.cardInner,
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      color: selected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            );
          }),
          if (_reason == 'other')
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: TextField(
                controller: _otherController,
                decoration: InputDecoration(
                  hintText: 'السبب...',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textHint,
                  ),
                  filled: true,
                  fillColor: AppColors.surfaceVariant,
                  border: OutlineInputBorder(
                    borderRadius: AppRadius.cardInner,
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.md,
                  ),
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'نقل إلى:',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: skipDestinations.map((d) {
              final (id, label) = d;
              final selected = _dest == id;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _dest = id),
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary
                            : AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Center(
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 12,
                            color: selected
                                ? AppColors.white
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                final reason = _reason == 'other'
                    ? _otherController.text
                    : _reason;
                widget.onSkip(reason, _dest);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.skip_next, size: 16),
              label: const Text('تخطي والتالي'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.cardInner,
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
// ReloadSheet
// ═══════════════════════════════════════════════════════════════

class ReloadSheet extends StatefulWidget {
  final int capacity;
  final int currentEmpty;
  final void Function(int newFull, int emptiesDropped) onReload;

  const ReloadSheet({
    super.key,
    required this.capacity,
    required this.currentEmpty,
    required this.onReload,
  });

  @override
  State<ReloadSheet> createState() => _ReloadSheetState();
}

class _ReloadSheetState extends State<ReloadSheet> {
  late int _newFull;
  late int _emptiesDrop;

  @override
  void initState() {
    super.initState();
    _newFull = widget.capacity;
    _emptiesDrop = widget.currentEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SheetHeader(
            title: 'تحميل جديد',
            subtitle: 'عدت للمستودع وحم\u0651لت الشاحنة',
            onClose: () => Navigator.pop(context),
          ),
          const SizedBox(height: AppSpacing.sm),
          _Counter(
            label: 'ممتلئ تم تحميله',
            value: _newFull,
            onChanged: (v) => setState(() => _newFull = v),
            incrementColor: AppColors.primary,
            step: 5,
            min: 1,
          ),
          const SizedBox(height: AppSpacing.xl),
          _Counter(
            label: 'فوارغ تم تنزيلها',
            value: _emptiesDrop,
            onChanged: (v) => setState(() => _emptiesDrop = v),
            incrementColor: AppColors.textSecondary,
            step: 5,
          ),
          const SizedBox(height: AppSpacing.xxl),
          SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                widget.onReload(_newFull, _emptiesDrop);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('تأكيد \u2014 بداية جديدة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.cardInner,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
