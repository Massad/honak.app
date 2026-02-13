import 'package:freezed_annotation/freezed_annotation.dart';

part 'queue_stats.freezed.dart';
part 'queue_stats.g.dart';

@freezed
class QueueDayStats with _$QueueDayStats {
  const factory QueueDayStats({
    @JsonKey(name: 'total_today') @Default(0) int totalToday,
    @Default(0) int completed,
    @JsonKey(name: 'in_progress') @Default(0) int inProgress,
    @Default(0) int waiting,
    @JsonKey(name: 'no_shows') @Default(0) int noShows,
    @JsonKey(name: 'avg_wait_min') @Default(0) int avgWaitMin,
    @JsonKey(name: 'avg_service_min') @Default(0) int avgServiceMin,
    @JsonKey(name: 'revenue_today_cents') @Default(0) int revenueToday,
    @JsonKey(name: 'subscribers_today') @Default(0) int subscribersToday,
  }) = _QueueDayStats;

  factory QueueDayStats.fromJson(Map<String, dynamic> json) =>
      _$QueueDayStatsFromJson(json);
}
