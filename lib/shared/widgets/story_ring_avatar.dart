import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';

/// Avatar with gradient ring for stories.
///
/// - Blue→cyan gradient ring when `hasStories && !allSeen`
/// - Gray ring when `allSeen`
/// - No ring when `!hasStories`
class StoryRingAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double radius;
  final bool hasStories;
  final bool allSeen;
  final VoidCallback? onTap;

  const StoryRingAvatar({
    super.key,
    this.imageUrl,
    required this.name,
    this.radius = 26,
    this.hasStories = true,
    this.allSeen = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final showGradient = hasStories && !allSeen;
    final showGrayRing = hasStories && allSeen;

    Widget avatar = CircleAvatar(
      radius: radius,
      backgroundColor: context.colorScheme.surfaceContainerHighest,
      backgroundImage:
          imageUrl != null ? CachedNetworkImageProvider(imageUrl!) : null,
      child: imageUrl == null
          ? Text(
              name.isNotEmpty ? name[0] : '',
              style: context.textTheme.titleSmall?.copyWith(
                fontSize: radius * 0.65,
              ),
            )
          : null,
    );

    if (!hasStories) return _wrapTap(avatar);

    // Ring around avatar
    return _wrapTap(
      Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: showGradient
              ? LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    context.feedColors.storyRingStart,
                    context.feedColors.storyRingEnd,
                  ],
                )
              : null,
          border: showGrayRing
              ? Border.all(
                  color: context.colorScheme.outlineVariant,
                  width: 2,
                )
              : null,
        ),
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colorScheme.surface,
          ),
          child: avatar,
        ),
      ),
    );
  }

  Widget _wrapTap(Widget child) {
    if (onTap == null) return child;
    return GestureDetector(onTap: onTap, child: child);
  }
}
