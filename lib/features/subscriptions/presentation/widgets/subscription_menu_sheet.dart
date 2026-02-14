import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/subscriptions/domain/entities/entities.dart';
import 'package:honak/features/subscriptions/presentation/widgets/cancel_subscription_sheet.dart';
import 'package:honak/features/subscriptions/presentation/widgets/credit_history_sheet.dart';
import 'package:honak/features/subscriptions/presentation/widgets/pause_subscription_sheet.dart';
import 'package:honak/features/subscriptions/presentation/widgets/renewal_request_sheet.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

void showSubscriptionMenuSheet(
  BuildContext context,
  Subscription subscription,
) {
  showAppSheet(
    context,
    builder: (context) => _SubscriptionMenuSheet(subscription: subscription),
  );
}

class _SubscriptionMenuSheet extends StatelessWidget {
  final Subscription subscription;

  const _SubscriptionMenuSheet({required this.subscription});

  @override
  Widget build(BuildContext context) {
    final policy = subscription.policy;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        0,
        AppSpacing.sm,
        0,
        AppSpacing.sm,
      ),
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
          const SizedBox(height: AppSpacing.md),
          Text(
            subscription.packageName,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ListTile(
            leading: const Icon(Icons.refresh, color: AppColors.primary),
            title: const Text('تجديد الاشتراك'),
            onTap: () {
              Navigator.pop(context);
              showRenewalRequestSheet(context, subscription);
            },
          ),
          if (policy?.canPause == true)
            ListTile(
              leading: Icon(
                Icons.pause_circle_outline,
                color: AppColors.warning,
              ),
              title: const Text('إيقاف مؤقت'),
              onTap: () {
                Navigator.pop(context);
                showPauseSubscriptionSheet(context, subscription);
              },
            ),
          if (policy?.canCancel == true)
            ListTile(
              leading: const Icon(Icons.cancel_outlined, color: AppColors.error),
              title: const Text('إلغاء الاشتراك'),
              onTap: () {
                Navigator.pop(context);
                showCancelSubscriptionSheet(context, subscription);
              },
            ),
          ListTile(
            leading: Icon(
              Icons.receipt_long_outlined,
              color: context.colorScheme.onSurfaceVariant,
            ),
            title: const Text('سجل الاستخدام'),
            onTap: () {
              Navigator.pop(context);
              showCreditHistorySheet(context, subscription);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.open_in_new,
              color: context.colorScheme.onSurfaceVariant,
            ),
            title: const Text('زيارة الصفحة'),
            onTap: () {
              Navigator.pop(context);
              context.push(Routes.pagePath(subscription.pageId));
            },
          ),
        ],
      ),
    );
  }
}
