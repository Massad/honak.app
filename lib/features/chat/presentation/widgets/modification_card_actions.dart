import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';

class ModificationPendingFooter extends StatelessWidget {
  final bool isBusinessMode;
  final VoidCallback onReject;
  final VoidCallback onApprove;

  const ModificationPendingFooter({
    super.key,
    required this.isBusinessMode,
    required this.onReject,
    required this.onApprove,
  });

  @override
  Widget build(BuildContext context) {
    if (isBusinessMode) {
      return Padding(
        padding: const EdgeInsetsDirectional.only(
          start: AppSpacing.md,
          end: AppSpacing.md,
          bottom: AppSpacing.md,
        ),
        child: Row(
          textDirection: TextDirection.ltr,
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onReject,
                icon: const Icon(Icons.close, size: 16),
                label: const Text('رفض'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                  side: const BorderSide(color: AppColors.divider),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.md),
                  ),
                  padding: const EdgeInsetsDirectional.symmetric(
                    vertical: AppSpacing.sm,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: FilledButton.icon(
                onPressed: onApprove,
                icon: const Icon(Icons.check, size: 16),
                label: const Text('موافقة'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.success,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.md),
                  ),
                  padding: const EdgeInsetsDirectional.symmetric(
                    vertical: AppSpacing.sm,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Customer mode — waiting
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.schedule, size: 14, color: AppColors.warning),
          SizedBox(width: AppSpacing.xs),
          Text(
            'بانتظار موافقة المتجر',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.warning,
            ),
          ),
        ],
      ),
    );
  }
}

class ModificationStatusBadge extends StatelessWidget {
  final String status;
  final String? rejectReason;

  const ModificationStatusBadge({
    super.key,
    required this.status,
    this.rejectReason,
  });

  @override
  Widget build(BuildContext context) {
    final (icon, label, color) = switch (status) {
      'approved' => (Icons.check_circle_outline, 'تم الموافقة', AppColors.success),
      'expired' => (Icons.timer_off_outlined, 'منتهي', AppColors.textHint),
      _ => (Icons.cancel_outlined, 'تم الرفض', AppColors.textSecondary),
    };
    final bgColor = status == 'approved'
        ? AppColors.success.withValues(alpha: 0.1)
        : AppColors.textHint.withValues(alpha: 0.1);

    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: AppSpacing.xs),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          if (status == 'rejected' && rejectReason != null) ...[
            const SizedBox(height: AppSpacing.xxs),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.md,
              ),
              child: Text(
                rejectReason!,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
