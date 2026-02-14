import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/core/extensions/context_ext.dart';

// Re-export individual step files so callers can import just this barrel.
export 'reservation_confirm_step.dart';
export 'reservation_date_step.dart';
export 'reservation_details_step.dart';

/// Data class for step definitions used by the reservation wizard.
class ReservationStepDef {
  final String id;
  final String label;
  final IconData icon;

  const ReservationStepDef(this.id, this.label, this.icon);
}

// ─────────────────────────────────────────────────────────────────────────────
// Step indicator
// ─────────────────────────────────────────────────────────────────────────────

/// Horizontal step indicator bar for the reservation wizard.
class ReservationStepIndicator extends StatelessWidget {
  final List<ReservationStepDef> steps;
  final int currentStep;
  final ValueChanged<int> onTapStep;

  const ReservationStepIndicator({
    super.key,
    required this.steps,
    required this.currentStep,
    required this.onTapStep,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xl, 0, AppSpacing.xl, AppSpacing.md,
      ),
      child: Row(
        children: steps.asMap().entries.map((entry) {
          final i = entry.key;
          final step = entry.value;
          final isCurrent = i == currentStep;
          final isDone = i < currentStep;

          return Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                end: i < steps.length - 1 ? AppSpacing.xs : 0,
              ),
              child: InkWell(
                onTap: isDone ? () => onTapStep(i) : null,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: isCurrent
                        ? AppColors.primary
                        : isDone
                            ? AppColors.success.withValues(alpha: 0.1)
                            : context.colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isDone ? Icons.check : step.icon,
                        size: 10,
                        color: isCurrent
                            ? Colors.white
                            : isDone
                                ? AppColors.success
                                : context.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: AppSpacing.xxs),
                      Flexible(
                        child: Text(
                          step.label,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontSize: 10,
                            color: isCurrent
                                ? Colors.white
                                : isDone
                                    ? AppColors.success
                                    : context.colorScheme.onSurfaceVariant,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Night count badge shown when date range is valid.
class NightCountBadge extends StatelessWidget {
  final int nightCount;

  const NightCountBadge({super.key, required this.nightCount});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.nightlight_round, size: 14, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Text(
            '$nightCount ${nightCount == 1 ? 'ليلة' : nightCount == 2 ? 'ليلتين' : 'ليالي'}',
            style: theme.textTheme.labelSmall
                ?.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
