import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/subscriptions/domain/entities/entities.dart';
import 'package:honak/features/subscriptions/presentation/widgets/inactive_subscription_card.dart';
import 'package:honak/features/subscriptions/presentation/widgets/subscription_card.dart';

class SubscriptionsTab extends StatelessWidget {
  final List<Subscription> active;
  final List<Subscription> inactive;

  const SubscriptionsTab({
    super.key,
    required this.active,
    required this.inactive,
  });

  @override
  Widget build(BuildContext context) {
    if (active.isEmpty && inactive.isEmpty) {
      return _EmptyState();
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        _SummaryBar(activeCount: active.length, inactiveCount: inactive.length),
        const SizedBox(height: AppSpacing.lg),
        if (active.isNotEmpty) ...[
          _SectionHeader(
            icon: Icons.circle,
            iconColor: AppColors.success,
            iconSize: 8,
            label: 'نشطة',
            count: active.length,
          ),
          const SizedBox(height: AppSpacing.sm),
          ...active.map((sub) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: SubscriptionCard(subscription: sub),
              )),
        ],
        if (inactive.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          _SectionHeader(
            icon: Icons.access_time,
            iconColor: Colors.grey,
            iconSize: 14,
            label: 'منتهية',
            count: inactive.length,
          ),
          const SizedBox(height: AppSpacing.sm),
          ...inactive.map((sub) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: InactiveSubscriptionCard(subscription: sub),
              )),
        ],
      ],
    );
  }
}

class _SummaryBar extends StatelessWidget {
  final int activeCount;
  final int inactiveCount;

  const _SummaryBar({required this.activeCount, required this.inactiveCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatChip(
          label: '$activeCount نشطة',
          color: AppColors.success,
        ),
        const SizedBox(width: AppSpacing.sm),
        _StatChip(
          label: '$inactiveCount منتهية',
          color: Colors.grey,
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final String label;
  final int count;

  const _SectionHeader({
    required this.icon,
    required this.iconColor,
    required this.iconSize,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: iconSize, color: iconColor),
        const SizedBox(width: AppSpacing.sm),
        Text(
          label,
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          '($count)',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.card_membership_outlined,
              size: 56,
              color: Colors.grey.shade200,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'لا توجد اشتراكات',
              style: context.textTheme.bodyLarge?.copyWith(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'عند اشتراكك في باقات المتاجر ستظهر هنا',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
