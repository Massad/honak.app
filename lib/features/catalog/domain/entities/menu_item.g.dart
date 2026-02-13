// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MenuItemImpl _$$MenuItemImplFromJson(
  Map<String, dynamic> json,
) => _$MenuItemImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  nameEn: json['name_en'] as String?,
  description: json['description'] as String?,
  price: const MoneyConverter().fromJson((json['price_cents'] as num).toInt()),
  image: json['image'] as String?,
  category: json['category'] as String,
  categoryAr: json['category_ar'] as String?,
  sizes:
      (json['sizes'] as List<dynamic>?)
          ?.map((e) => MenuItemSize.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  modifiers:
      (json['modifiers'] as List<dynamic>?)
          ?.map((e) => MenuItemModifier.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  isAvailable: json['is_available'] as bool? ?? true,
  isPopular: json['is_popular'] as bool? ?? false,
  preparationTimeMinutes: (json['preparation_time_minutes'] as num?)?.toInt(),
  calories: (json['calories'] as num?)?.toInt(),
  sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
  pageId: json['page_id'] as String?,
);

Map<String, dynamic> _$$MenuItemImplToJson(_$MenuItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'description': instance.description,
      'price_cents': const MoneyConverter().toJson(instance.price),
      'image': instance.image,
      'category': instance.category,
      'category_ar': instance.categoryAr,
      'sizes': instance.sizes,
      'modifiers': instance.modifiers,
      'is_available': instance.isAvailable,
      'is_popular': instance.isPopular,
      'preparation_time_minutes': instance.preparationTimeMinutes,
      'calories': instance.calories,
      'sort_order': instance.sortOrder,
      'page_id': instance.pageId,
    };

_$MenuItemSizeImpl _$$MenuItemSizeImplFromJson(Map<String, dynamic> json) =>
    _$MenuItemSizeImpl(
      name: json['name'] as String,
      nameAr: json['name_ar'] as String?,
      price: const MoneyConverter().fromJson(
        (json['price_cents'] as num).toInt(),
      ),
    );

Map<String, dynamic> _$$MenuItemSizeImplToJson(_$MenuItemSizeImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'name_ar': instance.nameAr,
      'price_cents': const MoneyConverter().toJson(instance.price),
    };

_$MenuItemModifierImpl _$$MenuItemModifierImplFromJson(
  Map<String, dynamic> json,
) => _$MenuItemModifierImpl(
  name: json['name'] as String,
  nameAr: json['name_ar'] as String?,
  price: json['price_cents'] == null
      ? null
      : const MoneyNullableConverter().fromJson(
          (json['price_cents'] as num?)?.toInt(),
        ),
);

Map<String, dynamic> _$$MenuItemModifierImplToJson(
  _$MenuItemModifierImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'name_ar': instance.nameAr,
  'price_cents': const MoneyNullableConverter().toJson(instance.price),
};
