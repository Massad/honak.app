// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_queue_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerQueueEntryImpl _$$CustomerQueueEntryImplFromJson(
  Map<String, dynamic> json,
) => _$CustomerQueueEntryImpl(
  id: json['id'] as String,
  pageId: json['page_id'] as String,
  pageName: json['page_name'] as String,
  position: (json['position'] as num).toInt(),
  status: $enumDecode(_$QueueStatusEnumMap, json['status']),
  source: $enumDecode(_$QueueSourceEnumMap, json['source']),
  packageId: json['package_id'] as String,
  packageName: json['package_name'] as String,
  packagePriceCents: (json['package_price_cents'] as num).toInt(),
  addOns:
      (json['add_ons'] as List<dynamic>?)
          ?.map((e) => QueueAddOn.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  totalPriceCents: (json['total_price_cents'] as num).toInt(),
  estimatedDurationMin: (json['estimated_duration_min'] as num).toInt(),
  aheadCount: (json['ahead_count'] as num?)?.toInt() ?? 0,
  estimatedWaitMin: (json['estimated_wait_min'] as num?)?.toInt() ?? 0,
  checkedInAt: (json['checked_in_at'] as num).toInt(),
  startedAt: (json['started_at'] as num?)?.toInt(),
  completedAt: (json['completed_at'] as num?)?.toInt(),
  onTheWay: json['on_the_way'] as bool? ?? false,
  modificationPending: json['modification_pending'] as bool? ?? false,
  paymentMethods:
      (json['payment_methods'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$CustomerQueueEntryImplToJson(
  _$CustomerQueueEntryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'page_id': instance.pageId,
  'page_name': instance.pageName,
  'position': instance.position,
  'status': _$QueueStatusEnumMap[instance.status]!,
  'source': _$QueueSourceEnumMap[instance.source]!,
  'package_id': instance.packageId,
  'package_name': instance.packageName,
  'package_price_cents': instance.packagePriceCents,
  'add_ons': instance.addOns,
  'total_price_cents': instance.totalPriceCents,
  'estimated_duration_min': instance.estimatedDurationMin,
  'ahead_count': instance.aheadCount,
  'estimated_wait_min': instance.estimatedWaitMin,
  'checked_in_at': instance.checkedInAt,
  'started_at': instance.startedAt,
  'completed_at': instance.completedAt,
  'on_the_way': instance.onTheWay,
  'modification_pending': instance.modificationPending,
  'payment_methods': instance.paymentMethods,
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
