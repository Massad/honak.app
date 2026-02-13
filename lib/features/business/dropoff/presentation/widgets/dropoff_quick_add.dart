import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_item.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_service.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_source.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_status.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_ticket.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

part 'dropoff_quick_add_items.dart';
part 'dropoff_quick_add_review.dart';

// ═════════════════════════════════════════════════════════════════
// Public API
// ═════════════════════════════════════════════════════════════════

/// Shows a 3-step bottom sheet for creating a walk-in dropoff ticket.
/// Returns the new [DropoffTicket] if submitted, `null` if dismissed.
Future<DropoffTicket?> showDropoffQuickAdd(
  BuildContext context, {
  required List<DropoffServiceCategory> serviceCategories,
  required List<DropoffAttribute> attributes,
  required List<String> itemTypes,
}) {
  return showAppSheet<DropoffTicket>(
    context,
    builder: (_) => _DropoffQuickAddSheet(
      serviceCategories: serviceCategories,
      attributes: attributes,
      itemTypes: itemTypes,
    ),
  );
}

// ═════════════════════════════════════════════════════════════════
// Root Sheet
// ═════════════════════════════════════════════════════════════════

class _DropoffQuickAddSheet extends StatefulWidget {
  final List<DropoffServiceCategory> serviceCategories;
  final List<DropoffAttribute> attributes;
  final List<String> itemTypes;

  const _DropoffQuickAddSheet({
    required this.serviceCategories,
    required this.attributes,
    required this.itemTypes,
  });

  @override
  State<_DropoffQuickAddSheet> createState() => _DropoffQuickAddSheetState();
}

class _DropoffQuickAddSheetState extends State<_DropoffQuickAddSheet> {
  int _step = 0; // 0 = customer, 1 = items, 2 = review

  // Step 1 data
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  // Step 2 data
  final List<DropoffItem> _items = [];

  // Step 3 data
  int _estimatedDays = 2;
  bool _urgent = false;
  final _notesCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  String get _stepTitle => switch (_step) {
        0 => 'بيانات العميل',
        1 => 'إضافة القطع',
        2 => 'مراجعة الطلب',
        _ => '',
      };

  bool get _canProceedStep1 => _nameCtrl.text.trim().isNotEmpty;

  int get _ticketNum =>
      DateTime.now().millisecondsSinceEpoch % 10000;

  Money get _totalPrice =>
      _items.fold(const Money.zero(), (sum, item) =>
          sum + Money(item.price) * item.quantity);

  void _addItem(DropoffItem item) {
    setState(() => _items.add(item));
  }

  void _removeItem(int index) {
    setState(() => _items.removeAt(index));
  }

