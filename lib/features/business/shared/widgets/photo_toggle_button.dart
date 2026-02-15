import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';

/// A toggle-style button for "before"/"after" photo actions.
///
/// Used by both dropoff entry cards and queue entry cards.
/// - Active: colored bg + 2px border + check icon.
/// - Inactive: transparent + 1px gray border.
class PhotoToggleButton extends StatelessWidget {
  const PhotoToggleButton({
    super.key,
    required this.label,
    required this.icon,
    required this.hasPhoto,
    this.activeColor = const Color(0xFF1A73E8),
    this.onTap,
  });

  final String label;
  final IconData icon;
  final bool hasPhoto;
  final Color activeColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final activeBg = activeColor.withValues(alpha: 0.08);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: hasPhoto ? activeBg : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasPhoto ? activeColor : context.colorScheme.outlineVariant,
            width: hasPhoto ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 12,
                color: hasPhoto
                    ? activeColor
                    : context.colorScheme.onSurfaceVariant),
            const SizedBox(width: 6),
            Text(label,
                style: context.textTheme.labelSmall?.copyWith(
                    color: hasPhoto
                        ? activeColor
                        : context.colorScheme.onSurfaceVariant,
                    fontSize: 11)),
            if (hasPhoto) ...[
              const SizedBox(width: 4),
              Icon(Icons.check_circle, size: 10, color: activeColor),
            ],
          ],
        ),
      ),
    );
  }
}
