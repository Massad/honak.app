import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';

import 'skeleton_box.dart';
import 'skeleton_container.dart';
import 'skeleton_text.dart';

class SkeletonProductCard extends StatelessWidget {
  final int count;
  final bool grid;

  const SkeletonProductCard({
    super.key,
    this.count = 4,
    this.grid = true,
  });

  @override
  Widget build(BuildContext context) {
    if (grid) {
      return _buildGrid();
    }
    return _buildList();
  }

  Widget _buildGrid() {
    return SkeletonContainer(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: AppSpacing.paddingAll(AppSpacing.lg),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.md,
          crossAxisSpacing: AppSpacing.md,
          childAspectRatio: 0.7,
        ),
        itemCount: count,
        itemBuilder: (context, index) => _buildGridItem(),
      ),
    );
  }

  Widget _buildGridItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: SkeletonBox(borderRadius: 12),
        ),
        SizedBox(height: AppSpacing.sm),
        const SkeletonText(lines: 2, height: 12),
        SizedBox(height: AppSpacing.xs),
        SkeletonText(width: 60, height: 12),
      ],
    );
  }

  Widget _buildList() {
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
                  const SkeletonBox(width: 80, height: 80, borderRadius: 12),
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SkeletonText(height: 14),
                        SizedBox(height: AppSpacing.sm),
                        SkeletonText(width: 140, height: 12),
                        SizedBox(height: AppSpacing.sm),
                        SkeletonText(width: 60, height: 12),
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
