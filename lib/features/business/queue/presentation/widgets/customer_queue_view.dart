import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/queue/domain/entities/available_add_on.dart';
import 'package:honak/features/business/queue/domain/entities/customer_queue_entry.dart';
import 'package:honak/features/business/queue/domain/entities/queue_status.dart';
import 'package:honak/features/business/queue/domain/entities/service_package.dart';
import 'package:honak/features/business/queue/presentation/widgets/customer/queue_active_tracker.dart';
import 'package:honak/features/business/queue/presentation/widgets/customer/queue_modify_sheet.dart';
import 'package:honak/features/business/queue/presentation/widgets/customer/queue_post_banner.dart';

/// Determines the page state from the active and recent queue entries.
String _getPageState(
  CustomerQueueEntry? activeEntry,
  CustomerQueueEntry? recentEntry,
) {
  if (activeEntry != null) {
    const terminalStatuses = {QueueStatus.completed, QueueStatus.noShow};
    if (!terminalStatuses.contains(activeEntry.status)) return 'active';
  }
  if (recentEntry != null) return 'post';
  return 'browse';
}

/// Customer-facing live queue view.
///
/// Routes between browse (stats only), active (tracker), and post (banner)
/// states based on the customer's queue entry.
class CustomerQueueView extends ConsumerWidget {
  final String pageName;
  final String? pageAvatar;
  final int currentQueueSize;
  final int estimatedWaitMin;
  final int inProgressCount;
  final List<ServicePackage> packages;
  final List<AvailableAddOn> availableAddOns;
  final bool isPaused;

  // Queue entry state
  final CustomerQueueEntry? activeEntry;
  final CustomerQueueEntry? recentEntry;

  // Callbacks
  final VoidCallback? onCancelEntry;
  final void Function(QueueModificationRequest)? onRequestModification;
  final VoidCallback? onMarkOnMyWay;
  final VoidCallback? onRebook;
  final VoidCallback? onViewRequestDetail;

  const CustomerQueueView({
    super.key,
    required this.pageName,
    this.pageAvatar,
    required this.currentQueueSize,
    required this.estimatedWaitMin,
    required this.inProgressCount,
    required this.packages,
    this.availableAddOns = const [],
    this.isPaused = false,
    this.activeEntry,
    this.recentEntry,
    this.onCancelEntry,
    this.onRequestModification,
    this.onMarkOnMyWay,
    this.onRebook,
    this.onViewRequestDetail,
  });

  static const _gradientBlue = LinearGradient(
    colors: [Color(0xFF1A73E8), Color(0xFF1565C0)],
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = _getPageState(activeEntry, recentEntry);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (state == 'active')
          QueueActiveTracker(
            entry: activeEntry!,
            packages: packages,
            availableAddOns: availableAddOns,
            onMarkOnMyWay: onMarkOnMyWay ?? () {},
            onCancelEntry: onCancelEntry ?? () {},
            onRequestModification:
                onRequestModification ?? (_) {},
          )
        else ...[
          _StatsHeader(
            currentQueueSize: currentQueueSize,
            estimatedWaitMin: estimatedWaitMin,
            inProgressCount: inProgressCount,
            isPaused: isPaused,
          ),
          if (state == 'post' && recentEntry != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: AppSpacing.md,
              ),
              child: QueuePostBanner(
                entry: recentEntry!,
                onRebook: onRebook ?? () {},
                onViewDetail: onViewRequestDetail,
              ),
            ),
        ],
      ],
    );
  }
}

// ── Stats Header (blue gradient) ──────────────────────────────────────────

class _StatsHeader extends StatelessWidget {
  final int currentQueueSize;
  final int estimatedWaitMin;
  final int inProgressCount;
  final bool isPaused;

  const _StatsHeader({
    required this.currentQueueSize,
    required this.estimatedWaitMin,
    required this.inProgressCount,
    required this.isPaused,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: CustomerQueueView._gradientBlue,
        borderRadius: AppRadius.card,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.people_outline, size: 16, color: Colors.white),
              const SizedBox(width: AppSpacing.sm),
              Text(
                context.l10n.queueCurrentQueue,
                style: context.textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              const Spacer(),
              if (isPaused)
                Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: AppRadius.pill,
                  ),
                  child: Text(
                    context.l10n.queuePausedTemporarily,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                value: '$currentQueueSize',
                label: context.l10n.queueLabelWaiting,
              ),
              _verticalDivider(),
              _StatItem(
                value: '$inProgressCount',
                label: context.l10n.queueInProgress,
              ),
              _verticalDivider(),
              _StatItem(
                value: '~$estimatedWaitMin',
                label: context.l10n.queueWaitMinutes,
                icon: Icons.access_time,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 48,
      color: Colors.white.withValues(alpha: 0.2),
    );
  }
}

// ── Stat Item ─────────────────────────────────────────────────────────────

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData? icon;

  const _StatItem({
    required this.value,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (icon != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: Theme.of(context).colorScheme.surface),
              const SizedBox(width: 4),
              Text(
                value,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.surface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        else
          Text(
            value,
            style: context.textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.surface,
              fontWeight: FontWeight.bold,
            ),
          ),
        const SizedBox(height: 2),
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
