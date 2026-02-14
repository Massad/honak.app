// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directory_floor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DirectoryFloorImpl _$$DirectoryFloorImplFromJson(Map<String, dynamic> json) =>
    _$DirectoryFloorImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      label: json['label'] as String?,
      tenantCount: (json['tenant_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DirectoryFloorImplToJson(
  _$DirectoryFloorImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'label': instance.label,
  'tenant_count': instance.tenantCount,
};
