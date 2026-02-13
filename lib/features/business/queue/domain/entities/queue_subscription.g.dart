// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueueSubscriptionImpl _$$QueueSubscriptionImplFromJson(
  Map<String, dynamic> json,
) => _$QueueSubscriptionImpl(
  id: json['id'] as String,
  nameAr: json['name_ar'] as String,
  washesPerMonth: (json['washes_per_month'] as num).toInt(),
  pricePerMonth: (json['price_per_month_cents'] as num).toInt(),
  packageId: json['package_id'] as String,
  features:
      (json['features'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  popular: json['popular'] as bool? ?? false,
);

Map<String, dynamic> _$$QueueSubscriptionImplToJson(
  _$QueueSubscriptionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name_ar': instance.nameAr,
  'washes_per_month': instance.washesPerMonth,
  'price_per_month_cents': instance.pricePerMonth,
  'package_id': instance.packageId,
  'features': instance.features,
  'popular': instance.popular,
};
