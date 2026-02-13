part of 'queue_board.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Sub-widgets for QueueBoard
// ═══════════════════════════════════════════════════════════════════════════

// ── Sticky header delegate ──

class _QueueHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _QueueHeaderDelegate({
    required this.waitingCount,
    required this.inProgressCount,
    required this.completedCount,
    required this.estimatedWaitMin,
    required this.isPaused,
    required this.onTogglePause,
    this.onAdd,
    this.activeFilter,
    this.onFilterChanged,
  });

  final int waitingCount;
  final int inProgressCount;
  final int completedCount;
  final int estimatedWaitMin;
  final bool isPaused;
  final VoidCallback onTogglePause;
  final VoidCallback? onAdd;
  final _QueueFilter? activeFilter;
  final ValueChanged<_QueueFilter>? onFilterChanged;

  @override
  double get maxExtent => 108;

  @override
  double get minExtent => 108;

  @override
  bool shouldRebuild(covariant _QueueHeaderDelegate oldDelegate) =>
      waitingCount != oldDelegate.waitingCount ||
      inProgressCount != oldDelegate.inProgressCount ||
      completedCount != oldDelegate.completedCount ||
      estimatedWaitMin != oldDelegate.estimatedWaitMin ||
      isPaused != oldDelegate.isPaused ||
      activeFilter != oldDelegate.activeFilter;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Title row + pause toggle
          Row(
            children: [
              Text(
                'لوحة الدور',
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              _PauseToggleButton(
                isPaused: isPaused,
                onToggle: onTogglePause,
              ),
              if (onAdd != null) ...[
                const SizedBox(width: AppSpacing.sm),
                GestureDetector(
                  onTap: onAdd,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Stats strip (tappable filters)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _StatChip(
                  icon: Icons.people_outline_rounded,
                  label: 'بالانتظار',
                  value: '$waitingCount',
                  color: AppColors.secondary,
                  bgColor: const Color(0xFFFFF8E1),
                  isActive: activeFilter == _QueueFilter.waiting,
                  onTap: onFilterChanged != null
                      ? () => onFilterChanged!(_QueueFilter.waiting)
                      : null,
                ),
                const SizedBox(width: AppSpacing.sm),
                _StatChip(
                  icon: Icons.play_arrow_rounded,
                  label: 'قيد الخدمة',
                  value: '$inProgressCount',
                  color: AppColors.primary,
                  bgColor: const Color(0xFFEFF6FF),
                  isActive: activeFilter == _QueueFilter.inProgress,
                  onTap: onFilterChanged != null
                      ? () => onFilterChanged!(_QueueFilter.inProgress)
                      : null,
                ),
                const SizedBox(width: AppSpacing.sm),
                _StatChip(
                  icon: Icons.check_circle_outline_rounded,
                  label: 'مكتمل',
                  value: '$completedCount',
                  color: AppColors.success,
                  bgColor: const Color(0xFFF0FDF4),
                  isActive: activeFilter == _QueueFilter.completed,
                  onTap: onFilterChanged != null
                      ? () => onFilterChanged!(_QueueFilter.completed)
                      : null,
                ),
                const SizedBox(width: AppSpacing.sm),
                _StatChip(
                  icon: Icons.schedule_rounded,
                  label: 'وقت الانتظار',
                  value: '~$estimatedWaitMin د',
                  color: const Color(0xFF7B1FA2),
                  bgColor: const Color(0xFFF3E5F5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stat Chip ──

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.bgColor,
    this.isActive = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final Color bgColor;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final chip = Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.md,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: isActive ? color : bgColor,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: isActive ? null : Border.all(color: Colors.transparent),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: isActive ? Colors.white : color),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: isActive ? Colors.white70 : Colors.grey.shade500,
              fontSize: 10,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            value,
            style: context.textTheme.bodySmall?.copyWith(
              color: isActive ? Colors.white : color,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: chip);
    }
    return chip;
  }
}

// ── Pause Toggle Button ──

class _PauseToggleButton extends StatelessWidget {
  const _PauseToggleButton({
    required this.isPaused,
    required this.onToggle,
  });

  final bool isPaused;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.md,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: isPaused
              ? const Color(0xFFFEF2F2)
              : Colors.grey.shade100,
          borderRadius: AppRadius.pill,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isPaused ? Icons.block_rounded : Icons.schedule_rounded,
              size: 12,
              color: isPaused ? AppColors.error : Colors.grey.shade500,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              isPaused ? 'الدور متوقف' : 'إيقاف الدور',
              style: context.textTheme.bodySmall?.copyWith(
                color: isPaused ? AppColors.error : Colors.grey.shade500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Pause Banner ──

class _PauseBanner extends StatelessWidget {
  const _PauseBanner({required this.onResume});

  final VoidCallback onResume;

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
          Icon(Icons.block_rounded, size: 18, color: AppColors.error),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الدور متوقف مؤقتاً',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.error,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  'لن يتمكن العملاء من حجز مكان بالدور حالياً',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: const Color(0xFFEF5350),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onResume,
            child: Text(
              'استئناف',
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.error,
                fontSize: 12,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Queue Column ──

class _QueueColumn extends StatelessWidget {
  const _QueueColumn({
    required this.label,
    required this.count,
    required this.color,
    required this.bgColor,
    required this.borderColor,
    required this.icon,
    required this.emptyText,
    required this.entries,
    required this.advanceLabel,
    required this.advanceColor,
    this.advanceIcon,
    this.showTimer = false,
    this.showNoShow = false,
    this.onAdvance,
    this.onNoShow,
    this.onRemove,
    this.onOpenDetail,
    this.onChangeStatus,
    this.onOpenChat,
  });

  final String label;
  final int count;
  final Color color;
  final Color bgColor;
  final Color borderColor;
  final IconData icon;
  final String emptyText;
  final List<QueueEntry> entries;
  final String advanceLabel;
  final Color advanceColor;
  final IconData? advanceIcon;
  final bool showTimer;
  final bool showNoShow;
  final void Function(String entryId)? onAdvance;
  final void Function(String entryId)? onNoShow;
  final void Function(String entryId)? onRemove;
  final void Function(QueueEntry entry)? onOpenDetail;
  final void Function(String entryId, QueueStatus newStatus)? onChangeStatus;
  final VoidCallback? onOpenChat;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Column header
        Row(
          children: [
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: AppRadius.pill,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 14, color: color),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    label,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: color,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: bgColor,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$count',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: color,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        // Entries or empty state
        if (entries.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
            decoration: BoxDecoration(
              borderRadius: AppRadius.cardInner,
              border: Border.all(
                color: borderColor,
                style: BorderStyle.solid,
              ),
            ),
            child: Center(
              child: Text(
                emptyText,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade300,
                  fontSize: 12,
                ),
              ),
            ),
          )
        else
          ...entries.map(
            (entry) => Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: AppSpacing.sm,
              ),
              child: QueueEntryCard(
                entry: entry,
                onAdvance: onAdvance != null
                    ? () => onAdvance!(entry.id)
                    : null,
                onNoShow: showNoShow && onNoShow != null
                    ? () => onNoShow!(entry.id)
                    : null,
                onRemove: onRemove != null
                    ? () => onRemove!(entry.id)
                    : null,
                onOpenDetail: onOpenDetail != null
                    ? () => onOpenDetail!(entry)
                    : null,
                onChangeStatus: onChangeStatus != null
                    ? (newStatus) => onChangeStatus!(entry.id, newStatus)
                    : null,
                onOpenChat: onOpenChat,
                activityLog: generateQueueActivity(entry),
                advanceLabel: advanceLabel,
                advanceIcon: advanceIcon,
                advanceColor: advanceColor,
                showTimer: showTimer,
              ),
            ),
          ),
      ],
    );
  }
}

// ── Completed Section (collapsible) ──

class _CompletedSection extends StatelessWidget {
  const _CompletedSection({
    required this.entries,
    required this.isExpanded,
    required this.onToggle,
  });

  final List<QueueEntry> entries;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Toggle button
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
                'مكتمل اليوم (${entries.length})',
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade400,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Divider(
                  color: Colors.grey.shade100,
                  height: 1,
                ),
              ),
            ],
          ),
        ),

        // Expanded entries
        if (isExpanded) ...[
          const SizedBox(height: AppSpacing.sm),
          if (entries.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
                child: Text(
                  'لا توجد طلبات مكتملة اليوم',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade300,
                    fontSize: 12,
                  ),
                ),
              ),
            )
          else
            ...entries.map(
              (entry) => Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: AppSpacing.sm,
                ),
                child: QueueEntryCard(
                  entry: entry,
                  compact: true,
                ),
              ),
            ),
        ],
      ],
    );
  }
}

