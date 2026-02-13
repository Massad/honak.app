// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessSubTypeImpl _$$BusinessSubTypeImplFromJson(
  Map<String, dynamic> json,
) => _$BusinessSubTypeImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  icon: json['icon'] as String? ?? '',
);

Map<String, dynamic> _$$BusinessSubTypeImplToJson(
  _$BusinessSubTypeImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'icon': instance.icon,
};

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
      id: json['id'] as String,
      nameAr: json['name_ar'] as String,
      nameEn: json['name_en'] as String?,
      iconName: json['icon_name'] as String,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      types:
          (json['types'] as List<dynamic>?)
              ?.map((e) => BusinessSubType.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
      'icon_name': instance.iconName,
      'sort_order': instance.sortOrder,
      'types': instance.types,
    };
