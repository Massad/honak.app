import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/shared/entities/money.dart';

/// Renders option groups for an item as chips (single/multi select) or text fields.
///
/// Extracted from ItemDetailPage._OptionGroupSection — used by ItemDetailPage,
/// ItemConfigurationStep, and any future selection flow.
class ItemOptionSelector extends StatelessWidget {
  final List<OptionGroup> optionGroups;
  final Map<String, Set<String>> selectedOptions;
  final Map<String, String> textInputs;
  final void Function(String groupId, String optionId, String type)
      onOptionSelected;
  final void Function(String groupId, String value) onTextInput;

  /// When true, uses smaller chips suitable for bottom sheets.
  final bool compact;

  const ItemOptionSelector({
    super.key,
    required this.optionGroups,
    required this.selectedOptions,
    required this.textInputs,
    required this.onOptionSelected,
    required this.onTextInput,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: optionGroups
          .map((group) => _OptionGroupSection(
                group: group,
                selected: selectedOptions[group.id] ?? {},
                textValue: textInputs[group.id] ?? '',
                onOptionSelected: (optionId) =>
                    onOptionSelected(group.id, optionId, group.type),
                onTextInput: (value) => onTextInput(group.id, value),
                compact: compact,
              ))
          .toList(),
    );
  }
}

class _OptionGroupSection extends StatelessWidget {
  final OptionGroup group;
  final Set<String> selected;
  final String textValue;
  final void Function(String optionId) onOptionSelected;
  final void Function(String value) onTextInput;
  final bool compact;

  const _OptionGroupSection({
    required this.group,
    required this.selected,
    required this.textValue,
    required this.onOptionSelected,
    required this.onTextInput,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: compact ? AppSpacing.md : AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                group.labelAr,
                style: compact
                    ? context.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600)
                    : context.textTheme.titleSmall,
              ),
              SizedBox(width: AppSpacing.sm),
              Text(
                group.isRequired
                    ? context.l10n.required
                    : context.l10n.optional,
                style: context.textTheme.bodySmall?.copyWith(
                  color: group.isRequired
                      ? context.colorScheme.error
                      : context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm),
          if (group.type == 'text_input')
            TextField(
              decoration: InputDecoration(
                hintText: group.labelAr,
                border: const OutlineInputBorder(),
                isDense: compact,
              ),
              onChanged: onTextInput,
            )
          else if (isColorGroup(group))
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.sm,
              children: group.options.map((option) {
                final isSelected = selected.contains(option.id);
                final color = parseColorHex(option.colorHex);
                return _ColorSwatch(
                  color: color ?? context.colorScheme.surfaceContainerHighest,
                  label: option.labelAr,
                  isSelected: isSelected,
                  onTap: () => onOptionSelected(option.id),
                );
              }).toList(),
            )
          else
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: group.options.map((option) {
                final isSelected = selected.contains(option.id);
                final label = option.priceModifier != 0
                    ? '${option.labelAr} (+${Money(option.priceModifier).toFormattedArabic()})'
                    : option.labelAr;

                if (group.type == 'single_select') {
                  return ChoiceChip(
                    label: Text(label),
                    selected: isSelected,
                    onSelected: (_) => onOptionSelected(option.id),
                    visualDensity:
                        compact ? VisualDensity.compact : null,
                  );
                }
                return FilterChip(
                  label: Text(label),
                  selected: isSelected,
                  onSelected: (_) => onOptionSelected(option.id),
                  visualDensity:
                      compact ? VisualDensity.compact : null,
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

bool isColorGroup(OptionGroup group) {
  if (group.options.isEmpty) return false;
  final withColor =
      group.options.where((o) => o.colorHex != null && o.colorHex!.isNotEmpty).length;
  return withColor > group.options.length / 2;
}

Color? parseColorHex(String? hex) {
  if (hex == null || hex.isEmpty) return null;
  var h = hex.replaceFirst('#', '');
  if (h.length == 6) h = 'FF$h';
  if (h.length != 8) return null;
  final value = int.tryParse(h, radix: 16);
  return value != null ? Color(value) : null;
}

class _ColorSwatch extends StatelessWidget {
  final Color color;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ColorSwatch({
    required this.color,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final luminance = color.computeLuminance();
    final checkColor = luminance > 0.5 ? Colors.black87 : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              border: Border.all(
                color: isSelected
                    ? context.colorScheme.primary
                    : context.colorScheme.outlineVariant,
                width: isSelected ? 2.5 : 1,
              ),
            ),
            child: isSelected
                ? Icon(Icons.check, size: 18, color: checkColor)
                : null,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
