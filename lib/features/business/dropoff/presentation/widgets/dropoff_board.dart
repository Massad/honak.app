import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_stats.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_status.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_ticket.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/dropoff_detail_view.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/dropoff_entry_card.dart';

/// Main tracking board view for dropoff-type businesses.
///
/// Copies [initialTickets] from provider into local state.
/// Supports status filtering, overdue alerts, search toggle,
/// collapsible delivered section, and ticket detail view.
class DropoffBoard extends StatefulWidget {
  const DropoffBoard({
    super.key,
    required this.initialTickets,
    required this.stats,
    this.onAdd,
  });

  final List<DropoffTicket> initialTickets;
  final DropoffDayStats stats;
  final VoidCallback? onAdd;

  @override
  State<DropoffBoard> createState() => _DropoffBoardState();
}

class _DropoffBoardState extends State<DropoffBoard> {
  late List<DropoffTicket> _tickets;
  DropoffStatus? _activeFilter;
  bool _showDelivered = false;
  bool _searchActive = false;

  @override
  void initState() {
    super.initState();
    _tickets = List.of(widget.initialTickets);
  }

  // ── Grouped tickets ──

  List<DropoffTicket> get _received =>
      _tickets.where((t) => t.status == DropoffStatus.received).toList();

  List<DropoffTicket> get _processing =>
      _tickets.where((t) => t.status == DropoffStatus.processing).toList();

  List<DropoffTicket> get _ready =>
      _tickets.where((t) => t.status == DropoffStatus.ready).toList();

  List<DropoffTicket> get _delivered =>
      _tickets.where((t) => t.status == DropoffStatus.delivered).toList();

  List<DropoffTicket> get _active =>
      _tickets.where((t) => t.status != DropoffStatus.delivered &&
          t.status != DropoffStatus.cancelled).toList();

  int get _overdueCount => _active.where((t) {
    final ready = DateTime.tryParse(t.estimatedReadyAt);
    if (ready == null) return false;
    return DateTime.now().isAfter(ready);
  }).length;

  List<DropoffTicket> get _filteredTickets {
    if (_activeFilter == null) {
      return _tickets.where((t) =>
          t.status != DropoffStatus.delivered &&
          t.status != DropoffStatus.cancelled).toList();
    }
    return _tickets.where((t) => t.status == _activeFilter).toList();
  }

  // ── Status transitions ──

  void _advanceStatus(String ticketId) {
    setState(() {
      _tickets = _tickets.map((t) {
        if (t.id != ticketId) return t;
        final now = DateTime.now().toIso8601String();
        return switch (t.status) {
          DropoffStatus.received =>
            t.copyWith(status: DropoffStatus.processing, startedAt: now),
          DropoffStatus.processing =>
            t.copyWith(status: DropoffStatus.ready, completedAt: now),
          DropoffStatus.ready =>
            t.copyWith(status: DropoffStatus.delivered, pickedUpAt: now),
          _ => t,
        };
      }).toList();
    });
    _showToast('تم تحديث الحالة');
  }

  void _showToast(String message) {
    if (!mounted) return;
    context.showSnackBar(message);
  }

  /// Adds a new ticket (called from DropoffQuickAdd).
  void addTicket(DropoffTicket ticket) {
    setState(() {
      _tickets = [..._tickets, ticket];
    });
    _showToast('تم إنشاء التذكرة');
  }

