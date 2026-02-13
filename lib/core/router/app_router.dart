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
      final isGuest = auth is AuthGuest;
      final isLoggedOut = auth is Unauthenticated;

      // Logged out users must go to welcome
      if (isLoggedOut && !isAuthRoute) return Routes.welcome;

      // Authenticated users shouldn't be on auth routes
      // (except profile setup — they may need that)
      if (isAuthenticated && isAuthRoute && location != Routes.loginProfile) {
        return Routes.home;
      }

      // Guests can access certain routes, redirect rest to home
      if (isGuest && isAuthRoute) return Routes.home;

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
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          const NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'استكشاف',
          ),
          const NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'طلباتي',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: unreadChats > 0,
              label: Text(unreadChats > 99 ? '99+' : '$unreadChats'),
              child: const Icon(Icons.chat_outlined),
            ),
            selectedIcon: Badge(
              isLabelVisible: unreadChats > 0,
              label: Text(unreadChats > 99 ? '99+' : '$unreadChats'),
              child: const Icon(Icons.chat),
            ),
            label: 'المحادثات',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: unreadNotifs > 0,
              label: Text(unreadNotifs > 99 ? '99+' : '$unreadNotifs'),
              child: const Icon(Icons.person_outlined),
            ),
            selectedIcon: Badge(
              isLabelVisible: unreadNotifs > 0,
              label: Text(unreadNotifs > 99 ? '99+' : '$unreadNotifs'),
              child: const Icon(Icons.person),
            ),
            label: 'حسابي',
          ),
        ],
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
