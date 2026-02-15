// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerSubscriptionInfoImpl _$$CustomerSubscriptionInfoImplFromJson(
  Map<String, dynamic> json,
) => _$CustomerSubscriptionInfoImpl(
  id: json['id'] as String,
  packageName: json['package_name'] as String,
  remainingCredits: (json['remaining_credits'] as num?)?.toInt(),
  totalCredits: (json['total_credits'] as num?)?.toInt(),
  expiresAt: json['expires_at'] as String?,
  model: json['model'] as String,
  recurringMode: json['recurring_mode'] as String?,
  recurringFrequency: json['recurring_frequency'] as String?,
  status: json['status'] as String,
);

Map<String, dynamic> _$$CustomerSubscriptionInfoImplToJson(
  _$CustomerSubscriptionInfoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'package_name': instance.packageName,
  'remaining_credits': instance.remainingCredits,
  'total_credits': instance.totalCredits,
  'expires_at': instance.expiresAt,
  'model': instance.model,
  'recurring_mode': instance.recurringMode,
  'recurring_frequency': instance.recurringFrequency,
  'status': instance.status,
};

_$RecentOrderImpl _$$RecentOrderImplFromJson(Map<String, dynamic> json) =>
    _$RecentOrderImpl(
      date: json['date'] as String,
      summary: json['summary'] as String,
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'pending',
    );

Map<String, dynamic> _$$RecentOrderImplToJson(_$RecentOrderImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'summary': instance.summary,
      'amount': instance.amount,
      'status': instance.status,
    };

_$BusinessCustomerImpl _$$BusinessCustomerImplFromJson(
  Map<String, dynamic> json,
) => _$BusinessCustomerImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  phone: json['phone'] as String?,
  avatar: json['avatar'] as String?,
  area: json['area'] as String?,
  badge:
      $enumDecodeNullable(_$CustomerBadgeEnumMap, json['badge']) ??
      CustomerBadge.newCustomer,
  totalOrders: (json['total_orders'] as num?)?.toInt() ?? 0,
  totalSpent: (json['total_spent'] as num?)?.toInt() ?? 0,
  lastOrderDate: json['last_order_date'] as String?,
  lastActivityDate: json['last_activity_date'] as String?,
  usualPayment: json['usual_payment'] as String?,
  subscription: json['subscription'] == null
      ? null
      : CustomerSubscriptionInfo.fromJson(
          json['subscription'] as Map<String, dynamic>,
        ),
  source: json['source'] as String?,
  createdAt: json['created_at'] as String?,
  notes: json['notes'] as String?,
  recentOrders:
      (json['recent_orders'] as List<dynamic>?)
          ?.map((e) => RecentOrder.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$BusinessCustomerImplToJson(
  _$BusinessCustomerImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'phone': instance.phone,
  'avatar': instance.avatar,
  'area': instance.area,
  'badge': _$CustomerBadgeEnumMap[instance.badge]!,
  'total_orders': instance.totalOrders,
  'total_spent': instance.totalSpent,
  'last_order_date': instance.lastOrderDate,
  'last_activity_date': instance.lastActivityDate,
  'usual_payment': instance.usualPayment,
  'subscription': instance.subscription,
  'source': instance.source,
  'created_at': instance.createdAt,
  'notes': instance.notes,
  'recent_orders': instance.recentOrders,
};

const _$CustomerBadgeEnumMap = {
  CustomerBadge.newCustomer: 'new',
  CustomerBadge.active: 'active',
  CustomerBadge.repeat: 'repeat',
  CustomerBadge.interested: 'interested',
  CustomerBadge.past: 'past',
};
