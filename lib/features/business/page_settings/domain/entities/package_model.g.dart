// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessPackageImpl _$$BusinessPackageImplFromJson(
  Map<String, dynamic> json,
) => _$BusinessPackageImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String? ?? '',
  price: (json['price'] as num).toInt(),
  credits: (json['credits'] as num).toInt(),
  creditLabel: json['credit_label'] as String,
  validityModel: json['validity_model'] as String? ?? 'visits_date',
  validityMonths: (json['validity_months'] as num?)?.toInt(),
  comparePrice: (json['compare_price'] as num?)?.toInt(),
  active: json['active'] as bool? ?? true,
  icon: json['icon'] as String? ?? 'package',
);

Map<String, dynamic> _$$BusinessPackageImplToJson(
  _$BusinessPackageImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'credits': instance.credits,
  'credit_label': instance.creditLabel,
  'validity_model': instance.validityModel,
  'validity_months': instance.validityMonths,
  'compare_price': instance.comparePrice,
  'active': instance.active,
  'icon': instance.icon,
};
