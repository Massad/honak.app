import 'package:honak/features/notifications/domain/entities/app_notification.dart';
import 'package:honak/shared/api/api_client.dart';

class NotificationRepository {
  final ApiClient _api;
  NotificationRepository(this._api);

  Future<List<AppNotification>> getNotifications() async {
    final response = await _api.get<List<AppNotification>>(
      '/v1/notifications',
      fromJson: (json) => (json as List)
          .map((e) => AppNotification.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(
        response.error?.message ?? 'Failed to load notifications');
  }

  Future<int> getUnreadCount() async {
    final response = await _api.get<int>(
      '/v1/notifications/unread-count',
      fromJson: (json) => (json as Map<String, dynamic>)['count'] as int,
    );
    if (response.isSuccess && response.data != null) return response.data!;
    return 0;
  }

  Future<void> markAsRead(String notificationId) async {
    await _api.post<void>('/v1/notifications/$notificationId/read');
  }

  Future<void> markAllAsRead() async {
    await _api.post<void>('/v1/notifications/read-all');
  }
}
