import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
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
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => ConfirmDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
      ),
    );
    return result ?? false;
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
      // Keep Cancel left, Confirm right regardless of RTL
      actionsAlignment: MainAxisAlignment.end,
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
    );
  }
}
