import 'dart:async';

import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/queue/domain/entities/available_add_on.dart';
import 'package:honak/features/business/queue/domain/entities/customer_queue_entry.dart';
import 'package:honak/features/business/queue/domain/entities/queue_status.dart';
import 'package:honak/features/business/queue/domain/entities/service_package.dart';
import 'package:honak/features/business/queue/presentation/widgets/customer/queue_cancel_sheet.dart';
import 'package:honak/features/business/queue/presentation/widgets/customer/queue_modify_sheet.dart';
import 'package:honak/features/business/queue/presentation/widgets/customer/queue_ready_card.dart';
import 'package:honak/features/business/queue/presentation/widgets/customer/queue_selection_summary.dart';

/// Displays the active queue tracking card for the customer.
///
/// Sub-states:
/// - Waiting / OnTheWay: Blue gradient with position number
/// - InProgress: Blue gradient with pulse indicator + elapsed timer
/// - Ready: Green gradient with "your car is ready"
class QueueActiveTracker extends StatelessWidget {
  final CustomerQueueEntry entry;
  final List<ServicePackage> packages;
  final List<AvailableAddOn>? availableAddOns;
  final VoidCallback onMarkOnMyWay;
  final VoidCallback onCancelEntry;
  final void Function(QueueModificationRequest) onRequestModification;

  const QueueActiveTracker({
    super.key,
    required this.entry,
    required this.packages,
    this.availableAddOns,
    required this.onMarkOnMyWay,
    required this.onCancelEntry,
    required this.onRequestModification,
  });

  @override
  Widget build(BuildContext context) {
    return switch (entry.status) {
      QueueStatus.waiting || QueueStatus.onTheWay => _WaitingCard(
          entry: entry,
          packages: packages,
          availableAddOns: availableAddOns,
          onMarkOnMyWay: onMarkOnMyWay,
          onCancelEntry: onCancelEntry,
          onRequestModification: onRequestModification,
        ),
      QueueStatus.inProgress => _InProgressCard(
          entry: entry,
          packages: packages,
          availableAddOns: availableAddOns,
          onRequestModification: onRequestModification,
        ),
      QueueStatus.ready => QueueReadyCard(entry: entry),
      _ => const SizedBox.shrink(),
    };
  }
}

// ══════════════════════════════════════════════════════════════════════════
// Waiting / OnTheWay Card
// ══════════════════════════════════════════════════════════════════════════

class _WaitingCard extends StatelessWidget {
  final CustomerQueueEntry entry;
  final List<ServicePackage> packages;
  final List<AvailableAddOn>? availableAddOns;
  final VoidCallback onMarkOnMyWay;
  final VoidCallback onCancelEntry;
  final void Function(QueueModificationRequest) onRequestModification;

  const _WaitingCard({
    required this.entry,
    required this.packages,
    this.availableAddOns,
    required this.onMarkOnMyWay,
    required this.onCancelEntry,
    required this.onRequestModification,
  });

  static const _gradientBlue = LinearGradient(
    colors: [Color(0xFF1A73E8), Color(0xFF1565C0)],
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: _gradientBlue,
            borderRadius: AppRadius.card,
          ),
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.navigation,
                    size: 14,
                    color: Colors.white70,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'أنت بالدور',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${entry.position}',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'رقمك بالدور',
                style: context.textTheme.labelSmall?.copyWith(
                  color: Colors.white70,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              // Ahead count + estimated wait
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: AppRadius.cardInner,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _miniStat(context,
                        value: '${entry.aheadCount}', label: 'قبلك'),
                    Container(
                      width: 1,
                      height: 32,
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                    _miniStat(context,
                        value: '~${entry.estimatedWaitMin} د',
                        label: 'وقت الانتظار'),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              QueueSelectionSummary(entry: entry),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _buildActionButtons(context),
      ],
    );
  }

  Widget _miniStat(
    BuildContext context, {
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: context.textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: Colors.white70,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        if (entry.status == QueueStatus.waiting && !entry.onTheWay)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onMarkOnMyWay,
              icon: const Icon(Icons.navigation, size: 14),
              label: const Text('أنا ادور — في الطريق'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.success,
                side: const BorderSide(color: AppColors.success),
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.button,
                ),
              ),
            ),
          )
        else if (entry.onTheWay)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.success,
              borderRadius: AppRadius.button,
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check, size: 14, color: Colors.white),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'أنت في الطريق',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => showQueueModifySheet(
              context: context,
              entry: entry,
              packages: packages,
              availableAddOns: availableAddOns,
              isInProgress: false,
              onSubmit: onRequestModification,
            ),
            icon: const Icon(Icons.edit_outlined, size: 14),
            label: const Text('طلب تعديل'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textSecondary,
              side: const BorderSide(color: AppColors.divider),
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.button,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => showQueueCancelSheet(
              context: context,
              entry: entry,
              onConfirm: onCancelEntry,
            ),
            icon: const Icon(Icons.close, size: 14),
            label: const Text('إلغاء الحجز'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.divider),
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.button,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// In Progress Card
// ══════════════════════════════════════════════════════════════════════════

class _InProgressCard extends StatefulWidget {
  final CustomerQueueEntry entry;
  final List<ServicePackage> packages;
  final List<AvailableAddOn>? availableAddOns;
  final void Function(QueueModificationRequest) onRequestModification;

  const _InProgressCard({
    required this.entry,
    required this.packages,
    this.availableAddOns,
    required this.onRequestModification,
  });

  @override
  State<_InProgressCard> createState() => _InProgressCardState();
}

class _InProgressCardState extends State<_InProgressCard> {
  Timer? _timer;
  int _elapsedSeconds = 0;

  @override
  void initState() {
    super.initState();
    _updateElapsed();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateElapsed(),
    );
  }

  void _updateElapsed() {
    if (!mounted) return;
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    setState(() {
      _elapsedSeconds = now - (widget.entry.startedAt ?? now);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  static const _gradientBlue = LinearGradient(
    colors: [Color(0xFF1A73E8), Color(0xFF1565C0)],
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
  );

  @override
  Widget build(BuildContext context) {
    final elapsedMin = _elapsedSeconds ~/ 60;
    final durationMin = widget.entry.estimatedDurationMin;
    final progress =
        durationMin > 0 ? (elapsedMin / durationMin).clamp(0.0, 1.0) : 0.0;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: _gradientBlue,
            borderRadius: AppRadius.card,
          ),
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _PulsingDot(),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'جاري العمل على سيارتك',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: AppRadius.cardInner,
                ),
                child: Column(
                  children: [
                    QueueSelectionSummary(entry: widget.entry),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$elapsedMin دقيقة مضت',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          'من $durationMin دقيقة',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ClipRRect(
                      borderRadius: AppRadius.pill,
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                        minHeight: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => showQueueModifySheet(
              context: context,
              entry: widget.entry,
              packages: widget.packages,
              availableAddOns: widget.availableAddOns,
              isInProgress: true,
              onSubmit: widget.onRequestModification,
            ),
            icon: const Icon(Icons.edit_outlined, size: 14),
            label: const Text('طلب تعديل'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textSecondary,
              side: const BorderSide(color: AppColors.divider),
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.button,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'لا يمكن الإلغاء بعد بدء الخدمة — تواصل عبر المحادثة',
          textAlign: TextAlign.center,
          style: context.textTheme.labelSmall?.copyWith(
            color: AppColors.textHint,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

// ── Pulsing Dot ───────────────────────────────────────────────────────────

class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
