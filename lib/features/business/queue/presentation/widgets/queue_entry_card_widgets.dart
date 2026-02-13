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
          const Color(0xFF1A73E8),
          const Color(0xFFEFF6FF),
          Icons.smartphone_rounded,
        ),
      QueueSource.phone => (
          'هاتف',
          const Color(0xFF7B1FA2),
          const Color(0xFFFAF5FF),
          Icons.phone_in_talk_rounded,
        ),
      QueueSource.walkIn => (
          'حضوري',
          const Color(0xFF6B7280),
          const Color(0xFFF3F4F6),
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
            Text('ادور',
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
        isOvertime ? '+${remaining.abs()} د تأخير' : '$remaining د متبقية';

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
    final conf = _StatusConfig.of(status);
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

// ── Photo Toggle Button ──

class _PhotoToggle extends StatelessWidget {
  const _PhotoToggle({
    required this.label,
    required this.icon,
    required this.active,
  });

  final String label;
  final IconData icon;
  final bool active;

  static const _activeColor = Color(0xFF1A73E8);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: active ? const Color(0xFFEFF6FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: active ? _activeColor : const Color(0xFFE5E7EB),
          width: active ? 2 : 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              size: 12,
              color: active ? _activeColor : const Color(0xFF9CA3AF)),
          const SizedBox(width: 6),
          Text(label,
              style: context.textTheme.labelSmall?.copyWith(
                  color: active ? _activeColor : const Color(0xFF9CA3AF),
                  fontSize: 11)),
          if (active) ...[
            const SizedBox(width: 4),
            const Icon(Icons.check_circle, size: 10, color: _activeColor),
          ],
        ],
      ),
    );
  }
}

// ── Status Picker Bottom Sheet ──

class _StatusPickerSheet extends StatelessWidget {
  const _StatusPickerSheet({
    required this.currentStatus,
    required this.customerName,
    required this.packageName,
    required this.onSelect,
  });

  final QueueStatus currentStatus;
  final String customerName;
  final String packageName;
  final ValueChanged<QueueStatus> onSelect;

  @override
  Widget build(BuildContext context) {
    final currentConf = _StatusConfig.of(currentStatus);
    final currentIdx = _statusOrder.indexOf(currentStatus);

    final pickerStatuses = [
      QueueStatus.waiting,
      QueueStatus.inProgress,
      QueueStatus.ready,
      QueueStatus.completed,
      QueueStatus.noShow,
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 4),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('تغيير حالة الطلب',
                            style: context.textTheme.bodySmall?.copyWith(
                                color: const Color(0xFF111827),
                                fontSize: 14)),
                        const SizedBox(height: 2),
                        Text('$customerName — $packageName',
                            style: context.textTheme.labelSmall?.copyWith(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 10)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.close,
                          size: 16, color: Color(0xFF6B7280)),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFF3F4F6)),

            // Current status
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('الحالة الحالية',
                      style: context.textTheme.labelSmall?.copyWith(
                          color: const Color(0xFF9CA3AF), fontSize: 10)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: currentConf.bgColor,
                      borderRadius:
                          BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                          color: currentConf.borderColor, width: 2),
                    ),
                    child: Row(
                      children: [
                        Icon(currentConf.icon,
                            size: 16, color: currentConf.color),
                        const SizedBox(width: 8),
                        Text(currentConf.label,
                            style: context.textTheme.bodySmall
                                ?.copyWith(color: currentConf.color)),
                        const Spacer(),
                        Text('الحالية',
                            style: context.textTheme.labelSmall?.copyWith(
                                color: const Color(0xFFD1D5DB),
                                fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Move to options
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('نقل إلى',
                      style: context.textTheme.labelSmall?.copyWith(
                          color: const Color(0xFF9CA3AF), fontSize: 10)),
                  const SizedBox(height: 8),
                  ...pickerStatuses
                      .where((s) => s != currentStatus)
                      .map((s) {
                    final conf = _StatusConfig.of(s);
                    final targetIdx = _statusOrder.indexOf(s);
                    final isBack = targetIdx < currentIdx;
                    return Padding(
                      padding:
                          const EdgeInsetsDirectional.only(bottom: 6),
                      child: GestureDetector(
                        onTap: () => onSelect(s),
                        child: Container(
                          padding:
                              const EdgeInsetsDirectional.symmetric(
                                  horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: isBack
                                ? const Color(0xFFFFF7ED)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(
                                AppRadius.md),
                            border: Border.all(
                              color: isBack
                                  ? const Color(0xFFFED7AA)
                                  : const Color(0xFFF3F4F6),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(conf.icon,
                                  size: 16, color: conf.color),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(conf.label,
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(color: conf.color)),
                              ),
                              if (isBack)
                                Container(
                                  padding:
                                      const EdgeInsetsDirectional
                                          .symmetric(
                                          horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFED7AA)
                                        .withValues(alpha: 0.5),
                                    borderRadius: AppRadius.pill,
                                  ),
                                  child: Text('تراجع',
                                      style: context
                                          .textTheme.labelSmall
                                          ?.copyWith(
                                              color: const Color(
                                                  0xFFFF9800),
                                              fontSize: 9)),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
