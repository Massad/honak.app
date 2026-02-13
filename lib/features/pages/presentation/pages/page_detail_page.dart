import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/queue/presentation/providers/queue_providers.dart';
import 'package:honak/features/business/queue/presentation/widgets/customer_queue_view.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/features/pages/presentation/providers/page_detail_providers.dart';
import 'package:honak/features/pages/presentation/widgets/header/header.dart';
import 'package:honak/features/pages/presentation/widgets/info/info.dart';
import 'package:honak/features/pages/presentation/widgets/page_skeleton.dart';
import 'package:honak/features/pages/presentation/widgets/page_tab_bar.dart';
import 'package:honak/features/pages/presentation/widgets/sections/sections.dart';
import 'package:honak/features/pages/presentation/widgets/shared/shared.dart';
import 'package:honak/features/pages/presentation/pages/claim_request_page.dart';
import 'package:honak/shared/widgets/coverage_banner.dart';
import 'package:honak/shared/widgets/error_view.dart';

class PageDetailPage extends ConsumerStatefulWidget {
  final String handle;

  const PageDetailPage({super.key, required this.handle});

  @override
  ConsumerState<PageDetailPage> createState() => _PageDetailPageState();
}

class _PageDetailPageState extends ConsumerState<PageDetailPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int? _lastTabCount;
  bool _isFollowing = false;
  int _selectedBranchIndex = 0;

  void _updateTabController(int tabCount) {
    if (_lastTabCount != tabCount) {
      _tabController?.dispose();
      _tabController = TabController(length: tabCount, vsync: this);
      _lastTabCount = tabCount;
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageAsync = ref.watch(pageDetailProvider(widget.handle));

    return Scaffold(
      body: pageAsync.when(
        loading: () => const PageDetailSkeleton(),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(pageDetailProvider(widget.handle)),
        ),
        data: (page) {
          if (!_isFollowing && page.isFollowing) {
            _isFollowing = page.isFollowing;
          }

          final archetype = page.archetype != null
              ? Archetype.fromKey(page.archetype!)
              : Archetype.followOnly;

          final isUnclaimed = page.claimStatus == 'unclaimed';
          final tabs = getPageTabs(archetype, isUnclaimed: isUnclaimed);
          _updateTabController(tabs.length);

          return _PageDetailContent(
            page: page,
            archetype: archetype,
            tabs: tabs,
            tabController: _tabController!,
            isFollowing: _isFollowing,
            selectedBranchIndex: _selectedBranchIndex,
            onFollowChanged: (level) {
              setState(() {
                _isFollowing = level != null;
              });
            },
            onBranchChanged: (index) {
              setState(() {
                _selectedBranchIndex = index;
              });
            },
          );
        },
      ),
    );
  }
}

