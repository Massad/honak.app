import 'package:flutter/material.dart';

/// App color palette.
///
/// **Brand & semantic** colors are constants used everywhere.
///
/// **Surface/text/border** colors below are light-mode defaults kept for
/// backward compatibility. Prefer `context.colorScheme` in widgets so that
/// colors adapt to the current theme (light/dark) automatically:
///
/// | Instead of              | Use                                    |
/// |-------------------------|----------------------------------------|
/// | `AppColors.background`  | `colorScheme.surfaceContainerLowest`   |
/// | `AppColors.surface`     | `colorScheme.surface`                  |
/// | `AppColors.textPrimary` | `colorScheme.onSurface`                |
/// | `AppColors.textSecondary`| `colorScheme.onSurfaceVariant`        |
/// | `AppColors.textHint`    | `colorScheme.onSurfaceVariant`         |
/// | `AppColors.divider`     | `colorScheme.outlineVariant`           |
/// | `AppColors.border`      | `colorScheme.outlineVariant`           |
abstract final class AppColors {
  // ── Brand ─────────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF1A73E8);
  static const Color primaryLight = Color(0xFF4DA3FF);
  static const Color primaryDark = Color(0xFF1557B0);

  // ── Secondary — warm amber ────────────────────────────────────────────────
  static const Color secondary = Color(0xFFFF9800);
  static const Color secondaryLight = Color(0xFFFFB300);
  static const Color secondaryDark = Color(0xFFFF6F00);

  // ── Backgrounds (light-mode defaults) ─────────────────────────────────────
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF9FAFB);

  // ── Backgrounds — dark (light-mode defaults for compat) ───────────────────
  static const Color backgroundDark = Color(0xFF030712);
  static const Color surfaceDark = Color(0xFF111827);
  static const Color surfaceVariantDark = Color(0xFF1F2937);

  // ── Semantic ──────────────────────────────────────────────────────────────
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF43A047);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF1976D2);

  // ── Text (light-mode defaults) ────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);

  // ── Text — dark ───────────────────────────────────────────────────────────
  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);
  static const Color textHintDark = Color(0xFF4B5563);

  // ── Borders (light-mode defaults) ─────────────────────────────────────────
  static const Color border = Color(0xFFF3F4F6);
  static const Color divider = Color(0xFFE5E7EB);

  // ── Borders — dark ────────────────────────────────────────────────────────
  static const Color borderDark = Color(0xFF1F2937);
  static const Color dividerDark = Color(0xFF374151);

  // ── Shimmer / skeleton loading ────────────────────────────────────────────
  static const Color shimmerBase = Color(0xFFE5E7EB);
  static const Color shimmerHighlight = Color(0xFFF9FAFB);
  static const Color shimmerBaseDark = Color(0xFF374151);
  static const Color shimmerHighlightDark = Color(0xFF1F2937);

  // ── Neutrals ──────────────────────────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
}
