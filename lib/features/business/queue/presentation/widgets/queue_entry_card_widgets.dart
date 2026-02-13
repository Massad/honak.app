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
        'حجز',
        AppColors.primary,
        const Color(0xFFEFF6FF), // blue-50
        Icons.smartphone_rounded,
      ),
      QueueSource.phone => (
        'هاتف',
        const Color(0xFF7B1FA2), // purple-600
        const Color(0xFFFAF5FF), // purple-50
        Icons.phone_in_talk_rounded,
      ),
      QueueSource.walkIn => (
        'حضوري',
        Colors.grey.shade500,
        Colors.grey.shade100,
        Icons.directions_walk_rounded,
      ),
    };

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 9, color: color),
          const SizedBox(width: 2),
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: color,
              fontSize: 10,
            ),
          ),
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
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
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
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 6,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF0FDF4), // green-50
          borderRadius: AppRadius.pill,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.navigation_rounded,
              size: 9,
              color: AppColors.success,
            ),
            const SizedBox(width: 2),
            Text(
              'ادور',
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.success,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Live Timer ──

class _LiveTimer extends StatefulWidget {
  const _LiveTimer({
    required this.startedAt,
    required this.durationMin,
  });

  final int startedAt; // epoch seconds
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
    final start = DateTime.fromMillisecondsSinceEpoch(widget.startedAt * 1000);
    final elapsed = DateTime.now().difference(start).inMinutes;
    if (mounted) setState(() => _elapsedMin = elapsed);
  }

  @override
  Widget build(BuildContext context) {
    final remaining = widget.durationMin - _elapsedMin;
    final isOvertime = remaining < 0;
    final isClose = remaining >= 0 && remaining <= 5;

    final (color, bgColor) = isOvertime
        ? (AppColors.error, const Color(0xFFFEF2F2)) // red-50
        : isClose
            ? (AppColors.secondary, const Color(0xFFFFF8E1)) // amber-50
            : (AppColors.primary, const Color(0xFFEFF6FF)); // blue-50

    final text = isOvertime
        ? '+${remaining.abs()} د تأخير'
        : '$remaining د متبقية';

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule_rounded, size: 10, color: color),
          const SizedBox(width: AppSpacing.xxs),
          Text(
            text,
            style: context.textTheme.labelSmall?.copyWith(
              color: color,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
