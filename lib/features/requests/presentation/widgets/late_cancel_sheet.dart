import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Late cancellation warning with fee info and reschedule option.
class LateCancelSheet extends StatelessWidget {
  final String? lateCancelMessage;
  final String? lateCancelFee;
  final VoidCallback onConfirm;
  final VoidCallback? onReschedule;
  final VoidCallback onClose;

  const LateCancelSheet({
    super.key,
    this.lateCancelMessage,
    this.lateCancelFee,
    required this.onConfirm,
    this.onReschedule,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppRadius.xxl)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Amber warning header
            Container(
              width: double.infinity,
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.lg,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFFFF8E1),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppRadius.xxl),
                ),
                border: Border(
                  bottom: BorderSide(color: Color(0xFFFFE082)),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      size: 18, color: Color(0xFFFF8F00)),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    '\u0625\u0644\u063a\u0627\u0621 \u0645\u062a\u0623\u062e\u0631',
                    style: textTheme.titleSmall?.copyWith(
                      color: const Color(0xFFFF8F00),
                    ),
                  ),
                ],
              ),
            ),
            // Body
            Padding(
              padding: const EdgeInsetsDirectional.all(AppSpacing.xl),
              child: Column(
                children: [
                  _WarningBox(
                    color: const Color(0xFFFFE082),
                    bgColor: const Color(0xFFFFF8E1).withValues(alpha: 0.5),
                    child: Text(
                      lateCancelMessage ??
                          '\u0627\u0644\u0625\u0644\u063a\u0627\u0621 \u0627\u0644\u0645\u062a\u0623\u062e\u0631 \u0642\u062f \u064a\u0624\u062b\u0631 \u0639\u0644\u0649 \u0623\u0648\u0644\u0648\u064a\u062a\u0643 \u0641\u064a \u0627\u0644\u062d\u062c\u0648\u0632\u0627\u062a \u0627\u0644\u0645\u0633\u062a\u0642\u0628\u0644\u064a\u0629',
                      style: textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  if (lateCancelFee != null) ...[
                    const SizedBox(height: AppSpacing.lg),
                    _WarningBox(
                      color: AppColors.error.withValues(alpha: 0.2),
                      bgColor: AppColors.error.withValues(alpha: 0.05),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 16,
                            color: AppColors.error,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              lateCancelFee!,
                              style: textTheme.bodySmall?.copyWith(
                                color: AppColors.error,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (onReschedule != null) ...[
                    const SizedBox(height: AppSpacing.lg),
                    btn.Button(
                      onPressed: onReschedule,
                      label: '\u064a\u0645\u0643\u0646\u0643 \u0625\u0639\u0627\u062f\u0629 \u0627\u0644\u062c\u062f\u0648\u0644\u0629 \u0628\u062f\u0644\u0627\u064b \u0645\u0646 \u0627\u0644\u0625\u0644\u063a\u0627\u0621',
                      icon: const btn.ButtonIcon(Icons.calendar_today),
                      variant: btn.Variant.outlined,
                      size: btn.ButtonSize.large,
                      expand: true,
                    ),
                  ],
                  const SizedBox(height: AppSpacing.xxl),
                  btn.Button(
                    onPressed: onClose,
                    label: '\u0627\u0644\u0627\u062d\u062a\u0641\u0627\u0638 \u0628\u0627\u0644\u062d\u062c\u0632',
                    size: btn.ButtonSize.large,
                    expand: true,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  btn.Button(
                    onPressed: onConfirm,
                    label: '\u0625\u0644\u063a\u0627\u0621 \u0639\u0644\u0649 \u0623\u064a \u062d\u0627\u0644',
                    variant: btn.Variant.outlined,
                    style: btn.Style.danger,
                    size: btn.ButtonSize.large,
                    expand: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WarningBox extends StatelessWidget {
  final Color color;
  final Color bgColor;
  final Widget child;

  const _WarningBox({
    required this.color,
    required this.bgColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: color),
        borderRadius: AppRadius.cardInner,
      ),
      child: child,
    );
  }
}
