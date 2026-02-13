// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_slide.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StorySlideImpl _$$StorySlideImplFromJson(Map<String, dynamic> json) =>
    _$StorySlideImpl(
      id: json['id'] as String,
      type: json['type'] as String? ?? 'text',
      image: json['image'] as String?,
      text: json['text'] as String?,
      textPosition: json['text_position'] as String? ?? 'center',
      font: json['font'] as String? ?? 'default',
      textColor: json['text_color'] as String? ?? '#FFFFFF',
      textLayers:
          (json['text_layers'] as List<dynamic>?)
              ?.map((e) => TextLayer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      bgColor: json['bg_color'] as String?,
      bgGradient: (json['bg_gradient'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['created_at'] as String?,
      duration: (json['duration'] as num?)?.toInt() ?? 5,
      seen: json['seen'] as bool? ?? false,
    );

Map<String, dynamic> _$$StorySlideImplToJson(_$StorySlideImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'image': instance.image,
      'text': instance.text,
      'text_position': instance.textPosition,
      'font': instance.font,
      'text_color': instance.textColor,
      'text_layers': instance.textLayers,
      'bg_color': instance.bgColor,
      'bg_gradient': instance.bgGradient,
      'created_at': instance.createdAt,
      'duration': instance.duration,
      'seen': instance.seen,
    };
