import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/shimmer_loading.dart';

/// Shimmer skeleton loader for the request detail page.
class RequestDetailSkeleton extends StatelessWidget {
  const RequestDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Business info card
          _buildBusinessCardSkeleton(context),
          const SizedBox(height: AppSpacing.xl),

          // Timeline placeholder
          _buildTimelineSkeleton(),
          const SizedBox(height: AppSpacing.xl),

          // Info card (items / details)
          _buildInfoCardSkeleton(context),
        ],
      ),
    );
  }

  Widget _buildBusinessCardSkeleton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          const ShimmerLoading(
            width: 48,
            height: 48,
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          const SizedBox(width: AppSpacing.md),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoading(height: 16, width: 140),
                SizedBox(height: AppSpacing.sm),
                ShimmerLoading(height: 12, width: 100),
              ],
            ),
          ),
          ShimmerLoading(
            width: 64,
            height: 28,
            borderRadius: const BorderRadius.all(Radius.circular(14)),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineSkeleton() {
    return Column(
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(
            start: AppSpacing.lg,
            bottom: AppSpacing.lg,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const ShimmerLoading(
                    width: 12,
                    height: 12,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  if (index < 2)
                    Container(
                      width: 2,
                      height: 32,
                      margin: const EdgeInsets.symmetric(
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: AppSpacing.md),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading(height: 13, width: 100),
                    SizedBox(height: AppSpacing.xs),
                    ShimmerLoading(height: 11, width: 150),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoCardSkeleton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoading(height: 14, width: 80),
          SizedBox(height: AppSpacing.md),
          ShimmerLoading(height: 12),
          SizedBox(height: AppSpacing.sm),
          ShimmerLoading(height: 12, width: 200),
          SizedBox(height: AppSpacing.sm),
          ShimmerLoading(height: 12, width: 160),
          SizedBox(height: AppSpacing.lg),
          // Divider line
          ShimmerLoading(height: 1),
          SizedBox(height: AppSpacing.lg),
          // Total line
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerLoading(height: 14, width: 60),
              ShimmerLoading(height: 14, width: 80),
            ],
          ),
        ],
      ),
    );
  }
}
