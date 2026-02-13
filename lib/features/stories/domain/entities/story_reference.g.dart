// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryReferenceImpl _$$StoryReferenceImplFromJson(Map<String, dynamic> json) =>
    _$StoryReferenceImpl(
      storyId: json['story_id'] as String,
      businessId: json['business_id'] as String,
      businessName: json['business_name'] as String,
      businessAvatar: json['business_avatar'] as String?,
      thumbnail: json['thumbnail'] as String?,
      text: json['text'] as String?,
      bgGradient: (json['bg_gradient'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      bgColor: json['bg_color'] as String?,
    );

Map<String, dynamic> _$$StoryReferenceImplToJson(
  _$StoryReferenceImpl instance,
) => <String, dynamic>{
  'story_id': instance.storyId,
  'business_id': instance.businessId,
  'business_name': instance.businessName,
  'business_avatar': instance.businessAvatar,
  'thumbnail': instance.thumbnail,
  'text': instance.text,
  'bg_gradient': instance.bgGradient,
  'bg_color': instance.bgColor,
};
