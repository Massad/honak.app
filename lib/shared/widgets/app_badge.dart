import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Shared badge / tag widget matching Figma's badge styling.
///
/// Uses 12% opacity background with full-color text for readable, accessible badges.
/// Supports optional leading icon and two sizes.
///
/// ```dart
/// AppBadge(label: 'Product', color: Colors.blue)
/// AppBadge(label: 'Update', color: Colors.blue, icon: Icons.campaign)
/// AppBadge.small(label: 'New', color: Colors.green)
/// ```
class AppBadge extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;

  /// If true, uses pill shape (fully rounded). Otherwise uses rounded rect.
  final bool pill;

  /// Badge size — affects font size, icon size, and padding.
  final AppBadgeSize size;

  const AppBadge({
    super.key,
    required this.label,
    required this.color,
    this.icon,
    this.pill = false,
    this.size = AppBadgeSize.regular,
  });

  /// Small badge — for inline use in post cards, item cards, etc.
  const AppBadge.small({
    super.key,
    required this.label,
    required this.color,
    this.icon,
    this.pill = false,
  }) : size = AppBadgeSize.small;

  /// Background opacity — matches Figma's `bg-blue-50` / `bg-red-50` feel.
  static const double _bgAlpha = 0.12;

  @override
  Widget build(BuildContext context) {
    final isSmall = size == AppBadgeSize.small;
    final fontSize = isSmall ? 10.0 : 12.0;
    final iconSize = isSmall ? 10.0 : 14.0;
    final hPadding = isSmall ? AppSpacing.sm : AppSpacing.md;
    final vPadding = isSmall ? AppSpacing.xxs : AppSpacing.xs;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: hPadding,
        vertical: vPadding,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: _bgAlpha),
        borderRadius: pill ? AppRadius.pill : AppRadius.badge,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: iconSize, color: color),
            SizedBox(width: isSmall ? AppSpacing.xxs : AppSpacing.xs),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

enum AppBadgeSize { small, regular }
