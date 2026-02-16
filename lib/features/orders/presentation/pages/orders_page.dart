import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/orders/presentation/widgets/orders_skeleton.dart';
import 'package:honak/features/orders/presentation/widgets/orders_tab_content.dart';
import 'package:honak/features/requests/domain/entities/entities.dart';
import 'package:honak/features/requests/presentation/providers/provider.dart';
import 'package:honak/shared/providers/nav_badge_provider.dart';
import 'package:honak/features/subscriptions/domain/entities/entities.dart';
import 'package:honak/features/subscriptions/presentation/providers/subscription_providers.dart';
import 'package:honak/features/subscriptions/presentation/widgets/subscriptions_tab.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Customer "My Orders" page — "طلباتي" with 4 tabs.
class OrdersPage extends ConsumerStatefulWidget {
  const OrdersPage({super.key});

  @override
  ConsumerState<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends ConsumerState<OrdersPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  bool _showSearch = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final requestsAsync = ref.watch(myRequestsProvider(null));
    final activeSubs = ref.watch(activeSubscriptionsProvider);

    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('طلباتي'),
        actions: [
          IconButton(
            icon: Icon(_showSearch ? Icons.close : Icons.search, size: 22),
            onPressed: () {
              setState(() {
                _showSearch = !_showSearch;
                if (!_showSearch) _searchQuery = '';
              });
            },
          ),
        ],
      ),
      body: requestsAsync.when(
        loading: () => const OrdersSkeleton(),
        error: (error, _) => _ErrorState(
          onRetry: () => ref.invalidate(myRequestsProvider(null)),
        ),
        data: (requests) => _OrdersBody(
          requests: requests,
          tabController: _tabController,
          showSearch: _showSearch,
          searchQuery: _searchQuery,
          onSearchChanged: (q) => setState(() => _searchQuery = q),
          onRefresh: () async => ref.invalidate(myRequestsProvider(null)),
          subscriptionCount: activeSubs.length,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------
// Body
// ---------------------------------------------------------------

class _OrdersBody extends StatelessWidget {
  final List<CustomerRequest> requests;
  final TabController tabController;
  final bool showSearch;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final Future<void> Function() onRefresh;
  final int subscriptionCount;

  const _OrdersBody({
    required this.requests,
    required this.tabController,
    required this.showSearch,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onRefresh,
    this.subscriptionCount = 0,
  });

  List<CustomerRequest> _filter(List<CustomerRequest> list) {
    if (searchQuery.isEmpty) return list;
    final q = searchQuery.toLowerCase();
    return list
        .where((r) =>
            r.businessName.toLowerCase().contains(q) ||
            (r.summary ?? '').toLowerCase().contains(q))
        .toList();
  }

  List<CustomerRequest> get _activeRequests => _filter(
        requests
            .where((r) => activeRequestStatuses.contains(r.status))
            .toList(),
      );

  List<CustomerRequest> get _upcomingRequests => _filter(
        requests
            .where((r) =>
                r.isSchedulable &&
                (r.status == 'accepted' || r.status == 'rescheduled'))
            .toList(),
      );

  List<CustomerRequest> get _historyRequests => _filter(
        requests
            .where((r) => _completedStatuses.contains(r.status))
            .toList(),
      );

  static const _completedStatuses = {
    'completed',
    'delivered',
    'declined',
    'cancelled_by_customer',
    'cancelled_by_business',
  };

  @override
  Widget build(BuildContext context) {
    final active = _activeRequests;
    final upcoming = _upcomingRequests;
    final history = _historyRequests;

    return Column(
      children: [
        if (showSearch)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              0,
            ),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'ابحث في طلباتك...',
                prefixIcon: const Icon(Icons.search, size: 20),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: context.colorScheme.outlineVariant),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: context.colorScheme.outlineVariant),
                ),
              ),
              onChanged: onSearchChanged,
            ),
          ),

        _OrdersTabBar(
          controller: tabController,
          activeCount: active.length,
          upcomingCount: upcoming.length,
          historyCount: history.length,
          subscriptionCount: subscriptionCount,
        ),

        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              RefreshIndicator(
                onRefresh: onRefresh,
                child: OrdersActiveTab(requests: active),
              ),
              RefreshIndicator(
                onRefresh: onRefresh,
                child: OrdersUpcomingTab(requests: upcoming),
              ),
              RefreshIndicator(
                onRefresh: onRefresh,
                child: OrdersHistoryTab(requests: history),
              ),
              const _SubscriptionsTabWrapper(),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------
// Tab Bar with count badges
// ---------------------------------------------------------------

class _OrdersTabBar extends StatelessWidget {
  final TabController controller;
  final int activeCount;
  final int upcomingCount;
  final int historyCount;
  final int subscriptionCount;

  const _OrdersTabBar({
    required this.controller,
    required this.activeCount,
    required this.upcomingCount,
    required this.historyCount,
    this.subscriptionCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: true,
      tabAlignment: TabAlignment.center,
      labelColor: AppColors.primary,
      unselectedLabelColor: context.colorScheme.onSurfaceVariant,
      indicatorColor: AppColors.primary,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: context.textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
      unselectedLabelStyle: context.textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: 13,
      ),
      tabs: [
        _TabWithBadge(label: 'نشطة', count: activeCount),
        _TabWithBadge(label: 'قادمة', count: upcomingCount),
        _TabWithBadge(label: 'السجل', count: historyCount),
        _TabWithBadge(label: 'اشتراكاتي', count: subscriptionCount),
      ],
    );
  }
}

class _TabWithBadge extends StatelessWidget {
  final String label;
  final int count;

  const _TabWithBadge({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          if (count > 0) ...[
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------
// Subscriptions Tab Wrapper
// ---------------------------------------------------------------

class _SubscriptionsTabWrapper extends ConsumerWidget {
  const _SubscriptionsTabWrapper();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subsAsync = ref.watch(mySubscriptionsProvider);

    return subsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => _ErrorState(
        onRetry: () => ref.invalidate(mySubscriptionsProvider),
      ),
      data: (subs) {
        final active = subs
            .where((s) =>
                s.status == SubscriptionStatus.active ||
                s.status == SubscriptionStatus.paused)
            .toList();
        final inactive = subs
            .where((s) =>
                s.status != SubscriptionStatus.active &&
                s.status != SubscriptionStatus.paused)
            .toList();

        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(mySubscriptionsProvider),
          child: SubscriptionsTab(active: active, inactive: inactive),
        );
      },
    );
  }
}

// ---------------------------------------------------------------
// Error State
// ---------------------------------------------------------------

class _ErrorState extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorState({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: context.colorScheme.outline,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'حدث خطأ أثناء تحميل الطلبات',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            btn.Button(
              onPressed: onRetry,
              label: 'إعادة المحاولة',
              icon: const btn.ButtonIcon(Icons.refresh),
              variant: btn.Variant.text,
            ),
          ],
        ),
      ),
    );
  }
}
