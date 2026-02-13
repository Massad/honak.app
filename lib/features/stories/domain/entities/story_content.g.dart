// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryContentImpl _$$StoryContentImplFromJson(Map<String, dynamic> json) =>
    _$StoryContentImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      stories:
          (json['stories'] as List<dynamic>?)
              ?.map((e) => StorySlide.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$StoryContentImplToJson(_$StoryContentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'stories': instance.stories,
    };
