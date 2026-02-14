import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// Confirmation sheet for unlinking a tenant — reason selection + confirm.
class UnlinkTenantSheet extends StatefulWidget {
  final Tenant tenant;
  final ValueChanged<String> onConfirm;

  const UnlinkTenantSheet({
    super.key,
    required this.tenant,
    required this.onConfirm,
  });

  @override
  State<UnlinkTenantSheet> createState() => _UnlinkTenantSheetState();
}

class _UnlinkTenantSheetState extends State<UnlinkTenantSheet> {
  String? _selectedReason;

  static const _reasons = [
    'لم يعد مستأجراً',
    'خطأ في الربط',
    'أخرى',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSheetHeader(
          title: 'إلغاء ربط "${widget.tenant.name}"',
          onClose: () => Navigator.pop(context),
        ),

        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'لماذا تريد إلغاء الربط؟',
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Reason options
              for (final reason in _reasons) ...[
                GestureDetector(
                  onTap: () => setState(() => _selectedReason = reason),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                    decoration: BoxDecoration(
                      borderRadius: AppRadius.cardInner,
                      border: Border.all(
                        color: _selectedReason == reason
                            ? AppColors.primary
                            : context.colorScheme.outlineVariant,
                      ),
                      color: _selectedReason == reason
                          ? AppColors.primary.withValues(alpha: 0.04)
                          : null,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _selectedReason == reason
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          size: 20,
                          color: _selectedReason == reason
                              ? AppColors.primary
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Text(reason, style: context.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ],

              const SizedBox(height: AppSpacing.lg),

              // Confirm button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedReason != null
                      ? () => widget.onConfirm(_selectedReason!)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.button,
                    ),
                  ),
                  child: const Text(
                    'إلغاء الربط',
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
