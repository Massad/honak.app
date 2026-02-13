import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';

import 'skeleton_circle.dart';
import 'skeleton_container.dart';
import 'skeleton_text.dart';

class SkeletonListTile extends StatelessWidget {
  final int count;

  const SkeletonListTile({super.key, this.count = 1});

  @override
  Widget build(BuildContext context) {
    return SkeletonContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < count; i++) ...[
            if (i > 0) const Divider(height: 1),
            Padding(
              padding: AppSpacing.listItemPadding,
              child: Row(
                children: [
                  const SkeletonCircle(size: 40),
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonText(width: 120, height: 14),
                        SizedBox(height: AppSpacing.sm),
                        SkeletonText(width: 200, height: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
