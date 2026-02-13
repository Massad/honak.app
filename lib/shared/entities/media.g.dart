// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MediaImpl _$$MediaImplFromJson(Map<String, dynamic> json) => _$MediaImpl(
  url: json['url'] as String,
  thumbnailUrl: json['thumbnail_url'] as String?,
  type:
      $enumDecodeNullable(_$MediaTypeEnumMap, json['type']) ?? MediaType.image,
  width: (json['width'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
);

Map<String, dynamic> _$$MediaImplToJson(_$MediaImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'thumbnail_url': instance.thumbnailUrl,
      'type': _$MediaTypeEnumMap[instance.type]!,
      'width': instance.width,
      'height': instance.height,
    };

const _$MediaTypeEnumMap = {MediaType.image: 'image', MediaType.video: 'video'};
