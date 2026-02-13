import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_reference.freezed.dart';
part 'story_reference.g.dart';

@freezed
class StoryReference with _$StoryReference {
  const factory StoryReference({
    @JsonKey(name: 'story_id') required String storyId,
    @JsonKey(name: 'business_id') required String businessId,
    @JsonKey(name: 'business_name') required String businessName,
    @JsonKey(name: 'business_avatar') String? businessAvatar,
    String? thumbnail,
    String? text,
    @JsonKey(name: 'bg_gradient') List<String>? bgGradient,
    @JsonKey(name: 'bg_color') String? bgColor,
  }) = _StoryReference;

  factory StoryReference.fromJson(Map<String, dynamic> json) =>
      _$StoryReferenceFromJson(json);
}
