import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Drag handle for the edit-order bottom sheet.
class EditOrderDragHandle extends StatelessWidget {
  const EditOrderDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: AppSpacing.md),
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: context.colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

/// Header row showing request id, business name, and close button.
class EditOrderHeader extends StatelessWidget {
  final String requestId;
  final String businessName;
  final VoidCallback onClose;

  const EditOrderHeader({
    super.key,
    required this.requestId,
    required this.businessName,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تعديل الطلب #$requestId',
                  style: textTheme.titleSmall,
                ),
                Text(
                  businessName,
                  style: textTheme.labelSmall
                      ?.copyWith(color: context.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close, size: 20),
          ),
        ],
      ),
    );
  }
}

/// Info notice about modification requiring business approval.
class EditOrderInfoNotice extends StatelessWidget {
  const EditOrderInfoNotice({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Container(
        padding: const EdgeInsetsDirectional.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.05),
          borderRadius: AppRadius.cardInner,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info_outline,
                size: 14, color: AppColors.primary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                'تعديل الطلب يتطلب موافقة المتجر. سيتم إعلامك عند الرد.',
                style: textTheme.labelSmall
                    ?.copyWith(color: context.colorScheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Warning shown when all items have been removed.
class EditOrderEmptyWarning extends StatelessWidget {
  const EditOrderEmptyWarning({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.05),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
        borderRadius: AppRadius.cardInner,
      ),
      child: Column(
        children: [
          const Icon(Icons.error_outline, size: 24, color: AppColors.error),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'لا يمكن حفظ طلب بدون منتجات',
            style: textTheme.bodySmall?.copyWith(color: AppColors.error),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'أضف منتجات أو قم بإلغاء الطلب',
            style: textTheme.labelSmall
                ?.copyWith(color: context.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

/// Bottom action bar with Cancel / Send buttons.
class EditOrderActions extends StatelessWidget {
  final bool canSave;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const EditOrderActions({
    super.key,
    required this.canSave,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.lg,
        end: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border:
            Border(top: BorderSide(color: context.colorScheme.outlineVariant, width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: btn.Button(
                onPressed: onCancel,
                label: 'إلغاء',
                variant: btn.Variant.outlined,
                size: btn.ButtonSize.large,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: btn.Button(
                onPressed: canSave ? onSave : null,
                label: 'إرسال طلب التعديل',
                icon: const btn.ButtonIcon(Icons.send),
                size: btn.ButtonSize.large,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
