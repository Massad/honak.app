// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropoff_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DropoffDayStatsImpl _$$DropoffDayStatsImplFromJson(
  Map<String, dynamic> json,
) => _$DropoffDayStatsImpl(
  totalToday: (json['total_today'] as num?)?.toInt() ?? 0,
  received: (json['received'] as num?)?.toInt() ?? 0,
  processing: (json['processing'] as num?)?.toInt() ?? 0,
  ready: (json['ready'] as num?)?.toInt() ?? 0,
  delivered: (json['delivered'] as num?)?.toInt() ?? 0,
  overdue: (json['overdue'] as num?)?.toInt() ?? 0,
  revenueToday: (json['revenue_today_cents'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$DropoffDayStatsImplToJson(
  _$DropoffDayStatsImpl instance,
) => <String, dynamic>{
  'total_today': instance.totalToday,
  'received': instance.received,
  'processing': instance.processing,
  'ready': instance.ready,
  'delivered': instance.delivered,
  'overdue': instance.overdue,
  'revenue_today_cents': instance.revenueToday,
};