  void _submit() {
    final now = DateTime.now();
    final readyAt = now.add(Duration(days: _estimatedDays));
    final ticketNumber = 'L-${_ticketNum.toString().padLeft(4, '0')}';

    final ticket = DropoffTicket(
      id: 'dof-${now.millisecondsSinceEpoch}',
      ticketNumber: ticketNumber,
      status: DropoffStatus.received,
      source: DropoffSource.walkIn,
      customerName: _nameCtrl.text.trim(),
      customerPhone:
          _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
      items: _items,
      totalPrice: _totalPrice.cents,
      droppedOffAt: now.toIso8601String(),
      estimatedReadyAt: readyAt.toIso8601String(),
      notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
      urgent: _urgent,
    );
    Navigator.pop(context, ticket);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SheetHeader(
          title: _stepTitle,
          step: _step,
          onBack: _step > 0 ? () => setState(() => _step--) : null,
          onClose: () => Navigator.pop(context),
        ),
        Flexible(
          child: switch (_step) {
            0 => _buildStep1(context),
            1 => _ItemsStep(
                serviceCategories: widget.serviceCategories,
                attributes: widget.attributes,
                itemTypes: widget.itemTypes,
                items: _items,
                onAddItem: _addItem,
                onRemoveItem: _removeItem,
                onNext: () => setState(() => _step = 2),
              ),
            2 => _ReviewStep(
                customerName: _nameCtrl.text.trim(),
                customerPhone: _phoneCtrl.text.trim().isEmpty
                    ? null
                    : _phoneCtrl.text.trim(),
                items: _items,
                estimatedDays: _estimatedDays,
                urgent: _urgent,
                notes: _notesCtrl.text,
                totalPrice: _totalPrice,
                ticketNumber:
                    'L-${_ticketNum.toString().padLeft(4, '0')}',
                onEditCustomer: () => setState(() => _step = 0),
                onRemoveItem: _removeItem,
                onEstimatedDaysChanged: (d) =>
                    setState(() => _estimatedDays = d),
                onUrgentChanged: (v) => setState(() => _urgent = v),
                notesController: _notesCtrl,
                onSubmit: _submit,
              ),
            _ => const SizedBox.shrink(),
          },
        ),
      ],
    );
  }

  // ── Step 1: Customer Info ──

  Widget _buildStep1(BuildContext context) {
    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      children: [
        _FieldLabel('اسم العميل *'),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: _nameCtrl,
          onChanged: (_) => setState(() {}),
          decoration: _inputDecoration(
            hint: 'مثال: أحمد',
            prefixIcon: Icons.person_outline,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        _FieldLabel('رقم الهاتف (اختياري)'),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: _phoneCtrl,
          keyboardType: TextInputType.phone,
          textDirection: TextDirection.ltr,
          decoration: _inputDecoration(
            hint: '07XXXXXXXX',
            prefixIcon: Icons.phone_outlined,
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),

        GestureDetector(
          onTap: _canProceedStep1
              ? () => setState(() => _step = 1)
              : null,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: _canProceedStep1
                  ? const Color(0xFF1A73E8)
                  : Colors.grey.shade300,
              borderRadius: AppRadius.cardInner,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'التالي — إضافة القطع',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const Icon(
                  Icons.chevron_left_rounded,
                  size: 16,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════
// Sheet Header (with step indicator + back)
// ═════════════════════════════════════════════════════════════════

class _SheetHeader extends StatelessWidget {
  final String title;
  final int step;
  final VoidCallback? onBack;
  final VoidCallback onClose;

  const _SheetHeader({
    required this.title,
    required this.step,
    this.onBack,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Title row
          Row(
            children: [
              if (onBack != null)
                GestureDetector(
                  onTap: onBack,
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.only(end: AppSpacing.sm),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 20,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Step indicator
              Text(
                '${step + 1}/3',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              GestureDetector(
                onTap: onClose,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ],
          ),
          // Step progress bar
          const SizedBox(height: AppSpacing.md),
          Row(
            children: List.generate(3, (i) {
              return Expanded(
                child: Container(
                  height: 3,
                  margin: EdgeInsetsDirectional.only(
                    end: i < 2 ? AppSpacing.xs : 0,
                  ),
                  decoration: BoxDecoration(
                    color: i <= step
                        ? AppColors.primary
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
          const Divider(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════
// Shared Widgets
// ═════════════════════════════════════════════════════════════════

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
    );
  }
}

InputDecoration _inputDecoration({
  String? hint,
  IconData? prefixIcon,
}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade300),
    prefixIcon: prefixIcon != null
        ? Icon(prefixIcon, size: 16, color: Colors.grey.shade300)
        : null,
    filled: true,
    fillColor: Colors.grey.shade50,
    contentPadding: const EdgeInsetsDirectional.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.md,
    ),
    border: OutlineInputBorder(
      borderRadius: AppRadius.cardInner,
      borderSide: BorderSide(color: Colors.grey.shade200),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: AppRadius.cardInner,
      borderSide: BorderSide(color: Colors.grey.shade200),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppRadius.cardInner,
      borderSide: const BorderSide(color: AppColors.primary),
    ),
  );
}
