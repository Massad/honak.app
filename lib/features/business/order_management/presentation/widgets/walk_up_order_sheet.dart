import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/l10n/arb/app_localizations.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/domain/entities/truck.dart';
import 'package:honak/shared/widgets/button.dart';

/// Quick order entry sheet used during driving mode.
/// Designed for speed — capture a walk-up/phone/whatsapp order in <30s.
class WalkUpOrderSheet extends StatefulWidget {
  final String productName;
  final void Function(QueueItem item) onAddAndDeliver;
  final void Function(QueueItem item) onAddToQueue;

  const WalkUpOrderSheet({
    super.key,
    required this.productName,
    required this.onAddAndDeliver,
    required this.onAddToQueue,
  });

  @override
  State<WalkUpOrderSheet> createState() => _WalkUpOrderSheetState();
}

class _WalkUpOrderSheetState extends State<WalkUpOrderSheet> {
  OrderSource _source = OrderSource.walkUp;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  int _qty = 1;
  int _emptyQty = 1;
  PaymentType _payment = PaymentType.cash;
  final _noteController = TextEditingController();

  List<({OrderSource id, String label, IconData icon})> _sourceOptions(AppLocalizations l10n) => [
    (id: OrderSource.walkUp, label: l10n.bizReqWalkUpSourceWalkUp, icon: Icons.shuffle),
    (id: OrderSource.phoneCall, label: l10n.bizReqWalkUpSourcePhone, icon: Icons.phone),
    (id: OrderSource.whatsapp, label: l10n.bizReqWalkUpSourceWhatsapp, icon: Icons.chat),
  ];

  List<({PaymentType id, String label})> _paymentOptions(AppLocalizations l10n) => [
    (id: PaymentType.cash, label: l10n.bizReqWalkUpPayCash),
    (id: PaymentType.credits, label: l10n.bizReqWalkUpPayCredits),
    (id: PaymentType.onAccount, label: l10n.bizReqWalkUpPayOnAccount),
  ];

  bool get _canSubmit => _qty > 0;

