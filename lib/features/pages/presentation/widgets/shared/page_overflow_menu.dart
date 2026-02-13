import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/features/pages/presentation/widgets/shared/report_sheet.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// Overflow menu bottom sheet for page detail.
/// Shows: Copy Link, Claim Page (unclaimed only), Report/Suggest Correction.
class PageOverflowMenu extends StatelessWidget {
  final String handle;
  final String claimStatus;
  final VoidCallback? onClaimPage;
  final String pageName;

  const PageOverflowMenu._({
    required this.handle,
    required this.claimStatus,
    this.onClaimPage,
    required this.pageName,
  });

  /// Opens the overflow menu as a bottom sheet.
  static void show({
    required BuildContext context,
    required String handle,
    required String claimStatus,
    required String pageName,
    VoidCallback? onClaimPage,
  }) {
    showAppSheet<void>(
      context,
      builder: (_) => PageOverflowMenu._(
        handle: handle,
        claimStatus: claimStatus,
        onClaimPage: onClaimPage,
        pageName: pageName,
      ),
    );
  }

  bool get _isUnclaimed => claimStatus == 'unclaimed';
  bool get _isPlatformManaged => claimStatus == 'platform_managed';

  String get _reportLabel => _isPlatformManaged
      ? '\u0627\u0642\u062a\u0631\u0627\u062d \u062a\u0635\u062d\u064a\u062d'
      : _isUnclaimed
          ? '\u0627\u0644\u0625\u0628\u0644\u0627\u063a \u0639\u0646 \u062e\u0637\u0623'
          : '\u0627\u0644\u0625\u0628\u0644\u0627\u063a \u0639\u0646 \u0627\u0644\u0635\u0641\u062d\u0629';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.colorScheme.outlineVariant,
                borderRadius: AppRadius.pill,
              ),
            ),
            SizedBox(height: AppSpacing.sm),

            // Copy Link
            _MenuItem(
              icon: Icons.link,
              iconBgColor:
                  context.colorScheme.surfaceContainerHighest,
              iconColor: context.colorScheme.onSurfaceVariant,
              label:
                  '\u0646\u0633\u062e \u0627\u0644\u0631\u0627\u0628\u0637',
              onTap: () => _handleCopyLink(context),
            ),
            SizedBox(height: AppSpacing.xxs),

            // Claim Page (unclaimed only)
            if (_isUnclaimed && onClaimPage != null) ...[
              _MenuItem(
                icon: Icons.shield_outlined,
                iconBgColor: Colors.blue.shade50,
                iconColor: context.colorScheme.primary,
                label:
                    '\u0625\u062b\u0628\u0627\u062a \u0645\u0644\u0643\u064a\u0629 \u0627\u0644\u0635\u0641\u062d\u0629',
                subtitle:
                    '\u0647\u0644 \u0623\u0646\u062a \u0635\u0627\u062d\u0628 \u0647\u0630\u0627 \u0627\u0644\u0646\u0634\u0627\u0637\u061f',
                labelColor: context.colorScheme.primary,
                onTap: () {
                  Navigator.pop(context);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!context.mounted) return;
                    onClaimPage?.call();
                  });
                },
              ),
              SizedBox(height: AppSpacing.xxs),
            ],

            // Report / Suggest Correction
            _MenuItem(
              icon: Icons.flag_outlined,
              iconBgColor: _isPlatformManaged
                  ? Colors.blue.shade50
                  : Colors.red.shade50,
              iconColor: _isPlatformManaged
                  ? context.colorScheme.primary
                  : Colors.red.shade600,
              label: _reportLabel,
              labelColor: _isPlatformManaged
                  ? context.colorScheme.primary
                  : Colors.red.shade600,
              onTap: () {
                Navigator.pop(context);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!context.mounted) return;
                  ReportSheet.show(
                    context: context,
                    pageName: pageName,
                    claimStatus: claimStatus,
                  );
                });
              },
            ),
        ],
      ),
    );
  }

  void _handleCopyLink(BuildContext context) {
    final cleanHandle = handle.replaceAll('@', '');
    Clipboard.setData(ClipboardData(text: 'honak.app/$cleanHandle'));
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green.shade400, size: 16),
            SizedBox(width: AppSpacing.sm),
            const Text(
              '\u062a\u0645 \u0646\u0633\u062e \u0627\u0644\u0631\u0627\u0628\u0637',
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String label;
  final String? subtitle;
  final Color? labelColor;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.label,
    this.subtitle,
    this.labelColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppRadius.cardInner,
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 16, color: iconColor),
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: labelColor,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                          fontSize: 10,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
