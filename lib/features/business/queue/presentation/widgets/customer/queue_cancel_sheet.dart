import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/queue/domain/entities/customer_queue_entry.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Shows the cancel confirmation bottom sheet.
Future<void> showQueueCancelSheet({
  required BuildContext context,
  required CustomerQueueEntry entry,
  required VoidCallback onConfirm,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => _QueueCancelSheet(
      entry: entry,
      onConfirm: onConfirm,
    ),
  );
}

class _QueueCancelSheet extends StatelessWidget {
  final CustomerQueueEntry entry;
  final VoidCallback onConfirm;

  const _QueueCancelSheet({
    required this.entry,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final price = Money(entry.totalPriceCents);

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.xxl),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: AppSpacing.sm),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.colorScheme.outlineVariant,
                borderRadius: AppRadius.pill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
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
                // Title
                Text(
                  context.l10n.queueCancelConfirmTitle,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                // Service summary
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
                // No charge notice
                Text(
                  context.l10n.queueNoChargeNotice,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                // Confirm cancel button
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
                // Stay in queue button
                btn.Button(
                  onPressed: () => Navigator.pop(context),
                  label: context.l10n.queueStayInQueue,
                  variant: btn.Variant.outlined,
                  size: btn.ButtonSize.large,
                  expand: true,
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
