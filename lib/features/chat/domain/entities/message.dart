import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

enum MessageType {
  text,
  image,
  system,
  alternativeSuggestion,
  infoRequest,
  modificationRequest,
  productCard,
  availabilityCard,
  quoteCard,
}

@freezed
class Message with _$Message {
  const Message._();

  const factory Message({
    required String id,
    @JsonKey(name: 'conversation_id') required String conversationId,
    @JsonKey(name: 'sender_id') String? senderId,
    @JsonKey(name: 'sender_name') String? senderName,
    required String type,
    @Default('') String content,
    @JsonKey(name: 'image_url') String? imageUrl,
    @Default({}) Map<String, dynamic> metadata,
    @JsonKey(name: 'created_at') required int createdAt,
    @JsonKey(name: 'is_from_business') @Default(false) bool isFromBusiness,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  MessageType get messageType => switch (type) {
        'alternative_suggestion' => MessageType.alternativeSuggestion,
        'info_request' => MessageType.infoRequest,
        'modification_request' => MessageType.modificationRequest,
        'product_card' => MessageType.productCard,
        'availability_card' => MessageType.availabilityCard,
        'quote_card' => MessageType.quoteCard,
        'image' => MessageType.image,
        'system' => MessageType.system,
        _ => MessageType.text,
      };
}
