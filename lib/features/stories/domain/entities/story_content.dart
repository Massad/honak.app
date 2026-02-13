import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/features/stories/domain/entities/story_slide.dart';

part 'story_content.freezed.dart';
part 'story_content.g.dart';

@freezed
class StoryContent with _$StoryContent {
  const factory StoryContent({
    required String id,
    required String name,
    String? avatar,
    @Default([]) List<StorySlide> stories,
  }) = _StoryContent;

  factory StoryContent.fromJson(Map<String, dynamic> json) =>
      _$StoryContentFromJson(json);
}
