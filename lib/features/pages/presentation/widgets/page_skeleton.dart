import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/skeleton/skeleton.dart';

/// Full-page skeleton shown while page detail data is loading.
/// Matches the new layout: cover → white section (info + action bar + tabs) → content.
class PageDetailSkeleton extends StatelessWidget {
  const PageDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Cover skeleton
            const SkeletonBox(width: double.infinity, height: 208),
            // White info section skeleton
            Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar (overlapping cover)
                  SkeletonBox(width: 64, height: 64),
                  SizedBox(height: 16),
                  // Name
                  SkeletonBox(width: 180, height: 22),
                  SizedBox(height: 8),
                  // Handle
                  SkeletonBox(width: 100, height: 14),
                  SizedBox(height: 12),
                  // Badge pills
                  Row(
                    children: [
                      SkeletonBox(width: 80, height: 20),
                      SizedBox(width: 8),
                      SkeletonBox(width: 60, height: 20),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Description
                  SkeletonBox(width: double.infinity, height: 14),
                  SizedBox(height: 6),
                  SkeletonBox(width: 220, height: 14),
                  SizedBox(height: 16),
                  // Location + hours
                  Row(
                    children: [
                      SkeletonBox(width: 140, height: 14),
                      SizedBox(width: 24),
                      SkeletonBox(width: 100, height: 14),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Trust metrics
                  Row(
                    children: [
                      Expanded(child: SkeletonBox(width: 110, height: 52)),
                      SizedBox(width: 8),
                      Expanded(child: SkeletonBox(width: 110, height: 52)),
                      SizedBox(width: 8),
                      Expanded(child: SkeletonBox(width: 110, height: 52)),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Action bar
                  Row(
                    children: [
                      Expanded(child: SkeletonBox(width: 80, height: 40)),
                      SizedBox(width: 8),
                      Expanded(child: SkeletonBox(width: 80, height: 40)),
                      SizedBox(width: 8),
                      SkeletonBox(width: 48, height: 40),
                      SizedBox(width: 8),
                      SkeletonBox(width: 48, height: 40),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            // Tab bar skeleton
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: const Row(
                children: [
                  SkeletonBox(width: 70, height: 32),
                  SizedBox(width: 16),
                  SkeletonBox(width: 50, height: 32),
                  SizedBox(width: 16),
                  SkeletonBox(width: 60, height: 32),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Content skeleton
            const SkeletonProductCard(count: 4, grid: true),
          ],
        ),
      ),
    );
  }
}
