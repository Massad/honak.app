import 'package:freezed_annotation/freezed_annotation.dart';

part 'dropoff_stats.freezed.dart';
part 'dropoff_stats.g.dart';

@freezed
class DropoffDayStats with _$DropoffDayStats {
  const factory DropoffDayStats({
    @JsonKey(name: 'total_today') @Default(0) int totalToday,
    @Default(0) int received,
    @Default(0) int processing,
    @Default(0) int ready,
    @Default(0) int delivered,
    @Default(0) int overdue,
    @JsonKey(name: 'revenue_today_cents') @Default(0) int revenueToday,
  }) = _DropoffDayStats;

  factory DropoffDayStats.fromJson(Map<String, dynamic> json) =>
      _$DropoffDayStatsFromJson(json);
}
