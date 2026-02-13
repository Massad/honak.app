// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionPackageImpl _$$SubscriptionPackageImplFromJson(
  Map<String, dynamic> json,
) => _$SubscriptionPackageImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  price: (json['price'] as num).toInt(),
  credits: (json['credits'] as num?)?.toInt(),
  creditLabel: json['credit_label'] as String?,
  validityMonths: (json['validity_months'] as num?)?.toInt() ?? 1,
  icon: json['icon'] as String?,
  compareSinglePrice: (json['compare_single_price'] as num?)?.toInt(),
  active: json['active'] as bool? ?? true,
  model: $enumDecode(_$SubscriptionModelEnumMap, json['model']),
  items:
      (json['items'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  itemIds:
      (json['item_ids'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  category: json['category'] as String?,
);

Map<String, dynamic> _$$SubscriptionPackageImplToJson(
  _$SubscriptionPackageImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'credits': instance.credits,
  'credit_label': instance.creditLabel,
  'validity_months': instance.validityMonths,
  'icon': instance.icon,
  'compare_single_price': instance.compareSinglePrice,
  'active': instance.active,
  'model': _$SubscriptionModelEnumMap[instance.model]!,
  'items': instance.items,
  'item_ids': instance.itemIds,
  'category': instance.category,
};

const _$SubscriptionModelEnumMap = {
  SubscriptionModel.visitsAndDate: 'visits_and_date',
  SubscriptionModel.visitsOnly: 'visits_only',
  SubscriptionModel.dateOnly: 'date_only',
  SubscriptionModel.bundle: 'bundle',
};
