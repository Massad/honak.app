import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/presentation/widgets/late_cancel_sheet.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Bottom sheet confirming cancellation.
///
/// Two variants:
/// - **Simple**: basic confirmation dialog
/// - **Late cancel**: warning with fee info and reschedule suggestion
class CancelConfirmationSheet extends StatelessWidget {
  final String requestId;
  final bool isLateCancellation;
  final String? lateCancelMessage;
  final String? lateCancelFee;
  final VoidCallback onConfirm;
  final VoidCallback? onReschedule;

  const CancelConfirmationSheet({
    super.key,
    required this.requestId,
    this.isLateCancellation = false,
    this.lateCancelMessage,
    this.lateCancelFee,
    required this.onConfirm,
    this.onReschedule,
  });

  @override
  Widget build(BuildContext context) {
    if (isLateCancellation) {
      return LateCancelSheet(
        lateCancelMessage: lateCancelMessage,
        lateCancelFee: lateCancelFee,
        onConfirm: onConfirm,
        onReschedule: onReschedule,
        onClose: () => Navigator.pop(context),
      );
    }

    return _SimpleCancelSheet(
      onConfirm: onConfirm,
      onClose: () => Navigator.pop(context),
    );
  }
}

/// Simple "are you sure?" cancellation dialog.
class _SimpleCancelSheet extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onClose;

  const _SimpleCancelSheet({
    required this.onConfirm,
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
      padding: const EdgeInsetsDirectional.all(AppSpacing.xxl),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 24, color: AppColors.error),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              '\u0625\u0644\u063a\u0627\u0621 \u0627\u0644\u0637\u0644\u0628',
              style: textTheme.titleSmall?.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '\u0647\u0644 \u0623\u0646\u062a \u0645\u062a\u0623\u0643\u062f \u0645\u0646 \u0625\u0644\u063a\u0627\u0621 \u0647\u0630\u0627 \u0627\u0644\u0637\u0644\u0628\u061f',
              style: textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            btn.Button(
              onPressed: onConfirm,
              label: '\u0646\u0639\u0645\u060c \u0625\u0644\u063a\u0627\u0621',
              style: btn.Style.danger,
              size: btn.ButtonSize.large,
              expand: true,
            ),
            const SizedBox(height: AppSpacing.sm),
            btn.Button(
              onPressed: onClose,
              label: '\u062a\u0631\u0627\u062c\u0639',
              variant: btn.Variant.outlined,
              size: btn.ButtonSize.large,
              expand: true,
            ),
          ],
        ),
      ),
    );
  }
}
