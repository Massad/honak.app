import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/skeleton/skeleton.dart';

class ChatDetailSkeleton extends StatelessWidget {
  const ChatDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonContainer(
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Column(
          children: [
            // Incoming bubble — start aligned
            _buildBubble(
              alignment: AlignmentDirectional.centerStart,
              width: 200,
              height: 44,
            ),
            const SizedBox(height: AppSpacing.sm),
            // Outgoing bubble — end aligned
            _buildBubble(
              alignment: AlignmentDirectional.centerEnd,
              width: 160,
              height: 44,
            ),
            const SizedBox(height: AppSpacing.sm),
            // Outgoing — short
            _buildBubble(
              alignment: AlignmentDirectional.centerEnd,
              width: 120,
              height: 36,
            ),
            const SizedBox(height: AppSpacing.sm),
            // Incoming — long
            _buildBubble(
              alignment: AlignmentDirectional.centerStart,
              width: 240,
              height: 60,
            ),
            const SizedBox(height: AppSpacing.sm),
            // Image placeholder — incoming
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: SkeletonBox(width: 180, height: 140, borderRadius: 12),
            ),
            const SizedBox(height: AppSpacing.sm),
            // Outgoing bubble
            _buildBubble(
              alignment: AlignmentDirectional.centerEnd,
              width: 180,
              height: 44,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBubble({
    required AlignmentDirectional alignment,
    required double width,
    required double height,
  }) {
    return Align(
      alignment: alignment,
      child: SkeletonBox(width: width, height: height, borderRadius: 16),
    );
  }
}
