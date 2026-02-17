import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/l10n/arb/app_localizations.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/domain/entities/truck.dart';
import 'package:honak/shared/widgets/button.dart';

// ═══════════════════════════════════════════════════════════════
// Constants
// ═══════════════════════════════════════════════════════════════

List<({PaymentType id, String label, IconData icon})> paymentOptions(AppLocalizations l10n) => [
  (id: PaymentType.cash, label: l10n.bizReqSheetPayCash, icon: Icons.payments_outlined),
  (id: PaymentType.credits, label: l10n.bizReqSheetPayCredits, icon: Icons.credit_card),
  (id: PaymentType.onAccount, label: l10n.bizReqSheetPayOnAccount, icon: Icons.description_outlined),
];

String paymentLabel(PaymentType type, AppLocalizations l10n) {
  switch (type) {
    case PaymentType.cash:
      return l10n.bizReqSheetPayCash;
    case PaymentType.credits:
      return l10n.bizReqSheetPayCredits;
    case PaymentType.onAccount:
      return l10n.bizReqSheetPayOnAccount;
  }
}

// ═══════════════════════════════════════════════════════════════
// SourceBadge
// ═══════════════════════════════════════════════════════════════

class SourceBadge extends StatelessWidget {
  final OrderSource source;
  final bool small;

  const SourceBadge({super.key, required this.source, this.small = false});

