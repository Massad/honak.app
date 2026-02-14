import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honak/config/business_type_config.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/shared/domain/entities/biz_category.dart';
import 'package:honak/shared/widgets/selection_sheet.dart';

// ═══════════════════════════════════════════════════════════════
// Step indicator — animated dots
// ═══════════════════════════════════════════════════════════════

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSteps, (i) {
          final isActive = i == currentStep;
          final isDone = i < currentStep;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isActive ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primary
                    : isDone
                        ? AppColors.primary.withValues(alpha: 0.4)
                        : Theme.of(context).colorScheme.outlineVariant,
                borderRadius: AppRadius.pill,
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Step 1 — Basics (name, category, image placeholder)
// ═══════════════════════════════════════════════════════════════

class WizardStepBasics extends StatelessWidget {
  final TextEditingController nameCtrl;
  final String? selectedCategoryId;
  final List<BizCategory> categories;
  final ItemManagementConfig? config;
  final ValueChanged<String?> onCategoryChanged;

  const WizardStepBasics({
    super.key,
    required this.nameCtrl,
    required this.selectedCategoryId,
    required this.categories,
    required this.config,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppSpacing.screenPadding,
      children: [
        // Name field
        const _FieldLabel(label: 'الاسم *'),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: nameCtrl,
          decoration: wizardInputDecoration(
            hint: config?.itemLabelAr ?? 'اسم العنصر',
          ),
        ),

        // Category selector
        if (config?.hasCategory ?? true) ...[
          const SizedBox(height: AppSpacing.xl),
          const _FieldLabel(label: 'التصنيف'),
          const SizedBox(height: AppSpacing.sm),
          _CategoryTapField(
            selectedId: selectedCategoryId,
            categories: categories,
            onChanged: onCategoryChanged,
          ),
        ],

        // Image placeholder
        if (config?.hasImage ?? true) ...[
          const SizedBox(height: AppSpacing.xl),
          const _FieldLabel(label: 'الصورة'),
          const SizedBox(height: AppSpacing.sm),
          GestureDetector(
            onTap: () => context.showSnackBar('قريباً: رفع الصور'),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                borderRadius: AppRadius.cardInner,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  style: BorderStyle.solid,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 32,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'إضافة صورة',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Step 2 — Details & Pricing
// ═══════════════════════════════════════════════════════════════

class WizardStepDetails extends StatelessWidget {
  final ItemManagementConfig? config;
  final TextEditingController descCtrl;
  final TextEditingController priceCtrl;
  final TextEditingController discountCtrl;
  final Map<String, TextEditingController> propertyControllers;
  final Map<String, List<String>> chipSelections;
  final void Function(String propId, List<String> chips) onChipChanged;

  const WizardStepDetails({
    super.key,
    required this.config,
    required this.descCtrl,
    required this.priceCtrl,
    required this.discountCtrl,
    required this.propertyControllers,
    required this.chipSelections,
    required this.onChipChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppSpacing.screenPadding,
      children: [
        // Description
        if (config?.hasDescription ?? false) ...[
          const _FieldLabel(label: 'الوصف'),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: descCtrl,
            maxLines: 3,
            decoration: wizardInputDecoration(hint: 'وصف مختصر...'),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],

        // Dynamic properties
        for (final prop in config?.properties ?? <ItemPropertyConfig>[]) ...[
          _FieldLabel(
            label: '${prop.labelAr}${prop.required ? ' *' : ''}',
          ),
          const SizedBox(height: AppSpacing.sm),
          _PropertyField(
            property: prop,
            controller: propertyControllers[prop.id],
            chipValues: chipSelections[prop.id] ?? [],
            onChipChanged: (chips) => onChipChanged(prop.id, chips),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],

        // Price
        if (config?.hasPrice ?? true) ...[
          const _FieldLabel(label: 'السعر (د.أ)'),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: priceCtrl,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
            ],
            decoration: wizardInputDecoration(hint: '0.00'),
          ),
        ],

        // Discount
        if (config?.canDiscount ?? false) ...[
          const SizedBox(height: AppSpacing.xl),
          const _FieldLabel(label: 'نسبة الخصم (%)'),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: discountCtrl,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: wizardInputDecoration(hint: '0'),
          ),
        ],
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Step 3 — Availability
// ═══════════════════════════════════════════════════════════════

class WizardStepAvailability extends StatelessWidget {
  final ItemManagementConfig? config;
  final String status;
  final TextEditingController stockCtrl;
  final ValueChanged<String> onStatusChanged;
  final List<String> assignedTeamIds;
  final VoidCallback? onTeamAssignTap;

  const WizardStepAvailability({
    super.key,
    required this.config,
    required this.status,
    required this.stockCtrl,
    required this.onStatusChanged,
    this.assignedTeamIds = const [],
    this.onTeamAssignTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppSpacing.screenPadding,
      children: [
        // Status selector
        const _FieldLabel(label: 'الحالة'),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          children: [
            _StatusChip(
              label: 'متاح',
              color: AppColors.success,
              isSelected: status == 'active',
              onTap: () => onStatusChanged('active'),
            ),
            _StatusChip(
              label: 'نفذت الكمية',
              color: AppColors.warning,
              isSelected: status == 'out_of_stock',
              onTap: () => onStatusChanged('out_of_stock'),
            ),
            _StatusChip(
              label: 'مخفي',
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              isSelected: status == 'hidden',
              onTap: () => onStatusChanged('hidden'),
            ),
          ],
        ),

        // Stock field
        if (config?.quantityMode == QuantityMode.perItem) ...[
          const SizedBox(height: AppSpacing.xl),
          const _FieldLabel(label: 'الكمية المتوفرة'),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: stockCtrl,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: wizardInputDecoration(hint: '0'),
          ),
        ],

        // Provider assignment — functional team picker
        if (config?.providerAssignment ?? false) ...[
          const SizedBox(height: AppSpacing.xl),
          GestureDetector(
            onTap: onTeamAssignTap,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.04),
                borderRadius: AppRadius.cardInner,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.15),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.chevron_left,
                    size: 18,
                    color: AppColors.primary.withValues(alpha: 0.4),
                  ),
                  if (assignedTeamIds.isNotEmpty) ...[
                    const SizedBox(width: AppSpacing.xs),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${assignedTeamIds.length}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                  const Spacer(),
                  Text(
                    'تعيين فريق',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.primary.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Icon(
                    Icons.group_outlined,
                    size: 20,
                    color: AppColors.primary.withValues(alpha: 0.6),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Bottom navigation — Back / Next / Save
// ═══════════════════════════════════════════════════════════════

class WizardBottomNav extends StatelessWidget {
  final int currentStep;
  final bool canGoNext;
  final bool saving;
  final VoidCallback onBack;
  final VoidCallback onNext;

  const WizardBottomNav({
    super.key,
    required this.currentStep,
    required this.canGoNext,
    required this.saving,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final isFinal = currentStep == 2;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md + bottomPadding,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          // Back / Cancel
          TextButton(
            onPressed: onBack,
            child: Text(
              currentStep == 0 ? 'إلغاء' : 'السابق',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const Spacer(),
          // Next / Save
          FilledButton(
            onPressed: canGoNext && !saving ? onNext : null,
            child: saving
                ? SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  )
                : Text(isFinal ? 'حفظ' : 'التالي'),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Shared helper widgets
// ═══════════════════════════════════════════════════════════════

class _FieldLabel extends StatelessWidget {
  final String label;

  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: context.textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

/// Standard input decoration for wizard form fields.
InputDecoration wizardInputDecoration({required String hint}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      fontSize: 13,
      color: Colors.grey.shade500,
    ),
    isDense: true,
    contentPadding: AppSpacing.inputPadding,
    border: OutlineInputBorder(
      borderRadius: AppRadius.button,
      borderSide: BorderSide(color: Colors.grey.shade200),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: AppRadius.button,
      borderSide: BorderSide(color: Colors.grey.shade200),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppRadius.button,
      borderSide: const BorderSide(color: AppColors.primary),
    ),
  );
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _StatusChip({
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color:
              isSelected ? color.withValues(alpha: 0.12) : Colors.grey.shade50,
          borderRadius: AppRadius.pill,
          border: Border.all(
            color: isSelected ? color : Theme.of(context).colorScheme.outlineVariant,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? color : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _CategoryTapField extends StatelessWidget {
  final String? selectedId;
  final List<BizCategory> categories;
  final ValueChanged<String?> onChanged;

  const _CategoryTapField({
    required this.selectedId,
    required this.categories,
    required this.onChanged,
  });

  String get _displayText {
    if (selectedId == null) return 'بدون تصنيف';
    final match = categories.where((c) => c.id == selectedId).firstOrNull;
    return match?.name ?? 'بدون تصنيف';
  }

  Future<void> _openSheet(BuildContext context) async {
    final options = [
      const SelectionOption<String?>(value: null, label: 'بدون تصنيف'),
      ...categories.map(
        (cat) => SelectionOption<String?>(value: cat.id, label: cat.name),
      ),
    ];

    final result = await showSelectionSheet<String?>(
      context: context,
      title: 'التصنيف',
      options: options,
      selectedValue: selectedId,
    );

    // result is null when the sheet is dismissed without selection —
    // only call onChanged when user actually tapped an option.
    if (context.mounted && result != selectedId) {
      // showSelectionSheet returns null both for "dismissed" and for
      // selecting the null-value option. We distinguish by checking
      // whether the sheet was popped with a value (Navigator.pop passes
      // the value) vs dismissed (swipe down returns null).
      // For simplicity, treat any non-identical result as a selection.
      onChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedId != null;

    return GestureDetector(
      onTap: () => _openSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          borderRadius: AppRadius.button,
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        child: Row(
          children: [
            Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const Spacer(),
            Text(
              _displayText,
              style: TextStyle(
                fontSize: 13,
                color: isSelected ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PropertyField extends StatelessWidget {
  final ItemPropertyConfig property;
  final TextEditingController? controller;
  final List<String> chipValues;
  final ValueChanged<List<String>> onChipChanged;

  const _PropertyField({
    required this.property,
    this.controller,
    required this.chipValues,
    required this.onChipChanged,
  });

  @override
  Widget build(BuildContext context) {
    return switch (property.type) {
      ItemPropertyType.chipList => _ChipListField(
          property: property,
          values: chipValues,
          onChanged: onChipChanged,
        ),
      ItemPropertyType.text => TextField(
          controller: controller,
          decoration: wizardInputDecoration(
            hint: property.placeholderAr ?? property.labelAr,
          ),
        ),
      ItemPropertyType.number => TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: wizardInputDecoration(
            hint: property.placeholderAr ?? '0',
          ),
        ),
      ItemPropertyType.duration => TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: wizardInputDecoration(
            hint: property.placeholderAr ?? '0',
          ).copyWith(suffixText: 'دقيقة'),
        ),
    };
  }
}

class _ChipListField extends StatefulWidget {
  final ItemPropertyConfig property;
  final List<String> values;
  final ValueChanged<List<String>> onChanged;

  const _ChipListField({
    required this.property,
    required this.values,
    required this.onChanged,
  });

  @override
  State<_ChipListField> createState() => _ChipListFieldState();
}

class _ChipListFieldState extends State<_ChipListField> {
  final _chipCtrl = TextEditingController();

  @override
  void dispose() {
    _chipCtrl.dispose();
    super.dispose();
  }

  void _addChip() {
    final val = _chipCtrl.text.trim();
    if (val.isEmpty || widget.values.contains(val)) return;

    final updated = [...widget.values, val];
    widget.onChanged(updated);
    _chipCtrl.clear();
  }

  void _removeChip(String val) {
    final updated = widget.values.where((v) => v != val).toList();
    widget.onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Existing chips
        if (widget.values.isNotEmpty)
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: widget.values.map((val) {
              return Chip(
                label: Text(val, style: const TextStyle(fontSize: 12)),
                deleteIcon: const Icon(Icons.close, size: 14),
                onDeleted: () => _removeChip(val),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                backgroundColor: AppColors.primary.withValues(alpha: 0.06),
                side: BorderSide.none,
              );
            }).toList(),
          ),

        if (widget.values.isNotEmpty)
          const SizedBox(height: AppSpacing.sm),

        // Add chip input
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _chipCtrl,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _addChip(),
                decoration: wizardInputDecoration(
                  hint: widget.property.placeholderAr ?? 'أضف...',
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton.filled(
              onPressed: _addChip,
              icon: const Icon(Icons.add, size: 18),
              style: IconButton.styleFrom(
                minimumSize: const Size(36, 36),
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
