import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/features/business/dashboard/presentation/pages/business_home_page.dart';
import 'package:honak/features/business/insights/presentation/pages/insights_page.dart';
import 'package:honak/features/business/order_management/presentation/pages/list_page.dart';
import 'package:honak/features/business/page_settings/presentation/pages/settings_page.dart';
import 'package:honak/features/business/shared/widgets/business_app_bar.dart';
import 'package:honak/features/chat/presentation/pages/business_chat_list_page.dart';
import 'package:honak/features/chat/presentation/providers/chat_provider.dart';
import 'package:honak/shared/providers/app_mode_provider.dart';
import 'package:honak/shared/providers/business_page_provider.dart';

// Business bottom navigation matching Figma MVP:
//
// Full archetypes (5 tabs):
//   Home (الرئيسية) | Insights (إحصائيات) | Orders [center] (الطلبات) | Chat (المحادثات) | Account (الصفحة)
//
// follow_only / directory (3 tabs):
//   Home (الرئيسية) | Insights (إحصائيات) | Account (الصفحة)

class BusinessShell extends ConsumerStatefulWidget {
  final Widget customerShell;

  const BusinessShell({super.key, required this.customerShell});

  @override
  ConsumerState<BusinessShell> createState() => _BusinessShellState();
}

class _BusinessShellState extends ConsumerState<BusinessShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bizPageAsync = ref.watch(currentBusinessPageProvider);
    final bizContext = ref.watch(businessContextProvider);

    // Still loading the page selection — show brief spinner
    if (bizPageAsync.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Loaded but no valid context — fall back to customer mode
    if (bizContext == null) {
      Future.microtask(() {
        ref.read(appModeProvider.notifier).switchToCustomerMode();
      });
      return widget.customerShell;
    }

    final isReducedNav = _isReducedArchetype(bizContext.archetype);
    final tabs = isReducedNav
        ? _buildReducedTabs()
        : _buildFullTabs(bizContext);
    final pages = isReducedNav
        ? _buildReducedPages()
        : _buildFullPages();

    if (_currentIndex >= tabs.length) {
      _currentIndex = 0;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const BusinessAppBar(),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: _BusinessBottomNav(
        tabs: tabs,
        currentIndex: _currentIndex,
        onTabChanged: (i) => setState(() => _currentIndex = i),
        chatBadge: isReducedNav ? 0 : ref.watch(unreadChatCountProvider),
      ),
    );
  }

  bool _isReducedArchetype(Archetype archetype) =>
      archetype == Archetype.followOnly || archetype == Archetype.directory;

  // ──────────────────────────────────────────────────────
  // Full navigation (5 tabs)
  // ──────────────────────────────────────────────────────

  List<_TabDef> _buildFullTabs(BusinessContext ctx) {
    return [
      const _TabDef(
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
        label: 'الرئيسية',
      ),
      const _TabDef(
        icon: Icons.bar_chart_outlined,
        selectedIcon: Icons.bar_chart,
        label: 'إحصائيات',
      ),
      _TabDef(
        icon: Icons.shopping_bag_outlined,
        selectedIcon: Icons.shopping_bag,
        label: ctx.requestsTabLabel,
        isCenter: true,
      ),
      const _TabDef(
        icon: Icons.chat_outlined,
        selectedIcon: Icons.chat,
        label: 'المحادثات',
      ),
      const _TabDef(
        icon: Icons.settings_outlined,
        selectedIcon: Icons.settings,
        label: 'الصفحة',
      ),
    ];
  }

  List<Widget> _buildFullPages() {
    return const [
      BusinessHomePage(),
      BusinessInsightsPage(),
      BusinessRequestsPage(),
      BusinessChatListPage(),
      BusinessSettingsPage(),
    ];
  }

  // ──────────────────────────────────────────────────────
  // Reduced navigation for follow_only / directory (3 tabs)
  // ──────────────────────────────────────────────────────

  List<_TabDef> _buildReducedTabs() {
    return const [
      _TabDef(
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
        label: 'الرئيسية',
      ),
      _TabDef(
        icon: Icons.bar_chart_outlined,
        selectedIcon: Icons.bar_chart,
        label: 'إحصائيات',
      ),
      _TabDef(
        icon: Icons.settings_outlined,
        selectedIcon: Icons.settings,
        label: 'الصفحة',
      ),
    ];
  }

  List<Widget> _buildReducedPages() {
    return const [
      BusinessHomePage(),
      BusinessInsightsPage(),
      BusinessSettingsPage(),
    ];
  }
}

