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
    final cs = Theme.of(context).colorScheme;

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
              onPressed: isBusinessMode ? onReject : null,
              icon: const Icon(Icons.close, size: 16),
              label: const Text('رفض'),
              style: OutlinedButton.styleFrom(
                foregroundColor: cs.onSurfaceVariant,
                disabledForegroundColor:
                    cs.onSurfaceVariant.withValues(alpha: 0.38),
                side: BorderSide(color: cs.outlineVariant),
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
              onPressed: isBusinessMode ? onApprove : null,
              icon: const Icon(Icons.check, size: 16),
              label: const Text('موافقة'),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.success,
                disabledBackgroundColor:
                    AppColors.success.withValues(alpha: 0.38),
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
    final cs = Theme.of(context).colorScheme;
    final (icon, label, color) = switch (status) {
      'approved' => (Icons.check_circle_outline, 'تم الموافقة', AppColors.success),
      'expired' => (Icons.timer_off_outlined, 'منتهي', cs.onSurfaceVariant),
      _ => (Icons.cancel_outlined, 'تم الرفض', cs.onSurfaceVariant),
    };
    final bgColor = status == 'approved'
        ? AppColors.success.withValues(alpha: 0.1)
        : cs.onSurfaceVariant.withValues(alpha: 0.1);

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
                style: TextStyle(
                  fontSize: 11,
                  color: cs.onSurfaceVariant,
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
