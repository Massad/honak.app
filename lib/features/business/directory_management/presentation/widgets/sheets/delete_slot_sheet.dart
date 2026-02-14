import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// Delete confirmation sheet — warning text + red delete button.
class DeleteSlotSheet extends StatelessWidget {
  final Tenant tenant;
  final VoidCallback onConfirm;

  const DeleteSlotSheet({
    super.key,
    required this.tenant,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSheetHeader(
          title: 'حذف "${tenant.name}"',
          onClose: () => Navigator.pop(context),
        ),

        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Warning
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.06),
                  borderRadius: AppRadius.cardInner,
                  border: Border.all(
                    color: AppColors.error.withValues(alpha: 0.15),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 20,
                      color: AppColors.error,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'سيتم حذف هذا المستأجر نهائياً من الدليل. لا يمكن التراجع عن هذا الإجراء.',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Delete button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.button,
                    ),
                  ),
                  child: const Text(
                    'حذف نهائي',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ],
    );
  }
}
