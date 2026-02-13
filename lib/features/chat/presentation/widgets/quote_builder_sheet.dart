import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/power_chat_types.dart';
import 'package:honak/shared/entities/money.dart';

class QuoteBuilderSheet extends StatefulWidget {
  final void Function(QuoteData quote) onSend;

  const QuoteBuilderSheet({super.key, required this.onSend});

  @override
  State<QuoteBuilderSheet> createState() => _QuoteBuilderSheetState();
}

class _QuoteBuilderSheetState extends State<QuoteBuilderSheet> {
  final List<_LineItem> _items = [_LineItem()];
  final _discountController = TextEditingController();
  final _notesController = TextEditingController();
  int _validDays = 3;

  static const _validDayOptions = [1, 3, 7, 14];

  @override
  void dispose() {
    _discountController.dispose();
    _notesController.dispose();
    for (final item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  int get _subtotalCents {
    return _items.fold(0, (sum, item) => sum + item.totalCents);
  }

  int get _discountCents {
    final text = _discountController.text.trim();
    if (text.isEmpty) return 0;
    final parsed = double.tryParse(text);
    if (parsed == null) return 0;
    return (parsed * 100).round();
  }

  int get _totalCents {
    final total = _subtotalCents - _discountCents;
    return total < 0 ? 0 : total;
  }

  bool get _isValid {
    return _items.any((item) =>
        item.descriptionController.text.trim().isNotEmpty &&
        item.priceCents > 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHandle(),
        _buildHeader(context),
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLineItems(),
                const SizedBox(height: AppSpacing.sm),
                _buildAddButton(),
                const SizedBox(height: AppSpacing.lg),
                _buildDiscount(),
                const SizedBox(height: AppSpacing.lg),
                _buildNotes(),
                const SizedBox(height: AppSpacing.lg),
                _buildValiditySelector(),
                const SizedBox(height: AppSpacing.lg),
                _buildTotalPreview(),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
        _buildSendButton(context),
      ],
    );
  }

  Widget _buildHandle() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: AppSpacing.sm),
      child: Container(
        width: 36,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.divider,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.lg,
        end: AppSpacing.sm,
        top: AppSpacing.md,
        bottom: AppSpacing.sm,
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'عرض سعر',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, size: 20),
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildLineItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'البنود',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ...List.generate(_items.length, (i) {
          return _LineItemRow(
            item: _items[i],
            showRemove: _items.length > 1,
            onRemove: () {
              setState(() {
                _items[i].dispose();
                _items.removeAt(i);
              });
            },
            onChanged: () => setState(() {}),
          );
        }),
      ],
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () => setState(() => _items.add(_LineItem())),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.divider,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 18, color: AppColors.primary),
            SizedBox(width: AppSpacing.xs),
            Text(
              'إضافة بند',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'خصم (اختياري)',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: _discountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: '0.00',
            hintStyle: const TextStyle(color: AppColors.textHint),
            suffixText: 'د.أ',
            suffixStyle: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
            filled: true,
            fillColor: AppColors.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            isDense: true,
          ),
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildNotes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ملاحظات (اختياري)',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: _notesController,
          maxLines: 3,
          minLines: 2,
          decoration: InputDecoration(
            hintText: 'أي ملاحظات إضافية...',
            hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
            filled: true,
            fillColor: AppColors.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsetsDirectional.all(AppSpacing.md),
            isDense: true,
          ),
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildValiditySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'صلاحية العرض',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: _validDayOptions.map((days) {
            final isSelected = _validDays == days;
            return Padding(
              padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
              child: GestureDetector(
                onTap: () => setState(() => _validDays = days),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.warning.withValues(alpha: 0.12)
                        : AppColors.surfaceVariant,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.warning
                          : AppColors.divider,
                      width: isSelected ? 1.5 : 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$days يوم',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected
                          ? AppColors.warning
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTotalPreview() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.06),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.2),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          if (_discountCents > 0) ...[
            _previewRow(
              'المجموع الفرعي',
              Money(_subtotalCents).toFormattedArabic(),
            ),
            const SizedBox(height: 4),
            _previewRow(
              'خصم',
              '- ${Money(_discountCents).toFormattedArabic()}',
              color: AppColors.success,
            ),
            const Padding(
              padding: EdgeInsetsDirectional.symmetric(vertical: 6),
              child: Divider(height: 1, color: AppColors.divider),
            ),
          ],
          _previewRow(
            'الإجمالي',
            Money(_totalCents).toFormattedArabic(),
            isBold: true,
            color: AppColors.warning,
          ),
        ],
      ),
    );
  }

  Widget _previewRow(
    String label,
    String value, {
    Color? color,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 14 : 12,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 16 : 13,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: color ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSendButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton.icon(
          onPressed: _isValid ? () => _send(context) : null,
          icon: const Icon(Icons.send_rounded, size: 18),
          label: const Text('إرسال عرض السعر'),
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.warning,
            disabledBackgroundColor: AppColors.divider,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsetsDirectional.symmetric(
              vertical: 14,
            ),
          ),
        ),
      ),
    );
  }

  void _send(BuildContext context) {
    final quoteItems = _items
        .where((item) =>
            item.descriptionController.text.trim().isNotEmpty &&
            item.priceCents > 0)
        .map((item) => QuoteItem(
              description: item.descriptionController.text.trim(),
              quantity: item.quantity,
              unitPriceCents: item.priceCents,
            ))
        .toList();

    final notes = _notesController.text.trim().isNotEmpty
        ? _notesController.text.trim()
        : null;

    final quote = QuoteData(
      id: 'quote_${DateTime.now().millisecondsSinceEpoch}',
      items: quoteItems,
      subtotalCents: _subtotalCents,
      discountCents: _discountCents > 0 ? _discountCents : null,
      totalCents: _totalCents,
      validDays: _validDays,
      notes: notes,
    );

    widget.onSend(quote);
    Navigator.pop(context);
  }
}

