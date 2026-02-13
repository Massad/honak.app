import 'package:freezed_annotation/freezed_annotation.dart';

part 'media.freezed.dart';
part 'media.g.dart';

enum MediaType {
  @JsonValue('image')
  image,
  @JsonValue('video')
  video,
}

@freezed
class Media with _$Media {
  const factory Media({
    required String url,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    @Default(MediaType.image) MediaType type,
    int? width,
    int? height,
  }) = _Media;

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
}
