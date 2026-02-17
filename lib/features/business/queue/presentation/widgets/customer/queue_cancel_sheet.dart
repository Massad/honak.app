import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/queue/domain/entities/customer_queue_entry.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Shows the cancel confirmation bottom sheet.
Future<void> showQueueCancelSheet({
  required BuildContext context,
  required CustomerQueueEntry entry,
  required VoidCallback onConfirm,
}) {
  return showAppSheet<void>(
    context,
    builder: (_) => _QueueCancelSheet(entry: entry, onConfirm: onConfirm),
  );
}

class _QueueCancelSheet extends StatelessWidget {
  final CustomerQueueEntry entry;
  final VoidCallback onConfirm;

  const _QueueCancelSheet({required this.entry, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final price = Money(entry.totalPriceCents);

    return AppSheetScaffold(
      showBodyDivider: false,
      showFooterDivider: false,
      bodyPadding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        0,
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
          // Warning icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.warning_amber_rounded,
              size: 32,
              color: AppColors.error,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            context.l10n.queueCancelConfirmTitle,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHighest,
              borderRadius: AppRadius.cardInner,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  entry.packageName,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  price.toFormattedArabic(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            context.l10n.queueNoChargeNotice,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          btn.Button(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            label: context.l10n.queueConfirmCancel,
            style: btn.Style.danger,
            size: btn.ButtonSize.large,
            expand: true,
          ),
          const SizedBox(height: AppSpacing.sm),
          btn.Button(
            onPressed: () => Navigator.pop(context),
            label: context.l10n.queueStayInQueue,
            variant: btn.Variant.outlined,
            size: btn.ButtonSize.large,
            expand: true,
          ),
        ],
      ),
    );
  }
}
