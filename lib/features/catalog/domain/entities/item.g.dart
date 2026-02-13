// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemImpl _$$ItemImplFromJson(Map<String, dynamic> json) => _$ItemImpl(
  id: json['id'] as String,
  nameAr: json['name_ar'] as String,
  nameEn: json['name_en'] as String?,
  descriptionAr: json['description_ar'] as String?,
  descriptionEn: json['description_en'] as String?,
  price: const _MoneyConverter().fromJson((json['price_cents'] as num).toInt()),
  images:
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  optionGroups:
      (json['option_groups'] as List<dynamic>?)
          ?.map((e) => OptionGroup.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  categoryId: json['category_id'] as String?,
  categoryName: json['category_name'] as String?,
  inStock: json['in_stock'] as bool? ?? true,
  pageId: json['page_id'] as String?,
  sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$ItemImplToJson(_$ItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
      'description_ar': instance.descriptionAr,
      'description_en': instance.descriptionEn,
      'price_cents': const _MoneyConverter().toJson(instance.price),
      'images': instance.images,
      'option_groups': instance.optionGroups,
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'in_stock': instance.inStock,
      'page_id': instance.pageId,
      'sort_order': instance.sortOrder,
    };

_$OptionGroupImpl _$$OptionGroupImplFromJson(Map<String, dynamic> json) =>
    _$OptionGroupImpl(
      id: json['id'] as String,
      labelAr: json['label_ar'] as String,
      labelEn: json['label_en'] as String?,
      type: json['type'] as String,
      isRequired: json['required'] as bool? ?? false,
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => ItemOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$OptionGroupImplToJson(_$OptionGroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label_ar': instance.labelAr,
      'label_en': instance.labelEn,
      'type': instance.type,
      'required': instance.isRequired,
      'options': instance.options,
    };

_$ItemOptionImpl _$$ItemOptionImplFromJson(Map<String, dynamic> json) =>
    _$ItemOptionImpl(
      id: json['id'] as String,
      labelAr: json['label_ar'] as String,
      labelEn: json['label_en'] as String?,
      priceModifier: (json['price_modifier'] as num?)?.toInt() ?? 0,
      colorHex: json['color_hex'] as String?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$$ItemOptionImplToJson(_$ItemOptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label_ar': instance.labelAr,
      'label_en': instance.labelEn,
      'price_modifier': instance.priceModifier,
      'color_hex': instance.colorHex,
      'image_url': instance.imageUrl,
    };
