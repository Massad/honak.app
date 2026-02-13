import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_stats.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_status.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_ticket.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/activity_log_utils.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/dropoff_detail_view.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/dropoff_entry_card.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/dropoff_status_config.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_info_template.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/dropoff_info_request_sheet.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/dropoff_status_picker.dart';

/// Main tracking board view for dropoff-type businesses.
///
/// Matches the Figma DropoffBoard component with:
/// - Sticky header: title, active count, overdue, search toggle, add button
/// - Stats row: 4 circular status cards (blue/orange/green/gray)
/// - Filter tabs: icon + label + count pills
/// - Ticket list with empty state
/// - Collapsible delivered section
class DropoffBoard extends StatefulWidget {
  const DropoffBoard({
    super.key,
    required this.initialTickets,
    required this.stats,
    this.onAdd,
    this.infoTemplates = const [],
  });

  final List<DropoffTicket> initialTickets;
  final DropoffDayStats stats;
  final VoidCallback? onAdd;
  final List<DropoffInfoTemplate> infoTemplates;

  @override
  State<DropoffBoard> createState() => _DropoffBoardState();
}

class _DropoffBoardState extends State<DropoffBoard> {
  late List<DropoffTicket> _tickets;
  DropoffStatus? _activeFilter;
  bool _showDelivered = false;
  bool _searchActive = false;
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tickets = List.of(widget.initialTickets);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  // ── Computed properties ──

  List<DropoffTicket> get _active => _tickets
      .where((t) =>
          t.status != DropoffStatus.delivered &&
          t.status != DropoffStatus.cancelled)
      .toList();

  List<DropoffTicket> get _delivered =>
      _tickets.where((t) => t.status == DropoffStatus.delivered).toList();

  int _countByStatus(DropoffStatus s) =>
      _tickets.where((t) => t.status == s).length;

  int get _overdueCount => _active.where((t) {
        final ready = DateTime.tryParse(t.estimatedReadyAt);
        if (ready == null) return false;
        return DateTime.now().isAfter(ready);
      }).length;

