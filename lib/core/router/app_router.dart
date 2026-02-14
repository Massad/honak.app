import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:honak/features/auth/presentation/pages/phone_input_page.dart';
import 'package:honak/features/auth/presentation/pages/profile_setup_page.dart';
import 'package:honak/features/auth/presentation/pages/welcome_page.dart';
import 'package:honak/features/business/shared/widgets/business_shell.dart';
import 'package:honak/features/catalog/presentation/pages/item_detail_page.dart';
import 'package:honak/features/chat/domain/entities/conversation.dart';
import 'package:honak/features/chat/presentation/pages/detail_page.dart';
import 'package:honak/features/chat/presentation/pages/list_page.dart';
import 'package:honak/features/chat/presentation/providers/chat_provider.dart';
import 'package:honak/features/explore/domain/entities/category.dart';
import 'package:honak/features/explore/presentation/pages/category_browse_page.dart';
import 'package:honak/features/explore/presentation/pages/explore_page.dart';
import 'package:honak/features/explore/presentation/pages/search_page.dart';
import 'package:honak/features/home/presentation/pages/home_page.dart';
import 'package:honak/features/home/presentation/pages/post_detail_page.dart';
import 'package:honak/features/notifications/presentation/pages/list_page.dart';
import 'package:honak/features/notifications/presentation/providers/notification_provider.dart';
import 'package:honak/features/pages/presentation/pages/page_detail_page.dart';
import 'package:honak/features/orders/presentation/pages/orders_page.dart';
import 'package:honak/features/account/presentation/pages/account_page.dart';
import 'package:honak/features/saved/presentation/pages/list_page.dart'
    as saved;
import 'package:honak/features/settings/presentation/pages/settings_page.dart';
import 'package:honak/features/requests/domain/entities/customer_request.dart';
import 'package:honak/features/requests/presentation/pages/detail_page.dart'
    as req_detail;
import 'package:honak/features/requests/presentation/pages/list_page.dart'
    as req_list;
import 'package:honak/features/business/order_management/presentation/pages/detail_page.dart'
    as biz_req_detail;
import 'package:honak/features/business/page_wizard/presentation/pages/wizard_page.dart';
import 'package:honak/features/business/shared/domain/entities/entities.dart';
import 'package:honak/shared/auth/auth_provider.dart';
import 'package:honak/shared/auth/auth_state.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/providers/app_mode_provider.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _customerShellKey = GlobalKey<NavigatorState>();

/// Bridges Riverpod auth + mode state changes to GoRouter's refreshListenable.
class _RouterRefreshNotifier extends ChangeNotifier {
  _RouterRefreshNotifier(Ref ref) {
    ref.listen(authProvider, (_, __) => notifyListeners());
    ref.listen(appModeProvider, (_, __) => notifyListeners());
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = _RouterRefreshNotifier(ref);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.home,
    debugLogDiagnostics: true,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final auth = ref.read(authProvider).valueOrNull;
      final location = state.matchedLocation;

      final isAuthRoute = location == Routes.welcome ||
          location == Routes.login ||
          location == Routes.loginVerify ||
          location == Routes.loginProfile;

      // Still loading — don't redirect
      if (auth is AuthLoading || auth == null) return null;

      final isAuthenticated = auth is Authenticated;
      final isLoggedOut = auth is Unauthenticated;

      // Logged out users must go to welcome
      if (isLoggedOut && !isAuthRoute) return Routes.welcome;

      // Authenticated users shouldn't be on auth routes
      // (except profile setup — they may need that)
      if (isAuthenticated && isAuthRoute && location != Routes.loginProfile) {
        return Routes.home;
      }

      // Guests CAN navigate to auth routes (to sign up/log in)

      return null;
    },
    routes: [
      // Auth routes
      GoRoute(
        path: Routes.welcome,
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const PhoneInputPage(),
      ),
      GoRoute(
        path: Routes.loginVerify,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return OtpVerificationPage(
            phone: extra?['phone'] as String? ?? '',
            requestId: extra?['request_id'] as String? ?? '',
          );
        },
      ),
      GoRoute(
        path: Routes.loginProfile,
        builder: (context, state) => const ProfileSetupPage(),
      ),

