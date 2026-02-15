import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/power_chat_types.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// Input limits for quote fields.
abstract final class QuoteLimits {
  static const int maxDescriptionLength = 100;
  static const int maxNotesLength = 300;
  static const int maxLineItems = 10;
}

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
    // Every line item must have a name. Price 0 is OK.
    return _items.isNotEmpty &&
        _items.every(
            (item) => item.descriptionController.text.trim().isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSheetHeader(
          title: 'عرض سعر',
          leading: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              size: 15,
              color: AppColors.warning,
            ),
          ),
          onClose: () => Navigator.pop(context),
        ),
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
                if (_items.length < QuoteLimits.maxLineItems)
                  _buildAddButton(),
                const SizedBox(height: AppSpacing.xl),
                _buildDiscount(),
                const SizedBox(height: AppSpacing.lg),
                _buildNotes(),
                const SizedBox(height: AppSpacing.lg),
                _buildValiditySelector(),
                const SizedBox(height: AppSpacing.lg),
                _buildSummary(),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
        _buildSendButton(context),
      ],
    );
  }

  // ─── Line items ─────────────────────────────────────────────

  Widget _buildLineItems() {
    return Column(
      children: List.generate(_items.length, (i) {
        return _LineItemCard(
          item: _items[i],
          index: i + 1,
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
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () => setState(() => _items.add(_LineItem())),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(12),
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

  // ─── Discount ───────────────────────────────────────────────

  Widget _buildDiscount() {
    return _FieldSection(
      label: 'خصم (اختياري)',
      child: _OutlinedMoneyField(
        controller: _discountController,
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  // ─── Notes ──────────────────────────────────────────────────

  Widget _buildNotes() {
    return _FieldSection(
      label: 'ملاحظات للعميل (اختياري)',
      child: TextField(
        controller: _notesController,
        maxLines: 3,
        minLines: 2,
        maxLength: QuoteLimits.maxNotesLength,
        decoration: InputDecoration(
          hintText: 'مثال: يشمل الكشف والتشخيص. المواد أصلية مع ضمان سنة.',
          hintStyle: TextStyle(
            color: context.colorScheme.onSurfaceVariant,
            fontSize: 13,
          ),
          filled: true,
          fillColor: context.colorScheme.surfaceContainerLowest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: context.colorScheme.outlineVariant),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: context.colorScheme.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.warning),
          ),
          contentPadding: const EdgeInsetsDirectional.all(AppSpacing.md),
          isDense: true,
          counterText: '',
        ),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  // ─── Validity ───────────────────────────────────────────────

  Widget _buildValiditySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel('العرض صالح لمدة'),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: _validDayOptions.map((days) {
            final isSelected = _validDays == days;
            final label = days == 1 ? '١ يوم' : '$days أيام';
            return Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  end: days != _validDayOptions.last ? AppSpacing.sm : 0,
                ),
                child: GestureDetector(
                  onTap: () => setState(() => _validDays = days),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 10,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.warning
                          : context.colorScheme.surfaceContainerLow,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.warning
                            : context.colorScheme.outlineVariant,
                        width: isSelected ? 1.5 : 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected
                            ? Colors.white
                            : context.colorScheme.onSurface,
                      ),
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

  // ─── Summary ────────────────────────────────────────────────

  Widget _buildSummary() {
    final hasDiscount = _discountCents > 0;
    final validityLabel = _validDays == 1 ? '١ يوم' : '$_validDays أيام';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.06),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.2),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(11),
                topRight: Radius.circular(11),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.receipt_long_outlined,
                    size: 14, color: AppColors.warning),
                SizedBox(width: AppSpacing.xs),
                Text(
                  'ملخص العرض',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.warning,
                  ),
                ),
              ],
            ),
          ),
          // Body
          Padding(
            padding: const EdgeInsetsDirectional.all(AppSpacing.md),
            child: Column(
              children: [
                if (hasDiscount) ...[
                  _summaryRow(
                    'المجموع الفرعي',
                    Money(_subtotalCents).toFormattedArabic(),
                  ),
                  const SizedBox(height: 4),
                  _summaryRow(
                    'خصم',
                    '- ${Money(_discountCents).toFormattedArabic()}',
                    color: AppColors.success,
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.symmetric(vertical: 8),
                    child: Divider(
                        height: 1,
                        color: AppColors.warning.withValues(alpha: 0.2)),
                  ),
                ],
                _summaryRow(
                  'الإجمالي',
                  Money(_totalCents).toFormattedArabic(),
                  isBold: true,
                  color: AppColors.warning,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined,
                        size: 12, color: AppColors.warning),
                    const SizedBox(width: 3),
                    Text(
                      'صالح لمدة $validityLabel',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.warning,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
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
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 16 : 13,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: color ?? context.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  // ─── Send button ────────────────────────────────────────────

  Widget _buildSendButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: _isValid ? () => _send(context) : null,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.warning,
            disabledBackgroundColor: context.colorScheme.outlineVariant,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsetsDirectional.symmetric(vertical: 14),
          ),
          // In RTL Row: Text=RIGHT (start), Icon=LEFT (end) ✓
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('إرسال'),
              SizedBox(width: AppSpacing.sm),
              Icon(Icons.send_rounded, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Send logic ─────────────────────────────────────────────

  void _send(BuildContext context) {
    final quoteItems = _items
        .where(
            (item) => item.descriptionController.text.trim().isNotEmpty)
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

// ═══════════════════════════════════════════════════════════════
// Shared helpers
// ═══════════════════════════════════════════════════════════════

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: context.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _FieldSection extends StatelessWidget {
  final String label;
  final Widget child;

  const _FieldSection({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(label),
        const SizedBox(height: AppSpacing.xs),
        child,
      ],
    );
  }
}

/// Outlined money input matching Figma style.
class _OutlinedMoneyField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _OutlinedMoneyField({
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: '0.00',
        hintStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 13),
        suffixText: 'د.أ',
        suffixStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 13),
        filled: true,
        fillColor: cs.surfaceContainerLowest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.warning),
        ),
        contentPadding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        isDense: true,
      ),
      style: const TextStyle(fontSize: 14),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Line item model + card
// ═══════════════════════════════════════════════════════════════

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

/// A single quote line item card matching Figma layout:
///
/// ```
/// ┌──────────────────────────────────────┐
/// │                            بند 1     │
/// │  ┌──────────────────────────────┐    │
/// │  │ مثال: كشف وتشخيص التسريب...   │    │
/// │  └──────────────────────────────┘    │
/// │  الكمية  [+ 1 -]  السعر  [__] د.أ   │
/// └──────────────────────────────────────┘
/// ```
class _LineItemCard extends StatelessWidget {
  final _LineItem item;
  final int index;
  final bool showRemove;
  final VoidCallback onRemove;
  final VoidCallback onChanged;

  const _LineItemCard({
    required this.item,
    required this.index,
    required this.showRemove,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;

    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: AppSpacing.md),
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // "بند N" label
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'بند $index',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              // Description field (outlined)
              TextField(
                controller: item.descriptionController,
                onChanged: (_) => onChanged(),
                maxLength: QuoteLimits.maxDescriptionLength,
                decoration: InputDecoration(
                  hintText: 'مثال: كشف وتشخيص التسريب...',
                  hintStyle: TextStyle(
                    color: cs.onSurfaceVariant,
                    fontSize: 13,
                  ),
                  filled: true,
                  fillColor: cs.surfaceContainerLowest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: cs.outlineVariant),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: cs.outlineVariant),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.warning),
                  ),
                  contentPadding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  isDense: true,
                  counterText: '',
                ),
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: AppSpacing.sm),
              // Price + Quantity row
              // RTL: [الكمية stepper] on RIGHT, [السعر field] on LEFT
              Row(
                children: [
                  // Quantity section (start = RIGHT in RTL)
                  Text(
                    'الكمية',
                    style: TextStyle(
                      fontSize: 12,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _Stepper(
                    value: item.quantity,
                    onIncrement: () {
                      item.quantity++;
                      onChanged();
                    },
                    onDecrement: item.quantity > 1
                        ? () {
                            item.quantity--;
                            onChanged();
                          }
                        : null,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  // Price section (end = LEFT in RTL)
                  Text(
                    'السعر',
                    style: TextStyle(
                      fontSize: 12,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: TextField(
                      controller: item.priceController,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                      onChanged: (_) => onChanged(),
                      decoration: InputDecoration(
                        hintText: '0.00',
                        hintStyle: TextStyle(
                          color: cs.onSurfaceVariant,
                          fontSize: 13,
                        ),
                        suffixText: 'د.أ',
                        suffixStyle: TextStyle(
                          color: cs.onSurfaceVariant,
                          fontSize: 12,
                        ),
                        filled: true,
                        fillColor: cs.surfaceContainerLowest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: cs.outlineVariant),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: cs.outlineVariant),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: AppColors.warning),
                        ),
                        contentPadding:
                            const EdgeInsetsDirectional.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.sm,
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
          // Remove button — top end corner (LEFT in RTL)
          if (showRemove)
            PositionedDirectional(
              top: 0,
              end: 0,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 12,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Compact quantity stepper: `[+ N -]` in a bordered container.
class _Stepper extends StatelessWidget {
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback? onDecrement;

  const _Stepper({
    required this.value,
    required this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _btn(Icons.add, onIncrement, cs),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.sm,
            ),
            child: Text(
              '$value',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _btn(Icons.remove, onDecrement, cs),
        ],
      ),
    );
  }

  Widget _btn(IconData icon, VoidCallback? onTap, ColorScheme cs) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 16,
          color: onTap != null ? cs.onSurface : cs.onSurfaceVariant,
        ),
      ),
    );
  }
}
