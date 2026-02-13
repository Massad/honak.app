import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

@freezed
class Conversation with _$Conversation {
  const Conversation._();

  const factory Conversation({
    required String id,
    @JsonKey(name: 'page_id') required String pageId,
    @JsonKey(name: 'page_name') required String pageName,
    @JsonKey(name: 'page_avatar') String? pageAvatar,
    @JsonKey(name: 'page_handle') String? pageHandle,
    @JsonKey(name: 'customer_id') String? customerId,
    @JsonKey(name: 'customer_name') String? customerName,
    @JsonKey(name: 'customer_avatar') String? customerAvatar,
    @JsonKey(name: 'request_id') String? requestId,
    @JsonKey(name: 'request_status') String? requestStatus,
    @JsonKey(name: 'request_expires_at') int? requestExpiresAt,
    @JsonKey(name: 'last_message') String? lastMessage,
    @JsonKey(name: 'last_message_at') required int lastMessageAt,
    @JsonKey(name: 'last_message_from') String? lastMessageFrom,
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
    @Default('active') String status,
    @Default('message') String type,
    @JsonKey(name: 'has_active_story') @Default(false) bool hasActiveStory,
    @JsonKey(name: 'needs_info') @Default(false) bool needsInfo,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  /// Display name based on viewer mode.
  String displayName({required bool isBusinessMode}) =>
      isBusinessMode ? (customerName ?? pageName) : pageName;

  /// Display avatar based on viewer mode.
  String? displayAvatar({required bool isBusinessMode}) =>
      isBusinessMode ? customerAvatar : pageAvatar;

  /// Whether this request is expired (past expiry or status = expired).
  bool get isExpired {
    if (requestStatus == 'expired') return true;
    if (requestExpiresAt == null) return false;
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return now > requestExpiresAt!;
  }
}
