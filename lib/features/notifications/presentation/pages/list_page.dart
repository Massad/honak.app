import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/shared/widgets/button.dart' as btn;
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/notifications/domain/entities/app_notification.dart';
import 'package:honak/features/notifications/presentation/providers/notification_provider.dart';
import 'package:honak/features/notifications/presentation/widgets/notification_card.dart';
import 'package:honak/features/notifications/presentation/widgets/notification_filter_chip.dart';
import 'package:honak/features/notifications/presentation/widgets/notification_list_skeleton.dart';
import 'package:honak/shared/widgets/app_direction.dart';
import 'package:honak/shared/widgets/empty_state.dart';

class NotificationListPage extends ConsumerStatefulWidget {
  const NotificationListPage({super.key});

  @override
  ConsumerState<NotificationListPage> createState() =>
      _NotificationListPageState();
}

class _NotificationListPageState extends ConsumerState<NotificationListPage> {
  String _activeFilter = 'all';
  final Set<String> _locallyReadIds = {};

  static const filters = [
    ('all', 'الكل'),
    ('requests', 'الطلبات'),
    ('pages', 'الصفحات'),
  ];

  List<AppNotification> _applyFilter(List<AppNotification> notifications) {
    if (_activeFilter == 'all') return notifications;
    if (_activeFilter == 'requests') {
      return notifications
          .where((n) =>
              n.type == 'request_status' || n.type == 'new_message')
          .toList();
    }
    // pages
    return notifications
        .where((n) =>
            n.type == 'new_follower' ||
            n.type == 'new_post' ||
            n.type == 'promotion')
        .toList();
  }

  bool _isRead(AppNotification n) =>
      n.isRead || _locallyReadIds.contains(n.id);

  void _markAsRead(AppNotification n) {
    if (_isRead(n)) return;
    setState(() => _locallyReadIds.add(n.id));
    ref.read(notificationRepositoryProvider).markAsRead(n.id);
  }

  void _handleNotificationTap(AppNotification n) {
    _markAsRead(n);
    final url = n.actionUrl;
    if (url == null || url.isEmpty) return;

    if (url.startsWith('/chat/')) {
      final convId = url.replaceFirst('/chat/', '');
      context.push(Routes.chatDetailPath(convId));
    } else if (url.startsWith('/requests/')) {
      final reqId = url.replaceFirst('/requests/', '');
      context.push(Routes.orderDetailPath(reqId));
    } else if (url.contains('/posts/')) {
      final postId = url.split('/posts/').last;
      context.push(Routes.postPath(postId));
    }
  }

  Future<void> _markAllAsRead() async {
    final notifications = ref.read(notificationsProvider).valueOrNull;
    if (notifications == null) return;

    setState(() {
      for (final n in notifications) {
        _locallyReadIds.add(n.id);
      }
    });

    await ref.read(notificationRepositoryProvider).markAllAsRead();
    ref.invalidate(notificationsProvider);
    ref.invalidate(unreadNotificationCountProvider);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم تعيين الكل كمقروء'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  String _getDateGroup(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final weekAgo = today.subtract(const Duration(days: 7));

    if (date.isAfter(today)) return 'اليوم';
    if (date.isAfter(yesterday)) return 'أمس';
    if (date.isAfter(weekAgo)) return 'هذا الأسبوع';
    return 'سابقاً';
  }

  @override
  Widget build(BuildContext context) {
    final asyncNotifications = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('الإشعارات'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(AppDirection.backIcon(context), size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        leading: btn.Button(
          onPressed: _markAllAsRead,
          label: 'تعيين الكل كمقروء',
          variant: btn.Variant.text,
          size: btn.ButtonSize.small,
        ),
        leadingWidth: 130,
      ),
      body: Column(
        children: [
          _FilterTabs(
            activeFilter: _activeFilter,
            onFilterChanged: (f) => setState(() => _activeFilter = f),
          ),
          Expanded(
            child: asyncNotifications.when(
              loading: () => const NotificationListSkeleton(),
              error: (err, _) => Center(
                child: Text('حدث خطأ: $err'),
              ),
              data: (notifications) {
                final filtered = _applyFilter(notifications);
                if (filtered.isEmpty) {
                  return const EmptyState(
                    icon: Icons.notifications_off_outlined,
                    title: 'لا توجد إشعارات',
                    subtitle:
                        'ستظهر إشعاراتك هنا عندما يكون لديك تحديثات جديدة',
                  );
                }
                return _NotificationList(
                  notifications: filtered,
                  isRead: _isRead,
                  onTap: _handleNotificationTap,
                  getDateGroup: _getDateGroup,
                  onRefresh: () =>
                      ref.refresh(notificationsProvider.future),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Filter Tabs
// ---------------------------------------------------------------------------

class _FilterTabs extends StatelessWidget {
  final String activeFilter;
  final ValueChanged<String> onFilterChanged;

  const _FilterTabs({
    required this.activeFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          for (final (key, label)
              in _NotificationListPageState.filters) ...[
            if (key != 'all') const SizedBox(width: AppSpacing.sm),
            NotificationFilterChip(
              label: label,
              isActive: activeFilter == key,
              onTap: () => onFilterChanged(key),
            ),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Notification List (grouped by date)
// ---------------------------------------------------------------------------

class _NotificationList extends StatelessWidget {
  final List<AppNotification> notifications;
  final bool Function(AppNotification) isRead;
  final ValueChanged<AppNotification> onTap;
  final String Function(int) getDateGroup;
  final Future<void> Function() onRefresh;

  const _NotificationList({
    required this.notifications,
    required this.isRead,
    required this.onTap,
    required this.getDateGroup,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    // Group by date
    final groups = <String, List<AppNotification>>{};
    for (final n in notifications) {
      final group = getDateGroup(n.createdAt);
      groups.putIfAbsent(group, () => []).add(n);
    }

    // Preserve order: اليوم → أمس → هذا الأسبوع → سابقاً
    const groupOrder = ['اليوم', 'أمس', 'هذا الأسبوع', 'سابقاً'];
    final orderedKeys =
        groupOrder.where((g) => groups.containsKey(g)).toList();

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: const EdgeInsetsDirectional.only(
          start: AppSpacing.lg,
          end: AppSpacing.lg,
          bottom: AppSpacing.xxxl,
        ),
        itemCount: orderedKeys.length,
        itemBuilder: (context, index) {
          final groupKey = orderedKeys[index];
          final items = groups[groupKey]!;
          return _DateGroup(
            label: groupKey,
            notifications: items,
            isRead: isRead,
            onTap: onTap,
            isFirst: index == 0,
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Date Group Section
// ---------------------------------------------------------------------------

class _DateGroup extends StatelessWidget {
  final String label;
  final List<AppNotification> notifications;
  final bool Function(AppNotification) isRead;
  final ValueChanged<AppNotification> onTap;
  final bool isFirst;

  const _DateGroup({
    required this.label,
    required this.notifications,
    required this.isRead,
    required this.onTap,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            top: isFirst ? 0 : AppSpacing.lg,
            bottom: AppSpacing.sm,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        for (int i = 0; i < notifications.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.sm),
          NotificationCard(
            notification: notifications[i],
            isRead: isRead(notifications[i]),
            onTap: () => onTap(notifications[i]),
          ),
        ],
      ],
    );
  }
}
