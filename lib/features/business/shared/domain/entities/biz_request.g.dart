// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biz_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BizRequestImpl _$$BizRequestImplFromJson(Map<String, dynamic> json) =>
    _$BizRequestImpl(
      id: json['id'] as String,
      customer: RequestCustomer.fromJson(
        json['customer'] as Map<String, dynamic>,
      ),
      status: json['status'] as String,
      type: json['type'] as String? ?? 'order',
      itemsCount: (json['items_count'] as num?)?.toInt() ?? 0,
      total: const MoneyNullableConverter().fromJson(
        (json['total_cents'] as num?)?.toInt(),
      ),
      note: json['note'] as String?,
      declineReason: json['decline_reason'] as String?,
      createdAt: (json['created_at'] as num).toInt(),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => RequestItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      conversationId: json['conversation_id'] as String?,
      preferredDate: json['preferred_date'] as String?,
      timeSlot: json['time_slot'] as String?,
      description: json['description'] as String?,
      dateRange: json['date_range'] as String?,
      guestCount: (json['guest_count'] as num?)?.toInt(),
      serviceLocation: json['service_location'] as String?,
    );

Map<String, dynamic> _$$BizRequestImplToJson(_$BizRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer': instance.customer,
      'status': instance.status,
      'type': instance.type,
      'items_count': instance.itemsCount,
      'total_cents': const MoneyNullableConverter().toJson(instance.total),
      'note': instance.note,
      'decline_reason': instance.declineReason,
      'created_at': instance.createdAt,
      'items': instance.items,
      'conversation_id': instance.conversationId,
      'preferred_date': instance.preferredDate,
      'time_slot': instance.timeSlot,
      'description': instance.description,
      'date_range': instance.dateRange,
      'guest_count': instance.guestCount,
      'service_location': instance.serviceLocation,
    };

_$RequestCustomerImpl _$$RequestCustomerImplFromJson(
  Map<String, dynamic> json,
) => _$RequestCustomerImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  avatarUrl: json['avatar_url'] as String?,
  phone: json['phone'] as String?,
);

Map<String, dynamic> _$$RequestCustomerImplToJson(
  _$RequestCustomerImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'avatar_url': instance.avatarUrl,
  'phone': instance.phone,
};

_$RequestItemImpl _$$RequestItemImplFromJson(Map<String, dynamic> json) =>
    _$RequestItemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      price: const MoneyNullableConverter().fromJson(
        (json['price_cents'] as num?)?.toInt(),
      ),
      variation: json['variation'] as String?,
    );

Map<String, dynamic> _$$RequestItemImplToJson(_$RequestItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'price_cents': const MoneyNullableConverter().toJson(instance.price),
      'variation': instance.variation,
    };