      // Main app shell with tabs
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return _AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _customerShellKey,
            routes: [
              GoRoute(
                path: Routes.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.explore,
                builder: (context, state) => const ExplorePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.quickActions,
                builder: (context, state) => const OrdersPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.chat,
                builder: (context, state) => const ChatListPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.me,
                builder: (context, state) => const AccountPage(),
              ),
            ],
          ),
        ],
      ),

      // Explore detail screens
      GoRoute(
        path: Routes.exploreSearch,
        builder: (context, state) => const ExploreSearchPage(),
      ),
      GoRoute(
        path: Routes.exploreCategory,
        builder: (context, state) {
          final slug = state.pathParameters['slug']!;
          final extra = state.extra as Map<String, dynamic>?;
          return CategoryBrowsePage(
            categorySlug: slug,
            categoryName: extra?['name'] as String? ?? slug,
            types: extra?['types'] as List<BusinessSubType>?,
            selectedTypeId: extra?['selectedTypeId'] as String?,
          );
        },
      ),

      // Detail screens
      GoRoute(
        path: Routes.chatDetail,
        builder: (context, state) {
          final conversation = state.extra as Conversation;
          return ChatDetailPage(conversation: conversation);
        },
      ),
      GoRoute(
        path: Routes.notifications,
        builder: (context, state) => const NotificationListPage(),
      ),
      GoRoute(
        path: Routes.settings,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: Routes.page,
        builder: (context, state) {
          final handle = state.pathParameters['handle']!;
          return PageDetailPage(handle: handle);
        },
      ),
      GoRoute(
        path: Routes.product,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ItemDetailPage(itemId: id);
        },
      ),
      GoRoute(
        path: Routes.post,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return PostDetailPage(postId: id);
        },
      ),
      GoRoute(
        path: Routes.requests,
        builder: (context, state) => const req_list.RequestListPage(),
      ),
      GoRoute(
        path: Routes.requestDetail,
        builder: (context, state) {
          final request = state.extra as CustomerRequest;
          return req_detail.CustomerRequestDetailPage(request: request);
        },
      ),
      GoRoute(
        path: Routes.orders,
        builder: (context, state) => const OrdersPage(),
      ),
      GoRoute(
        path: Routes.cart,
        builder: (context, state) => const _PlaceholderPage(title: 'Cart'),
      ),
      GoRoute(
        path: Routes.checkout,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Checkout'),
      ),
      GoRoute(
        path: Routes.orderDetail,
        builder: (context, state) {
          final request = state.extra as CustomerRequest?;
          if (request != null) {
            return req_detail.CustomerRequestDetailPage(request: request);
          }
          final id = state.pathParameters['id']!;
          return _PlaceholderPage(title: 'Order: $id');
        },
      ),
      GoRoute(
        path: Routes.orderTracking,
        builder: (context, state) {
          final request = state.extra as CustomerRequest?;
          if (request != null) {
            return req_detail.CustomerRequestDetailPage(request: request);
          }
          final id = state.pathParameters['id']!;
          return _PlaceholderPage(title: 'Track: $id');
        },
      ),
      GoRoute(
        path: Routes.saved,
        builder: (context, state) => const saved.SavedListPage(),
      ),
      GoRoute(
        path: Routes.editProfile,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Edit Profile'),
      ),
      GoRoute(
        path: Routes.bizDashboard,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Biz Dashboard'),
      ),
      GoRoute(
        path: Routes.bizOrders,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Biz Orders'),
      ),
      GoRoute(
        path: Routes.bizCreatePost,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Create Post'),
      ),
      GoRoute(
        path: Routes.bizCatalog,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Biz Catalog'),
      ),
      GoRoute(
        path: Routes.bizSettings,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Biz Settings'),
      ),
      GoRoute(
        path: Routes.bizTeam,
        builder: (context, state) => const _PlaceholderPage(title: 'Team'),
      ),
      GoRoute(
        path: Routes.bizOrderDetail,
        builder: (context, state) {
          final request = state.extra as BizRequest?;
          if (request != null) {
            return biz_req_detail.RequestDetailPage(request: request);
          }
          final id = state.pathParameters['id']!;
          return _PlaceholderPage(title: 'Biz Order: $id');
        },
      ),
      GoRoute(
        path: Routes.bizPageCreate,
        builder: (context, state) => const WizardPage(),
      ),
    ],
  );
});

