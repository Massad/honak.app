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
import 'package:honak/shared/widgets/app_list_item.dart';
import 'package:honak/shared/widgets/app_section_header.dart';
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

    return AppSheetScaffold(
      title: null,
      showBodyDivider: false,
      showFooterDivider: false,
      bodyPadding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.md,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSectionHeader(
            title: subscription.packageName,
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.sm,
              0,
              AppSpacing.sm,
              AppSpacing.sm,
            ),
          ),
          AppListItem(
            leading: const Icon(Icons.refresh, color: AppColors.primary),
            title: 'تجديد الاشتراك',
            affordance: AppListItemAffordance.chevron,
            onTap: () {
              Navigator.pop(context);
              showRenewalRequestSheet(context, subscription);
            },
          ),
          if (policy?.canPause == true)
            AppListItem(
              leading: Icon(
                Icons.pause_circle_outline,
                color: AppColors.warning,
              ),
              title: 'إيقاف مؤقت',
              affordance: AppListItemAffordance.chevron,
              onTap: () {
                Navigator.pop(context);
                showPauseSubscriptionSheet(context, subscription);
              },
            ),
          if (policy?.canCancel == true)
            AppListItem(
              leading: const Icon(
                Icons.cancel_outlined,
                color: AppColors.error,
              ),
              title: 'إلغاء الاشتراك',
              affordance: AppListItemAffordance.chevron,
              onTap: () {
                Navigator.pop(context);
                showCancelSubscriptionSheet(context, subscription);
              },
            ),
          AppListItem(
            leading: Icon(
              Icons.receipt_long_outlined,
              color: context.colorScheme.onSurfaceVariant,
            ),
            title: 'سجل الاستخدام',
            affordance: AppListItemAffordance.chevron,
            onTap: () {
              Navigator.pop(context);
              showCreditHistorySheet(context, subscription);
            },
          ),
          AppListItem(
            leading: Icon(
              Icons.open_in_new,
              color: context.colorScheme.onSurfaceVariant,
            ),
            title: 'زيارة الصفحة',
            affordance: AppListItemAffordance.chevron,
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
