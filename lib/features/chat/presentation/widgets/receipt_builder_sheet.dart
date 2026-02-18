import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/power_chat_types.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/button.dart';

class ReceiptBuilderSheet extends StatefulWidget {
  final void Function(ReceiptCardData data) onSend;

  const ReceiptBuilderSheet({super.key, required this.onSend});

  @override
  State<ReceiptBuilderSheet> createState() => _ReceiptBuilderSheetState();
}

class _ReceiptBuilderSheetState extends State<ReceiptBuilderSheet> {
  final _titleController = TextEditingController(text: 'إيصال الدفع');
  final _discountController = TextEditingController();
  final _deliveryController = TextEditingController();
  final _notesController = TextEditingController();
  final List<_ReceiptDraftItem> _items = [_ReceiptDraftItem()];
  String _paymentMethod = 'cash';

  static const _paymentMethods = <({String id, String label})>[
    (id: 'cash', label: 'نقداً'),
    (id: 'cliq', label: 'كليك'),
    (id: 'bank_transfer', label: 'تحويل بنكي'),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _discountController.dispose();
    _deliveryController.dispose();
    _notesController.dispose();
    for (final item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  int _toCents(String value) {
    final parsed = double.tryParse(value.trim());
    if (parsed == null) return 0;
    return (parsed * 100).round();
  }

  int get _subtotalCents =>
      _validItems.fold(0, (sum, item) => sum + item.totalCents);
  int get _discountCents => _toCents(_discountController.text);
  int get _deliveryCents => _toCents(_deliveryController.text);
  int get _totalCents {
    final total = _subtotalCents - _discountCents + _deliveryCents;
    return total < 0 ? 0 : total;
  }

  List<_ReceiptLineDraft> get _validItems => _items
      .map((item) => item.toLine())
      .whereType<_ReceiptLineDraft>()
      .toList();

  bool get _canSend => _validItems.isNotEmpty;

  void _addItem() {
    setState(() => _items.add(_ReceiptDraftItem()));
  }

  void _removeItemAt(int index) {
    if (_items.length <= 1) return;
    setState(() {
      _items[index].dispose();
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppSheetScaffold(
      title: 'أرسل إيصال',
      variant: AppSheetVariant.fullscreen,
      headerCompact: true,
      showBodyDivider: false,
      showFooterDivider: true,
      scrollable: false,
      bodyPadding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      footerPadding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: 'عنوان الإيصال',
              filled: true,
              fillColor: context.colorScheme.surfaceContainerLowest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: context.colorScheme.outlineVariant,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: ListView(
              children: [
                Text(
                  'بنود الإيصال',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                ..._items.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return Padding(
                    padding: const EdgeInsetsDirectional.only(
                      bottom: AppSpacing.sm,
                    ),
                    child: _ReceiptItemCard(
                      index: index + 1,
                      item: item,
                      canRemove: _items.length > 1,
                      onRemove: () => _removeItemAt(index),
                      onChanged: () => setState(() {}),
                    ),
                  );
                }),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Button(
                    onPressed: _addItem,
                    label: 'أضف بند',
                    icon: const ButtonIcon(Icons.add, size: 16),
                    variant: Variant.text,
                    size: ButtonSize.small,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: _MoneyField(
                        controller: _discountController,
                        label: 'خصم (د.أ)',
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _MoneyField(
                        controller: _deliveryController,
                        label: 'توصيل (د.أ)',
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'طريقة الدفع',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: _paymentMethods.map((method) {
                    final selected = _paymentMethod == method.id;
                    return ChoiceChip(
                      label: Text(method.label),
                      selected: selected,
                      onSelected: (_) =>
                          setState(() => _paymentMethod = method.id),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextField(
                  controller: _notesController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'ملاحظات (اختياري)',
                    filled: true,
                    fillColor: context.colorScheme.surfaceContainerLowest,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: context.colorScheme.outlineVariant,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsetsDirectional.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer.withValues(
                      alpha: 0.3,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: context.colorScheme.primaryContainer,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'الإجمالي',
                        style: context.textTheme.labelMedium?.copyWith(
                          color: context.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        (_totalCents / 100).toStringAsFixed(2),
                        style: context.textTheme.headlineSmall?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      footer: Button(
        onPressed: _canSend
            ? () {
                final items = _validItems
                    .map(
                      (item) => ReceiptLineItem(
                        label: item.label,
                        quantity: item.quantity,
                        unitPriceCents: item.unitPriceCents,
                      ),
                    )
                    .toList();
                widget.onSend(
                  ReceiptCardData(
                    title: _titleController.text.trim().isEmpty
                        ? 'إيصال الدفع'
                        : _titleController.text.trim(),
                    items: items,
                    subtotalCents: _subtotalCents,
                    discountCents: _discountCents,
                    deliveryFeeCents: _deliveryCents,
                    totalCents: _totalCents,
                    paymentMethod: _paymentMethod,
                    status: 'pending',
                  ),
                );
                Navigator.of(context).pop();
              }
            : null,
        label: 'إرسال الإيصال',
        icon: const ButtonIcon(Icons.send_rounded, size: 16),
        expand: true,
      ),
    );
  }
}

class _ReceiptItemCard extends StatelessWidget {
  final int index;
  final _ReceiptDraftItem item;
  final bool canRemove;
  final VoidCallback onRemove;
  final VoidCallback onChanged;

  const _ReceiptItemCard({
    required this.index,
    required this.item,
    required this.canRemove,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'بند $index',
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              if (canRemove)
                Button(
                  onPressed: onRemove,
                  label: 'حذف',
                  variant: Variant.text,
                  style: Style.danger,
                  size: ButtonSize.small,
                ),
            ],
          ),
          TextField(
            controller: item.labelController,
            onChanged: (_) => onChanged(),
            decoration: InputDecoration(
              hintText: 'اسم البند',
              filled: true,
              fillColor: context.colorScheme.surface,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Expanded(
                child: _MoneyField(
                  controller: item.quantityController,
                  label: 'الكمية',
                  onChanged: (_) => onChanged(),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _MoneyField(
                  controller: item.unitPriceController,
                  label: 'السعر (د.أ)',
                  onChanged: (_) => onChanged(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MoneyField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final ValueChanged<String>? onChanged;

  const _MoneyField({
    required this.controller,
    required this.label,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: context.colorScheme.surface,
      ),
    );
  }
}

class _ReceiptDraftItem {
  final labelController = TextEditingController();
  final quantityController = TextEditingController(text: '1');
  final unitPriceController = TextEditingController();

  void dispose() {
    labelController.dispose();
    quantityController.dispose();
    unitPriceController.dispose();
  }

  _ReceiptLineDraft? toLine() {
    final label = labelController.text.trim();
    if (label.isEmpty) return null;
    final quantity = int.tryParse(quantityController.text.trim()) ?? 1;
    final unitPrice =
        ((double.tryParse(unitPriceController.text.trim()) ?? 0) * 100).round();
    return _ReceiptLineDraft(
      label: label,
      quantity: quantity < 1 ? 1 : quantity,
      unitPriceCents: unitPrice < 0 ? 0 : unitPrice,
    );
  }
}

class _ReceiptLineDraft {
  final String label;
  final int quantity;
  final int unitPriceCents;

  const _ReceiptLineDraft({
    required this.label,
    required this.quantity,
    required this.unitPriceCents,
  });

  int get totalCents => quantity * unitPriceCents;
}
