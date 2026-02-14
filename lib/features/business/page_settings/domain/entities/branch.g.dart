// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BranchImpl _$$BranchImplFromJson(Map<String, dynamic> json) => _$BranchImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  address: json['address'] as String?,
  phone: json['phone'] as String?,
  city: json['city'] as String?,
  neighborhood: json['neighborhood'] as String?,
  status: json['status'] as String? ?? 'active',
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  isMain: json['is_main'] as bool? ?? false,
  active: json['active'] as bool? ?? true,
  locationType: json['location_type'] as String? ?? 'standalone',
  venueId: json['venue_id'] as String?,
  venueName: json['venue_name'] as String?,
  venueFloor: json['venue_floor'] as String?,
  venueUnit: json['venue_unit'] as String?,
);

Map<String, dynamic> _$$BranchImplToJson(_$BranchImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'city': instance.city,
      'neighborhood': instance.neighborhood,
      'status': instance.status,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'is_main': instance.isMain,
      'active': instance.active,
      'location_type': instance.locationType,
      'venue_id': instance.venueId,
      'venue_name': instance.venueName,
      'venue_floor': instance.venueFloor,
      'venue_unit': instance.venueUnit,
    };