  @override
  Widget build(BuildContext context) {
    final _sourceConfig = {
      OrderSource.recurringAuto: (
        label: context.l10n.bizReqSheetSourceAuto,
        icon: Icons.refresh,
        color: const Color(0xFF7B1FA2),
      ),
      OrderSource.appOrder: (
        label: context.l10n.bizReqSheetSourceApp,
        icon: Icons.smartphone,
        color: AppColors.primary,
      ),
      OrderSource.walkUp: (
        label: context.l10n.bizReqSheetSourceWalkUp,
        icon: Icons.shuffle,
        color: AppColors.success,
      ),
      OrderSource.phoneCall: (
        label: context.l10n.bizReqSheetSourcePhone,
        icon: Icons.phone,
        color: AppColors.secondary,
      ),
      OrderSource.whatsapp: (
        label: context.l10n.bizReqSheetSourceWhatsapp,
        icon: Icons.chat,
        color: const Color(0xFF25D366),
      ),
      OrderSource.adHoc: (
        label: context.l10n.bizReqSheetSourceAdHoc,
        icon: Icons.add,
        color: context.colorScheme.onSurfaceVariant,
      ),
    };

    final config = _sourceConfig[source] ??
        (label: source.name, icon: Icons.add, color: context.colorScheme.onSurfaceVariant);

    if (small) {
      return Icon(config.icon, size: 10, color: context.colorScheme.onSurfaceVariant);
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
// Shows detailed cards with undo/edit within 30-min window.
// ═══════════════════════════════════════════════════════════════

class DeliveredCollapse extends StatefulWidget {
  final List<QueueItem> items;
  final void Function(int position)? onUndo;
  final void Function(int position)? onEdit;

  const DeliveredCollapse({
    super.key,
    required this.items,
    this.onUndo,
    this.onEdit,
  });

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
                  color: context.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 6),
                Text(
                  context.l10n.bizReqSheetDelivered(widget.items.length),
                  style: TextStyle(
                    fontSize: 10,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (_open)
            Column(
              children: widget.items.map((d) {
                final totalQty =
                    d.fullDelivered ?? d.items.fold<int>(0, (s, i) => s + i.qty);

                // 30-min edit window
                final deliveredAt = d.deliveredAt != null
                    ? DateTime.tryParse(d.deliveredAt!)
                    : null;
                final minutesAgo = deliveredAt != null
                    ? DateTime.now().difference(deliveredAt).inMinutes
                    : 999;
                final canModify = minutesAgo <= 30;

                // Time label
                final timeLabel = deliveredAt != null
                    ? '${deliveredAt.hour.toString().padLeft(2, '0')}:${deliveredAt.minute.toString().padLeft(2, '0')}'
                    : '';

                return Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: AppRadius.card,
                    border: Border.all(
                      color: context.colorScheme.outlineVariant.withAlpha(100),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top row: check + name | qty + time
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check,
                                  size: 12,
                                  color: AppColors.success,
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    d.customerName,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: context.colorScheme.onSurface,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                context.l10n.bizReqSheetUnitCount(totalQty),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              if (timeLabel.isNotEmpty) ...[
                                const SizedBox(width: 8),
                                Text(
                                  timeLabel,
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: context.colorScheme.onSurfaceVariant
                                        .withAlpha(130),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),

                      // Detail badges row: payment, empties, note
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (d.actualPayment != null)
                              _deliveredBadge(
                                paymentLabel(d.actualPayment!, context.l10n),
                                context.colorScheme.onSurfaceVariant,
                                context.colorScheme.surfaceContainerHighest,
                              ),
                            if (d.emptiesCollected != null &&
                                d.emptiesCollected! > 0) ...[
                              const SizedBox(width: 4),
                              _deliveredBadge(
                                context.l10n.bizReqSheetEmptyCount(d.emptiesCollected!),
                                context.colorScheme.onSurfaceVariant,
                                context.colorScheme.surfaceContainerHighest,
                              ),
                            ],
                            if (d.deliveryNote != null &&
                                d.deliveryNote!.isNotEmpty) ...[
                              const SizedBox(width: 4),
                              Flexible(
                                child: _deliveredBadge(
                                  d.deliveryNote!,
                                  const Color(0xFFFF9800),
                                  const Color(0xFFFFF8E1),
                                  maxWidth: 120,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                      // Undo / Edit actions — only for recent deliveries
                      if (canModify &&
                          (widget.onUndo != null || widget.onEdit != null))
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            padding: const EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: context.colorScheme.outlineVariant
                                      .withAlpha(60),
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                if (widget.onEdit != null)
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () =>
                                          widget.onEdit!(d.position),
                                      child: Container(
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary
                                              .withAlpha(20),
                                          borderRadius:
                                              BorderRadius.circular(
                                                  AppRadius.sm),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.edit_outlined,
                                                size: 10,
                                                color: AppColors.primary),
                                            const SizedBox(width: 4),
                                            Text(
                                              context.l10n.bizReqSheetEditData,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                if (widget.onEdit != null &&
                                    widget.onUndo != null)
                                  const SizedBox(width: 8),
                                if (widget.onUndo != null)
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () =>
                                          widget.onUndo!(d.position),
                                      child: Container(
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: AppColors.error
                                              .withAlpha(20),
                                          borderRadius:
                                              BorderRadius.circular(
                                                  AppRadius.sm),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.undo,
                                                size: 10,
                                                color: AppColors.error),
                                            const SizedBox(width: 4),
                                            Text(
                                              context.l10n.bizReqSheetUndo,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: AppColors.error,
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
                        ),

                      // Expired notice
                      if (!canModify)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text(
                              context.l10n.bizReqSheetExpired,
                              style: TextStyle(
                                fontSize: 8,
                                color: context.colorScheme.onSurfaceVariant
                                    .withAlpha(100),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _deliveredBadge(
    String text,
    Color textColor,
    Color bgColor, {
    double? maxWidth,
  }) {
    return Container(
      constraints:
          maxWidth != null ? BoxConstraints(maxWidth: maxWidth) : null,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.pill,
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 8, color: textColor),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// EditDeliverySheet — modify a delivered item within 30-min window
// ═══════════════════════════════════════════════════════════════

class EditDeliverySheet extends StatefulWidget {
  final QueueItem item;
  final void Function(
    int position,
    int fullDelivered,
    int emptiesCollected,
    PaymentType actualPayment,
    String note,
  ) onSave;

  const EditDeliverySheet({
    super.key,
    required this.item,
    required this.onSave,
  });

  @override
  State<EditDeliverySheet> createState() => _EditDeliverySheetState();
}

class _EditDeliverySheetState extends State<EditDeliverySheet> {
  late int _fullDel;
  late int _emptyCol;
  late PaymentType _payment;
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final qty = widget.item.items.fold<int>(0, (s, i) => s + i.qty);
    _fullDel = widget.item.fullDelivered ?? qty;
    _emptyCol = widget.item.emptiesCollected ?? 0;
    _payment = widget.item.actualPayment ?? widget.item.payment;
    _noteController.text = widget.item.deliveryNote ?? '';
  }

  @override
  void dispose() {
    _noteController.dispose();
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
            title: context.l10n.bizReqSheetEditTitle,
            subtitle: context.l10n.bizReqSheetEditSubtitle,
            onClose: () => Navigator.pop(context),
          ),
          // Customer info
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceVariant,
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
                  widget.item.address.split('\u060C').first,
                  style: TextStyle(
                    fontSize: 10,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Warning banner
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              border: Border.all(color: const Color(0xFFFFECB3)),
              borderRadius: AppRadius.cardInner,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.warning_amber,
                  size: 14,
                  color: Color(0xFFFF9800),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    context.l10n.bizReqSheetEditWarning,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.amber[800],
                    ),
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
                  label: context.l10n.bizReqSheetFullDelivered,
                  value: _fullDel,
                  onChanged: (v) => setState(() => _fullDel = v),
                  incrementColor: AppColors.primary,
                ),
              ),
              Expanded(
                child: _Counter(
                  label: context.l10n.bizReqSheetEmptiesCollected,
                  value: _emptyCol,
                  onChanged: (v) => setState(() => _emptyCol = v),
                  incrementColor: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          // Payment selector
          Row(
            children: paymentOptions(context.l10n).map((opt) {
              final active = _payment == opt.id;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _payment = opt.id),
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: active
                            ? AppColors.primary
                            : context.colorScheme.surfaceVariant,
                        borderRadius: AppRadius.cardInner,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            opt.icon,
                            size: 13,
                            color: active
                                ? Colors.white
                                : context.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            opt.label,
                            style: TextStyle(
                              fontSize: 12,
                              color: active
                                  ? Colors.white
                                  : context.colorScheme.onSurfaceVariant,
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
          const SizedBox(height: AppSpacing.lg),
          // Note
          TextField(
            controller: _noteController,
            decoration: InputDecoration(
              hintText: context.l10n.bizReqSheetNoteHint,
              hintStyle: TextStyle(
                fontSize: 14,
                color: context.colorScheme.onSurfaceVariant,
              ),
              filled: true,
              fillColor: context.colorScheme.surfaceVariant,
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
          // Save button
          Button(
            onPressed: () {
              widget.onSave(
                widget.item.position,
                _fullDel,
                _emptyCol,
                _payment,
                _noteController.text,
              );
              Navigator.pop(context);
            },
            label: context.l10n.bizReqSheetSaveEdit,
            icon: const ButtonIcon(Icons.check),
            size: ButtonSize.large,
            expand: true,
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
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colorScheme.onSurfaceVariant,
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
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 14,
                color: context.colorScheme.onSurfaceVariant,
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
          style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _circleButton(
              icon: Icons.remove,
              color: context.colorScheme.surfaceVariant,
              iconColor: context.colorScheme.onSurface,
              onTap: () => onChanged((value - step).clamp(min, 9999)),
            ),
            SizedBox(
              width: 48,
              child: Text(
                '$value',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ),
            _circleButton(
              icon: Icons.add,
              color: incrementColor,
              iconColor: Colors.white,
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
            title: context.l10n.bizReqSheetConfirmTitle,
            onClose: () => Navigator.pop(context),
          ),
          // Customer info
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceVariant,
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
                  '${context.l10n.bizReqSheetUnitCount(qty)} \u00B7 ${widget.item.address.split('\u060C').first}',
                  style: TextStyle(
                    fontSize: 10,
                    color: context.colorScheme.onSurfaceVariant,
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
                  label: context.l10n.bizReqSheetFullDelivered,
                  value: _fullDel,
                  onChanged: (v) => setState(() => _fullDel = v),
                  incrementColor: AppColors.primary,
                ),
              ),
              Expanded(
                child: _Counter(
                  label: context.l10n.bizReqSheetEmptiesCollected,
                  value: _emptyCol,
                  onChanged: (v) => setState(() => _emptyCol = v),
                  incrementColor: context.colorScheme.onSurfaceVariant,
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
                      Text(
                        context.l10n.bizReqSheetExchangeDiff,
                        style: TextStyle(
                          fontSize: 12,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (exchangeUnits > 0)
                    _infoRow(
                      context.l10n.bizReqSheetExchange,
                      context.l10n.bizReqSheetUnitCount(exchangeUnits),
                      AppColors.success,
                    ),
                  _infoRow(
                    context.l10n.bizReqSheetNewNoEmpty,
                    context.l10n.bizReqSheetUnitCount(newUnits),
                    AppColors.secondary,
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          // Payment selector
          Row(
            children: paymentOptions(context.l10n).map((opt) {
              final active = _payment == opt.id;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _payment = opt.id),
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: active ? AppColors.primary : context.colorScheme.surfaceVariant,
                        borderRadius: AppRadius.cardInner,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            opt.icon,
                            size: 13,
                            color: active ? Colors.white : context.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            opt.label,
                            style: TextStyle(
                              fontSize: 12,
                              color: active ? Colors.white : context.colorScheme.onSurfaceVariant,
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
              context.l10n.bizReqSheetPaymentChanged(paymentLabel(widget.item.payment, context.l10n), paymentLabel(_payment, context.l10n)),
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
                  context.l10n.bizReqSheetCreditsAfter(widget.item.creditsRemaining!, (widget.item.creditsRemaining! - _fullDel).clamp(0, 9999)),
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
              hintText: context.l10n.bizReqSheetNoteHint,
              hintStyle: TextStyle(
                fontSize: 14,
                color: context.colorScheme.onSurfaceVariant,
              ),
              filled: true,
              fillColor: context.colorScheme.surfaceVariant,
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
          Button(
            onPressed: () {
              widget.onConfirm(
                _fullDel,
                _emptyCol,
                _payment,
                _noteController.text,
              );
              Navigator.pop(context);
            },
            label: context.l10n.bizReqSheetConfirmDelivery,
            icon: const ButtonIcon(Icons.check),
            style: Style.success,
            size: ButtonSize.large,
            expand: true,
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
            style: TextStyle(
              fontSize: 10,
              color: context.colorScheme.onSurfaceVariant,
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
            title: context.l10n.bizReqSheetSkipTitle,
            onClose: () => Navigator.pop(context),
          ),
          // Customer info
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceVariant,
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
                  '${widget.item.items.map((i) => '${i.qty} ${context.l10n.bizReqDmBottle}').join(', ')} \u00B7 ${widget.item.address.split('\u060C').first}',
                  style: TextStyle(
                    fontSize: 10,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Reasons
          ...skipReasons(context.l10n).map((r) {
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
                        : context.colorScheme.surface,
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : context.colorScheme.outlineVariant,
                    ),
                    borderRadius: AppRadius.cardInner,
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      color: selected
                          ? AppColors.primary
                          : context.colorScheme.onSurface,
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
                  hintText: context.l10n.bizReqSheetSkipReasonHint,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  filled: true,
                  fillColor: context.colorScheme.surfaceVariant,
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
          Text(
            context.l10n.bizReqSheetMoveTo,
            style: TextStyle(fontSize: 12, color: context.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: skipDestinations(context.l10n).map((d) {
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
                            : context.colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Center(
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 12,
                            color: selected
                                ? AppColors.white
                                : context.colorScheme.onSurfaceVariant,
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
          Button(
            onPressed: () {
              final reason = _reason == 'other'
                  ? _otherController.text
                  : _reason;
              widget.onSkip(reason, _dest);
              Navigator.pop(context);
            },
            label: context.l10n.bizReqSheetSkipConfirm,
            icon: const ButtonIcon(Icons.skip_next),
            style: Style.warning,
            size: ButtonSize.large,
            expand: true,
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
            title: context.l10n.bizReqSheetReloadTitle,
            subtitle: context.l10n.bizReqSheetReloadSubtitle,
            onClose: () => Navigator.pop(context),
          ),
          const SizedBox(height: AppSpacing.sm),
          _Counter(
            label: context.l10n.bizReqSheetFullLoaded,
            value: _newFull,
            onChanged: (v) => setState(() => _newFull = v),
            incrementColor: AppColors.primary,
            step: 5,
            min: 1,
          ),
          const SizedBox(height: AppSpacing.xl),
          _Counter(
            label: context.l10n.bizReqSheetEmptiesDropped,
            value: _emptiesDrop,
            onChanged: (v) => setState(() => _emptiesDrop = v),
            incrementColor: context.colorScheme.onSurfaceVariant,
            step: 5,
          ),
          const SizedBox(height: AppSpacing.xxl),
          Button(
            onPressed: () {
              widget.onReload(_newFull, _emptiesDrop);
              Navigator.pop(context);
            },
            label: context.l10n.bizReqSheetReloadConfirm,
            icon: const ButtonIcon(Icons.refresh),
            size: ButtonSize.large,
            expand: true,
          ),
        ],
      ),
    );
  }
}
