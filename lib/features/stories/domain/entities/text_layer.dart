import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_layer.freezed.dart';
part 'text_layer.g.dart';

@freezed
class TextLayer with _$TextLayer {
  const factory TextLayer({
    required String id,
    required String text,
    @JsonKey(name: 'position_x') @Default(0.5) double positionX,
    @JsonKey(name: 'position_y') @Default(0.5) double positionY,
    @Default('#FFFFFF') String color,
    @Default('default') String font,
    @JsonKey(name: 'font_size') @Default(24.0) double fontSize,
    @Default('center') String align,
  }) = _TextLayer;

  factory TextLayer.fromJson(Map<String, dynamic> json) =>
      _$TextLayerFromJson(json);
}
