// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      id: json['id'] as String,
      label: json['label'] as String,
      labelIcon: json['label_icon'] as String? ?? 'home',
      area: json['area'] as String,
      city: json['city'] as String? ?? 'عمّان',
      street: json['street'] as String? ?? '',
      building: json['building'] as String? ?? '',
      floor: json['floor'] as String? ?? '',
      apartment: json['apartment'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
      isDefault: json['is_default'] as bool? ?? false,
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'label_icon': instance.labelIcon,
      'area': instance.area,
      'city': instance.city,
      'street': instance.street,
      'building': instance.building,
      'floor': instance.floor,
      'apartment': instance.apartment,
      'notes': instance.notes,
      'is_default': instance.isDefault,
    };
