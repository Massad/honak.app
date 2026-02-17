import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Identity verification before invite — shows page info + confirm/cancel.
class TenantInviteConfirm extends StatelessWidget {
  final Map<String, dynamic> page;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const TenantInviteConfirm({
    super.key,
    required this.page,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: AppSpacing.lg),

        // Page avatar
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withValues(alpha: 0.1),
          ),
          child: const Icon(
            Icons.storefront,
            size: 28,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Page name
        Text(
          page['name'] as String,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),

        // Handle + category
        Text(
          '${page['handle']} · ${page['category']}',
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),

        // Followers
        Text(
          context.l10n.dirTenantFormFollowers(page['followers'] as int),
          style: context.textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),

        // Confirmation question
        Text(
          context.l10n.dirInviteConfirmTitle,
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.xxl,
          ),
          child: Text(
            context.l10n.dirInviteConfirmDesc,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),

        // Buttons
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.lg,
          ),
          child: Row(
            textDirection: TextDirection.ltr,
            children: [
              // Cancel
              Expanded(
                child: btn.Button(
                  onPressed: onCancel,
                  label: context.l10n.dirInviteConfirmCancel,
                  variant: btn.Variant.outlined,
                  size: btn.ButtonSize.large,
                  expand: true,
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Confirm
              Expanded(
                child: btn.Button(
                  onPressed: onConfirm,
                  label: context.l10n.dirInviteConfirmYes,
                  size: btn.ButtonSize.large,
                  expand: true,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}