/// Tab configuration per archetype — matches Figma PAGE_TABS logic.
/// Unclaimed pages only get main + info (no activity/directory).
List<({String id, String label})> getPageTabs(
  Archetype archetype, {
  bool isUnclaimed = false,
}) {
  final allTabs = switch (archetype) {
    Archetype.followOnly => [
        (id: 'activity', label: '\u0646\u0634\u0627\u0637'),
        (id: 'info', label: '\u0645\u0639\u0644\u0648\u0645\u0627\u062a'),
      ],
    Archetype.directory => [
        (id: 'main', label: '\u0646\u0638\u0631\u0629 \u0639\u0627\u0645\u0629'),
        (id: 'directory', label: '\u0627\u0644\u062f\u0644\u064a\u0644'),
        (id: 'activity', label: '\u0646\u0634\u0627\u0637'),
        (id: 'info', label: '\u0645\u0639\u0644\u0648\u0645\u0627\u062a'),
      ],
    Archetype.menuOrder => [
        (id: 'main', label: '\u0627\u0644\u0642\u0627\u0626\u0645\u0629'),
        (id: 'activity', label: '\u0646\u0634\u0627\u0637'),
        (id: 'info', label: '\u0645\u0639\u0644\u0648\u0645\u0627\u062a'),
      ],
    Archetype.catalogOrder => [
        (id: 'main', label: '\u0627\u0644\u0645\u0646\u062a\u062c\u0627\u062a'),
        (id: 'activity', label: '\u0646\u0634\u0627\u0637'),
        (id: 'info', label: '\u0645\u0639\u0644\u0648\u0645\u0627\u062a'),
      ],
    Archetype.serviceBooking => [
        (id: 'main', label: '\u0627\u0644\u062e\u062f\u0645\u0627\u062a'),
        (id: 'activity', label: '\u0646\u0634\u0627\u0637'),
        (id: 'info', label: '\u0645\u0639\u0644\u0648\u0645\u0627\u062a'),
      ],
    Archetype.portfolioInquiry => [
        (id: 'main', label: '\u0627\u0644\u0623\u0639\u0645\u0627\u0644'),
        (id: 'activity', label: '\u0646\u0634\u0627\u0637'),
        (id: 'info', label: '\u0645\u0639\u0644\u0648\u0645\u0627\u062a'),
      ],
    Archetype.reservation => [
        (id: 'main', label: '\u0627\u0644\u0623\u0645\u0627\u0643\u0646'),
        (id: 'activity', label: '\u0646\u0634\u0627\u0637'),
        (id: 'info', label: '\u0645\u0639\u0644\u0648\u0645\u0627\u062a'),
      ],
    Archetype.quoteRequest => [
        (id: 'main', label: '\u0646\u0638\u0631\u0629 \u0639\u0627\u0645\u0629'),
        (id: 'activity', label: '\u0646\u0634\u0627\u0637'),
        (id: 'info', label: '\u0645\u0639\u0644\u0648\u0645\u0627\u062a'),
      ],
  };

  if (isUnclaimed) {
    return allTabs.where((t) => t.id == 'main' || t.id == 'info').toList();
  }
  return allTabs;
}

class _PageDetailContent extends StatelessWidget {
  final PageDetail page;
  final Archetype archetype;
  final List<({String id, String label})> tabs;
  final TabController tabController;
  final bool isFollowing;
  final int selectedBranchIndex;
  final ValueChanged<FollowLevel?> onFollowChanged;
  final ValueChanged<int> onBranchChanged;

