import 'package:freezed_annotation/freezed_annotation.dart';

part 'directory_manage_stats.freezed.dart';
part 'directory_manage_stats.g.dart';

@freezed
class DirectoryManageStats with _$DirectoryManageStats {
  const factory DirectoryManageStats({
    @Default(0) int total,
    @Default(0) int claimed,
    @Default(0) int invited,
    @Default(0) int unclaimed,
    @JsonKey(name: 'new_this_week') @Default(0) int newThisWeek,
  }) = _DirectoryManageStats;

  factory DirectoryManageStats.fromJson(Map<String, dynamic> json) =>
      _$DirectoryManageStatsFromJson(json);
}
