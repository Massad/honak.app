import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/subscriptions/domain/entities/entities.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

void showCancelSubscriptionSheet(
  BuildContext context,
  Subscription subscription,
) {
  showAppSheet(
    context,
    builder: (context) =>
        _CancelSubscriptionSheet(subscription: subscription),
  );
}

class _CancelSubscriptionSheet extends StatelessWidget {
  final Subscription subscription;

  const _CancelSubscriptionSheet({required this.subscription});

  @override
  Widget build(BuildContext context) {
    final policy = subscription.policy;
    final noticeDays = policy?.cancellationNoticeDays ?? 0;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: context.colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.cancel_outlined,
              size: 28,
              color: AppColors.error,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'إلغاء الاشتراك',
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _WarningBanner(policy: policy),
          if (noticeDays > 0) ...[
            const SizedBox(height: AppSpacing.md),
            _NoticeBanner(noticeDays: noticeDays),
          ],
          const SizedBox(height: AppSpacing.xxl),
          btn.Button(
            onPressed: () {
              Navigator.pop(context);
              context.showSnackBar('تم إلغاء الاشتراك');
            },
            label: 'تأكيد الإلغاء',
            style: btn.Style.danger,
            size: btn.ButtonSize.large,
            expand: true,
          ),
          const SizedBox(height: AppSpacing.sm),
          btn.Button(
            onPressed: () => Navigator.pop(context),
            label: 'العودة',
            variant: btn.Variant.outlined,
            size: btn.ButtonSize.large,
            expand: true,
          ),
        ],
      ),
    );
  }
}

class _WarningBanner extends StatelessWidget {
  final SubscriptionPolicy? policy;

  const _WarningBanner({required this.policy});

  @override
  Widget build(BuildContext context) {
    final refundable = (policy?.cancellationFee ?? 0) == 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.error.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber, size: 16, color: AppColors.error),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'تنبيه',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            refundable
                ? 'سيتم إلغاء اشتراكك مع استرجاع المبلغ المتبقي حسب سياسة المتجر.'
                : 'عند الإلغاء لن يتم استرجاع أي مبالغ مدفوعة. سيبقى اشتراكك فعالاً حتى نهاية الفترة الحالية.',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.error.withValues(alpha: 0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _NoticeBanner extends StatelessWidget {
  final int noticeDays;

  const _NoticeBanner({required this.noticeDays});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 16, color: AppColors.info),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'مدة الإشعار المطلوبة: $noticeDays يوم قبل الإلغاء',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.info,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
