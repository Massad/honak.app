// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biz_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BizCategoryImpl _$$BizCategoryImplFromJson(Map<String, dynamic> json) =>
    _$BizCategoryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      nameEn: json['name_en'] as String?,
      itemCount: (json['item_count'] as num?)?.toInt() ?? 0,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$BizCategoryImplToJson(_$BizCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'item_count': instance.itemCount,
      'sort_order': instance.sortOrder,
    };
