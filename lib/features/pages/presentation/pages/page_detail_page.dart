import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/dropoff/presentation/providers/dropoff_providers.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/customer_dropoff_view.dart';
import 'package:honak/features/business/queue/domain/entities/customer_queue_entry.dart';
import 'package:honak/features/business/queue/domain/entities/queue_add_on.dart';
import 'package:honak/features/business/queue/domain/entities/queue_source.dart';
import 'package:honak/features/business/queue/domain/entities/queue_status.dart';
import 'package:honak/features/business/queue/presentation/providers/customer_queue_providers.dart';
import 'package:honak/features/business/queue/presentation/providers/queue_providers.dart';
import 'package:honak/features/business/queue/presentation/widgets/customer/queue_or_schedule_sheet.dart';
import 'package:honak/features/business/queue/presentation/widgets/customer_queue_view.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/features/pages/presentation/providers/page_detail_providers.dart';
import 'package:honak/features/pages/presentation/widgets/header/header.dart';
import 'package:honak/features/pages/presentation/widgets/info/info.dart';
import 'package:honak/features/pages/presentation/widgets/page_skeleton.dart';
import 'package:honak/features/pages/presentation/widgets/page_tab_bar.dart';
import 'package:honak/features/pages/presentation/widgets/sections/sections.dart';
import 'package:honak/features/pages/presentation/widgets/sections/directory_tab.dart';
import 'package:honak/features/pages/presentation/widgets/sections/booking_wizard_sheet.dart';
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
    // Directory pages keep their directory tab even when unclaimed —
    // the tenant list is useful even without a manager.
    if (archetype == Archetype.directory) {
      return allTabs.where((t) => t.id != 'activity').toList();
    }
    return allTabs.where((t) => t.id == 'main' || t.id == 'info').toList();
  }
  return allTabs;
}

class _PageDetailContent extends StatefulWidget {
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
  State<_PageDetailContent> createState() => _PageDetailContentState();
}

class _PageDetailContentState extends State<_PageDetailContent> {
  @override
  Widget build(BuildContext context) {
    final page = widget.page;
    final archetype = widget.archetype;
    final showNearestBranch = page.branches.length >= 2;
    final hasCoverage = page.coverageZones.isNotEmpty ||
        page.coverageZonesStructured.isNotEmpty;
    final hasMiddleElements = showNearestBranch || hasCoverage;

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

        // 2. Nearest branch card (all archetypes with 2+ branches)
        if (showNearestBranch)
          SliverToBoxAdapter(
            child: NearestBranchCard(
              branches: page.branches,
              archetype: archetype,
              selectedBranchIndex: widget.selectedBranchIndex,
              onBranchChanged: widget.onBranchChanged,
              pageName: page.name,
            ),
          ),

        // 2b. Coverage banner
        if (hasCoverage)
          SliverToBoxAdapter(
            child: CoverageBanner(coverageAreas: coverageAreas),
          ),

        // 3. White info section
        SliverToBoxAdapter(
          child: PageInfoCard(
            page: page,
            archetype: archetype,
            hasMiddleElements: hasMiddleElements,
            isFollowing: widget.isFollowing,
            onFollowChanged: widget.onFollowChanged,
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
            tabController: widget.tabController,
            tabs: widget.tabs.map((t) => Tab(text: t.label)).toList(),
          ),
        ),
      ],
      // 5. Tab body — each tab gets its own scroll context
      body: TabBarView(
        controller: widget.tabController,
        children: widget.tabs.map((tab) {
          return _buildTabContent(context, tab.id, page, archetype);
        }).toList(),
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
      'info' => SingleChildScrollView(child: InfoTab(page: page)),
      'directory' => DirectoryTab(pageId: page.id, page: page),
      _ => const SizedBox.shrink(),
    };
  }

  void _openClaimFlow(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ClaimRequestPage(page: widget.page),
      ),
    );
  }

  Widget _buildMainSection(
      BuildContext context, PageDetail page, Archetype archetype) {
    if (page.claimStatus == 'unclaimed' && archetype != Archetype.directory) {
      return SingleChildScrollView(
        child: SectionEmptyState(
          page: page,
          archetype: archetype,
          onClaimPage: () => _openClaimFlow(context),
        ),
      );
    }

    return switch (archetype) {
      Archetype.catalogOrder =>
        CatalogSection(pageId: page.id, page: page),
      Archetype.menuOrder =>
        MenuSection(pageId: page.id, page: page),
      Archetype.serviceBooking => isQueueType(page.businessTypeId)
          ? _ServiceBookingWithQueue(page: page)
          : isDropoffType(page.businessTypeId)
              ? _ServiceBookingWithDropoff(page: page)
              : ServiceBookingSection(
                  pageId: page.id,
                  pageName: page.name,
                  teamMembersCount: page.teamMembersCount,
                  packages: page.packages,
                ),
      Archetype.quoteRequest =>
        QuoteRequestSection(pageId: page.id, page: page),
      Archetype.portfolioInquiry =>
        PortfolioSection(pageId: page.id, pageName: page.name),
      Archetype.reservation =>
        ReservationSection(pageId: page.id, page: page),
      Archetype.followOnly => FollowOnlySection(page: page),
      Archetype.directory => DirectorySection(pageId: page.id, page: page),
    };
  }
}

