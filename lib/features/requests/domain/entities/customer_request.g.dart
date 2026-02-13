// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerRequestImpl _$$CustomerRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CustomerRequestImpl(
  id: json['id'] as String,
  type: json['type'] as String,
  status: json['status'] as String,
  businessPageId: json['business_page_id'] as String,
  businessName: json['business_name'] as String,
  businessAvatarUrl: json['business_avatar_url'] as String?,
  businessSlug: json['business_slug'] as String?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => OrderLineItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  itemsCount: (json['items_count'] as num?)?.toInt() ?? 0,
  total: const MoneyNullableConverter().fromJson(
    (json['total_cents'] as num?)?.toInt(),
  ),
  note: json['note'] as String?,
  summary: json['summary'] as String?,
  createdAt: (json['created_at'] as num).toInt(),
  timeline:
      (json['timeline'] as List<dynamic>?)
          ?.map((e) => TimelineEvent.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  deliveryTracking: json['delivery_tracking'] == null
      ? null
      : DeliveryTracking.fromJson(
          json['delivery_tracking'] as Map<String, dynamic>,
        ),
  paidBySubscription: json['paid_by_subscription'] == null
      ? null
      : SubscriptionPayment.fromJson(
          json['paid_by_subscription'] as Map<String, dynamic>,
        ),
  canEdit: json['can_edit'] as bool? ?? false,
  canCancel: json['can_cancel'] as bool? ?? false,
  canReschedule: json['can_reschedule'] as bool? ?? false,
  preferredDate: json['preferred_date'] as String?,
  timeSlot: json['time_slot'] as String?,
  description: json['description'] as String?,
  dateRange: json['date_range'] as String?,
  guestCount: (json['guest_count'] as num?)?.toInt(),
  serviceLocation: json['service_location'] as String?,
  urgency: json['urgency'] as String?,
  teamMember: json['team_member'] as String?,
  deliveryMethod: json['delivery_method'] as String?,
  deliveryAddress: json['delivery_address'] as String?,
  paymentMethod: json['payment_method'] as String?,
  declineReason: json['decline_reason'] as String?,
  queuePosition: (json['queue_position'] as num?)?.toInt(),
  estimatedWaitMin: (json['estimated_wait_min'] as num?)?.toInt(),
  queueStatus: json['queue_status'] as String?,
);

Map<String, dynamic> _$$CustomerRequestImplToJson(
  _$CustomerRequestImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'status': instance.status,
  'business_page_id': instance.businessPageId,
  'business_name': instance.businessName,
  'business_avatar_url': instance.businessAvatarUrl,
  'business_slug': instance.businessSlug,
  'items': instance.items,
  'items_count': instance.itemsCount,
  'total_cents': const MoneyNullableConverter().toJson(instance.total),
  'note': instance.note,
  'summary': instance.summary,
  'created_at': instance.createdAt,
  'timeline': instance.timeline,
  'delivery_tracking': instance.deliveryTracking,
  'paid_by_subscription': instance.paidBySubscription,
  'can_edit': instance.canEdit,
  'can_cancel': instance.canCancel,
  'can_reschedule': instance.canReschedule,
  'preferred_date': instance.preferredDate,
  'time_slot': instance.timeSlot,
  'description': instance.description,
  'date_range': instance.dateRange,
  'guest_count': instance.guestCount,
  'service_location': instance.serviceLocation,
  'urgency': instance.urgency,
  'team_member': instance.teamMember,
  'delivery_method': instance.deliveryMethod,
  'delivery_address': instance.deliveryAddress,
  'payment_method': instance.paymentMethod,
  'decline_reason': instance.declineReason,
  'queue_position': instance.queuePosition,
  'estimated_wait_min': instance.estimatedWaitMin,
  'queue_status': instance.queueStatus,
};

_$OrderLineItemImpl _$$OrderLineItemImplFromJson(Map<String, dynamic> json) =>
    _$OrderLineItemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      price: const MoneyNullableConverter().fromJson(
        (json['price_cents'] as num?)?.toInt(),
      ),
      variation: json['variation'] as String?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$$OrderLineItemImplToJson(_$OrderLineItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'price_cents': const MoneyNullableConverter().toJson(instance.price),
      'variation': instance.variation,
      'image_url': instance.imageUrl,
    };

_$TimelineEventImpl _$$TimelineEventImplFromJson(Map<String, dynamic> json) =>
    _$TimelineEventImpl(
      status: json['status'] as String,
      label: json['label'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      actor: json['actor'] as String? ?? 'system',
      detail: json['detail'] as String?,
      done: json['done'] as bool? ?? false,
    );

Map<String, dynamic> _$$TimelineEventImplToJson(_$TimelineEventImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'label': instance.label,
      'timestamp': instance.timestamp,
      'actor': instance.actor,
      'detail': instance.detail,
      'done': instance.done,
    };

_$DeliveryTrackingImpl _$$DeliveryTrackingImplFromJson(
  Map<String, dynamic> json,
) => _$DeliveryTrackingImpl(
  status: json['status'] as String,
  estimatedMinutes: (json['estimated_minutes'] as num?)?.toInt(),
  driverName: json['driver_name'] as String?,
  driverPhone: json['driver_phone'] as String?,
);

Map<String, dynamic> _$$DeliveryTrackingImplToJson(
  _$DeliveryTrackingImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'estimated_minutes': instance.estimatedMinutes,
  'driver_name': instance.driverName,
  'driver_phone': instance.driverPhone,
};

_$SubscriptionPaymentImpl _$$SubscriptionPaymentImplFromJson(
  Map<String, dynamic> json,
) => _$SubscriptionPaymentImpl(
  subscriptionId: json['subscription_id'] as String,
  packageName: json['package_name'] as String,
  creditsUsed: (json['credits_used'] as num?)?.toInt() ?? 1,
  remainingAfter: (json['remaining_after'] as num?)?.toInt(),
);

Map<String, dynamic> _$$SubscriptionPaymentImplToJson(
  _$SubscriptionPaymentImpl instance,
) => <String, dynamic>{
  'subscription_id': instance.subscriptionId,
  'package_name': instance.packageName,
  'credits_used': instance.creditsUsed,
  'remaining_after': instance.remainingAfter,
};