  List<DropoffTicket> get _filteredTickets {
    var list = _activeFilter == null
        ? _tickets
            .where((t) =>
                t.status != DropoffStatus.delivered &&
                t.status != DropoffStatus.cancelled)
            .toList()
        : _tickets.where((t) => t.status == _activeFilter).toList();

    if (_searchCtrl.text.trim().isNotEmpty) {
      final q = _searchCtrl.text.toLowerCase();
      list = list.where((t) {
        return t.customerName.toLowerCase().contains(q) ||
            t.ticketNumber.toLowerCase().contains(q) ||
            (t.customerPhone?.contains(q) ?? false) ||
            t.items.any((i) => i.name.contains(q));
      }).toList();
    }
    return list;
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

  void _changeStatus(String ticketId, DropoffStatus newStatus) {
    setState(() {
      _tickets = _tickets.map((t) {
        if (t.id != ticketId) return t;
        final now = DateTime.now().toIso8601String();
        var updated = t.copyWith(status: newStatus);
        if (newStatus == DropoffStatus.processing) {
          updated = updated.copyWith(startedAt: t.startedAt ?? now);
        } else if (newStatus == DropoffStatus.ready) {
          updated = updated.copyWith(
            startedAt: t.startedAt ?? now,
            completedAt: t.completedAt ?? now,
          );
        } else if (newStatus == DropoffStatus.delivered) {
          updated = updated.copyWith(
            startedAt: t.startedAt ?? now,
            completedAt: t.completedAt ?? now,
            pickedUpAt: t.pickedUpAt ?? now,
            paid: true,
          );
        }
        return updated;
      }).toList();
    });
    _showToast('تم تغيير الحالة');
  }

  void _mockPhotoCapture(String ticketId, String type) {
    setState(() {
      _tickets = _tickets.map((t) {
        if (t.id != ticketId) return t;
        final updatedItems = t.items.map((item) {
          if (item == t.items.first) {
            if (type == 'before') {
              return item.copyWith(
                photoBefore: item.photoBefore != null
                    ? null
                    : 'mock://photo-captured',
              );
            } else {
              return item.copyWith(
                photoAfter: item.photoAfter != null
                    ? null
                    : 'mock://photo-captured',
              );
            }
          }
          return item;
        }).toList();
        return t.copyWith(items: updatedItems);
      }).toList();
    });
  }

  void _showToast(String message) {
    if (!mounted) return;
    context.showSnackBar(message);
  }

  void _showInfoRequest(String ticketId) async {
    if (widget.infoTemplates.isEmpty) {
      _showToast('لا توجد قوالب طلب معلومات');
      return;
    }
    final selectedIds = await showDropoffInfoRequestSheet(
      context,
      templates: widget.infoTemplates,
    );
    if (selectedIds != null && selectedIds.isNotEmpty && mounted) {
      _showToast('تم إرسال طلب معلومات (${selectedIds.length})');
    }
  }

  void _openActivityLog(DropoffTicket ticket) {
    showActivityLogSheet(
      context,
      ticket: ticket,
      activityLog: generateMockActivity(ticket),
    );
  }

  /// Adds a new ticket (called from DropoffQuickAdd).
  void addTicket(DropoffTicket ticket) {
    setState(() {
      _tickets = [ticket, ..._tickets];
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
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.surface,
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    _buildHeader(context, overdueCount),
                    if (_searchActive) _buildSearchBar(context),
                    _buildStatsRow(context),
                    _buildFilterTabs(context),
                    const SizedBox(height: AppSpacing.sm),
                    Divider(height: 1, color: Colors.grey.shade100),
                  ],
                ),
              ),
            ),
          ),

          // ── Ticket list ──
          SliverPadding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.lg,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: AppSpacing.md),

                if (filtered.isEmpty)
                  _buildEmptyState(context)
                else
                  ...filtered.map((ticket) => Padding(
                        padding: const EdgeInsetsDirectional.only(
                          bottom: AppSpacing.md,
                        ),
                        child: DropoffEntryCard(
                          ticket: ticket,
                          onAdvance: () => _advanceStatus(ticket.id),
                          onTap: () => _openDetail(ticket),
                          onStatusChange: (status) =>
                              _changeStatus(ticket.id, status),
                          onPhotoBefore: () =>
                              _mockPhotoCapture(ticket.id, 'before'),
                          onPhotoAfter: () =>
                              _mockPhotoCapture(ticket.id, 'after'),
                          onRequestInfo: () =>
                              _showInfoRequest(ticket.id),
                          onActivityLog: () => _openActivityLog(ticket),
                          activityLog: generateMockActivity(ticket),
                        ),
                      )),

                // ── Delivered section (collapsible) ──
                const SizedBox(height: AppSpacing.md),
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

  // ── Header ──

  Widget _buildHeader(BuildContext context, int overdueCount) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          // Title + subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'لوحة التتبع',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${_active.length} تذكرة نشطة',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    if (overdueCount > 0) ...[
                      const SizedBox(width: AppSpacing.sm),
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 10,
                        color: AppColors.error,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '$overdueCount متأخرة',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Search toggle
          GestureDetector(
            onTap: () => setState(() {
              _searchActive = !_searchActive;
              if (!_searchActive) _searchCtrl.clear();
            }),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: AppRadius.cardInner,
              ),
              child: Icon(
                _searchActive ? Icons.close : Icons.search_rounded,
                size: 16,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),

          // Add button
          if (widget.onAdd != null)
            GestureDetector(
              onTap: widget.onAdd,
              child: Container(
                height: 36,
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A73E8),
                  borderRadius: AppRadius.cardInner,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add, size: 14, color: Colors.white),
                    const SizedBox(width: 6),
                    const Text(
                      'استلام جديد',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ── Search Bar ──

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: TextField(
        controller: _searchCtrl,
        onChanged: (_) => setState(() {}),
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'بحث بالاسم أو رقم التذكرة...',
          hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade300),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          border: OutlineInputBorder(
            borderRadius: AppRadius.cardInner,
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppRadius.cardInner,
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppRadius.cardInner,
            borderSide: const BorderSide(color: Color(0xFF1A73E8)),
          ),
        ),
      ),
    );
  }

  // ── Stats Row (4 circular cards) ──

  Widget _buildStatsRow(BuildContext context) {
    final stats = <(DropoffStatus, IconData, String)>[
      (DropoffStatus.received, Icons.inbox_rounded, 'استلام'),
      (DropoffStatus.processing, Icons.autorenew_rounded, 'معالجة'),
      (DropoffStatus.ready, Icons.check_circle_rounded, 'جاهز'),
      (DropoffStatus.delivered, Icons.local_shipping_rounded, 'تم التسليم'),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: stats.map((s) {
          final conf = DropoffStatusConfig.of(s.$1);
          final count = _countByStatus(s.$1);

          return Padding(
            padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
            child: Container(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 12,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: conf.bgColor,
                borderRadius: AppRadius.cardInner,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(s.$2, size: 14, color: conf.color),
                  const SizedBox(width: AppSpacing.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$count',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        s.$3,
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Filter Tabs ──

  Widget _buildFilterTabs(BuildContext context) {
    final filters = <(DropoffStatus?, IconData, String)>[
      (null, Icons.inventory_2_outlined, 'الكل'),
      (DropoffStatus.received, Icons.inbox_rounded, 'استلام'),
      (DropoffStatus.processing, Icons.autorenew_rounded, 'معالجة'),
      (DropoffStatus.ready, Icons.check_circle_rounded, 'جاهز'),
      (DropoffStatus.delivered, Icons.local_shipping_rounded, 'تم التسليم'),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: Row(
        children: filters.map((f) {
          final isActive = _activeFilter == f.$1;
          final count = f.$1 == null
              ? _active.length
              : _countByStatus(f.$1!);

          return Padding(
            padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
            child: GestureDetector(
              onTap: () => setState(() {
                _activeFilter = f.$1;
                if (f.$1 == DropoffStatus.delivered) {
                  _showDelivered = true;
                }
              }),
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF1A73E8)
                      : Colors.grey.shade100,
                  borderRadius: AppRadius.pill,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      f.$2,
                      size: 12,
                      color: isActive ? Colors.white : Colors.grey.shade500,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      f.$3,
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            isActive ? Colors.white : Colors.grey.shade500,
                      ),
                    ),
                    if (count > 0) ...[
                      const SizedBox(width: 6),
                      Text(
                        '$count',
                        style: TextStyle(
                          fontSize: 10,
                          color: isActive
                              ? Colors.white.withValues(alpha: 0.8)
                              : Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Empty State ──

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 40,
              color: Colors.grey.shade200,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              _searchCtrl.text.isNotEmpty
                  ? 'لا توجد نتائج'
                  : 'لا توجد تذاكر',
              style: TextStyle(
                fontSize: 14,
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
