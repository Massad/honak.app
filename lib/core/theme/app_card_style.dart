import 'package:flutter/material.dart';

import 'app_radius.dart';
import 'app_shadows.dart';

/// Reusable card [BoxDecoration] builders.
///
/// These compose [AppRadius], [AppShadows], and the current [ColorScheme]
/// / [FeedColors] into ready-to-use decorations, eliminating repeated
/// boilerplate across feed cards, business pages, explore, etc.
///
/// Usage:
/// ```dart
/// Container(
///   decoration: AppCardStyle.standard(context.colorScheme),
///   clipBehavior: Clip.antiAlias,
///   child: ...
/// )
/// ```
abstract final class AppCardStyle {
  /// Standard card — surface bg, subtle border, sm shadow.
  ///
  /// Used for: product, update, photo, catalog items, trust metrics, etc.
  static BoxDecoration standard(ColorScheme cs) => BoxDecoration(
        color: cs.surface,
        borderRadius: AppRadius.card,
        border: Border.all(
          color: cs.outlineVariant.withValues(alpha: 0.5),
        ),
        boxShadow: AppShadows.sm,
      );

  /// Flat colored card — solid bg, no border, no shadow.
  ///
  /// Used for: status cards (with pastel palette), inline banners.
  static BoxDecoration flat(Color color) => BoxDecoration(
        color: color,
        borderRadius: AppRadius.cardInner,
      );

  /// Accent-bordered card — surface bg, accent-tinted border, sm shadow.
  ///
  /// Used for: offer cards (orange border), special promotions.
  static BoxDecoration accented(ColorScheme cs, {required Color accent}) =>
      BoxDecoration(
        color: cs.surface,
        borderRadius: AppRadius.card,
        border: Border.all(
          color: accent.withValues(alpha: 0.15),
        ),
        boxShadow: AppShadows.sm,
      );

  /// Promoted / muted card — translucent bg, muted border, no shadow.
  ///
  /// Used for: promoted/sponsored content, secondary callouts.
  static BoxDecoration promoted({
    required Color background,
    required Color border,
  }) =>
      BoxDecoration(
        color: background.withValues(alpha: 0.8),
        borderRadius: AppRadius.card,
        border: Border.all(color: border),
      );

  /// Offer card gradient banner — red-to-orange gradient.
  ///
  /// Used for: offer cards (Figma redesign).
  static BoxDecoration offerGradient({
    required Color gradientStart,
    required Color gradientEnd,
  }) =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.centerEnd,
          end: AlignmentDirectional.centerStart,
          colors: [gradientStart, gradientEnd],
        ),
        borderRadius: AppRadius.card,
        boxShadow: AppShadows.sm,
      );

  /// Status card — notification style with side accent border.
  ///
  /// Used for: status cards (warning/info variants).
  static BoxDecoration statusCard({
    required Color background,
    required Color borderColor,
  }) =>
      BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: BorderDirectional(
          end: BorderSide(color: borderColor, width: 4),
        ),
      );
}
