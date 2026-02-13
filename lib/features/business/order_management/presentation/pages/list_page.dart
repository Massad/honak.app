import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/config/business_type_config.dart';
import 'package:honak/features/business/order_management/presentation/providers/provider.dart';
import 'package:honak/features/business/order_management/presentation/providers/truck_provider.dart';
import 'package:honak/features/business/order_management/presentation/widgets/request_card.dart';
import 'package:honak/features/business/order_management/presentation/widgets/truck_detail_overlay.dart';
import 'package:honak/features/business/order_management/presentation/widgets/truck_status_cards.dart';
import 'package:honak/features/business/dropoff/presentation/providers/dropoff_providers.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/dropoff_board.dart';
import 'package:honak/features/business/queue/domain/entities/queue_entry.dart';
import 'package:honak/features/business/queue/presentation/providers/queue_providers.dart';
import 'package:honak/features/business/queue/presentation/widgets/queue_board.dart';
import 'package:honak/features/business/queue/presentation/widgets/queue_quick_add.dart';
import 'package:honak/features/business/shared/domain/entities/entities.dart';
import 'package:honak/shared/providers/business_page_provider.dart';

class BusinessRequestsPage extends ConsumerStatefulWidget {
  const BusinessRequestsPage({super.key});

  @override
  ConsumerState<BusinessRequestsPage> createState() =>
      _BusinessRequestsPageState();
}

class _BusinessRequestsPageState extends ConsumerState<BusinessRequestsPage> {
  int _activeFilter = 0;

