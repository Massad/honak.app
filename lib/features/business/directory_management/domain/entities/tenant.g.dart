// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TenantImpl _$$TenantImplFromJson(Map<String, dynamic> json) => _$TenantImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  nameEn: json['name_en'] as String?,
  category: json['category'] as String,
  floorId: json['floor_id'] as String,
  unit: json['unit'] as String,
  isOpen: json['is_open'] as bool? ?? true,
  temporarilyClosed: json['temporarily_closed'] as bool? ?? false,
  pageId: json['page_id'] as String?,
  logoUrl: json['logo_url'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  linkedAt: json['linked_at'] as String?,
  invitedAt: json['invited_at'] as String?,
);

Map<String, dynamic> _$$TenantImplToJson(_$TenantImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'category': instance.category,
      'floor_id': instance.floorId,
      'unit': instance.unit,
      'is_open': instance.isOpen,
      'temporarily_closed': instance.temporarilyClosed,
      'page_id': instance.pageId,
      'logo_url': instance.logoUrl,
      'tags': instance.tags,
      'linked_at': instance.linkedAt,
      'invited_at': instance.invitedAt,
    };
