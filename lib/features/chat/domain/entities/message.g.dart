// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: json['id'] as String,
      conversationId: json['conversation_id'] as String,
      senderId: json['sender_id'] as String?,
      senderName: json['sender_name'] as String?,
      type: json['type'] as String,
      content: json['content'] as String? ?? '',
      imageUrl: json['image_url'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      createdAt: (json['created_at'] as num).toInt(),
      isFromBusiness: json['is_from_business'] as bool? ?? false,
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversation_id': instance.conversationId,
      'sender_id': instance.senderId,
      'sender_name': instance.senderName,
      'type': instance.type,
      'content': instance.content,
      'image_url': instance.imageUrl,
      'metadata': instance.metadata,
      'created_at': instance.createdAt,
      'is_from_business': instance.isFromBusiness,
    };
