import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';
import 'package:honak/shared/widgets/story_ring_avatar.dart';
import 'package:honak/shared/widgets/story_viewer.dart';

/// Square avatar (64px, rounded-2xl) with optional story-ring gradient border.
/// When stories exist, shows a blue→cyan gradient border and opens StoryViewer on tap.
class PageAvatar extends StatelessWidget {
  final String? avatarUrl;
  final List<PageStory> stories;
  final VoidCallback? onOpenStories;

  const PageAvatar({
    super.key,
    this.avatarUrl,
    this.stories = const [],
    this.onOpenStories,
  });

  /// Convenience: opens StoryViewer with the given stories.
  static void openStories(BuildContext context, List<PageStory> stories) {
    StoryViewer.show(
      context,
      stories: stories
          .map((s) => StoryItem(
                id: s.id,
                imageUrl: s.imageUrl,
                duration: s.duration,
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasStories = stories.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          hasStories ? AppRadius.lg + 6 : AppRadius.lg,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: StoryRingAvatar(
        imageUrl: avatarUrl,
        name: '',
        size: 64,
        borderRadius: BorderRadius.circular(AppRadius.md),
        hasStories: hasStories,
        onTap: hasStories ? onOpenStories : null,
      ),
    );
  }
}
