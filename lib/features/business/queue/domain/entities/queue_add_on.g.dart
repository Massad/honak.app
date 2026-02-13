// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_add_on.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueueAddOnImpl _$$QueueAddOnImplFromJson(Map<String, dynamic> json) =>
    _$QueueAddOnImpl(
      name: json['name'] as String,
      price: (json['price_cents'] as num).toInt(),
    );

Map<String, dynamic> _$$QueueAddOnImplToJson(_$QueueAddOnImpl instance) =>
    <String, dynamic>{'name': instance.name, 'price_cents': instance.price};