/// Wraps ServiceBookingSection with a CustomerDropoffView for dropoff-based pages.
class _ServiceBookingWithDropoff extends ConsumerWidget {
  final PageDetail page;

  const _ServiceBookingWithDropoff({required this.page});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dropoffAsync = ref.watch(customerDropoffDataProvider(page.id));

    return ServiceBookingSection(
      pageId: page.id,
      pageName: page.name,
      teamMembersCount: page.teamMembersCount,
      packages: page.packages,
      headerSlivers: [
        SliverToBoxAdapter(
          child: dropoffAsync.when(
            data: (data) => Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: CustomerDropoffView(
                tickets: data.tickets,
              ),
            ),
            loading: () => const Padding(
              padding: EdgeInsets.all(AppSpacing.xl),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}

/// Wraps ServiceBookingSection with a CustomerQueueView for queue-based pages.
///
/// Manages local queue entry state for demo. When the user taps "حجز" on a
/// service item, shows [QueueOrScheduleSheet] ("today / book later") instead
/// of the default [BookingWizardSheet]. Joining the queue creates a local
/// [CustomerQueueEntry] so the tracker renders immediately.
class _ServiceBookingWithQueue extends ConsumerStatefulWidget {
  final PageDetail page;

  const _ServiceBookingWithQueue({required this.page});

  @override
  ConsumerState<_ServiceBookingWithQueue> createState() =>
      _ServiceBookingWithQueueState();
}

class _ServiceBookingWithQueueState
    extends ConsumerState<_ServiceBookingWithQueue> {
  /// Local override — set when the user joins the queue in-session.
  CustomerQueueEntry? _demoEntry;

  /// Set to true after the post-queue banner is dismissed.
  bool _recentDismissed = false;

  @override
  Widget build(BuildContext context) {
    final queueAsync = ref.watch(customerQueueDataProvider(widget.page.id));
    final activeEntryAsync =
        ref.watch(customerActiveQueueProvider(widget.page.id));
    final recentEntryAsync =
        ref.watch(recentQueueEntryProvider(widget.page.id));

    return queueAsync.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.xl),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, __) => ServiceBookingSection(
        pageId: widget.page.id,
        pageName: widget.page.name,
        teamMembersCount: widget.page.teamMembersCount,
        packages: widget.page.packages,
      ),
      data: (data) {
        // Active entry: local demo override takes precedence over API result
        final activeEntry = _demoEntry ?? activeEntryAsync.valueOrNull;
        final recentEntry =
            _recentDismissed ? null : recentEntryAsync.valueOrNull;

        return ServiceBookingSection(
          pageId: widget.page.id,
          pageName: widget.page.name,
          teamMembersCount: widget.page.teamMembersCount,
          packages: widget.page.packages,
          onBookServiceOverride: (item) =>
              _handleBookService(context, item, data),
          headerSlivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: CustomerQueueView(
                  pageName: widget.page.name,
                  pageAvatar: widget.page.avatarUrl,
                  currentQueueSize: data.stats.waiting,
                  estimatedWaitMin: data.stats.avgWaitMin,
                  inProgressCount: data.stats.inProgress,
                  packages: data.packages,
                  availableAddOns: data.availableAddOns,
                  activeEntry: activeEntry,
                  recentEntry: recentEntry,
                  onCancelEntry: () => setState(() => _demoEntry = null),
                  onMarkOnMyWay: () {
                    if (_demoEntry != null) {
                      setState(() {
                        _demoEntry = _demoEntry!.copyWith(
                          onTheWay: true,
                          status: QueueStatus.onTheWay,
                        );
                      });
                    }
                  },
                  onRequestModification: (_) {
                    // Demo: show snackbar confirming modification request
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم إرسال طلب التعديل'),
                        ),
                      );
                    }
                  },
                  onRebook: () => setState(() => _recentDismissed = true),
                  onViewRequestDetail: () {
                    // TODO: navigate to request detail page
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Intercepts service booking for queue pages.
  ///
  /// Matches the tapped [item] to a [ServicePackage] by `nameAr`. If matched,
  /// shows [QueueOrScheduleSheet] ("today / book later"). If no match, falls
  /// back to the standard [BookingWizardSheet].
  void _handleBookService(
    BuildContext context,
    dynamic item,
    QueueData queueData,
  ) {
    // item is an Item from catalog/domain/entities/item.dart
    final itemName = item.nameAr as String;
    final itemId = item.id as String;
    final itemPriceCents = item.price.cents as int;

    // If there's already an active queue entry, block and show dialog
    final activeEntry = _demoEntry ??
        ref.read(customerActiveQueueProvider(widget.page.id)).valueOrNull;
    if (activeEntry != null) {
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('لديك حجز قائم'),
          content: const Text(
            'لديك حجز قائم بالدور. الغِ الحالي أولاً لحجز خدمة جديدة.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('حسناً'),
            ),
          ],
        ),
      );
      return;
    }

    // Match service → package by Arabic name
    final matchedPackage = queueData.packages
        .where((pkg) => pkg.nameAr == itemName)
        .firstOrNull;

    if (matchedPackage == null) {
      // No matching queue package — fall back to standard booking
      final durationMinutes = (item.sortOrder as int) > 0
          ? item.sortOrder as int
          : 30;
      BookingWizardSheet.show(
        context: context,
        pageName: widget.page.name,
        serviceId: itemId,
        serviceName: itemName,
        priceCents: itemPriceCents,
        durationMinutes: durationMinutes,
      );
      return;
    }

    showQueueOrScheduleSheet(
      context: context,
      queuePackage: matchedPackage,
      availableAddOns: queueData.availableAddOns,
      queueSize: queueData.stats.waiting,
      estimatedWaitMin: queueData.stats.avgWaitMin,
      isPaused: false,
      onJoinQueue: (packageId, addOnIds) {
        // Calculate total with add-ons
        var totalCents = matchedPackage.price;
        final resolvedAddOns = <QueueAddOn>[];
        if (addOnIds != null) {
          for (final id in addOnIds) {
            final addOn = queueData.availableAddOns
                .where((a) => a.id == id)
                .firstOrNull;
            if (addOn != null) {
              totalCents += addOn.priceCents;
              resolvedAddOns.add(
                QueueAddOn(name: addOn.nameAr, price: addOn.priceCents),
              );
            }
          }
        }

        // Create local demo entry (in production this would be an API call)
        final entry = CustomerQueueEntry(
          id: 'qe_demo_${DateTime.now().millisecondsSinceEpoch}',
          pageId: widget.page.id,
          pageName: widget.page.name,
          position: queueData.stats.waiting + 1,
          status: QueueStatus.waiting,
          source: QueueSource.appReserve,
          packageId: packageId,
          packageName: matchedPackage.nameAr,
          packagePriceCents: matchedPackage.price,
          addOns: resolvedAddOns,
          totalPriceCents: totalCents,
          estimatedDurationMin: matchedPackage.durationMin,
          aheadCount: queueData.stats.waiting,
          estimatedWaitMin: queueData.stats.avgWaitMin,
          checkedInAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        );
        setState(() => _demoEntry = entry);
      },
      onBookLater: () {
        // Standard booking wizard for scheduling
        final durationMinutes = (item.sortOrder as int) > 0
            ? item.sortOrder as int
            : matchedPackage.durationMin;
        BookingWizardSheet.show(
          context: context,
          pageName: widget.page.name,
          serviceId: itemId,
          serviceName: itemName,
          priceCents: itemPriceCents,
          durationMinutes: durationMinutes,
        );
      },
    );
  }
}
