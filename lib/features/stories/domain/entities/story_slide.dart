import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/features/stories/domain/entities/text_layer.dart';

part 'story_slide.freezed.dart';
part 'story_slide.g.dart';

@freezed
class StorySlide with _$StorySlide {
  const factory StorySlide({
    required String id,
    @Default('text') String type,
    String? image,
    String? text,
    @JsonKey(name: 'text_position') @Default('center') String textPosition,
    @Default('default') String font,
    @JsonKey(name: 'text_color') @Default('#FFFFFF') String textColor,
    @JsonKey(name: 'text_layers') @Default([]) List<TextLayer> textLayers,
    @JsonKey(name: 'bg_color') String? bgColor,
    @JsonKey(name: 'bg_gradient') List<String>? bgGradient,
    @JsonKey(name: 'created_at') String? createdAt,
    @Default(5) int duration,
    @Default(false) bool seen,
  }) = _StorySlide;

  factory StorySlide.fromJson(Map<String, dynamic> json) =>
      _$StorySlideFromJson(json);
}
