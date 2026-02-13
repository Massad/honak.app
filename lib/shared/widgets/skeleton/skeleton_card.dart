import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';

import 'skeleton_box.dart';
import 'skeleton_container.dart';
import 'skeleton_text.dart';

class SkeletonCard extends StatelessWidget {
  final int count;

  const SkeletonCard({super.key, this.count = 1});

  @override
  Widget build(BuildContext context) {
    return SkeletonContainer(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < count; i++) ...[
              if (i > 0) SizedBox(height: AppSpacing.lg),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SkeletonBox(height: 180, borderRadius: 0),
                    Padding(
                      padding: AppSpacing.cardPadding,
                      child: const SkeletonText(lines: 2),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