class _AppShell extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const _AppShell({required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appMode = ref.watch(appModeProvider).valueOrNull ?? AppMode.customer;

    if (appMode == AppMode.business) {
      return BusinessShell(customerShell: navigationShell);
    }

    final unreadChats = ref.watch(unreadChatCountProvider);
    final unreadNotifs = ref.watch(unreadNotificationCountProvider).valueOrNull ?? 0;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _CustomerBottomNav(
        navigationShell: navigationShell,
        unreadChats: unreadChats,
        unreadNotifs: unreadNotifs,
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  final String title;

  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.construction,
              size: 48,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(title, style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'قريباً...',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomerBottomNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final int unreadChats;
  final int unreadNotifs;

  const _CustomerBottomNav({
    required this.navigationShell,
    required this.unreadChats,
    required this.unreadNotifs,
  });

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.sm,
            right: AppSpacing.sm,
            top: AppSpacing.xs,
            bottom: AppSpacing.xs,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                index: 0,
                currentIndex: currentIndex,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'الرئيسية',
                onTap: () => navigationShell.goBranch(
                  0,
                  initialLocation: currentIndex == 0,
                ),
              ),
              _NavItem(
                index: 1,
                currentIndex: currentIndex,
                icon: Icons.explore_outlined,
                activeIcon: Icons.explore,
                label: 'استكشاف',
                onTap: () => navigationShell.goBranch(
                  1,
                  initialLocation: currentIndex == 1,
                ),
              ),
              _CenterTab(
                isActive: currentIndex == 2,
                onTap: () => navigationShell.goBranch(
                  2,
                  initialLocation: currentIndex == 2,
                ),
              ),
              _NavItem(
                index: 3,
                currentIndex: currentIndex,
                icon: Icons.chat_outlined,
                activeIcon: Icons.chat,
                label: 'المحادثات',
                badgeCount: unreadChats,
                onTap: () => navigationShell.goBranch(
                  3,
                  initialLocation: currentIndex == 3,
                ),
              ),
              _NavItem(
                index: 4,
                currentIndex: currentIndex,
                icon: Icons.person_outlined,
                activeIcon: Icons.person,
                label: 'حسابي',
                badgeCount: unreadNotifs,
                onTap: () => navigationShell.goBranch(
                  4,
                  initialLocation: currentIndex == 4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int badgeCount;
  final VoidCallback onTap;

  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.activeIcon,
    required this.label,
    this.badgeCount = 0,
    required this.onTap,
  });

  bool get _isActive => index == currentIndex;

  @override
  Widget build(BuildContext context) {
    final primary = context.colorScheme.primary;
    final grey = context.colorScheme.onSurfaceVariant;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Badge(
              isLabelVisible: badgeCount > 0,
              label: Text(badgeCount > 99 ? '99+' : '$badgeCount'),
              child: Icon(
                _isActive ? activeIcon : icon,
                size: 24,
                color: _isActive ? primary : grey,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: _isActive ? FontWeight.w600 : FontWeight.normal,
                color: _isActive ? primary : grey,
              ),
            ),
            const SizedBox(height: 2),
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isActive ? primary : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CenterTab extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;

  const _CenterTab({required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: const Offset(0, -12),
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, Color(0xFF4DA3FF)],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.shopping_bag,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -8),
              child: Text(
                'طلباتي',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                      isActive ? FontWeight.w600 : FontWeight.normal,
                  color: isActive
                      ? context.colorScheme.primary
                      : context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
