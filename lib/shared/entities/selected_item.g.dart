// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SelectedItemImpl _$$SelectedItemImplFromJson(Map<String, dynamic> json) =>
    _$SelectedItemImpl(
      itemId: json['itemId'] as String,
      name: json['name'] as String,
      image: json['image'] as String?,
      basePriceCents: (json['basePriceCents'] as num).toInt(),
      selectedOptions:
          (json['selectedOptions'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              k,
              (e as List<dynamic>)
                  .map(
                    (e) => SelectedOption.fromJson(e as Map<String, dynamic>),
                  )
                  .toList(),
            ),
          ) ??
          const {},
      textInputs:
          (json['textInputs'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      categoryName: json['categoryName'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$SelectedItemImplToJson(_$SelectedItemImpl instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'name': instance.name,
      'image': instance.image,
      'basePriceCents': instance.basePriceCents,
      'selectedOptions': instance.selectedOptions,
      'textInputs': instance.textInputs,
      'quantity': instance.quantity,
      'categoryName': instance.categoryName,
      'description': instance.description,
    };

_$SelectedOptionImpl _$$SelectedOptionImplFromJson(Map<String, dynamic> json) =>
    _$SelectedOptionImpl(
      id: json['id'] as String,
      labelAr: json['labelAr'] as String,
      priceModifierCents: (json['priceModifierCents'] as num?)?.toInt() ?? 0,
      colorHex: json['colorHex'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$SelectedOptionImplToJson(
  _$SelectedOptionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'labelAr': instance.labelAr,
  'priceModifierCents': instance.priceModifierCents,
  'colorHex': instance.colorHex,
  'imageUrl': instance.imageUrl,
};
