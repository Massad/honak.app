import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/subscriptions/domain/entities/entities.dart';
import 'package:honak/features/subscriptions/presentation/widgets/renewal_request_sheet.dart';
import 'package:honak/shared/widgets/app_image.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

class InactiveSubscriptionCard extends StatelessWidget {
  final Subscription subscription;

  const InactiveSubscriptionCard({super.key, required this.subscription});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: AppRadius.card,
          border: Border.all(color: context.colorScheme.outlineVariant),
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            AppImage(
              url: subscription.pageLogo,
              width: 36,
              height: 36,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              placeholderIcon: Icons.storefront,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subscription.pageName,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
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
            const SizedBox(width: AppSpacing.sm),
            _StatusChip(status: subscription.status),
            const SizedBox(width: AppSpacing.sm),
            btn.Button(
              onPressed: () =>
                  showRenewalRequestSheet(context, subscription),
              label: 'تجديد',
              variant: btn.Variant.outlined,
              size: btn.ButtonSize.small,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final SubscriptionStatus status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final label = _labelForStatus(status);
    final color = _colorForStatus(context, status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  String _labelForStatus(SubscriptionStatus status) {
    switch (status) {
      case SubscriptionStatus.depleted:
        return 'نفدت';
      case SubscriptionStatus.expired:
        return 'انتهت';
      case SubscriptionStatus.cancelled:
        return 'ملغاة';
      default:
        return '';
    }
  }

  Color _colorForStatus(BuildContext context, SubscriptionStatus status) {
    switch (status) {
      case SubscriptionStatus.depleted:
        return AppColors.warning;
      case SubscriptionStatus.expired:
        return context.colorScheme.onSurfaceVariant;
      case SubscriptionStatus.cancelled:
        return AppColors.error;
      default:
        return context.colorScheme.onSurfaceVariant;
    }
  }
}
