import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/features/business/stories/domain/entities/story_stats.dart';
import 'package:honak/features/stories/domain/entities/story_slide.dart';

part 'my_story.freezed.dart';
part 'my_story.g.dart';

@freezed
class MyStory with _$MyStory {
  const factory MyStory({
    required String id,
    required StorySlide slide,
    @Default('live') String status,
    @Default('followers') String audience,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'expires_at') String? expiresAt,
    @JsonKey(name: 'scheduled_at') String? scheduledAt,
    @Default(StoryStats()) StoryStats stats,
  }) = _MyStory;

  factory MyStory.fromJson(Map<String, dynamic> json) =>
      _$MyStoryFromJson(json);
}
