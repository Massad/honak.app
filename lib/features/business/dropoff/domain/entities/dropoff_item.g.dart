// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropoff_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DropoffItemImpl _$$DropoffItemImplFromJson(Map<String, dynamic> json) =>
    _$DropoffItemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toInt(),
      service: json['service'] as String,
      price: (json['price_cents'] as num).toInt(),
      attributes:
          (json['attributes'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      notes: json['notes'] as String?,
      photoBefore: json['photo_before'] as String?,
      photoAfter: json['photo_after'] as String?,
    );

Map<String, dynamic> _$$DropoffItemImplToJson(_$DropoffItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'service': instance.service,
      'price_cents': instance.price,
      'attributes': instance.attributes,
      'notes': instance.notes,
      'photo_before': instance.photoBefore,
      'photo_after': instance.photoAfter,
    };
