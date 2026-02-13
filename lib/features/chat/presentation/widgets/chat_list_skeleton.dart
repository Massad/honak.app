import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/skeleton/skeleton_circle.dart';
import 'package:honak/shared/widgets/skeleton/skeleton_container.dart';
import 'package:honak/shared/widgets/skeleton/skeleton_text.dart';

class ChatListSkeleton extends StatelessWidget {
  final int count;

  const ChatListSkeleton({super.key, this.count = 6});

  @override
  Widget build(BuildContext context) {
    return SkeletonContainer(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsetsDirectional.symmetric(
          vertical: AppSpacing.sm,
        ),
        itemCount: count,
        separatorBuilder: (_, __) => const Divider(height: 1, indent: 76),
        itemBuilder: (_, __) => _buildSkeletonRow(),
      ),
    );
  }

  Widget _buildSkeletonRow() {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: AppSpacing.lg,
        end: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.md,
      ),
      child: Row(
        children: [
          const SkeletonCircle(size: 48),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonText(width: 120, height: 14),
                    SkeletonText(width: 40, height: 12),
                  ],
                ),
                SizedBox(height: AppSpacing.sm),
                SkeletonText(width: 200, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