// ── Revenue Summary ──

class _RevenueSummary extends StatelessWidget {
  const _RevenueSummary({
    required this.totalCount,
    required this.completedRevenueCents,
    required this.pendingRevenueCents,
  });

  final int totalCount;
  final int completedRevenueCents;
  final int pendingRevenueCents;

  @override
  Widget build(BuildContext context) {
    final completedRevenue = Money(completedRevenueCents);
    final pendingRevenue = Money(pendingRevenueCents);

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ملخص اليوم',
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade500,
                  fontSize: 12,
                ),
              ),
              Icon(
                Icons.auto_awesome_rounded,
                size: 14,
                color: AppColors.secondary,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Stats row
          Row(
            children: [
              // Total cars
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '$totalCount',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      'إجمالي السيارات',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: Colors.grey.shade400,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),

              // Completed revenue
              Expanded(
                child: Column(
                  children: [
                    Text(
                      completedRevenue.toJodString(),
                      style: context.textTheme.titleMedium?.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      'إيراد مكتمل (د.أ)',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: Colors.grey.shade400,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),

              // Pending revenue
              Expanded(
                child: Column(
                  children: [
                    Text(
                      pendingRevenue.toJodString(),
                      style: context.textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      'إيراد قادم (د.أ)',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: Colors.grey.shade400,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
