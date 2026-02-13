// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropoff_ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DropoffTicketImpl _$$DropoffTicketImplFromJson(Map<String, dynamic> json) =>
    _$DropoffTicketImpl(
      id: json['id'] as String,
      ticketNumber: json['ticket_number'] as String,
      status: $enumDecode(_$DropoffStatusEnumMap, json['status']),
      source: $enumDecode(_$DropoffSourceEnumMap, json['source']),
      customerName: json['customer_name'] as String,
      customerPhone: json['customer_phone'] as String?,
      customerAvatar: json['customer_avatar'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => DropoffItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['total_price_cents'] as num).toInt(),
      droppedOffAt: json['dropped_off_at'] as String,
      estimatedReadyAt: json['estimated_ready_at'] as String,
      startedAt: json['started_at'] as String?,
      completedAt: json['completed_at'] as String?,
      pickedUpAt: json['picked_up_at'] as String?,
      notes: json['notes'] as String?,
      urgent: json['urgent'] as bool? ?? false,
      paid: json['paid'] as bool? ?? false,
      paymentMethod: json['payment_method'] as String?,
    );

Map<String, dynamic> _$$DropoffTicketImplToJson(_$DropoffTicketImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ticket_number': instance.ticketNumber,
      'status': _$DropoffStatusEnumMap[instance.status]!,
      'source': _$DropoffSourceEnumMap[instance.source]!,
      'customer_name': instance.customerName,
      'customer_phone': instance.customerPhone,
      'customer_avatar': instance.customerAvatar,
      'items': instance.items,
      'total_price_cents': instance.totalPrice,
      'dropped_off_at': instance.droppedOffAt,
      'estimated_ready_at': instance.estimatedReadyAt,
      'started_at': instance.startedAt,
      'completed_at': instance.completedAt,
      'picked_up_at': instance.pickedUpAt,
      'notes': instance.notes,
      'urgent': instance.urgent,
      'paid': instance.paid,
      'payment_method': instance.paymentMethod,
    };

const _$DropoffStatusEnumMap = {
  DropoffStatus.received: 'received',
  DropoffStatus.processing: 'processing',
  DropoffStatus.ready: 'ready',
  DropoffStatus.delivered: 'delivered',
  DropoffStatus.cancelled: 'cancelled',
};

const _$DropoffSourceEnumMap = {
  DropoffSource.walkIn: 'walkIn',
  DropoffSource.appRequest: 'appRequest',
  DropoffSource.phone: 'phone',
};
