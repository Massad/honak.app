import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';
part 'app_notification.g.dart';

enum NotificationType {
  requestStatus,
  newMessage,
  newFollower,
  newPost,
  promotion,
}

@freezed
class AppNotification with _$AppNotification {
  const AppNotification._();

  const factory AppNotification({
    required String id,
    required String type,
    required String title,
    required String body,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'page_name') String? pageName,
    @JsonKey(name: 'page_id') String? pageId,
    @JsonKey(name: 'action_url') String? actionUrl,
    @JsonKey(name: 'is_read') @Default(false) bool isRead,
    @JsonKey(name: 'created_at') required int createdAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);

  NotificationType get notificationType => switch (type) {
        'request_status' => NotificationType.requestStatus,
        'new_message' => NotificationType.newMessage,
        'new_follower' => NotificationType.newFollower,
        'new_post' => NotificationType.newPost,
        'promotion' => NotificationType.promotion,
        _ => NotificationType.requestStatus,
      };
}
