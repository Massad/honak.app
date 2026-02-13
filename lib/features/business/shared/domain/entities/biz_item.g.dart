// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biz_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BizItemImpl _$$BizItemImplFromJson(Map<String, dynamic> json) =>
    _$BizItemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      nameEn: json['name_en'] as String?,
      description: json['description'] as String?,
      price: const MoneyNullableConverter().fromJson(
        (json['price_cents'] as num?)?.toInt(),
      ),
      priceText: json['price_text'] as String?,
      originalPrice: const MoneyNullableConverter().fromJson(
        (json['original_price_cents'] as num?)?.toInt(),
      ),
      discountPercent: (json['discount_percent'] as num?)?.toInt(),
      discountEnds: json['discount_ends'] as String?,
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      categoryId: json['category_id'] as String?,
      categoryName: json['category_name'] as String?,
      status: json['status'] as String? ?? 'active',
      stock: (json['stock'] as num?)?.toInt(),
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      pageId: json['page_id'] as String?,
      branchIds:
          (json['branch_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      assignedTeamIds:
          (json['assigned_team_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      properties: json['properties'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$BizItemImplToJson(_$BizItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'description': instance.description,
      'price_cents': const MoneyNullableConverter().toJson(instance.price),
      'price_text': instance.priceText,
      'original_price_cents': const MoneyNullableConverter().toJson(
        instance.originalPrice,
      ),
      'discount_percent': instance.discountPercent,
      'discount_ends': instance.discountEnds,
      'images': instance.images,
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'status': instance.status,
      'stock': instance.stock,
      'sort_order': instance.sortOrder,
      'page_id': instance.pageId,
      'branch_ids': instance.branchIds,
      'assigned_team_ids': instance.assignedTeamIds,
      'properties': instance.properties,
    };
