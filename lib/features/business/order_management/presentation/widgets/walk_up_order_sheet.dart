import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/domain/entities/truck.dart';

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

  static const _sourceOptions = [
    (id: OrderSource.walkUp, label: 'زبون مباشر', icon: Icons.person),
    (id: OrderSource.phoneCall, label: 'اتصال', icon: Icons.phone),
    (id: OrderSource.whatsapp, label: 'واتساب', icon: Icons.chat),
  ];

  static const _paymentOptions = [
    (id: PaymentType.cash, label: 'نقدا\u064B'),
    (id: PaymentType.credits, label: 'رصيد'),
    (id: PaymentType.onAccount, label: 'على الحساب'),
  ];

  bool get _canSubmit => _qty > 0;

  QueueItem _buildItem(QueueItemStatus status) {
    return QueueItem(
      position: 0,
      status: status,
      customerName:
          _nameController.text.trim().isEmpty
              ? 'زبون جديد'
              : _nameController.text.trim(),
      customerPhone: _phoneController.text.trim(),
      address: 'نقطة GPS',
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
              const Expanded(
                child: const Text(
                  'طلب سريع',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
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
                      'مصدر الطلب',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: _sourceOptions.map((s) {
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
                                      : context.colorScheme.surfaceVariant,
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
                    // Customer name
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'اسم الزبون',
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
                    const SizedBox(height: AppSpacing.sm),
                    // Phone
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                        hintText: 'رقم الهاتف (اختياري)',
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
                        color: context.colorScheme.surfaceVariant,
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
                      'فوارغ للجمع',
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
                          color: context.colorScheme.surfaceVariant,
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
                      'الدفع',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: _paymentOptions.map((p) {
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
                                      : context.colorScheme.surfaceVariant,
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
                        hintText: 'ملاحظة (اختياري)',
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
                    const SizedBox(height: AppSpacing.xl),
                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton.icon(
                              onPressed: _canSubmit
                                  ? () {
                                      final item = _buildItem(
                                        QueueItemStatus.delivered,
                                      );
                                      widget.onAddAndDeliver(item);
                                      Navigator.pop(context);
                                    }
                                  : null,
                              icon:
                                  const Icon(Icons.check, size: 14),
                              label:
                                  const Text('أضف وسل\u0651م الآن'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.success,
                                foregroundColor: Colors.white,
                                disabledBackgroundColor:
                                    context.colorScheme.surfaceVariant,
                                disabledForegroundColor:
                                    context.colorScheme.onSurfaceVariant,
                                shape: RoundedRectangleBorder(
                                  borderRadius: AppRadius.cardInner,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: OutlinedButton.icon(
                              onPressed: _canSubmit
                                  ? () {
                                      final item = _buildItem(
                                        QueueItemStatus.pending,
                                      );
                                      widget.onAddToQueue(item);
                                      Navigator.pop(context);
                                    }
                                  : null,
                              icon:
                                  const Icon(Icons.add, size: 14),
                              label: const Text('أضف للدور'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                side: BorderSide(
                                  color: _canSubmit
                                      ? AppColors.primary
                                      : context.colorScheme.outlineVariant,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: AppRadius.cardInner,
                                ),
                              ),
                            ),
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
