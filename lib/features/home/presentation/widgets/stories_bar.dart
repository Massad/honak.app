import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/home/domain/entities/story.dart';
import 'package:honak/shared/widgets/story_ring_avatar.dart';

class StoriesBar extends StatelessWidget {
  final List<Story> stories;
  final ValueChanged<int>? onStoryTap;

  const StoriesBar({
    super.key,
    required this.stories,
    this.onStoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: AppSpacing.paddingH(AppSpacing.lg),
        itemCount: stories.length,
        separatorBuilder: (_, __) => SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) => _StoryCircle(
          story: stories[index],
          onTap: onStoryTap != null ? () => onStoryTap!(index) : null,
        ),
      ),
    );
  }
}

class _StoryCircle extends StatelessWidget {
  final Story story;
  final VoidCallback? onTap;

  const _StoryCircle({required this.story, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 68,
        child: Column(
          children: [
            StoryRingAvatar(
              imageUrl: story.pageAvatarUrl,
              name: story.pageName,
              radius: 26,
              hasStories: true,
              allSeen: !story.hasNew,
            ),
            SizedBox(height: AppSpacing.xs),
            Text(
              story.pageName,
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 10,
                fontWeight: story.hasNew ? FontWeight.w600 : null,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
