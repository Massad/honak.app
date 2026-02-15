import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/chat/presentation/providers/chat_provider.dart';
import 'package:honak/features/notifications/presentation/providers/notification_provider.dart';
import 'package:honak/features/requests/presentation/providers/provider.dart';
import 'package:honak/features/business/order_management/presentation/providers/provider.dart'
    as biz;
import 'package:honak/shared/providers/business_page_provider.dart';

/// Navigation tabs shared across customer and business modes.
enum NavTab { home, explore, orders, chat, account, insights }

/// Immutable bag of badge counts keyed by [NavTab].
class NavBadges {
  final Map<NavTab, int> _counts;

  const NavBadges([this._counts = const {}]);

  int operator [](NavTab tab) => _counts[tab] ?? 0;
  bool hasBadge(NavTab tab) => this[tab] > 0;
}

/// Statuses that count as "active" for the customer orders badge.
const activeRequestStatuses = {
  'pending',
  'pending_review',
  'accepted',
  'in_progress',
  'preparing',
  'suggested',
  'pending_reschedule',
  'modification_requested',
  'alternative_offered',
};

/// Single provider for all customer navigation badges.
final customerNavBadgesProvider = Provider<NavBadges>((ref) {
  final chatCount = ref.watch(unreadChatCountProvider);
  final notifCount =
      ref.watch(unreadNotificationCountProvider).valueOrNull ?? 0;

  final requestsAsync = ref.watch(myRequestsProvider(null));
  final ordersCount = requestsAsync.whenOrNull(
        data: (list) =>
            list.where((r) => activeRequestStatuses.contains(r.status)).length,
      ) ??
      0;

  return NavBadges({
    NavTab.chat: chatCount,
    NavTab.account: notifCount,
    NavTab.orders: ordersCount,
  });
});

/// Single provider for all business navigation badges.
final businessNavBadgesProvider = Provider<NavBadges>((ref) {
  final chatCount = ref.watch(unreadChatCountProvider);

  final page = ref.watch(currentBusinessPageProvider).valueOrNull;
  final ordersCount = page == null
      ? 0
      : ref
              .watch(biz.bizRequestsProvider(
                  (pageId: page.id, status: 'pending')))
              .whenOrNull(data: (list) => list.length) ??
          0;

  return NavBadges({
    NavTab.chat: chatCount,
    NavTab.orders: ordersCount,
  });
});
