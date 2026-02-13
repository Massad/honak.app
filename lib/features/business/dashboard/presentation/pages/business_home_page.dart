import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/features/business/dashboard/presentation/pages/business_dashboard_page.dart';
import 'package:honak/features/business/dashboard/presentation/widgets/content_tab.dart';
import 'package:honak/shared/providers/business_page_provider.dart';
import 'package:honak/features/business/catalog_management/presentation/pages/manage_page.dart';
import 'package:honak/shared/widgets/empty_state.dart';

/// Business Home screen with horizontal sub-tabs.
/// Matches Figma BusinessHome.tsx: Dashboard | Manage | Content | Customers.
/// Reduced archetypes (followOnly, directory) hide Manage + Customers.
class BusinessHomePage extends ConsumerStatefulWidget {
  const BusinessHomePage({super.key});

  @override
  ConsumerState<BusinessHomePage> createState() => _BusinessHomePageState();
}

class _BusinessHomePageState extends ConsumerState<BusinessHomePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<_HomeTab> _tabs = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 0, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _rebuildTabs(BusinessContext? bizContext) {
    final newTabs = _buildTabList(bizContext);
    if (newTabs.length != _tabs.length ||
        !_tabsMatch(newTabs, _tabs)) {
      _tabs = newTabs;
      final oldIndex = _tabController.index;
      _tabController.dispose();
      _tabController = TabController(length: _tabs.length, vsync: this);
      if (oldIndex < _tabs.length) {
        _tabController.index = oldIndex;
      }
    }
  }

  bool _tabsMatch(List<_HomeTab> a, List<_HomeTab> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i].id != b[i].id) return false;
    }
    return true;
  }

  List<_HomeTab> _buildTabList(BusinessContext? bizContext) {
    if (bizContext == null) return [];

    final archetype = bizContext.archetype;
    final isReduced = archetype == Archetype.followOnly ||
        archetype == Archetype.directory;

    final tabs = <_HomeTab>[
      _HomeTab(
        id: 'dashboard',
        icon: Icons.dashboard_outlined,
        label: context.l10n.bizTabDashboard,
      ),
    ];

    if (!isReduced) {
      tabs.add(_HomeTab(
        id: 'manage',
        icon: Icons.inventory_2_outlined,
        label: context.l10n.bizTabManage,
      ));
    }

    tabs.add(_HomeTab(
      id: 'content',
      icon: Icons.circle_outlined,
      label: context.l10n.bizTabContent,
    ));

    if (!isReduced) {
      tabs.add(_HomeTab(
        id: 'customers',
        icon: Icons.people_outlined,
        label: context.l10n.bizTabCustomers,
      ));
    }

    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    final bizContext = ref.watch(businessContextProvider);
    _rebuildTabs(bizContext);

    if (_tabs.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        // ── Horizontal sub-tab bar ──
        Container(
          color: context.colorScheme.surface,
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.grey.shade400,
            indicatorColor: AppColors.primary,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
            tabs: _tabs.map((tab) => Tab(
              height: 40,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(tab.icon, size: 14),
                  const SizedBox(width: 6),
                  Text(tab.label),
                ],
              ),
            )).toList(),
          ),
        ),

        // ── Tab content ──
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _tabs.map((tab) => _buildTabContent(tab.id)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTabContent(String tabId) {
    return switch (tabId) {
      'dashboard' => const BusinessDashboardPage(),
      'manage' => const BusinessManagePage(),
      'content' => const ContentTab(),
      'customers' => EmptyState(
          icon: Icons.people_outlined,
          title: context.l10n.contentCustomersComingSoon,
          subtitle: '',
        ),
      _ => const SizedBox.shrink(),
    };
  }
}

class _HomeTab {
  final String id;
  final IconData icon;
  final String label;

  const _HomeTab({
    required this.id,
    required this.icon,
    required this.label,
  });
}
