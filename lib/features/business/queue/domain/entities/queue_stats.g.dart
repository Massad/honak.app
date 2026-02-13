// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueueDayStatsImpl _$$QueueDayStatsImplFromJson(Map<String, dynamic> json) =>
    _$QueueDayStatsImpl(
      totalToday: (json['total_today'] as num?)?.toInt() ?? 0,
      completed: (json['completed'] as num?)?.toInt() ?? 0,
      inProgress: (json['in_progress'] as num?)?.toInt() ?? 0,
      waiting: (json['waiting'] as num?)?.toInt() ?? 0,
      noShows: (json['no_shows'] as num?)?.toInt() ?? 0,
      avgWaitMin: (json['avg_wait_min'] as num?)?.toInt() ?? 0,
      avgServiceMin: (json['avg_service_min'] as num?)?.toInt() ?? 0,
      revenueToday: (json['revenue_today_cents'] as num?)?.toInt() ?? 0,
      subscribersToday: (json['subscribers_today'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$QueueDayStatsImplToJson(_$QueueDayStatsImpl instance) =>
    <String, dynamic>{
      'total_today': instance.totalToday,
      'completed': instance.completed,
      'in_progress': instance.inProgress,
      'waiting': instance.waiting,
      'no_shows': instance.noShows,
      'avg_wait_min': instance.avgWaitMin,
      'avg_service_min': instance.avgServiceMin,
      'revenue_today_cents': instance.revenueToday,
      'subscribers_today': instance.subscribersToday,
    };
