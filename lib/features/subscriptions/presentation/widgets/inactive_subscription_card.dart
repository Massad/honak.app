import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/subscriptions/domain/entities/entities.dart';
import 'package:honak/features/subscriptions/presentation/widgets/renewal_request_sheet.dart';

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
          border: Border.all(color: Colors.grey.shade100),
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.sm),
              child: CachedNetworkImage(
                imageUrl: subscription.pageLogo ?? '',
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  width: 36,
                  height: 36,
                  color: Colors.grey.shade100,
                  child: Icon(
                    Icons.storefront,
                    size: 18,
                    color: Colors.grey.shade300,
                  ),
                ),
                errorWidget: (_, __, ___) => Container(
                  width: 36,
                  height: 36,
                  color: Colors.grey.shade100,
                  child: Icon(
                    Icons.storefront,
                    size: 18,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
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
                      color: AppColors.textSecondary,
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
            SizedBox(
              height: 30,
              child: OutlinedButton(
                onPressed: () =>
                    showRenewalRequestSheet(context, subscription),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  textStyle: const TextStyle(fontSize: 11),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.button,
                  ),
                ),
                child: const Text('تجديد'),
              ),
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
    final color = _colorForStatus(status);

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

  Color _colorForStatus(SubscriptionStatus status) {
    switch (status) {
      case SubscriptionStatus.depleted:
        return AppColors.warning;
      case SubscriptionStatus.expired:
        return Colors.grey;
      case SubscriptionStatus.cancelled:
        return AppColors.error;
      default:
        return Colors.grey;
    }
  }
}
