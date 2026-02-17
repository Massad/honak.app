import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/shared/widgets/app_dialog_templates.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Reusable confirmation dialog with two actions.
///
/// Returns `true` if the user confirmed, `false` / `null` if dismissed.
///
/// ```dart
/// final confirmed = await ConfirmDialog.show(
///   context,
///   title: 'Delete item?',
///   message: 'This cannot be undone.',
///   confirmLabel: 'Delete',
///   isDestructive: true,
/// );
/// ```
class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? confirmLabel;
  final String? cancelLabel;
  final bool isDestructive;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel,
    this.cancelLabel,
    this.isDestructive = false,
  });

  /// Shows the dialog and returns `true` if confirmed.
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmLabel,
    String? cancelLabel,
    bool isDestructive = false,
  }) async {
    final result = await showAppConfirmDialog(
      context,
      title: title,
      message: message,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
      confirmStyle: isDestructive
          ? btn.Style.danger
          : btn.Style.primary,
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        btn.Button(
          onPressed: () => Navigator.pop(context, false),
          label: cancelLabel ?? context.l10n.cancel,
          variant: btn.Variant.text,
        ),
        btn.Button(
          onPressed: () => Navigator.pop(context, true),
          label: confirmLabel ?? context.l10n.ok,
          style: isDestructive ? btn.Style.danger : btn.Style.primary,
        ),
      ],
      actionsAlignment: MainAxisAlignment.end,
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
    );
  }
}
