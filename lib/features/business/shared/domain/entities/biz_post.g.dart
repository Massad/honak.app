// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biz_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BizPostImpl _$$BizPostImplFromJson(Map<String, dynamic> json) =>
    _$BizPostImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      caption: json['caption'] as String,
      image: json['image'] as String?,
      statusColor: json['status_color'] as String?,
      pageId: json['page_id'] as String?,
      createdAt: (json['created_at'] as num).toInt(),
      status: json['status'] as String? ?? 'published',
      audience: json['audience'] as String?,
      scheduledAt: (json['scheduled_at'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$BizPostImplToJson(_$BizPostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'caption': instance.caption,
      'image': instance.image,
      'status_color': instance.statusColor,
      'page_id': instance.pageId,
      'created_at': instance.createdAt,
      'status': instance.status,
      'audience': instance.audience,
      'scheduled_at': instance.scheduledAt,
    };
