import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';

import 'skeleton_box.dart';
import 'skeleton_circle.dart';
import 'skeleton_container.dart';
import 'skeleton_text.dart';

class SkeletonFeedPost extends StatelessWidget {
  final int count;

  const SkeletonFeedPost({super.key, this.count = 3});

  @override
  Widget build(BuildContext context) {
    return SkeletonContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < count; i++) ...[
            if (i > 0) const Divider(height: 1),
            _buildPost(),
          ],
        ],
      ),
    );
  }

  Widget _buildPost() {
    return Padding(
      padding: AppSpacing.cardPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SkeletonCircle(size: 40),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonText(width: 100, height: 14),
                    SizedBox(height: AppSpacing.xs),
                    SkeletonText(width: 60, height: 12),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm),
          const SkeletonBox(height: 200),
          SizedBox(height: AppSpacing.sm),
          const SkeletonText(lines: 2),
        ],
      ),
    );
  }
}
