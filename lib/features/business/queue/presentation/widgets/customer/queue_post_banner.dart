import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/queue/domain/entities/customer_queue_entry.dart';
import 'package:honak/features/business/queue/domain/entities/queue_status.dart';
import 'package:honak/shared/entities/money.dart';

/// Post-queue dismissible banner shown after a queue entry is completed,
/// no-show, or cancelled.
///
/// Three variants:
/// - Completed: white bg, green check
/// - NoShow: amber bg, warning icon
/// - Cancelled: gray bg, X icon
class QueuePostBanner extends StatefulWidget {
  final CustomerQueueEntry entry;
  final VoidCallback onRebook;
  final VoidCallback? onViewDetail;

  const QueuePostBanner({
    super.key,
    required this.entry,
    required this.onRebook,
    this.onViewDetail,
  });

  @override
  State<QueuePostBanner> createState() => _QueuePostBannerState();
}

class _QueuePostBannerState extends State<QueuePostBanner> {
  bool _dismissed = false;

  @override
  Widget build(BuildContext context) {
    if (_dismissed) return const SizedBox.shrink();

    return switch (widget.entry.status) {
      QueueStatus.completed => _buildCompletedBanner(context),
      QueueStatus.noShow => _buildNoShowBanner(context),
      _ => _buildCancelledBanner(context),
    };
  }

  // ── Completed Banner ────────────────────────────────────────────────────

  Widget _buildCompletedBanner(BuildContext context) {
    final total = Money(widget.entry.totalPriceCents);
    final durationMin = widget.entry.estimatedDurationMin;

    return _BannerCard(
      backgroundColor: Theme.of(context).colorScheme.surface,
      borderColor: AppColors.success.withValues(alpha: 0.3),
      onDismiss: _dismiss,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.check_circle,
                  size: 24,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تمت الخدمة بنجاح',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${widget.entry.packageName} • ${total.toFormattedArabic()} • $durationMin دقيقة',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: widget.onRebook,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.button,
                    ),
                  ),
                  child: const Text('احجز مرة أخرى'),
                ),
              ),
              if (widget.onViewDetail != null) ...[
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onViewDetail,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: context.colorScheme.onSurfaceVariant,
                      side: BorderSide(color: context.colorScheme.outlineVariant),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.button,
                      ),
                    ),
                    child: const Text('التفاصيل'),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  // ── No-Show Banner ──────────────────────────────────────────────────────

  Widget _buildNoShowBanner(BuildContext context) {
    return _BannerCard(
      backgroundColor: AppColors.warning.withValues(alpha: 0.08),
      borderColor: AppColors.warning.withValues(alpha: 0.3),
      onDismiss: _dismiss,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.warning_amber_rounded,
                  size: 24,
                  color: AppColors.warning,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  'لم يتم الحضور',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.warning,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: widget.onRebook,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.button,
                ),
              ),
              child: const Text('احجز من جديد'),
            ),
          ),
        ],
      ),
    );
  }

  // ── Cancelled Banner ────────────────────────────────────────────────────

  Widget _buildCancelledBanner(BuildContext context) {
    return _BannerCard(
      backgroundColor: context.colorScheme.outlineVariant,
      borderColor: context.colorScheme.outlineVariant,
      onDismiss: _dismiss,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.cancel_outlined,
                  size: 24,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  'تم إلغاء الحجز',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: widget.onRebook,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.button,
                ),
              ),
              child: const Text('احجز من جديد'),
            ),
          ),
        ],
      ),
    );
  }

  void _dismiss() => setState(() => _dismissed = true);
}

// ── Banner Card Container ─────────────────────────────────────────────────

class _BannerCard extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback onDismiss;
  final Widget child;

  const _BannerCard({
    required this.backgroundColor,
    required this.borderColor,
    required this.onDismiss,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppRadius.card,
        border: Border.all(color: borderColor),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: AppSpacing.xxl),
            child: child,
          ),
          // Dismiss button — top-end (left in RTL)
          PositionedDirectional(
            top: 0,
            end: 0,
            child: GestureDetector(
              onTap: onDismiss,
              child: Icon(
                Icons.close,
                size: 16,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
