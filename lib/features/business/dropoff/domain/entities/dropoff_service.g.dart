// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropoff_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DropoffServiceCategoryImpl _$$DropoffServiceCategoryImplFromJson(
  Map<String, dynamic> json,
) => _$DropoffServiceCategoryImpl(
  id: json['id'] as String,
  nameAr: json['name_ar'] as String,
  icon: json['icon'] as String,
  services: (json['services'] as List<dynamic>)
      .map((e) => DropoffService.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$DropoffServiceCategoryImplToJson(
  _$DropoffServiceCategoryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name_ar': instance.nameAr,
  'icon': instance.icon,
  'services': instance.services,
};

_$DropoffServiceImpl _$$DropoffServiceImplFromJson(Map<String, dynamic> json) =>
    _$DropoffServiceImpl(
      id: json['id'] as String,
      nameAr: json['name_ar'] as String,
      price: (json['price_cents'] as num).toInt(),
      durationDays: (json['duration_days'] as num).toInt(),
    );

Map<String, dynamic> _$$DropoffServiceImplToJson(
  _$DropoffServiceImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name_ar': instance.nameAr,
  'price_cents': instance.price,
  'duration_days': instance.durationDays,
};

_$DropoffAttributeImpl _$$DropoffAttributeImplFromJson(
  Map<String, dynamic> json,
) => _$DropoffAttributeImpl(
  id: json['id'] as String,
  labelAr: json['label_ar'] as String,
  values: (json['values'] as List<dynamic>).map((e) => e as String).toList(),
  optional: json['optional'] as bool? ?? true,
);

Map<String, dynamic> _$$DropoffAttributeImplToJson(
  _$DropoffAttributeImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'label_ar': instance.labelAr,
  'values': instance.values,
  'optional': instance.optional,
};