  QueueItem _buildItem(QueueItemStatus status) {
    return QueueItem(
      position: 0,
      status: status,
      customerName:
          _nameController.text.trim().isEmpty
              ? context.l10n.bizReqWalkUpDefaultCustomer
              : _nameController.text.trim(),
      customerPhone: _phoneController.text.trim(),
      address: context.l10n.bizReqWalkUpGpsPoint,
      coordinates: const LatLng(lat: 31.955, lng: 35.873),
      items: [QueueOrderItem(name: widget.productName, qty: _qty)],
      source: _source,
      payment: _payment,
      notes: _noteController.text.isEmpty ? null : _noteController.text,
      isNewCustomer: true,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.xl,
            AppSpacing.lg,
            AppSpacing.md,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  context.l10n.bizReqWalkUpTitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerHighest,
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
        ),
        Divider(height: 1, color: context.colorScheme.outlineVariant),
        // Scrollable content
        Flexible(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(AppSpacing.lg),
                  children: [
                    // Source selector
                    Text(
                      context.l10n.bizReqWalkUpSource,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: _sourceOptions(context.l10n).map((s) {
                        final active = _source == s.id;
                        return Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsetsDirectional.only(end: 8),
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _source = s.id),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSpacing.sm,
                                ),
                                decoration: BoxDecoration(
                                  color: active
                                      ? AppColors.primary
                                      : context.colorScheme.surfaceContainerHighest,
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.sm),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      s.icon,
                                      size: 14,
                                      color: active
                                          ? AppColors.white
                                          : context.colorScheme.onSurfaceVariant,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      s.label,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: active
                                            ? AppColors.white
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
                    // Customer section with "اختياري" badge
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 13,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              context.l10n.bizReqWalkUpWho,
                              style: TextStyle(
                                fontSize: 12,
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: context.colorScheme.surfaceContainerHighest,
                            borderRadius: AppRadius.pill,
                          ),
                          child: Text(
                            context.l10n.optional,
                            style: TextStyle(
                              fontSize: 10,
                              color: context.colorScheme.onSurfaceVariant
                                  .withAlpha(130),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    // Customer name
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: context.l10n.bizReqWalkUpCustomerName,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        filled: true,
                        fillColor: context.colorScheme.surfaceContainerHighest,
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
                    const SizedBox(height: AppSpacing.sm),
                    // Phone
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textDirection: Directionality.of(context),
                      decoration: InputDecoration(
                        hintText: context.l10n.bizReqWalkUpPhoneOptional,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        filled: true,
                        fillColor: context.colorScheme.surfaceContainerHighest,
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
                    // Quantity
                    Text(
                      widget.productName,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerHighest,
                        borderRadius: AppRadius.cardInner,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _circleBtn(
                            icon: Icons.remove,
                            color: context.colorScheme.surface,
                            iconColor: context.colorScheme.onSurface,
                            onTap: () => setState(
                              () => _qty = (_qty - 1).clamp(1, 999),
                            ),
                          ),
                          SizedBox(
                            width: 64,
                            child: Text(
                              '$_qty',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                                color: context.colorScheme.onSurface,
                              ),
                            ),
                          ),
                          _circleBtn(
                            icon: Icons.add,
                            color: AppColors.primary,
                            iconColor: Colors.white,
                            onTap: () => setState(() => _qty++),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    // Empties
                    Text(
                      context.l10n.bizReqWalkUpEmpties,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _circleBtn(
                          icon: Icons.remove,
                          color: context.colorScheme.surfaceContainerHighest,
                          iconColor: context.colorScheme.onSurface,
                          onTap: () => setState(
                            () => _emptyQty = (_emptyQty - 1).clamp(0, 999),
                          ),
                          size: 40,
                        ),
                        SizedBox(
                          width: 48,
                          child: Text(
                            '$_emptyQty',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                        ),
                        _circleBtn(
                          icon: Icons.add,
                          color: Theme.of(context).colorScheme.outline,
                          iconColor: context.colorScheme.onSurface,
                          onTap: () => setState(() => _emptyQty++),
                          size: 40,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    // Payment
                    Text(
                      context.l10n.bizReqWalkUpPayment,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: _paymentOptions(context.l10n).map((p) {
                        final active = _payment == p.id;
                        return Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsetsDirectional.only(end: 8),
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _payment = p.id),
                              child: Container(
                                height: 44,
                                decoration: BoxDecoration(
                                  color: active
                                      ? AppColors.primary
                                      : context.colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.sm,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    p.label,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: active
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
                    // Note
                    TextField(
                      controller: _noteController,
                      decoration: InputDecoration(
                        hintText: context.l10n.bizReqWalkUpNoteHint,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        filled: true,
                        fillColor: context.colorScheme.surfaceContainerHighest,
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
                    const SizedBox(height: AppSpacing.xl),
                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: Button(
                            onPressed: _canSubmit
                                ? () {
                                    final item = _buildItem(
                                      QueueItemStatus.delivered,
                                    );
                                    widget.onAddAndDeliver(item);
                                    Navigator.pop(context);
                                  }
                                : null,
                            label: context.l10n.bizReqWalkUpAddDeliver,
                            icon: const ButtonIcon(Icons.check),
                            style: Style.success,
                            size: ButtonSize.large,
                            expand: true,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Button(
                            onPressed: _canSubmit
                                ? () {
                                    final item = _buildItem(
                                      QueueItemStatus.pending,
                                    );
                                    widget.onAddToQueue(item);
                                    Navigator.pop(context);
                                  }
                                : null,
                            label: context.l10n.bizReqWalkUpAddQueue,
                            icon: const ButtonIcon(Icons.add),
                            variant: Variant.outlined,
                            size: ButtonSize.large,
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

  Widget _circleBtn({
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
    double size = 48,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: color == context.colorScheme.surface
              ? Border.all(color: context.colorScheme.outlineVariant)
              : null,
        ),
        child: Icon(icon, size: size * 0.375, color: iconColor),
      ),
    );
  }
}