  @override
  Widget build(BuildContext context) {
    final bizContext = ref.watch(businessContextProvider);
    if (bizContext == null) return const SizedBox.shrink();

    // Dropoff-based businesses get the DropoffBoard
    if (isDropoffType(bizContext.config?.id)) {
      return _DropoffBoardWrapper(pageId: bizContext.page.id);
    }

    // Queue-based businesses get the QueueBoard instead of the standard list
    if (isQueueType(bizContext.config?.id)) {
      return _QueueBoardWrapper(pageId: bizContext.page.id);
    }

    final hasDeliveryZones =
        bizContext.config?.features.contains('delivery_zones') ?? false;
    final labels = bizContext.config?.orderLabels;

    final statusFilters = [
      _FilterDef(
        label: labels?.incoming ?? 'طلبات جديدة',
        status: 'pending',
      ),
      _FilterDef(
        label: labels?.accepted ?? 'طلبات مقبولة',
        status: 'accepted',
      ),
      _FilterDef(
        label: 'قيد التنفيذ',
        status: 'in_progress',
      ),
      _FilterDef(
        label: labels?.completed ?? 'طلبات مكتملة',
        status: 'completed',
      ),
    ];

    final currentFilter = statusFilters[_activeFilter];
    final requestsAsync = ref.watch(
      bizRequestsProvider((
        pageId: bizContext.page.id,
        status: currentFilter.status,
      )),
    );

    return Column(
      children: [
        // Header with title
        _Header(
          title: 'إدارة الطلبات',
          approvalMode: bizContext.config?.defaultOrderApproval,
        ),

        // Filter pill tabs
        _FilterBar(
          filters: statusFilters,
          activeIndex: _activeFilter,
          counts: _buildFilterCounts(bizContext.page.id),
          onTap: (i) => setState(() => _activeFilter = i),
        ),

        // Truck status section (only for delivery businesses)
        if (hasDeliveryZones)
          _TruckSection(pageSlug: bizContext.page.slug),

        // Request list
        Expanded(
          child: Container(
            color: const Color(0xFFF5F5F5),
            child: requestsAsync.when(
              data: (requests) {
                if (requests.isEmpty) {
                  return _EmptyRequestState(
                    label: currentFilter.label,
                  );
                }
                return _RequestList(
                  requests: requests,
                  onInvalidate: () =>
                      _invalidateRequests(bizContext.page.id),
                );
              },
              loading: () => const _RequestListSkeleton(),
              error: (error, _) => _ErrorState(
                message: error.toString(),
                onRetry: () => _invalidateRequests(bizContext.page.id),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Map<int, AsyncValue<int>> _buildFilterCounts(String pageId) {
    final pendingAsync = ref.watch(
      bizRequestsProvider((pageId: pageId, status: 'pending')),
    );
    final acceptedAsync = ref.watch(
      bizRequestsProvider((pageId: pageId, status: 'accepted')),
    );
    final inProgressAsync = ref.watch(
      bizRequestsProvider((pageId: pageId, status: 'in_progress')),
    );
    final completedAsync = ref.watch(
      bizRequestsProvider((pageId: pageId, status: 'completed')),
    );

    return {
      0: pendingAsync.whenData((list) => list.length),
      1: acceptedAsync.whenData((list) => list.length),
      2: inProgressAsync.whenData((list) => list.length),
      3: completedAsync.whenData((list) => list.length),
    };
  }

  void _invalidateRequests(String pageId) {
    for (final status in ['pending', 'accepted', 'in_progress', 'completed', null]) {
      ref.invalidate(bizRequestsProvider((pageId: pageId, status: status)));
    }
  }
}

// ═══════════════════════════════════════════════════════════════
// Header — title + approval badge
// ═══════════════════════════════════════════════════════════════

class _Header extends StatelessWidget {
  final String title;
  final OrderApprovalMode? approvalMode;

  const _Header({required this.title, this.approvalMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          if (approvalMode != null) _ApprovalBadge(mode: approvalMode!),
        ],
      ),
    );
  }
}

class _ApprovalBadge extends StatelessWidget {
  final OrderApprovalMode mode;

  const _ApprovalBadge({required this.mode});

  @override
  Widget build(BuildContext context) {
    final isAuto = mode == OrderApprovalMode.auto;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isAuto
            ? const Color(0xFFE8F5E9)
            : const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isAuto
              ? const Color(0xFFC8E6C9)
              : const Color(0xFFFFE0B2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isAuto ? Icons.bolt : Icons.assignment_outlined,
            size: 10,
            color: isAuto
                ? const Color(0xFF43A047)
                : const Color(0xFFFF9800),
          ),
          const SizedBox(width: 3),
          Text(
            isAuto ? 'قبول تلقائي' : 'قبول يدوي',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: isAuto
                  ? const Color(0xFF43A047)
                  : const Color(0xFFFF9800),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Filter bar — horizontal scrollable pills
// ═══════════════════════════════════════════════════════════════

class _FilterBar extends StatelessWidget {
  final List<_FilterDef> filters;
  final int activeIndex;
  final Map<int, AsyncValue<int>> counts;
  final ValueChanged<int> onTap;

  const _FilterBar({
    required this.filters,
    required this.activeIndex,
    required this.counts,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.xs,
        AppSpacing.sm,
        AppSpacing.md,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(filters.length, (i) {
            final f = filters[i];
            final isActive = i == activeIndex;
            final countAsync = counts[i];
            final countText =
                countAsync?.whenOrNull(data: (c) => '$c') ?? '-';

            return Padding(
              padding: EdgeInsetsDirectional.only(
                end: AppSpacing.sm,
              ),
              child: GestureDetector(
                onTap: () => onTap(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: isActive
                        ? null
                        : Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        f.label,
                        style: TextStyle(
                          fontSize: 12,
                          color: isActive
                              ? Colors.white
                              : Colors.grey.shade600,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? Colors.white.withValues(alpha: 0.2)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          countText,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: isActive
                                ? Colors.white
                                : Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Truck section — header + truck status cards
// ═══════════════════════════════════════════════════════════════

class _TruckSection extends ConsumerWidget {
  final String pageSlug;

  const _TruckSection({required this.pageSlug});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trucksAsync = ref.watch(truckDeliveryDataProvider(pageSlug));

    return trucksAsync.when(
      data: (data) {
        if (data == null || data.trucks.isEmpty) return const SizedBox.shrink();
        final summary = ref.watch(truckSummaryProvider(pageSlug));
        return Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(height: 0.5, thickness: 0.5),
              const SizedBox(height: AppSpacing.sm),
              // Truck cards (includes its own header row)
              TruckStatusCards(
                trucks: data.trucks,
                activeCount: summary.activeTrucks,
                totalDelivered: summary.totalDelivered,
                totalRemaining: summary.totalRemaining,
                onSelectTruck: (truck) {
                  showTruckDetailOverlay(context, truck, pageSlug);
                },
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) {
        debugPrint('TruckSection error: $error\n$stack');
        return const SizedBox.shrink();
      },
    );
  }
}



// ═══════════════════════════════════════════════════════════════
// Request list with pull-to-refresh
// ═══════════════════════════════════════════════════════════════

class _RequestList extends StatelessWidget {
  final List<BizRequest> requests;
  final VoidCallback onInvalidate;

  const _RequestList({
    required this.requests,
    required this.onInvalidate,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => onInvalidate(),
      child: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: requests.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, i) => RequestCard(
          request: requests[i],
          onInvalidate: onInvalidate,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Skeleton shimmer loading
// ═══════════════════════════════════════════════════════════════

class _RequestListSkeleton extends StatelessWidget {
  const _RequestListSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.lg),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (_, __) => const _RequestCardSkeleton(),
    );
  }
}

class _RequestCardSkeleton extends StatelessWidget {
  const _RequestCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _shimmerBox(width: 40, height: 18),
                    const SizedBox(height: 4),
                    _shimmerBox(width: 60, height: 12),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _shimmerBox(width: 80, height: 16),
                    const SizedBox(height: 4),
                    _shimmerBox(width: 50, height: 12),
                  ],
                ),
                const SizedBox(width: AppSpacing.md),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.shimmerBase,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(14),
              ),
            ),
            child: Row(
              children: [
                _shimmerBox(width: 55, height: 24),
                const SizedBox(width: AppSpacing.sm),
                _shimmerBox(width: 45, height: 24),
                const Spacer(),
                _shimmerBox(width: 60, height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _shimmerBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.shimmerBase,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Empty state
// ═══════════════════════════════════════════════════════════════

class _EmptyRequestState extends StatelessWidget {
  final String label;

  const _EmptyRequestState({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.inbox_outlined,
                size: 28,
                color: Colors.grey.shade300,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'لا توجد $label',
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'ستظهر الطلبات هنا عند وصولها',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Error state
// ═══════════════════════════════════════════════════════════════

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'حدث خطأ في تحميل الطلبات',
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Dropoff board wrapper — loads data and renders DropoffBoard
// ═══════════════════════════════════════════════════════════════

class _DropoffBoardWrapper extends ConsumerWidget {
  final String pageId;

  const _DropoffBoardWrapper({required this.pageId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dropoffAsync = ref.watch(dropoffDataProvider(pageId));

    return dropoffAsync.when(
      data: (data) => DropoffBoard(
        initialTickets: data.tickets,
        stats: data.stats,
        serviceCategories: data.serviceCategories,
        attributes: data.attributes,
        itemTypes: data.itemTypes,
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => _ErrorState(
        message: error.toString(),
        onRetry: () => ref.invalidate(dropoffDataProvider(pageId)),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Queue board wrapper — loads data and renders QueueBoard with onAdd
// ═══════════════════════════════════════════════════════════════

class _QueueBoardWrapper extends ConsumerStatefulWidget {
  final String pageId;

  const _QueueBoardWrapper({required this.pageId});

  @override
  ConsumerState<_QueueBoardWrapper> createState() =>
      _QueueBoardWrapperState();
}

class _QueueBoardWrapperState extends ConsumerState<_QueueBoardWrapper> {
  late List<QueueEntry> _entries;
  QueueData? _data;

  @override
  Widget build(BuildContext context) {
    final queueAsync = ref.watch(queueDataProvider(widget.pageId));

    return queueAsync.when(
      data: (data) {
        // Initialise entries on first load or when the provider refreshes
        if (_data == null || !identical(_data, data)) {
          _data = data;
          _entries = List.of(data.entries);
        }

        return QueueBoard(
          key: ValueKey(_entries.length),
          initialQueue: _entries,
          stats: data.stats,
          onAdd: () async {
            final entry = await showQueueQuickAdd(
              context,
              packages: data.packages,
            );
            if (entry != null) {
              setState(() {
                _entries = [..._entries, entry];
              });
            }
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => _ErrorState(
        message: error.toString(),
        onRetry: () => ref.invalidate(queueDataProvider(widget.pageId)),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Filter definition
// ═══════════════════════════════════════════════════════════════

class _FilterDef {
  final String label;
  final String? status;

  const _FilterDef({
    required this.label,
    required this.status,
  });
}
