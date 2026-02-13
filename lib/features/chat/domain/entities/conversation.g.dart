// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConversationImpl _$$ConversationImplFromJson(Map<String, dynamic> json) =>
    _$ConversationImpl(
      id: json['id'] as String,
      pageId: json['page_id'] as String,
      pageName: json['page_name'] as String,
      pageAvatar: json['page_avatar'] as String?,
      pageHandle: json['page_handle'] as String?,
      customerId: json['customer_id'] as String?,
      customerName: json['customer_name'] as String?,
      customerAvatar: json['customer_avatar'] as String?,
      requestId: json['request_id'] as String?,
      requestStatus: json['request_status'] as String?,
      requestExpiresAt: (json['request_expires_at'] as num?)?.toInt(),
      lastMessage: json['last_message'] as String?,
      lastMessageAt: (json['last_message_at'] as num).toInt(),
      lastMessageFrom: json['last_message_from'] as String?,
      unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'active',
      type: json['type'] as String? ?? 'message',
      hasActiveStory: json['has_active_story'] as bool? ?? false,
      needsInfo: json['needs_info'] as bool? ?? false,
    );

Map<String, dynamic> _$$ConversationImplToJson(_$ConversationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'page_id': instance.pageId,
      'page_name': instance.pageName,
      'page_avatar': instance.pageAvatar,
      'page_handle': instance.pageHandle,
      'customer_id': instance.customerId,
      'customer_name': instance.customerName,
      'customer_avatar': instance.customerAvatar,
      'request_id': instance.requestId,
      'request_status': instance.requestStatus,
      'request_expires_at': instance.requestExpiresAt,
      'last_message': instance.lastMessage,
      'last_message_at': instance.lastMessageAt,
      'last_message_from': instance.lastMessageFrom,
      'unread_count': instance.unreadCount,
      'status': instance.status,
      'type': instance.type,
      'has_active_story': instance.hasActiveStory,
      'needs_info': instance.needsInfo,
    };
