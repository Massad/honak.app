import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Unified image widget with lazy loading, caching, and error handling.
///
/// Three variants:
/// - `AppImage()` — generic rectangular image
/// - `AppImage.avatar()` — circular avatar with initials fallback
/// - `AppImage.cover()` — cover/banner image
class AppImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final IconData _placeholderIcon;
  final bool _isCircle;
  final String? _fallbackText;

  /// Generic rectangular image with shimmer loading and error fallback.
  const AppImage({
    super.key,
    this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    IconData placeholderIcon = Icons.image_outlined,
  })  : _placeholderIcon = placeholderIcon,
        _isCircle = false,
        _fallbackText = null;

  /// Circular avatar with initials fallback when image is null or fails.
  ///
  /// [radius] is the avatar radius (diameter = radius * 2).
  /// [name] is used to derive the initials placeholder.
  const AppImage.avatar({
    super.key,
    this.url,
    String? name,
    double radius = 20,
  })  : width = radius * 2,
        height = radius * 2,
        fit = BoxFit.cover,
        borderRadius = null,
        _placeholderIcon = Icons.person_outlined,
        _isCircle = true,
        _fallbackText = name;

  /// Convenience for cover/banner images.
  const AppImage.cover({
    super.key,
    this.url,
    this.width,
    this.height = 200,
    this.borderRadius,
  })  : fit = BoxFit.cover,
        _placeholderIcon = Icons.photo_outlined,
        _isCircle = false,
        _fallbackText = null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget child;
    if (url == null || url!.isEmpty) {
      child = _buildPlaceholder(theme);
    } else {
      child = CachedNetworkImage(
        imageUrl: url!,
        width: width,
        height: height,
        fit: fit,
        fadeInDuration: const Duration(milliseconds: 200),
        placeholder: (_, __) => _buildShimmer(theme),
        errorWidget: (_, __, ___) => _buildPlaceholder(theme),
      );
    }

    if (_isCircle) return ClipOval(child: child);
    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: child);
    }
    return child;
  }

  Widget _buildShimmer(ThemeData theme) {
    return Shimmer.fromColors(
      baseColor: theme.colorScheme.surfaceContainerHighest,
      highlightColor: theme.colorScheme.surface,
      child: Container(
        width: width,
        height: height,
        color: theme.colorScheme.surfaceContainerHighest,
      ),
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    final bg = theme.colorScheme.surfaceContainerHighest;

    // Avatar with name → show initials
    final text = _fallbackText;
    if (_isCircle && text != null && text.isNotEmpty) {
      final size = width ?? 40;
      return Container(
        width: size,
        height: size,
        color: bg,
        alignment: Alignment.center,
        child: Text(
          text[0],
          style: TextStyle(
            fontSize: size * 0.4,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    // Scale icon to container — small containers get small icons
    final iconSize = _isCircle
        ? (width ?? 40) * 0.5
        : (height != null && height! < 64)
            ? height! * 0.5
            : 32.0;

    return Container(
      width: width,
      height: height,
      color: bg,
      alignment: Alignment.center,
      child: Icon(
        _placeholderIcon,
        color: theme.colorScheme.outline,
        size: iconSize,
      ),
    );
  }
}
