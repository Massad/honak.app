import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Selection indicator style for [SelectableTile].
enum TileSelectionStyle { none, radio, checkbox }

/// A reusable selectable list tile with proper RTL layout.
///
/// Layout (in RTL):
/// ```
/// [leading]   [title + subtitle]   [selection indicator]
///   RIGHT          CENTER                LEFT
/// ```
///
/// The selection indicator (radio/checkbox) is always at the **end** side
/// (left in RTL, right in LTR), matching platform conventions.
class SelectableTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final Widget? titleSuffix;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback? onTap;
  final TileSelectionStyle selectionStyle;
  final Color activeColor;

  const SelectableTile({
    super.key,
    this.leading,
    required this.title,
    this.titleSuffix,
    this.subtitle,
    this.isSelected = false,
    this.onTap,
    this.selectionStyle = TileSelectionStyle.radio,
    this.activeColor = AppColors.warning,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor.withValues(alpha: 0.06)
              : cs.surface,
          border: Border.all(
            color: isSelected ? activeColor : cs.outlineVariant,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            // Leading widget — start side (RIGHT in RTL)
            if (leading != null) ...[
              leading!,
              const SizedBox(width: AppSpacing.sm),
            ],
            // Title + subtitle — center
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: cs.onSurface,
                          ),
                        ),
                      ),
                      if (titleSuffix != null) ...[
                        const SizedBox(width: 4),
                        titleSuffix!,
                      ],
                    ],
                  ),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: 2),
                      child: Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 11,
                          color: cs.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
            // Selection indicator — end side (LEFT in RTL)
            if (selectionStyle != TileSelectionStyle.none) ...[
              const SizedBox(width: AppSpacing.sm),
              _SelectionIndicator(
                style: selectionStyle,
                isSelected: isSelected,
                activeColor: activeColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SelectionIndicator extends StatelessWidget {
  final TileSelectionStyle style;
  final bool isSelected;
  final Color activeColor;

  const _SelectionIndicator({
    required this.style,
    required this.isSelected,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isCheckbox = style == TileSelectionStyle.checkbox;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: isCheckbox ? 22 : 24,
      height: isCheckbox ? 22 : 24,
      decoration: BoxDecoration(
        shape: isCheckbox ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: isCheckbox ? BorderRadius.circular(4) : null,
        color: isSelected ? activeColor : Colors.transparent,
        border: Border.all(
          color: isSelected ? activeColor : cs.outline,
          width: 2,
        ),
      ),
      child: isSelected
          ? Icon(
              Icons.check,
              size: isCheckbox ? 14 : 16,
              color: Colors.white,
            )
          : null,
    );
  }
}
