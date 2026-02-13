// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TenantImpl _$$TenantImplFromJson(Map<String, dynamic> json) => _$TenantImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  floor: json['floor'] as String? ?? '',
  unit: json['unit'] as String? ?? '',
  businessType: json['business_type'] as String? ?? '',
  linkedPageId: json['linked_page_id'] as String?,
  status: json['status'] as String? ?? 'active',
);

Map<String, dynamic> _$$TenantImplToJson(_$TenantImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'floor': instance.floor,
      'unit': instance.unit,
      'business_type': instance.businessType,
      'linked_page_id': instance.linkedPageId,
      'status': instance.status,
    };