class _LineItem {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  int quantity = 1;

  int get priceCents {
    final text = priceController.text.trim();
    if (text.isEmpty) return 0;
    final parsed = double.tryParse(text);
    if (parsed == null) return 0;
    return (parsed * 100).round();
  }

  int get totalCents => priceCents * quantity;

  void dispose() {
    descriptionController.dispose();
    priceController.dispose();
  }
}

class _LineItemRow extends StatelessWidget {
  final _LineItem item;
  final bool showRemove;
  final VoidCallback onRemove;
  final VoidCallback onChanged;

  const _LineItemRow({
    required this.item,
    required this.showRemove,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      padding: const EdgeInsetsDirectional.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: item.descriptionController,
                  onChanged: (_) => onChanged(),
                  decoration: const InputDecoration(
                    hintText: 'وصف البند',
                    hintStyle:
                        TextStyle(color: AppColors.textHint, fontSize: 13),
                    border: InputBorder.none,
                    contentPadding: EdgeInsetsDirectional.symmetric(
                      horizontal: AppSpacing.sm,
                    ),
                    isDense: true,
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              if (showRemove)
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.close, size: 16),
                  color: AppColors.textHint,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                ),
            ],
          ),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              // Quantity stepper
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.divider),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _StepperButton(
                      icon: Icons.remove,
                      onTap: item.quantity > 1
                          ? () {
                              item.quantity--;
                              onChanged();
                            }
                          : null,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: AppSpacing.sm,
                      ),
                      child: Text(
                        '${item.quantity}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    _StepperButton(
                      icon: Icons.add,
                      onTap: () {
                        item.quantity++;
                        onChanged();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              // Price input
              Expanded(
                child: TextField(
                  controller: item.priceController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (_) => onChanged(),
                  textAlign: TextAlign.end,
                  decoration: const InputDecoration(
                    hintText: '0.00',
                    hintStyle:
                        TextStyle(color: AppColors.textHint, fontSize: 13),
                    suffixText: 'د.أ',
                    suffixStyle: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsetsDirectional.symmetric(
                      horizontal: AppSpacing.sm,
                    ),
                    isDense: true,
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _StepperButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 16,
          color: onTap != null ? AppColors.textPrimary : AppColors.textHint,
        ),
      ),
    );
  }
}