  const _PageDetailContent({
    required this.page,
    required this.archetype,
    required this.tabs,
    required this.tabController,
    required this.isFollowing,
    required this.selectedBranchIndex,
    required this.onFollowChanged,
    required this.onBranchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final hasMultipleBranches = page.branches.length >= 2;
    final hasCoverage = page.coverageZones.isNotEmpty ||
        page.coverageZonesStructured.isNotEmpty;
    final hasMiddleElements = hasMultipleBranches || hasCoverage;

    // Flatten coverage areas for banner
    final coverageAreas = hasCoverage
        ? [
            ...page.coverageZones,
            ...page.coverageZonesStructured
                .expand((z) => z.areas.map((a) => a.name)),
          ]
        : <String>[];

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        // 1. Cover image
        SliverToBoxAdapter(
          child: PageCover(
            coverUrl: page.coverUrl,
            onBack: () => Navigator.pop(context),
            onShare: () {},
          ),
        ),

        // 2. Branch selector (only if 2+ branches) — between cover and white section
        if (hasMultipleBranches)
          SliverToBoxAdapter(
            child: BranchSelector(
              branches: page.branches,
              selectedIndex: selectedBranchIndex,
              onBranchChanged: onBranchChanged,
            ),
          ),

        // 2b. Coverage banner — between branch selector and white section
        if (hasCoverage)
          SliverToBoxAdapter(
            child: CoverageBanner(coverageAreas: coverageAreas),
          ),

        // 3. White info section (avatar + name + badges + description +
        //    location + hours + trust metrics + status banner + action bar)
        SliverToBoxAdapter(
          child: PageInfoCard(
            page: page,
            archetype: archetype,
            hasMiddleElements: hasMiddleElements,
            isFollowing: isFollowing,
            onFollowChanged: onFollowChanged,
            onSearchType: (type) {
              final catSlug = page.exploreCategory ?? page.categoryId;
              if (catSlug != null) {
                context.push(
                  Routes.exploreCategoryPath(catSlug),
                  extra: {
                    'name': page.categoryName ?? type,
                    'selectedTypeId': page.businessTypeId,
                  },
                );
              } else {
                context.push(Routes.explore);
              }
            },
            onSearchCategory: (category) {
              final catSlug = page.exploreCategory ?? page.categoryId;
              if (catSlug != null) {
                context.push(
                  Routes.exploreCategoryPath(catSlug),
                  extra: {'name': category},
                );
              } else {
                context.push(Routes.explore);
              }
            },
            onClaimPage: page.claimStatus == 'unclaimed'
                ? () => _openClaimFlow(context)
                : null,
          ),
        ),

        // 4. Pinned tab bar
        SliverPersistentHeader(
          pinned: true,
          delegate: PageTabBarDelegate(
            tabController: tabController,
            tabs: tabs.map((t) => Tab(text: t.label)).toList(),
          ),
        ),
      ],
      body: TabBarView(
        controller: tabController,
        children: tabs
            .map((t) => Builder(
                  builder: (context) =>
                      _buildTabContent(context, t.id, page, archetype),
                ))
            .toList(),
      ),
    );
  }

  void _openClaimFlow(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ClaimRequestPage(page: page),
      ),
    );
  }

  Widget _buildTabContent(
    BuildContext context,
    String tabId,
    PageDetail page,
    Archetype archetype,
  ) {
    return switch (tabId) {
      'main' => _buildMainSection(context, page, archetype),
      'activity' => ActivityTab(
          pageId: page.id,
          pageSlug: page.slug,
          archetype: archetype,
          pinnedPosts: page.pinnedPosts,
        ),
      'info' => InfoTab(page: page),
      'directory' => DirectorySection(pageId: page.id),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildMainSection(
      BuildContext context, PageDetail page, Archetype archetype) {
    // Unclaimed pages show the auto-registered banner instead of content
    if (page.claimStatus == 'unclaimed') {
      return SectionEmptyState(
        page: page,
        archetype: archetype,
        onClaimPage: () => _openClaimFlow(context),
      );
    }

    return switch (archetype) {
      Archetype.catalogOrder =>
        CatalogSection(pageId: page.id, page: page),
      Archetype.menuOrder =>
        MenuSection(pageId: page.id, page: page),
      Archetype.serviceBooking => isQueueType(page.businessTypeId)
          ? _ServiceBookingWithQueue(page: page)
          : ServiceBookingSection(
              pageId: page.id,
              pageName: page.name,
              teamMembersCount: page.teamMembersCount,
            ),
      Archetype.quoteRequest =>
        QuoteRequestSection(pageId: page.id, page: page),
      Archetype.portfolioInquiry =>
        PortfolioSection(pageId: page.id, pageName: page.name),
      Archetype.reservation =>
        ReservationSection(pageId: page.id, page: page),
      Archetype.followOnly => FollowOnlySection(page: page),
      Archetype.directory => DirectorySection(pageId: page.id),
    };
  }
}

/// Wraps ServiceBookingSection with a CustomerQueueView for queue-based pages.
class _ServiceBookingWithQueue extends ConsumerWidget {
  final PageDetail page;

  const _ServiceBookingWithQueue({required this.page});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queueAsync = ref.watch(customerQueueDataProvider(page.id));

    return CustomScrollView(
      slivers: [
        // Queue view (loaded async)
        SliverToBoxAdapter(
          child: queueAsync.when(
            data: (data) => Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: CustomerQueueView(
                pageName: page.name,
                pageAvatar: page.avatarUrl,
                currentQueueSize: data.stats.waiting,
                estimatedWaitMin: data.stats.avgWaitMin,
                inProgressCount: data.stats.inProgress,
                packages: data.packages,
                subscriptions: data.subscriptions,
              ),
            ),
            loading: () => const Padding(
              padding: EdgeInsets.all(AppSpacing.xl),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ),
        // Standard service booking section below
        SliverToBoxAdapter(
          child: ServiceBookingSection(
            pageId: page.id,
            pageName: page.name,
            teamMembersCount: page.teamMembersCount,
          ),
        ),
      ],
    );
  }
}
