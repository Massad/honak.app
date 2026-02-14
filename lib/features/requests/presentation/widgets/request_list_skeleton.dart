import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/shimmer_loading.dart';

/// Shimmer skeleton loader for the customer request list.
class RequestListSkeleton extends StatelessWidget {
  const RequestListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: 3,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (_, __) => const _RequestCardSkeleton(),
    );
  }
}

class _RequestCardSkeleton extends StatelessWidget {
  const _RequestCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: avatar + business name + status badge
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
                    ShimmerLoading(height: 14, width: 120),
                    SizedBox(height: AppSpacing.xs),
                    ShimmerLoading(height: 11, width: 80),
                  ],
                ),
              ),
              ShimmerLoading(
                width: 60,
                height: 24,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Items summary line
          const ShimmerLoading(height: 12, width: 180),
          const SizedBox(height: AppSpacing.sm),
          // Price / date line
          const ShimmerLoading(height: 12, width: 100),
        ],
      ),
    );
  }
}
