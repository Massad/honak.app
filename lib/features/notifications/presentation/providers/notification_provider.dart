import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/notifications/data/repository/notification_repository.dart';
import 'package:honak/features/notifications/domain/entities/app_notification.dart';
import 'package:honak/shared/providers/api_provider.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(ref.read(apiClientProvider));
});

final notificationsProvider =
    FutureProvider<List<AppNotification>>((ref) async {
  final repo = ref.read(notificationRepositoryProvider);
  return repo.getNotifications();
});

final unreadNotificationCountProvider = FutureProvider<int>((ref) async {
  final repo = ref.read(notificationRepositoryProvider);
  return repo.getUnreadCount();
});

final markNotificationReadProvider =
    FutureProvider.family<void, String>((ref, notificationId) async {
  final repo = ref.read(notificationRepositoryProvider);
  await repo.markAsRead(notificationId);
});

final markAllNotificationsReadProvider =
    FutureProvider<void>((ref) async {
  final repo = ref.read(notificationRepositoryProvider);
  await repo.markAllAsRead();
});
