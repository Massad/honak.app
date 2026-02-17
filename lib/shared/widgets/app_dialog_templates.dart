import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_dialog.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

class AppDialogOption<T> {
  final T value;
  final String label;
  final IconData? icon;
  final bool isDestructive;

  const AppDialogOption({
    required this.value,
    required this.label,
    this.icon,
    this.isDestructive = false,
  });
}

Widget _dialogActionRow(
  BuildContext context, {
  TextDirection? textDirection,
  required VoidCallback onSecondary,
  required String secondaryLabel,
  required VoidCallback onPrimary,
  required String primaryLabel,
  btn.Style primaryStyle = btn.Style.primary,
}) {
  return Row(
    textDirection: textDirection ?? Directionality.of(context),
    mainAxisSize: MainAxisSize.min,
    children: [
      btn.Button(
        onPressed: onSecondary,
        label: secondaryLabel,
        variant: btn.Variant.text,
      ),
      const SizedBox(width: AppSpacing.sm),
      btn.Button(
        onPressed: onPrimary,
        label: primaryLabel,
        style: primaryStyle,
      ),
    ],
  );
}

Future<bool> showAppConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String? confirmLabel,
  String? cancelLabel,
  btn.Style confirmStyle = btn.Style.primary,
}) async {
  final actionDirection = Directionality.of(context);
  final result = await showAppDialog<bool>(
    context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        actions: [
          _dialogActionRow(
            ctx,
            textDirection: actionDirection,
            onSecondary: () => Navigator.of(ctx).pop(false),
            secondaryLabel: cancelLabel ?? ctx.l10n.cancel,
            onPrimary: () => Navigator.of(ctx).pop(true),
            primaryLabel: confirmLabel ?? ctx.l10n.ok,
            primaryStyle: confirmStyle,
          ),
        ],
      );
    },
  );

  return result ?? false;
}

Future<bool> showAppDangerConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String? confirmLabel,
  String? cancelLabel,
}) {
  return showAppConfirmDialog(
    context,
    title: title,
    message: message,
    confirmLabel: confirmLabel,
    cancelLabel: cancelLabel,
    confirmStyle: btn.Style.danger,
  );
}

Future<void> showAppInfoDialog(
  BuildContext context, {
  required String title,
  required String message,
  String? okLabel,
}) async {
  await showAppDialog<void>(
    context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        actions: [
          btn.Button(
            onPressed: () => Navigator.of(ctx).pop(),
            label: okLabel ?? ctx.l10n.ok,
          ),
        ],
      );
    },
  );
}

Future<T?> showAppActionListDialog<T>(
  BuildContext context, {
  required String title,
  String? message,
  required List<AppDialogOption<T>> options,
  String? cancelLabel,
}) {
  return showAppDialog<T>(
    context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(title),
        content: message == null ? null : Text(message),
        contentPadding: message == null
            ? const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0)
            : null,
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        actions: [
          if (message == null)
            ...options.map(
              (opt) => SizedBox(
                width: double.infinity,
                child: btn.Button(
                  onPressed: () => Navigator.of(ctx).pop(opt.value),
                  label: opt.label,
                  icon: opt.icon == null ? null : btn.ButtonIcon(opt.icon!),
                  style: opt.isDestructive
                      ? btn.Style.danger
                      : btn.Style.primary,
                  variant: btn.Variant.text,
                  expand: true,
                ),
              ),
            ),
          btn.Button(
            onPressed: () => Navigator.of(ctx).pop(),
            label: cancelLabel ?? ctx.l10n.cancel,
            variant: btn.Variant.text,
          ),
        ],
      );
    },
  );
}
