import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/entities/selected_item.dart';
import 'package:honak/shared/providers/business_page_provider.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/item_selection/item_picker_sheet.dart';

/// 3-step alternative suggestion sheet:
///  1. Reason selection
///  2. Item picker (multiPick) — when reason is not text-only
///  3. Summary + optional note + send
class AlternativeSheet extends ConsumerStatefulWidget {
  final String requestId;
  final String? pageSlug;

  const AlternativeSheet({
    super.key,
    required this.requestId,
    this.pageSlug,
  });

  @override
  ConsumerState<AlternativeSheet> createState() => _AlternativeSheetState();
}

class _AlternativeSheetState extends ConsumerState<AlternativeSheet> {
  int _step = 0;
  String? _selectedReason;
  final _noteController = TextEditingController();
  bool _isLoading = false;
  List<SelectedItem> _pickedItems = [];

  static const _reasons = [
    ('alternative_available', 'البديل متوفر'),
    ('suggest_other', 'نقترح خيارات أخرى'),
    ('text_only', 'ملاحظة نصية فقط'),
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  String? get _resolvedPageSlug =>
      widget.pageSlug ??
      ref.read(currentBusinessPageProvider).valueOrNull?.slug;

  bool get _isTextOnly => _selectedReason == 'text_only';

  bool get _canSend {
    if (_isLoading) return false;
    if (_selectedReason == null) return false;
    if (_isTextOnly) {
      return _noteController.text.trim().isNotEmpty;
    }
    return _pickedItems.isNotEmpty;
  }

  void _goNext() {
    setState(() {
      if (_isTextOnly) {
        _step = 2;
      } else if (_resolvedPageSlug != null) {
        _step = 1;
      } else {
        _step = 2;
      }
    });
  }

  void _openItemPicker() {
    final slug = _resolvedPageSlug;
    if (slug == null) return;
    showAppSheet(
      context,
      builder: (_) => ItemPickerSheet(
        pageSlug: slug,
        mode: ItemPickerMode.multiPick,
        title: 'اختر البدائل',
        initialSelections: _pickedItems,
        onItemsSelected: (items) {
          setState(() {
            _pickedItems = items;
            _step = 2;
          });
        },
      ),
    );
  }

  Future<void> _handleSend() async {
    if (!_canSend) return;
    setState(() => _isLoading = true);

    await Future<void>.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      context.showSnackBar('تم إرسال الاقتراح');
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Title
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                'اقتراح بديل',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            if (_step == 0) _buildReasonStep(),
            if (_step == 1) _buildItemPickerStep(),
            if (_step == 2) _buildSummaryStep(),
          ],
        ),
      ),
    );
  }

  Widget _buildReasonStep() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            'اختر نوع الاقتراح',
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        ..._reasons.map((r) {
          final isSelected = _selectedReason == r.$1;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: GestureDetector(
              onTap: () => setState(() => _selectedReason = r.$1),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.05)
                      : Theme.of(context).colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      r.$2,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: isSelected
                            ? AppColors.primary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      size: 20,
                      color: isSelected
                          ? AppColors.primary
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),

        const SizedBox(height: AppSpacing.lg),

        SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: _selectedReason != null ? _goNext : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Theme.of(context).colorScheme.surface,
              disabledBackgroundColor: Theme.of(context).colorScheme.outlineVariant,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'التالي',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
      ],
    );
  }

  Widget _buildItemPickerStep() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildBackButton(0),
        const SizedBox(height: AppSpacing.md),

        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            'اختر البدائل المقترحة',
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        if (_pickedItems.isNotEmpty) ...[
          ..._pickedItems.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: _SelectedItemRow(
                  item: item,
                  onRemove: () => setState(() {
                    _pickedItems.removeWhere((i) => i.itemId == item.itemId);
                  }),
                ),
              )),
          const SizedBox(height: AppSpacing.sm),
        ],

        OutlinedButton.icon(
          onPressed: _openItemPicker,
          icon: const Icon(Icons.add, size: 18),
          label: Text(_pickedItems.isEmpty ? 'اختر من المنتجات' : 'إضافة المزيد'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed:
                _pickedItems.isNotEmpty ? () => setState(() => _step = 2) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Theme.of(context).colorScheme.surface,
              disabledBackgroundColor: Theme.of(context).colorScheme.outlineVariant,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'التالي',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
      ],
    );
  }

  Widget _buildSummaryStep() {
    final previousStep =
        _isTextOnly ? 0 : (_resolvedPageSlug != null ? 1 : 0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildBackButton(previousStep),
        const SizedBox(height: AppSpacing.md),

        // Show picked items summary
        if (_pickedItems.isNotEmpty) ...[
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Text(
              'البدائل المقترحة (${_pickedItems.length})',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ..._pickedItems.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    Text(
                      Money(item.totalPriceCents).toFormattedArabic(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: AppSpacing.md),
        ],

        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            'أضف ملاحظة للعميل',
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        TextField(
          controller: _noteController,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          maxLines: 3,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: 'مثال: الصنف غير متوفر، لكن يوجد بديل مشابه...',
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerLowest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            contentPadding: const EdgeInsets.all(AppSpacing.md),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),

        SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: _canSend ? _handleSend : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Theme.of(context).colorScheme.surface,
              disabledBackgroundColor: Theme.of(context).colorScheme.outlineVariant,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  )
                : const Text(
                    'إرسال اقتراح',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
      ],
    );
  }

  Widget _buildBackButton(int targetStep) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: GestureDetector(
        onTap: () => setState(() => _step = targetStep),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'رجوع',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 4),
            Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectedItemRow extends StatelessWidget {
  final SelectedItem item;
  final VoidCallback onRemove;

  const _SelectedItemRow({required this.item, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (item.optionsSummary.isNotEmpty)
                  Text(
                    item.optionsSummary,
                    style: TextStyle(
                      fontSize: 11,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            Money(item.totalPriceCents).toFormattedArabic(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              size: 16,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