// ═══════════════════════════════════════════════════════════════
// Tab definition
// ═══════════════════════════════════════════════════════════════

class _TabDef {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isCenter;

  const _TabDef({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    this.isCenter = false,
  });
}

// ═══════════════════════════════════════════════════════════════
// Bottom navigation bar — Figma-matching layout
// Center button (Orders) is raised orange circle
// Chat button supports unread badge
// ═══════════════════════════════════════════════════════════════

class _BusinessBottomNav extends StatelessWidget {
  final List<_TabDef> tabs;
  final int currentIndex;
  final ValueChanged<int> onTabChanged;
  final int chatBadge;

  const _BusinessBottomNav({
    required this.tabs,
    required this.currentIndex,
    required this.onTabChanged,
    required this.chatBadge,
  });

  int? get _centerIndex {
    for (var i = 0; i < tabs.length; i++) {
      if (tabs[i].isCenter) return i;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final centerIdx = _centerIndex;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 56,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Regular row of nav items (center slot is a transparent placeholder)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(tabs.length, (i) {
                  final tab = tabs[i];
                  final isSelected = i == currentIndex;

                  if (tab.isCenter) {
                    // Invisible placeholder to keep spacing
                    return GestureDetector(
                      onTap: () => onTabChanged(i),
                      behavior: HitTestBehavior.opaque,
                      child: const SizedBox(width: 64, height: 56),
                    );
                  }

                  final showBadge =
                      tab.label == 'المحادثات' && chatBadge > 0;

                  return _BottomNavItem(
                    icon: tab.icon,
                    selectedIcon: tab.selectedIcon,
                    label: tab.label,
                    isSelected: isSelected,
                    badge: showBadge ? chatBadge : 0,
                    onTap: () => onTabChanged(i),
                  );
                }),
              ),

              // Raised center button — positioned above the row
              if (centerIdx != null)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: _CenterNavButton(
                      icon: tabs[centerIdx].icon,
                      selectedIcon: tabs[centerIdx].selectedIcon,
                      label: tabs[centerIdx].label,
                      isSelected: centerIdx == currentIndex,
                      onTap: () => onTabChanged(centerIdx),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Center (Orders) button — raised orange circle
// ═══════════════════════════════════════════════════════════════

const _centerOrange = Color(0xFFFF9800);

class _CenterNavButton extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CenterNavButton({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

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
            // Raised orange circle
            Transform.translate(
              offset: const Offset(0, -10),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _centerOrange,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: _centerOrange.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  isSelected ? selectedIcon : icon,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -8),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? _centerOrange : Colors.grey.shade500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Regular bottom nav item — with optional badge
// ═══════════════════════════════════════════════════════════════

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final int badge;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    this.badge = 0,
    required this.onTap,
  });

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
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isSelected ? selectedIcon : icon,
                    size: 22,
                    color:
                        isSelected ? AppColors.primary : Colors.grey.shade400,
                  ),
                ),
                if (badge > 0)
                  PositionedDirectional(
                    top: -2,
                    end: 4,
                    child: Container(
                      constraints: const BoxConstraints(minWidth: 18),
                      height: 18,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          badge > 99 ? '+99' : '$badge',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.normal,
                color:
                    isSelected ? AppColors.primary : Colors.grey.shade500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
