// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueueEntryImpl _$$QueueEntryImplFromJson(Map<String, dynamic> json) =>
    _$QueueEntryImpl(
      id: json['id'] as String,
      position: (json['position'] as num).toInt(),
      status: $enumDecode(_$QueueStatusEnumMap, json['status']),
      source: $enumDecode(_$QueueSourceEnumMap, json['source']),
      customerName: json['customer_name'] as String,
      customerPhone: json['customer_phone'] as String?,
      customerAvatar: json['customer_avatar'] as String?,
      isSubscriber: json['is_subscriber'] as bool? ?? false,
      vehicleType: json['vehicle_type'] as String?,
      vehicleColor: json['vehicle_color'] as String?,
      plateNumber: json['plate_number'] as String?,
      vehicleLabel: json['vehicle_label'] as String?,
      packageId: json['package_id'] as String,
      packageName: json['package_name'] as String,
      packagePrice: (json['package_price_cents'] as num).toInt(),
      addOns:
          (json['add_ons'] as List<dynamic>?)
              ?.map((e) => QueueAddOn.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalPrice: (json['total_price_cents'] as num).toInt(),
      estimatedDurationMin: (json['estimated_duration_min'] as num).toInt(),
      checkedInAt: (json['checked_in_at'] as num).toInt(),
      startedAt: (json['started_at'] as num?)?.toInt(),
      completedAt: (json['completed_at'] as num?)?.toInt(),
      estimatedReadyAt: (json['estimated_ready_at'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      photosBefore:
          (json['photos_before'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      photosAfter:
          (json['photos_after'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      subscriptionPlan: json['subscription_plan'] as String?,
    );

Map<String, dynamic> _$$QueueEntryImplToJson(_$QueueEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': instance.position,
      'status': _$QueueStatusEnumMap[instance.status]!,
      'source': _$QueueSourceEnumMap[instance.source]!,
      'customer_name': instance.customerName,
      'customer_phone': instance.customerPhone,
      'customer_avatar': instance.customerAvatar,
      'is_subscriber': instance.isSubscriber,
      'vehicle_type': instance.vehicleType,
      'vehicle_color': instance.vehicleColor,
      'plate_number': instance.plateNumber,
      'vehicle_label': instance.vehicleLabel,
      'package_id': instance.packageId,
      'package_name': instance.packageName,
      'package_price_cents': instance.packagePrice,
      'add_ons': instance.addOns,
      'total_price_cents': instance.totalPrice,
      'estimated_duration_min': instance.estimatedDurationMin,
      'checked_in_at': instance.checkedInAt,
      'started_at': instance.startedAt,
      'completed_at': instance.completedAt,
      'estimated_ready_at': instance.estimatedReadyAt,
      'notes': instance.notes,
      'photos_before': instance.photosBefore,
      'photos_after': instance.photosAfter,
      'subscription_plan': instance.subscriptionPlan,
    };

const _$QueueStatusEnumMap = {
  QueueStatus.waiting: 'waiting',
  QueueStatus.onTheWay: 'onTheWay',
  QueueStatus.inProgress: 'inProgress',
  QueueStatus.ready: 'ready',
  QueueStatus.completed: 'completed',
  QueueStatus.noShow: 'noShow',
};

const _$QueueSourceEnumMap = {
  QueueSource.walkIn: 'walkIn',
  QueueSource.appReserve: 'appReserve',
  QueueSource.phone: 'phone',
};
