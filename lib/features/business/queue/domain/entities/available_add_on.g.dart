// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_add_on.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AvailableAddOnImpl _$$AvailableAddOnImplFromJson(Map<String, dynamic> json) =>
    _$AvailableAddOnImpl(
      id: json['id'] as String,
      nameAr: json['name_ar'] as String,
      priceCents: (json['price_cents'] as num).toInt(),
    );

Map<String, dynamic> _$$AvailableAddOnImplToJson(
  _$AvailableAddOnImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name_ar': instance.nameAr,
  'price_cents': instance.priceCents,
};
