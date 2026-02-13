import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';

export 'booking_step_confirm.dart';
export 'booking_step_datetime.dart';
export 'booking_step_team.dart';

/// Step indicator row: numbered circles connected by lines.
class WizardStepIndicator extends StatelessWidget {
  final List<String> labels;
  final int currentStep;

  const WizardStepIndicator({
    super.key,
    required this.labels,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: List.generate(labels.length * 2 - 1, (i) {
          if (i.isOdd) {
            final stepBefore = i ~/ 2;
            final isDone = stepBefore < currentStep;
            return Expanded(
              child: Container(
                height: 2,
                color: isDone
                    ? context.colorScheme.primary
                    : context.colorScheme.outlineVariant,
              ),
            );
          }
          final stepIndex = i ~/ 2;
          return _StepDot(
            label: labels[stepIndex],
            isActive: stepIndex == currentStep,
            isDone: stepIndex < currentStep,
            index: stepIndex + 1,
          );
        }),
      ),
    );
  }
}

class _StepDot extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isDone;
  final int index;

  const _StepDot({
    required this.label,
    required this.isActive,
    required this.isDone,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.colorScheme.primary;
    final outlineColor = context.colorScheme.outlineVariant;
    final bgColor =
        isDone ? primaryColor : (isActive ? primaryColor : outlineColor);
    final fgColor = isDone || isActive
        ? context.colorScheme.onPrimary
        : context.colorScheme.onSurfaceVariant;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: isDone
              ? Icon(Icons.check, size: 16, color: fgColor)
              : Text(
                  '$index',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: fgColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: isActive || isDone
                ? primaryColor
                : context.colorScheme.onSurfaceVariant,
            fontWeight: isActive ? FontWeight.w600 : null,
          ),
        ),
      ],
    );
  }
}
