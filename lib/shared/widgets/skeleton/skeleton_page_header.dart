import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';

import 'skeleton_box.dart';
import 'skeleton_circle.dart';
import 'skeleton_container.dart';
import 'skeleton_text.dart';

class SkeletonPageHeader extends StatelessWidget {
  const SkeletonPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover image
          const SkeletonBox(height: 200, borderRadius: 0),
          // Overlapping avatar + info
          Transform.translate(
            offset: const Offset(0, -40),
            child: Padding(
              padding: AppSpacing.paddingH(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SkeletonCircle(size: 80),
                  SizedBox(height: AppSpacing.md),
                  // Name
                  SkeletonText(width: 160, height: 20),
                  SizedBox(height: AppSpacing.sm),
                  // Handle
                  SkeletonText(width: 100, height: 14),
                  SizedBox(height: AppSpacing.sm),
                  // Category + location
                  SkeletonText(width: 140, height: 14),
                  SizedBox(height: AppSpacing.lg),
                  // Action buttons
                  Row(
                    children: [
                      const SkeletonBox(width: 80, height: 36, borderRadius: 18),
                      SizedBox(width: AppSpacing.sm),
                      const SkeletonBox(width: 80, height: 36, borderRadius: 18),
                      SizedBox(width: AppSpacing.sm),
                      const SkeletonBox(width: 80, height: 36, borderRadius: 18),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
