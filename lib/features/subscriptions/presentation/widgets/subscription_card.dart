import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/subscriptions/domain/entities/entities.dart';
import 'package:honak/features/subscriptions/presentation/widgets/renewal_request_sheet.dart';
import 'package:honak/features/subscriptions/presentation/widgets/subscription_menu_sheet.dart';
import 'package:honak/shared/widgets/app_image.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

class SubscriptionCard extends StatelessWidget {
  final Subscription subscription;

  const SubscriptionCard({super.key, required this.subscription});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showSubscriptionMenuSheet(context, subscription),
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: AppRadius.card,
          border: Border.all(color: context.colorScheme.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            _CardHeader(subscription: subscription),
            _BalanceSection(subscription: subscription),
            if (_isNearExpiry) _ExpiryWarning(subscription: subscription),
            _ActionButtons(subscription: subscription),
          ],
        ),
      ),
    );
  }

  bool get _isNearExpiry {
    final days = subscription.daysUntilExpiry;
    return days != null && days <= 7 && days > 0;
  }
}

class _CardHeader extends StatelessWidget {
  final Subscription subscription;

  const _CardHeader({required this.subscription});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          AppImage(
            url: subscription.pageLogo,
            width: 48,
            height: 48,
            borderRadius: BorderRadius.circular(AppRadius.md),
            placeholderIcon: Icons.storefront,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subscription.pageName,
                  style: context.textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subscription.packageName,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    fontSize: 11,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BalanceSection extends StatelessWidget {
  final Subscription subscription;

  const _BalanceSection({required this.subscription});

  @override
  Widget build(BuildContext context) {
    final isDateOnly = subscription.model == SubscriptionModel.dateOnly;
    final health = subscription.balanceHealth;

    final bgColor = isDateOnly
        ? const Color(0xFFE3F2FD)
        : _bgColorForHealth(health);
    final textColor = isDateOnly
        ? AppColors.info
        : _textColorForHealth(health);

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isDateOnly ? 'الرصيد' : 'الرصيد المتبقي',
                  style: TextStyle(fontSize: 11, color: textColor),
                ),
                Text(
                  isDateOnly
                      ? 'غير محدود'
                      : '${subscription.remainingCredits ?? 0} / ${subscription.totalCredits ?? 0}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
              ],
            ),
            if (!isDateOnly &&
                subscription.totalCredits != null &&
                subscription.totalCredits! > 0) ...[
              const SizedBox(height: AppSpacing.sm),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (subscription.remainingCredits ?? 0) /
                      subscription.totalCredits!,
                  minHeight: 6,
                  backgroundColor: textColor.withValues(alpha: 0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _bgColorForHealth(BalanceHealth health) {
    switch (health) {
      case BalanceHealth.healthy:
        return const Color(0xFFE8F5E9);
      case BalanceHealth.low:
        return const Color(0xFFFFF3E0);
      case BalanceHealth.depleted:
        return const Color(0xFFFFEBEE);
    }
  }

  Color _textColorForHealth(BalanceHealth health) {
    switch (health) {
      case BalanceHealth.healthy:
        return AppColors.success;
      case BalanceHealth.low:
        return AppColors.warning;
      case BalanceHealth.depleted:
        return AppColors.error;
    }
  }
}

class _ExpiryWarning extends StatelessWidget {
  final Subscription subscription;

  const _ExpiryWarning({required this.subscription});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.schedule, size: 14, color: AppColors.warning),
          const SizedBox(width: AppSpacing.sm),
          Text(
            'ينتهي خلال ${subscription.daysUntilExpiry} أيام',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.warning,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final Subscription subscription;

  const _ActionButtons({required this.subscription});

  @override
  Widget build(BuildContext context) {
    final isDateOnly = subscription.model == SubscriptionModel.dateOnly;
    final orderLabel = isDateOnly ? 'احجز بالرصيد' : 'اطلب برصيدك';

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: btn.Button(
              onPressed: () =>
                  context.push(Routes.pagePath(subscription.pageId)),
              label: orderLabel,
              size: btn.ButtonSize.small,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: btn.Button(
              onPressed: () =>
                  showRenewalRequestSheet(context, subscription),
              label: 'تجديد',
              variant: btn.Variant.outlined,
              size: btn.ButtonSize.small,
            ),
          ),
        ],
      ),
    );
  }
}
