// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryImpl _$$StoryImplFromJson(Map<String, dynamic> json) => _$StoryImpl(
  id: json['id'] as String,
  pageId: json['page_id'] as String,
  pageName: json['page_name'] as String,
  pageAvatarUrl: json['page_avatar_url'] as String?,
  hasNew: json['has_new'] as bool? ?? false,
  storyCount: (json['story_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$StoryImplToJson(_$StoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'page_id': instance.pageId,
      'page_name': instance.pageName,
      'page_avatar_url': instance.pageAvatarUrl,
      'has_new': instance.hasNew,
      'story_count': instance.storyCount,
    };
