import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_stats.freezed.dart';
part 'story_stats.g.dart';

@freezed
class StoryStats with _$StoryStats {
  const factory StoryStats({
    @Default(0) int views,
    @JsonKey(name: 'unique_reach') @Default(0) int uniqueReach,
    @Default(0) int shares,
    @Default(0) int messages,
    @JsonKey(name: 'profile_visits') @Default(0) int profileVisits,
    @JsonKey(name: 'link_clicks') @Default(0) int linkClicks,
  }) = _StoryStats;

  factory StoryStats.fromJson(Map<String, dynamic> json) =>
      _$StoryStatsFromJson(json);
}
