part of 'queue_entry_card.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Sub-widgets for QueueEntryCard
// ═══════════════════════════════════════════════════════════════════════════

// ── Source Badge ──

class _SourceBadge extends StatelessWidget {
  const _SourceBadge({required this.source});

  final QueueSource source;

  @override
  Widget build(BuildContext context) {
    final (label, color, bgColor, icon) = switch (source) {
      QueueSource.appReserve => (
          context.l10n.queueSourceReserve,
          const Color(0xFF1A73E8),
          const Color(0xFFEFF6FF),
          Icons.smartphone_rounded,
        ),
      QueueSource.phone => (
          context.l10n.queueSourcePhone,
          const Color(0xFF7B1FA2),
          const Color(0xFFFAF5FF),
          Icons.phone_in_talk_rounded,
        ),
      QueueSource.walkIn => (
          context.l10n.queueSourceWalkIn,
          context.colorScheme.onSurfaceVariant,
          context.colorScheme.surfaceContainerLow,
          Icons.directions_walk_rounded,
        ),
    };

    return Container(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: bgColor, borderRadius: AppRadius.pill),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 9, color: color),
          const SizedBox(width: 2),
          Text(label,
              style: context.textTheme.labelSmall
                  ?.copyWith(color: color, fontSize: 10)),
        ],
      ),
    );
  }
}

// ── On The Way Badge (animated pulse) ──

class _OnTheWayBadge extends StatefulWidget {
  @override
  State<_OnTheWayBadge> createState() => _OnTheWayBadgeState();
}

class _OnTheWayBadgeState extends State<_OnTheWayBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.5, end: 1.0).animate(_controller),
      child: Container(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
            color: const Color(0xFFF0FDF4), borderRadius: AppRadius.pill),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.navigation_rounded,
                size: 9, color: Color(0xFF43A047)),
            const SizedBox(width: 2),
            Text(context.l10n.queueOnTheWayBadge,
                style: context.textTheme.labelSmall
                    ?.copyWith(color: const Color(0xFF43A047), fontSize: 10)),
          ],
        ),
      ),
    );
  }
}

// ── Live Timer ──

class _LiveTimer extends StatefulWidget {
  const _LiveTimer({required this.startedAt, required this.durationMin});

  final int startedAt;
  final int durationMin;

  @override
  State<_LiveTimer> createState() => _LiveTimerState();
}

class _LiveTimerState extends State<_LiveTimer> {
  late Timer _timer;
  int _elapsedMin = 0;

  @override
  void initState() {
    super.initState();
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 30), (_) => _tick());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _tick() {
    final start =
        DateTime.fromMillisecondsSinceEpoch(widget.startedAt * 1000);
    final elapsed = DateTime.now().difference(start).inMinutes;
    if (mounted) setState(() => _elapsedMin = elapsed);
  }

  @override
  Widget build(BuildContext context) {
    final remaining = widget.durationMin - _elapsedMin;
    final isOvertime = remaining < 0;
    final isClose = remaining >= 0 && remaining <= 5;

    final (color, bgColor) = isOvertime
        ? (const Color(0xFFE53935), const Color(0xFFFEF2F2))
        : isClose
            ? (const Color(0xFFFF9800), const Color(0xFFFFF8E1))
            : (const Color(0xFF1A73E8), const Color(0xFFEFF6FF));

    final text =
        isOvertime ? context.l10n.queueMinOvertime(remaining.abs()) : context.l10n.queueMinRemaining(remaining);

    return Container(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: bgColor, borderRadius: AppRadius.pill),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule_rounded, size: 10, color: color),
          const SizedBox(width: 2),
          Text(text,
              style: context.textTheme.labelSmall
                  ?.copyWith(color: color, fontSize: 10)),
        ],
      ),
    );
  }
}

// ── Status Badge (interactive dropdown) ──

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status, required this.onTap});

  final QueueStatus status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final conf = QueueStatusConfig.ofLocalized(status, context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: conf.bgColor,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: conf.borderColor),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0D000000), blurRadius: 2, offset: Offset(0, 1)),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(conf.icon, size: 11, color: conf.color),
            const SizedBox(width: 4),
            Text(conf.label,
                style: context.textTheme.labelSmall
                    ?.copyWith(color: conf.color, fontSize: 10)),
            const SizedBox(width: 2),
            Icon(Icons.keyboard_arrow_down_rounded,
                size: 10,
                color: conf.color.withValues(alpha: 0.6)),
          ],
        ),
      ),
    );
  }
}

// ── Status Picker Bottom Sheet ──

/// Shows a queue status picker using the shared generic picker.
Future<QueueStatus?> _showQueueStatusPicker(
  BuildContext context, {
  required QueueStatus currentStatus,
  required String customerName,
  required String packageName,
}) {
  final currentConfig = QueueStatusConfig.ofLocalized(currentStatus, context);
  final currentIdx = QueueStatusConfig.statusOrder.indexOf(currentStatus);

  final options = QueueStatusConfig.pickerStatuses
      .where((s) => s != currentStatus)
      .map((s) {
    final conf = QueueStatusConfig.ofLocalized(s, context);
    final targetIdx = QueueStatusConfig.statusOrder.indexOf(s);
    return StatusOption<QueueStatus>(
      status: s,
      config: conf,
      isBackward: targetIdx < currentIdx,
    );
  }).toList();

  return showGenericStatusPicker<QueueStatus>(
    context,
    title: context.l10n.queueChangeStatus,
    subtitle: '$customerName — $packageName',
    currentConfig: currentConfig,
    availableStatuses: options,
  );
}
