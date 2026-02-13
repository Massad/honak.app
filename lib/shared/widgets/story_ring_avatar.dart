import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';

/// Avatar with gradient ring for stories.
///
/// Supports two shapes:
/// - **Circle** (default): set [radius], uses [CircleAvatar]
/// - **Rounded-rect**: set [size] + [borderRadius]
///
/// Ring states:
/// - Blue→cyan gradient ring when `hasStories && !allSeen`
/// - Gray ring when `allSeen`
/// - No ring when `!hasStories`
class StoryRingAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;

  /// Radius for circle mode. Ignored when [borderRadius] is set.
  final double radius;

  /// Explicit width/height for rounded-rect mode.
  /// Falls back to `radius * 2` if not provided.
  final double? size;

  /// When non-null, renders a rounded-rect avatar instead of circle.
  final BorderRadius? borderRadius;

  final bool hasStories;
  final bool allSeen;
  final VoidCallback? onTap;

  /// Custom placeholder widget when [imageUrl] is null.
  /// Falls back to a letter avatar.
  final Widget? placeholder;

  const StoryRingAvatar({
    super.key,
    this.imageUrl,
    required this.name,
    this.radius = 26,
    this.size,
    this.borderRadius,
    this.hasStories = true,
    this.allSeen = false,
    this.onTap,
    this.placeholder,
  });

  bool get _isRoundedRect => borderRadius != null;

  @override
  Widget build(BuildContext context) {
    final avatar = _isRoundedRect
        ? _buildRectAvatar(context)
        : _buildCircleAvatar(context);

    if (!hasStories) return _wrapTap(avatar);

    final showGradient = !allSeen;

    if (_isRoundedRect) {
      return _wrapTap(_buildRectRing(context, avatar, showGradient));
    }
    return _wrapTap(_buildCircleRing(context, avatar, showGradient));
  }

  // ─── Circle mode ────────────────────────────────────────────

  Widget _buildCircleAvatar(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: context.colorScheme.surfaceContainerHighest,
      backgroundImage:
          imageUrl != null ? CachedNetworkImageProvider(imageUrl!) : null,
      child: imageUrl == null
          ? (placeholder ??
              Text(
                name.isNotEmpty ? name[0] : '',
                style: context.textTheme.titleSmall?.copyWith(
                  fontSize: radius * 0.65,
                ),
              ))
          : null,
    );
  }

  Widget _buildCircleRing(
    BuildContext context,
    Widget avatar,
    bool showGradient,
  ) {
    return Container(
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
        border: !showGradient
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
    );
  }

  // ─── Rounded-rect mode ──────────────────────────────────────

  Widget _buildRectAvatar(BuildContext context) {
    final s = size ?? radius * 2;
    final br = borderRadius!;

    return ClipRRect(
      borderRadius: br,
      child: imageUrl != null
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              width: s,
              height: s,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) =>
                  _rectPlaceholder(context, s),
            )
          : _rectPlaceholder(context, s),
    );
  }

  Widget _rectPlaceholder(BuildContext context, double s) {
    return Container(
      width: s,
      height: s,
      color: context.colorScheme.surfaceContainerHighest,
      child: placeholder ??
          Center(
            child: Text(
              name.isNotEmpty ? name[0] : '',
              style: context.textTheme.titleSmall?.copyWith(
                fontSize: s * 0.35,
              ),
            ),
          ),
    );
  }

  Widget _buildRectRing(
    BuildContext context,
    Widget avatar,
    bool showGradient,
  ) {
    final br = borderRadius!;
    // Slightly larger radius for the outer ring
    final outerBr = br + const BorderRadius.all(Radius.circular(2));

    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: outerBr,
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
        border: !showGradient
            ? Border.all(
                color: context.colorScheme.outlineVariant,
                width: 2,
              )
            : null,
      ),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: br,
          color: context.colorScheme.surface,
        ),
        child: avatar,
      ),
    );
  }

  Widget _wrapTap(Widget child) {
    if (onTap == null) return child;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: child,
    );
  }
}
