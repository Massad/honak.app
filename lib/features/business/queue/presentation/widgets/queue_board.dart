import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/queue/domain/entities/queue_entry.dart';
import 'package:honak/features/business/queue/domain/entities/queue_stats.dart';
import 'package:honak/features/business/queue/domain/entities/queue_status.dart';
import 'package:honak/features/business/queue/presentation/widgets/queue_entry_card.dart';
import 'package:honak/shared/entities/money.dart';

part 'queue_board_sections.dart';

/// The main kanban-style queue board for queue-based businesses.
///
/// Displays entries grouped by status: waiting, in-progress, ready.
/// Includes stats strip, pause toggle, completed section, and revenue summary.
class QueueBoard extends StatefulWidget {
  const QueueBoard({
    super.key,
    required this.initialQueue,
    required this.stats,
    this.onAdd,
  });

  final List<QueueEntry> initialQueue;
  final QueueDayStats stats;
  final VoidCallback? onAdd;

  @override
  State<QueueBoard> createState() => _QueueBoardState();
}

class _QueueBoardState extends State<QueueBoard> {
  late List<QueueEntry> _queue;
  bool _showCompleted = false;
  bool _pauseQueue = false;

  @override
  void initState() {
    super.initState();
    _queue = List.of(widget.initialQueue);
  }

  // ── Grouped entries ──

  List<QueueEntry> get _waiting => _queue
      .where((e) =>
          e.status == QueueStatus.waiting ||
          e.status == QueueStatus.onTheWay)
      .toList()
    ..sort((a, b) => a.position.compareTo(b.position));

  List<QueueEntry> get _inProgress => _queue
      .where((e) => e.status == QueueStatus.inProgress)
      .toList()
    ..sort((a, b) => (a.startedAt ?? 0).compareTo(b.startedAt ?? 0));

  List<QueueEntry> get _ready =>
      _queue.where((e) => e.status == QueueStatus.ready).toList();

  List<QueueEntry> get _completed => _queue
      .where((e) =>
          e.status == QueueStatus.completed ||
          e.status == QueueStatus.noShow)
      .toList()
    ..sort((a, b) => (b.completedAt ?? 0).compareTo(a.completedAt ?? 0));

  // ── Live stats ──

  int get _completedRevenue => _completed
      .where((e) => e.status == QueueStatus.completed)
      .fold(0, (sum, e) => sum + e.totalPrice);

  int get _pendingRevenue =>
      [..._waiting, ..._inProgress, ..._ready]
          .fold(0, (sum, e) => sum + e.totalPrice);

  int get _estimatedWaitMin {
    final ahead = _waiting.length;
    final avgService = widget.stats.avgServiceMin > 0
        ? widget.stats.avgServiceMin
        : 30;
    final workers = _inProgress.isNotEmpty ? _inProgress.length : 1;
    return (ahead / workers * avgService).round();
  }

  // ── Status transitions ──

  void _advanceStatus(String entryId) {
    setState(() {
      _queue = _queue.map((e) {
        if (e.id != entryId) return e;
        final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        return switch (e.status) {
          QueueStatus.waiting ||
          QueueStatus.onTheWay =>
            e.copyWith(status: QueueStatus.inProgress, startedAt: now),
          QueueStatus.inProgress =>
            e.copyWith(status: QueueStatus.ready, completedAt: now),
          QueueStatus.ready =>
            e.copyWith(status: QueueStatus.completed, completedAt: now),
          _ => e,
        };
      }).toList();
    });
    _showToast('تم تحديث الحالة');
  }

  void _markNoShow(String entryId) {
    setState(() {
      _queue = _queue.map((e) {
        if (e.id != entryId) return e;
        final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        return e.copyWith(status: QueueStatus.noShow, completedAt: now);
      }).toList();
    });
    _showToast('تم تسجيل عدم الحضور');
  }

  void _removeEntry(String entryId) {
    setState(() {
      _queue = _queue.where((e) => e.id != entryId).toList();
    });
    _showToast('تم الحذف');
  }

  void _showToast(String message) {
    if (!mounted) return;
    context.showSnackBar(message);
  }