  void _openDetail(DropoffTicket ticket) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DropoffDetailView(
        ticket: ticket,
        onAdvance: (id) {
          _advanceStatus(id);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredTickets;
    final overdueCount = _overdueCount;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── Sticky header ──
          SliverPersistentHeader(
            pinned: true,
            delegate: _DropoffHeaderDelegate(
              activeCount: _active.length,
              overdueCount: overdueCount,
              searchActive: _searchActive,
              onToggleSearch: () =>
                  setState(() => _searchActive = !_searchActive),
              onAdd: widget.onAdd,
            ),
          ),

          SliverPadding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.lg,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: AppSpacing.md),

                // ── Status filter pills ──
                _buildFilterRow(context),
                const SizedBox(height: AppSpacing.md),

                // ── Overdue alert ──
                if (overdueCount > 0) ...[
                  _OverdueAlert(count: overdueCount),
                  const SizedBox(height: AppSpacing.md),
                ],

                // ── Ticket list ──
                if (filtered.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      borderRadius: AppRadius.cardInner,
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Center(
                      child: Text(
                        'لا توجد تذاكر',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade300,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                else
                  ...filtered.map((ticket) => Padding(
                    padding: const EdgeInsetsDirectional.only(
                      bottom: AppSpacing.sm,
                    ),
                    child: DropoffEntryCard(
                      ticket: ticket,
                      onAdvance: () => _advanceStatus(ticket.id),
                      onTap: () => _openDetail(ticket),
                    ),
                  )),

                // ── Delivered section (collapsible) ──
                const SizedBox(height: AppSpacing.lg),
                _DeliveredSection(
                  tickets: _delivered,
                  isExpanded: _showDelivered,
                  onToggle: () =>
                      setState(() => _showDelivered = !_showDelivered),
                ),

                const SizedBox(height: AppSpacing.lg),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow(BuildContext context) {
    final filters = <(DropoffStatus?, String, int)>[
      (null, 'الكل', _active.length),
      (DropoffStatus.received, 'مستلمة', _received.length),
      (DropoffStatus.processing, 'قيد المعالجة', _processing.length),
      (DropoffStatus.ready, 'جاهزة', _ready.length),
      (DropoffStatus.delivered, 'تم التسليم', _delivered.length),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((f) {
          final isActive = _activeFilter == f.$1;
          final color = f.$1 != null ? _statusColor(f.$1!) : AppColors.primary;

          return Padding(
            padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
            child: GestureDetector(
              onTap: () => setState(() => _activeFilter = f.$1),
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? color.withValues(alpha: 0.1)
                      : Colors.grey.shade100,
                  borderRadius: AppRadius.pill,
                  border: isActive ? Border.all(color: color) : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      f.$2,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: isActive ? color : Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      '${f.$3}',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: isActive ? color : Colors.grey.shade400,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Color _statusColor(DropoffStatus status) => switch (status) {
        DropoffStatus.received => AppColors.secondary,
        DropoffStatus.processing => AppColors.primary,
        DropoffStatus.ready => AppColors.success,
        DropoffStatus.delivered => const Color(0xFF616161),
        DropoffStatus.cancelled => AppColors.error,
      };
}

// ═══════════════════════════════════════════════════════════════
// Sticky Header Delegate
// ═══════════════════════════════════════════════════════════════

class _DropoffHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _DropoffHeaderDelegate({
    required this.activeCount,
    required this.overdueCount,
    required this.searchActive,
    required this.onToggleSearch,
    this.onAdd,
  });

  final int activeCount;
  final int overdueCount;
  final bool searchActive;
  final VoidCallback onToggleSearch;
  final VoidCallback? onAdd;

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant _DropoffHeaderDelegate oldDelegate) =>
      activeCount != oldDelegate.activeCount ||
      overdueCount != oldDelegate.overdueCount ||
      searchActive != oldDelegate.searchActive;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          Text(
            'لوحة التتبع',
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          // Active count badge
          Container(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 6,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: AppRadius.pill,
            ),
            child: Text(
              '$activeCount',
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.primary,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Overdue alert
          if (overdueCount > 0) ...[
            const SizedBox(width: AppSpacing.xs),
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: AppRadius.pill,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 10,
                    color: AppColors.error,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '$overdueCount',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: AppColors.error,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],

          const Spacer(),

          // Search toggle
          GestureDetector(
            onTap: onToggleSearch,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: searchActive
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_rounded,
                size: 18,
                color: searchActive ? AppColors.primary : Colors.grey.shade500,
              ),
            ),
          ),

          // Add button
          if (onAdd != null) ...[
            const SizedBox(width: AppSpacing.sm),
            GestureDetector(
              onTap: onAdd,
              child: Container(
                height: 36,
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.md,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: AppRadius.pill,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add, size: 16, color: Colors.white),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      'استلام جديد',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Overdue Alert Banner
// ═══════════════════════════════════════════════════════════════

class _OverdueAlert extends StatelessWidget {
  const _OverdueAlert({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        border: Border.all(color: const Color(0xFFFEE2E2)),
        borderRadius: AppRadius.cardInner,
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, size: 18, color: AppColors.error),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$count تذاكر متأخرة',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.error,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  'تجاوزت الموعد المتوقع للتجهيز',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: const Color(0xFFEF5350),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Delivered Section (collapsible)
// ═══════════════════════════════════════════════════════════════

class _DeliveredSection extends StatelessWidget {
  const _DeliveredSection({
    required this.tickets,
    required this.isExpanded,
    required this.onToggle,
  });

  final List<DropoffTicket> tickets;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onToggle,
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 14,
                color: Colors.grey.shade400,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'تم التسليم (${tickets.length})',
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade400,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Divider(color: Colors.grey.shade100, height: 1),
              ),
            ],
          ),
        ),
        if (isExpanded) ...[
          const SizedBox(height: AppSpacing.sm),
          if (tickets.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
                child: Text(
                  'لا توجد تذاكر مسلّمة اليوم',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade300,
                    fontSize: 12,
                  ),
                ),
              ),
            )
          else
            ...tickets.map((ticket) => Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: AppSpacing.sm,
              ),
              child: DropoffEntryCard(ticket: ticket, compact: true),
            )),
        ],
      ],
    );
  }
}
