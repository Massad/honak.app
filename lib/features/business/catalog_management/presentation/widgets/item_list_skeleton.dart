import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/shimmer_loading.dart';

/// Shimmer skeleton loader displayed while items are loading.
class ItemListSkeleton extends StatelessWidget {
  const ItemListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          // Search bar skeleton
          const ShimmerLoading(
            height: 40,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          const SizedBox(height: AppSpacing.md),

          // Category pills skeleton
          Row(
            children: [
              for (int i = 0; i < 4; i++) ...[
                if (i > 0) const SizedBox(width: AppSpacing.sm),
                ShimmerLoading(
                  width: 60 + (i * 10),
                  height: 30,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Item cards skeleton
          ...List.generate(5, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                ),
                padding: const EdgeInsets.all(AppSpacing.md),
                child: const Row(
                  children: [
                    ShimmerLoading(
                      width: 60,
                      height: 60,
                      borderRadius:
                          BorderRadius.all(Radius.circular(12)),
                    ),
                    SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ShimmerLoading(height: 14, width: 120),
                          SizedBox(height: AppSpacing.sm),
                          ShimmerLoading(height: 12, width: 80),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
