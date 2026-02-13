// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServicePackageImpl _$$ServicePackageImplFromJson(Map<String, dynamic> json) =>
    _$ServicePackageImpl(
      id: json['id'] as String,
      nameAr: json['name_ar'] as String,
      nameEn: json['name_en'] as String?,
      descriptionAr: json['description_ar'] as String?,
      price: (json['price_cents'] as num).toInt(),
      durationMin: (json['duration_min'] as num).toInt(),
      features:
          (json['features'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      icon: json['icon'] as String?,
      popular: json['popular'] as bool? ?? false,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$$ServicePackageImplToJson(
  _$ServicePackageImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name_ar': instance.nameAr,
  'name_en': instance.nameEn,
  'description_ar': instance.descriptionAr,
  'price_cents': instance.price,
  'duration_min': instance.durationMin,
  'features': instance.features,
  'icon': instance.icon,
  'popular': instance.popular,
  'color': instance.color,
};
