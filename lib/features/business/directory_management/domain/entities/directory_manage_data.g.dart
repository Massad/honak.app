// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directory_manage_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DirectoryManageDataImpl _$$DirectoryManageDataImplFromJson(
  Map<String, dynamic> json,
) => _$DirectoryManageDataImpl(
  tenants:
      (json['tenants'] as List<dynamic>?)
          ?.map((e) => Tenant.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  floors:
      (json['floors'] as List<dynamic>?)
          ?.map((e) => DirectoryFloor.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  amenities:
      (json['amenities'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  featuredTenantIds:
      (json['featured_tenant_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  stats: json['stats'] == null
      ? null
      : DirectoryManageStats.fromJson(json['stats'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$DirectoryManageDataImplToJson(
  _$DirectoryManageDataImpl instance,
) => <String, dynamic>{
  'tenants': instance.tenants,
  'floors': instance.floors,
  'categories': instance.categories,
  'amenities': instance.amenities,
  'featured_tenant_ids': instance.featuredTenantIds,
  'stats': instance.stats,
};
