import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/shimmer_loading.dart';

/// Shimmer skeleton loader for the orders page.
class OrdersSkeleton extends StatelessWidget {
  const OrdersSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          // Tab bar skeleton
          const Row(
            children: [
              Expanded(child: ShimmerLoading(height: 36)),
              SizedBox(width: AppSpacing.sm),
              Expanded(child: ShimmerLoading(height: 36)),
              SizedBox(width: AppSpacing.sm),
              Expanded(child: ShimmerLoading(height: 36)),
              SizedBox(width: AppSpacing.sm),
              Expanded(child: ShimmerLoading(height: 36)),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),

          // Order card skeletons
          Expanded(
            child: ListView.separated(
              itemCount: 4,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (_, __) => const _OrderCardSkeleton(),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderCardSkeleton extends StatelessWidget {
  const _OrderCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: avatar + name + badge
          Row(
            children: [
              const ShimmerLoading(
                width: 40,
                height: 40,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              const SizedBox(width: AppSpacing.md),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading(height: 14, width: 130),
                    SizedBox(height: AppSpacing.xs),
                    ShimmerLoading(height: 10, width: 70),
                  ],
                ),
              ),
              ShimmerLoading(
                width: 56,
                height: 24,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Summary line
          const Padding(
            padding: EdgeInsetsDirectional.only(start: 52),
            child: ShimmerLoading(height: 12, width: 180),
          ),
          const SizedBox(height: AppSpacing.md),

          // Bottom row: price + icons
          const Padding(
            padding: EdgeInsetsDirectional.only(start: 52),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerLoading(height: 12, width: 60),
                ShimmerLoading(height: 12, width: 40),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Progress bar placeholder
          const ShimmerLoading(
            height: 3,
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
        ],
      ),
    );
  }
}