  /// Adds a new entry to the queue (called from QueueQuickAdd).
  void addEntry(QueueEntry entry) {
    final maxPos = _queue
        .where((e) => e.status == QueueStatus.waiting)
        .fold(0, (max, e) => e.position > max ? e.position : max);
    setState(() {
      _queue = [..._queue, entry.copyWith(position: maxPos + 1)];
    });
    _showToast('تمت الإضافة للدور');
  }

  @override
  Widget build(BuildContext context) {
    final waiting = _waiting;
    final inProgress = _inProgress;
    final ready = _ready;
    final completed = _completed;
    final completedCount =
        completed.where((e) => e.status == QueueStatus.completed).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── Sticky header ──
          SliverPersistentHeader(
            pinned: true,
            delegate: _QueueHeaderDelegate(
              waitingCount: waiting.length,
              inProgressCount: inProgress.length,
              completedCount: completedCount,
              estimatedWaitMin: _estimatedWaitMin,
              isPaused: _pauseQueue,
              onTogglePause: () =>
                  setState(() => _pauseQueue = !_pauseQueue),
              onAdd: widget.onAdd,
            ),
          ),

          SliverPadding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.lg,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Pause banner ──
                if (_pauseQueue) ...[
                  const SizedBox(height: AppSpacing.md),
                  _PauseBanner(
                    onResume: () => setState(() => _pauseQueue = false),
                  ),
                ],

                // ── Waiting column ──
                const SizedBox(height: AppSpacing.md),
                _QueueColumn(
                  label: 'في الانتظار',
                  count: waiting.length,
                  color: AppColors.secondary,
                  bgColor: const Color(0xFFFFF8E1),
                  borderColor: const Color(0xFFFFE082),
                  icon: Icons.schedule_rounded,
                  emptyText: 'لا يوجد أحد بالانتظار',
                  entries: waiting,
                  advanceLabel: 'ابدأ الخدمة',
                  advanceColor: AppColors.primary,
                  showNoShow: true,
                  onAdvance: _advanceStatus,
                  onNoShow: _markNoShow,
                  onRemove: _removeEntry,
                ),

                // ── In Progress column ──
                const SizedBox(height: AppSpacing.lg),
                _QueueColumn(
                  label: 'قيد الخدمة',
                  count: inProgress.length,
                  color: AppColors.primary,
                  bgColor: const Color(0xFFEFF6FF),
                  borderColor: const Color(0xFFBFDBFE),
                  icon: Icons.play_arrow_rounded,
                  emptyText: 'لا توجد سيارات قيد الخدمة',
                  entries: inProgress,
                  advanceLabel: 'جاهز ✓',
                  advanceColor: AppColors.success,
                  showTimer: true,
                  onAdvance: _advanceStatus,
                  onRemove: _removeEntry,
                ),

                // ── Ready column ──
                const SizedBox(height: AppSpacing.lg),
                _QueueColumn(
                  label: 'جاهز للاستلام',
                  count: ready.length,
                  color: AppColors.success,
                  bgColor: const Color(0xFFF0FDF4),
                  borderColor: const Color(0xFFBBF7D0),
                  icon: Icons.check_circle_outline_rounded,
                  emptyText: 'لا توجد سيارات جاهزة',
                  entries: ready,
                  advanceLabel: 'تم الاستلام',
                  advanceColor: const Color(0xFF616161),
                  onAdvance: _advanceStatus,
                  onRemove: _removeEntry,
                ),

                // ── Completed section (collapsible) ──
                const SizedBox(height: AppSpacing.lg),
                _CompletedSection(
                  entries: completed,
                  isExpanded: _showCompleted,
                  onToggle: () =>
                      setState(() => _showCompleted = !_showCompleted),
                ),

                // ── Revenue summary ──
                const SizedBox(height: AppSpacing.lg),
                _RevenueSummary(
                  totalCount:
                      completedCount + inProgress.length + waiting.length,
                  completedRevenueCents: _completedRevenue,
                  pendingRevenueCents: _pendingRevenue,
                ),

                const SizedBox(height: AppSpacing.lg),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
