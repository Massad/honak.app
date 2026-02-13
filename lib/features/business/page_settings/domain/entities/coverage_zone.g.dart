// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coverage_zone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CoverageZoneImpl _$$CoverageZoneImplFromJson(Map<String, dynamic> json) =>
    _$CoverageZoneImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      zone: json['zone'] as String,
      active: json['active'] as bool? ?? true,
      deliveryFee: (json['delivery_fee'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CoverageZoneImplToJson(_$CoverageZoneImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'zone': instance.zone,
      'active': instance.active,
      'delivery_fee': instance.deliveryFee,
    };
