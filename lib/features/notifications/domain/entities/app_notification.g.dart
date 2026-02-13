// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppNotificationImpl _$$AppNotificationImplFromJson(
  Map<String, dynamic> json,
) => _$AppNotificationImpl(
  id: json['id'] as String,
  type: json['type'] as String,
  title: json['title'] as String,
  body: json['body'] as String,
  imageUrl: json['image_url'] as String?,
  pageName: json['page_name'] as String?,
  pageId: json['page_id'] as String?,
  actionUrl: json['action_url'] as String?,
  isRead: json['is_read'] as bool? ?? false,
  createdAt: (json['created_at'] as num).toInt(),
);

Map<String, dynamic> _$$AppNotificationImplToJson(
  _$AppNotificationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'title': instance.title,
  'body': instance.body,
  'image_url': instance.imageUrl,
  'page_name': instance.pageName,
  'page_id': instance.pageId,
  'action_url': instance.actionUrl,
  'is_read': instance.isRead,
  'created_at': instance.createdAt,
};
