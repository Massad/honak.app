import 'package:flutter/material.dart' as flutter;
import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_direction.dart';

/// Button visual style (color scheme).
enum Style {
  /// Primary blue — main actions, confirm.
  primary,

  /// Yellow/orange — warnings, caution.
  warning,

  /// Red — destructive actions, delete, cancel.
  danger,

  /// Blue/info — informational actions.
  info,

  /// Success green — completion, success states.
  success,
}

/// Button variant (fill style).
enum Variant {
  /// Filled button with solid background.
  filled,

  /// Outlined button with border only.
  outlined,

  /// Text-only button, no background or border.
  text,

  /// Tonal button with subtle background (8% opacity).
  tonal,
}

/// Button size presets.
enum ButtonSize {
  /// Compact 28px — inline actions, card CTAs.
  small,

  /// Standard 40px — most buttons.
  medium,

  /// Large 48px — bottom CTAs, wizard navigation.
  large,
}

/// Icon configuration for Button.
class ButtonIcon {
  final IconData data;
  final double? size;
  final Color? color;

  const ButtonIcon(this.data, {this.size, this.color});

  /// Forward arrow that auto-flips in RTL.
  static ButtonIcon forwardArrow({double? size, Color? color}) =>
      ButtonIcon(Icons.arrow_forward, size: size, color: color);

  /// Back arrow that auto-flips in RTL.
  static ButtonIcon backArrow({double? size, Color? color}) =>
      ButtonIcon(Icons.arrow_back, size: size, color: color);
}

/// Unified button component with RTL support and consistent styling.
///
/// Simple API - most params optional:
/// ```dart
/// // Minimal usage
/// Button(
///   onPressed: () {},
///   label: 'حفظ',
/// )
///
/// // With icon (always trailing)
/// Button(
///   onPressed: () {},
///   label: 'التالي',
///   icon: ButtonIcon(Icons.arrow_forward),
/// )
///
/// // Icon-only button
/// Button(
///   onPressed: () {},
///   icon: ButtonIcon(Icons.close),
/// )
///
/// // Danger button
/// Button(
///   onPressed: () {},
///   label: 'حذف',
///   style: Style.danger,
/// )
///
/// // Outlined secondary
/// Button(
///   onPressed: () {},
///   label: 'إلغاء',
///   variant: Variant.outlined,
/// )
///
/// // Loading state
/// Button(
///   onPressed: null,
///   label: 'جاری الحفظ...',
///   isLoading: true,
/// )
/// ```
class Button extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;

  /// Button color scheme (primary, warning, danger, info, success).
  final Style style;

  /// Button fill style (filled, outlined, text, tonal).
  final Variant variant;

  /// Button height (small 28px, medium 40px, large 48px).
  final ButtonSize size;

  /// Optional icon. Always trailing when label exists, center when icon-only.
  final ButtonIcon? icon;

  /// If true, button takes full width.
  final bool expand;

  /// If true, shows loading spinner instead of content.
  final bool isLoading;

  const Button({
    super.key,
    this.label,
    required this.onPressed,
    this.style = Style.primary,
    this.variant = Variant.filled,
    this.size = ButtonSize.medium,
    this.icon,
    this.expand = false,
    this.isLoading = false,
  }) : assert(label != null || icon != null,
            'Either label or icon must be provided');


  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    final double height = switch (size) {
      ButtonSize.small => 28,
      ButtonSize.medium => 40,
      ButtonSize.large => 48,
    };

    final double defaultIconSize = switch (size) {
      ButtonSize.small => 14,
      ButtonSize.medium => 18,
      ButtonSize.large => 18,
    };
    final iconSize = icon?.size ?? defaultIconSize;

    final padding = switch (size) {
      ButtonSize.small => const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.md,
        ),
      ButtonSize.medium => const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.sm,
        ),
      ButtonSize.large => const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.xxl,
          vertical: AppSpacing.md,
        ),
    };

    // Build content
    final Widget content;
    if (isLoading) {
      content = SizedBox(
        width: iconSize,
        height: iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: _getForegroundColor(cs),
        ),
      );
    } else if (label == null && icon != null) {
      // Icon-only button
      final resolvedIconData = _resolveIcon(icon!.data, isRtl);
      content = flutter.Icon(
        resolvedIconData,
        size: iconSize,
        color: icon!.color,
      );
    } else if (label != null && icon != null) {
      // Text + icon (icon trailing)
      final resolvedIconData = _resolveIcon(icon!.data, isRtl);
      final iconWidget = flutter.Icon(
        resolvedIconData,
        size: iconSize,
        color: icon!.color,
      );
      final textWidget = Text(label!);
      final spacing = SizedBox(width: size == ButtonSize.small ? 6 : 8);

      content = Row(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [textWidget, spacing, iconWidget],
      );
    } else {
      // Text-only button
      content = Text(label!);
    }

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
    );

    final visualDensity =
        size == ButtonSize.small ? VisualDensity.compact : null;

    Widget button = switch (variant) {
      Variant.filled => FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: _getBackgroundColor(cs),
            foregroundColor: _getForegroundColor(cs),
            disabledBackgroundColor:
                _getBackgroundColor(cs).withValues(alpha: 0.38),
            padding: padding,
            shape: shape,
            visualDensity: visualDensity,
            minimumSize: flutter.Size(0, height),
          ),
          child: content,
        ),
      Variant.outlined => OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: _getBackgroundColor(cs),
            side: BorderSide(color: _getBackgroundColor(cs)),
            padding: padding,
            shape: shape,
            visualDensity: visualDensity,
            minimumSize: flutter.Size(0, height),
          ),
          child: content,
        ),
      Variant.text => TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: _getBackgroundColor(cs),
            padding: padding,
            shape: shape,
            visualDensity: visualDensity,
            minimumSize: flutter.Size(0, height),
          ),
          child: content,
        ),
      Variant.tonal => FilledButton.tonal(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: _getBackgroundColor(cs).withValues(alpha: 0.08),
            foregroundColor: _getBackgroundColor(cs),
            padding: padding,
            shape: shape,
            visualDensity: visualDensity,
            minimumSize: flutter.Size(0, height),
          ),
          child: content,
        ),
    };

    if (expand) {
      button = SizedBox(
        width: double.infinity,
        height: height,
        child: button,
      );
    }

    return button;
  }

  /// Get background color based on style.
  Color _getBackgroundColor(ColorScheme cs) {
    return switch (style) {
      Style.primary => AppColors.primary,
      Style.warning => AppColors.warning,
      Style.danger => AppColors.error,
      Style.info => AppColors.info,
      Style.success => AppColors.success,
    };
  }

  /// Get foreground color (for filled variant).
  Color _getForegroundColor(ColorScheme cs) {
    return switch (style) {
      Style.primary => Colors.white,
      Style.warning => Colors.white,
      Style.danger => Colors.white,
      Style.info => Colors.white,
      Style.success => Colors.white,
    };
  }

  /// Flip directional icons in RTL.
  static IconData _resolveIcon(IconData icon, bool isRtl) {
    return AppDirection.resolveDirectionalIcon(icon, isRtl: isRtl);
  }
}
