import 'package:freezed_annotation/freezed_annotation.dart';

part 'story.freezed.dart';
part 'story.g.dart';

@freezed
class Story with _$Story {
  const factory Story({
    required String id,
    @JsonKey(name: 'page_id') required String pageId,
    @JsonKey(name: 'page_name') required String pageName,
    @JsonKey(name: 'page_avatar_url') String? pageAvatarUrl,
    @JsonKey(name: 'has_new') @Default(false) bool hasNew,
    @JsonKey(name: 'story_count') @Default(0) int storyCount,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}
