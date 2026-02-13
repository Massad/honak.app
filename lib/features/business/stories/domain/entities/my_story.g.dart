// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MyStoryImpl _$$MyStoryImplFromJson(Map<String, dynamic> json) =>
    _$MyStoryImpl(
      id: json['id'] as String,
      slide: StorySlide.fromJson(json['slide'] as Map<String, dynamic>),
      status: json['status'] as String? ?? 'live',
      audience: json['audience'] as String? ?? 'followers',
      createdAt: json['created_at'] as String?,
      expiresAt: json['expires_at'] as String?,
      scheduledAt: json['scheduled_at'] as String?,
      stats: json['stats'] == null
          ? const StoryStats()
          : StoryStats.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MyStoryImplToJson(_$MyStoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slide': instance.slide,
      'status': instance.status,
      'audience': instance.audience,
      'created_at': instance.createdAt,
      'expires_at': instance.expiresAt,
      'scheduled_at': instance.scheduledAt,
      'stats': instance.stats,
    };
