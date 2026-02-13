import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/skeleton/skeleton_circle.dart';
import 'package:honak/shared/widgets/skeleton/skeleton_container.dart';
import 'package:honak/shared/widgets/skeleton/skeleton_text.dart';

class NotificationListSkeleton extends StatelessWidget {
  const NotificationListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonContainer(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        itemCount: 8,
        separatorBuilder: (_, __) =>
            const SizedBox(height: AppSpacing.sm),
        itemBuilder: (_, __) => const _SkeletonNotificationCard(),
      ),
    );
  }
}

class _SkeletonNotificationCard extends StatelessWidget {
  const _SkeletonNotificationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SkeletonCircle(size: 40),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonText(width: 100, height: 12),
                const SizedBox(height: AppSpacing.sm),
                const SkeletonText(height: 12, lines: 2),
                const SizedBox(height: AppSpacing.xs),
                SkeletonText(width: 60, height: 10),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          const SkeletonCircle(size: 8),
        ],
      ),
    );
  }
}
