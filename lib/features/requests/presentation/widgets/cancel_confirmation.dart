import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/features/requests/presentation/widgets/late_cancel_sheet.dart';
import 'package:honak/shared/widgets/app_sheet_templates.dart';
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

  const _SimpleCancelSheet({required this.onConfirm, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return AppConfirmationSheet(
      title: '\u0625\u0644\u063a\u0627\u0621 \u0627\u0644\u0637\u0644\u0628',
      message:
          '\u0647\u0644 \u0623\u0646\u062a \u0645\u062a\u0623\u0643\u062f \u0645\u0646 \u0625\u0644\u063a\u0627\u0621 \u0647\u0630\u0627 \u0627\u0644\u0637\u0644\u0628\u061f',
      confirmLabel: '\u0646\u0639\u0645\u060c \u0625\u0644\u063a\u0627\u0621',
      cancelLabel: '\u062a\u0631\u0627\u062c\u0639',
      onConfirm: onConfirm,
      onCancel: onClose,
      icon: Icons.close,
      iconColor: AppColors.error,
      iconBackgroundColor: AppColors.error.withValues(alpha: 0.1),
      confirmStyle: btn.Style.danger,
    );
  }
}
