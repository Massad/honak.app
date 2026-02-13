import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';

part 'selected_item.freezed.dart';
part 'selected_item.g.dart';

@freezed
class SelectedItem with _$SelectedItem {
  const SelectedItem._();

  const factory SelectedItem({
    required String itemId,
    required String name,
    String? image,
    required int basePriceCents,
    @Default({}) Map<String, List<SelectedOption>> selectedOptions,
    @Default({}) Map<String, String> textInputs,
    @Default(1) int quantity,
    String? categoryName,
    String? description,
  }) = _SelectedItem;

  int get _modifierSum {
    int sum = 0;
    for (final options in selectedOptions.values) {
      for (final opt in options) {
        sum += opt.priceModifierCents;
      }
    }
    return sum;
  }

  int get unitPriceCents => basePriceCents + _modifierSum;
  int get totalPriceCents => unitPriceCents * quantity;

  String get optionsSummary {
    final labels = <String>[];
    for (final options in selectedOptions.values) {
      for (final opt in options) {
        labels.add(opt.labelAr);
      }
    }
    for (final text in textInputs.values) {
      if (text.isNotEmpty) labels.add(text);
    }
    return labels.join('، ');
  }

  bool isComplete(List<OptionGroup> groups) {
    for (final group in groups) {
      if (!group.isRequired) continue;
      if (group.type == 'text_input') {
        final text = textInputs[group.id];
        if (text == null || text.isEmpty) return false;
      } else {
        final selected = selectedOptions[group.id];
        if (selected == null || selected.isEmpty) return false;
      }
    }
    return true;
  }

  Map<String, dynamic> toMetadata() => {
        'id': itemId,
        'name': name,
        if (image != null) 'image': image,
        'base_price_cents': basePriceCents,
        'unit_price_cents': unitPriceCents,
        'total_price_cents': totalPriceCents,
        'quantity': quantity,
        if (categoryName != null) 'category': categoryName,
        if (description != null) 'description': description,
        if (optionsSummary.isNotEmpty) 'options_summary': optionsSummary,
        if (selectedOptions.isNotEmpty)
          'selected_options': selectedOptions.map(
            (groupId, opts) => MapEntry(
              groupId,
              opts.map((o) => o.toJson()).toList(),
            ),
          ),
        if (textInputs.isNotEmpty) 'text_inputs': textInputs,
      };

  factory SelectedItem.fromMetadata(Map<String, dynamic> meta) {
    final rawOptions =
        meta['selected_options'] as Map<String, dynamic>? ?? {};
    final parsedOptions = <String, List<SelectedOption>>{};
    for (final entry in rawOptions.entries) {
      final list = (entry.value as List)
          .map((e) => SelectedOption.fromJson(e as Map<String, dynamic>))
          .toList();
      parsedOptions[entry.key] = list;
    }

    final rawText = meta['text_inputs'] as Map<String, dynamic>? ?? {};
    final parsedText =
        rawText.map((k, v) => MapEntry(k, v as String));

    return SelectedItem(
      itemId: meta['id'] as String? ?? '',
      name: meta['name'] as String? ?? '',
      image: meta['image'] as String?,
      basePriceCents: meta['base_price_cents'] as int? ?? 0,
      selectedOptions: parsedOptions,
      textInputs: parsedText,
      quantity: meta['quantity'] as int? ?? 1,
      categoryName: meta['category'] as String?,
      description: meta['description'] as String?,
    );
  }

  factory SelectedItem.fromJson(Map<String, dynamic> json) =>
      _$SelectedItemFromJson(json);
}

@freezed
class SelectedOption with _$SelectedOption {
  const factory SelectedOption({
    required String id,
    required String labelAr,
    @Default(0) int priceModifierCents,
    String? colorHex,
    String? imageUrl,
  }) = _SelectedOption;

  factory SelectedOption.fromItemOption(ItemOption o) => SelectedOption(
        id: o.id,
        labelAr: o.labelAr,
        priceModifierCents: o.priceModifier,
        colorHex: o.colorHex,
        imageUrl: o.imageUrl,
      );

  factory SelectedOption.fromJson(Map<String, dynamic> json) =>
      _$SelectedOptionFromJson(json);
}
