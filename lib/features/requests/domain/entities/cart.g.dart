// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartItemImpl _$$CartItemImplFromJson(Map<String, dynamic> json) =>
    _$CartItemImpl(
      itemId: json['itemId'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
      unitPriceCents: (json['unit_price_cents'] as num).toInt(),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      variation: json['variation'] as String?,
      selectedOptions:
          (json['selectedOptions'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              k,
              (e as List<dynamic>).map((e) => e as String).toList(),
            ),
          ) ??
          const {},
    );

Map<String, dynamic> _$$CartItemImplToJson(_$CartItemImpl instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'unit_price_cents': instance.unitPriceCents,
      'quantity': instance.quantity,
      'variation': instance.variation,
      'selectedOptions': instance.selectedOptions,
    };

_$CartImpl _$$CartImplFromJson(Map<String, dynamic> json) => _$CartImpl(
  pageId: json['page_id'] as String,
  pageName: json['page_name'] as String,
  pageAvatarUrl: json['page_avatar_url'] as String?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$CartImplToJson(_$CartImpl instance) =>
    <String, dynamic>{
      'page_id': instance.pageId,
      'page_name': instance.pageName,
      'page_avatar_url': instance.pageAvatarUrl,
      'items': instance.items,
    };
