import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/domain/entities/customer_request.dart';
import 'package:honak/core/extensions/context_ext.dart';

/// Vertical timeline stepper showing request status progression.
class StatusTimeline extends StatelessWidget {
  final List<TimelineEvent> events;
  final String currentStatus;

  const StatusTimeline({
    super.key,
    required this.events,
    required this.currentStatus,
  });

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'حالة الطلب',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: context.colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: AppSpacing.lg),
        ...List.generate(events.length, (i) {
          final event = events[i];
          final isLast = i == events.length - 1;
          return _TimelineStep(
            event: event,
            isLast: isLast,
          );
        }),
      ],
    );
  }
}

class _TimelineStep extends StatelessWidget {
  final TimelineEvent event;
  final bool isLast;

  const _TimelineStep({
    required this.event,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final config = _stepConfig(context, event);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon column + connector line
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: config.bgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    config.icon,
                    size: 14,
                    color: config.iconColor,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin:
                          const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
                      color: config.isDone
                          ? AppColors.success.withValues(alpha: 0.3)
                          : Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: isLast ? 0 : AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          event.label,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: config.labelColor,
                                    fontWeight: config.isDone
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                                  ),
                        ),
                      ),
                      _ActorBadge(actor: event.actor),
                    ],
                  ),
                  if (event.timestamp > 0) ...[
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      _formatTimestamp(event.timestamp),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                  if (event.detail != null) ...[
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      event.detail!,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _StepConfig _stepConfig(BuildContext context, TimelineEvent event) {
    final cs = Theme.of(context).colorScheme;
    switch (event.status) {
      case 'cancelled_by_customer' || 'cancelled_by_business':
        return _StepConfig(
          icon: Icons.cancel_outlined,
          iconColor: AppColors.error,
          bgColor: AppColors.error.withValues(alpha: 0.1),
          labelColor: AppColors.error,
          isDone: true,
        );
      case 'pending_reschedule' || 'modification_requested':
        return _StepConfig(
          icon: Icons.access_time,
          iconColor: const Color(0xFFFF8F00),
          bgColor: const Color(0xFFFFF3E0),
          labelColor: const Color(0xFFFF8F00),
          isDone: true,
        );
      case 'alternative_offered':
        return _StepConfig(
          icon: Icons.edit_outlined,
          iconColor: const Color(0xFF7B1FA2),
          bgColor: const Color(0xFFF3E5F5),
          labelColor: const Color(0xFF7B1FA2),
          isDone: true,
        );
      case 'rescheduled':
        return _StepConfig(
          icon: Icons.calendar_today,
          iconColor: AppColors.primary,
          bgColor: AppColors.primary.withValues(alpha: 0.1),
          labelColor: AppColors.primary,
          isDone: true,
        );
      default:
        final isDone = event.status == 'completed' ||
            event.status == 'accepted' ||
            event.status == 'in_progress' ||
            event.status == 'preparing' ||
            event.status == 'pending' ||
            event.status == 'pending_review';
        if (isDone) {
          return _StepConfig(
            icon: Icons.check_circle_outline,
            iconColor: AppColors.success,
            bgColor: AppColors.success.withValues(alpha: 0.1),
            labelColor: cs.onSurface,
            isDone: true,
          );
        }
        return _StepConfig(
          icon: Icons.circle_outlined,
          iconColor: cs.onSurfaceVariant,
          bgColor: cs.surfaceContainerLow,
          labelColor: cs.onSurfaceVariant,
          isDone: false,
        );
    }
  }

  String _formatTimestamp(int epochSeconds) {
    final dt = DateTime.fromMillisecondsSinceEpoch(epochSeconds * 1000);
    final now = DateTime.now();
    final diff = now.difference(dt);

    if (diff.inMinutes < 1) return 'الآن';
    if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} دقيقة';
    if (diff.inHours < 24) return 'منذ ${diff.inHours} ساعة';
    if (diff.inDays < 7) return 'منذ ${diff.inDays} يوم';

    return '${dt.day}/${dt.month}/${dt.year}';
  }
}

class _StepConfig {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final Color labelColor;
  final bool isDone;

  const _StepConfig({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.labelColor,
    required this.isDone,
  });
}

class _ActorBadge extends StatelessWidget {
  final String actor;

  const _ActorBadge({required this.actor});

  @override
  Widget build(BuildContext context) {
    if (actor == 'system') return const SizedBox.shrink();

    final isCustomer = actor == 'customer';
    final label = isCustomer ? 'أنت' : 'المتجر';
    final color = isCustomer ? AppColors.primary : AppColors.success;

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontSize: 10,
            ),
      ),
    );
  }
}
