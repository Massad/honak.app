import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_action_row.dart';
import 'package:honak/shared/widgets/app_list_item.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

class AppSheetOption<T> {
  final T value;
  final String title;
  final String? subtitle;
  final Widget? leading;

  const AppSheetOption({
    required this.value,
    required this.title,
    this.subtitle,
    this.leading,
  });
}

Future<T?> showAppPickerSheet<T>(
  BuildContext context, {
  required String title,
  required List<AppSheetOption<T>> options,
}) {
  return showAppSheet<T>(
    context,
    builder: (sheetContext) => AppSheetScaffold(
      title: title,
      showBodyDivider: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: options
            .map(
              (option) => Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: AppSpacing.sm,
                ),
                child: AppListItem(
                  leading: option.leading,
                  title: option.title,
                  subtitle: option.subtitle,
                  affordance: AppListItemAffordance.chevron,
                  onTap: () => Navigator.of(sheetContext).pop(option.value),
                ),
              ),
            )
            .toList(),
      ),
    ),
  );
}

class AppFormSheet extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? footer;

  const AppFormSheet({super.key, this.title, required this.body, this.footer});

  @override
  Widget build(BuildContext context) {
    return AppSheetScaffold(
      title: title,
      showBodyDivider: title != null,
      body: body,
      footer: footer,
    );
  }
}

class AppConfirmationSheet extends StatelessWidget {
  final String title;
  final String? message;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final IconData icon;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final btn.Style confirmStyle;
  final bool showHeader;

  const AppConfirmationSheet({
    super.key,
    required this.title,
    this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.onConfirm,
    this.onCancel,
    this.icon = Icons.info_outline,
    this.iconColor,
    this.iconBackgroundColor,
    this.confirmStyle = btn.Style.primary,
    this.showHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AppSheetScaffold(
      showHeader: showHeader,
      showBodyDivider: false,
      showFooterDivider: false,
      scrollable: false,
      bodyPadding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xxl,
        AppSpacing.lg,
        AppSpacing.xxl,
        AppSpacing.sm,
      ),
      footerPadding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color:
                  iconBackgroundColor ??
                  colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 28,
              color: iconColor ?? colorScheme.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          if (message != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
      footer: AppActionRow(
        primaryLabel: confirmLabel,
        onPrimary: onConfirm,
        primaryStyle: confirmStyle,
        secondaryLabel: cancelLabel,
        onSecondary: onCancel ?? () => Navigator.of(context).pop(),
      ),
    );
  }
}
