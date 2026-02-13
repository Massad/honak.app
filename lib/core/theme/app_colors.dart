import 'package:flutter/material.dart';

/// App color palette — aligned with Tailwind CSS v4 gray scale used in Figma.
///
/// Light mode uses Tailwind `gray` family (cool undertone).
/// Dark mode uses the same family at dark-range values.
abstract final class AppColors {
  // ── Brand ─────────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF1A73E8);
  static const Color primaryLight = Color(0xFF4DA3FF);
  static const Color primaryDark = Color(0xFF1557B0);

  // ── Secondary — warm amber ────────────────────────────────────────────────
  static const Color secondary = Color(0xFFFF9800);
  static const Color secondaryLight = Color(0xFFFFB300);
  static const Color secondaryDark = Color(0xFFFF6F00);

  // ── Backgrounds — light ───────────────────────────────────────────────────
  static const Color background = Color(0xFFF5F5F5); // Figma explicit
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF9FAFB); // gray-50

  // ── Backgrounds — dark ────────────────────────────────────────────────────
  static const Color backgroundDark = Color(0xFF030712); // gray-950
  static const Color surfaceDark = Color(0xFF111827); // gray-900
  static const Color surfaceVariantDark = Color(0xFF1F2937); // gray-800

  // ── Semantic ──────────────────────────────────────────────────────────────
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF43A047);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF1976D2);

  // ── Text — light ──────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF111827); // gray-900
  static const Color textSecondary = Color(0xFF6B7280); // gray-500
  static const Color textHint = Color(0xFF9CA3AF); // gray-400

  // ── Text — dark ───────────────────────────────────────────────────────────
  static const Color textPrimaryDark = Color(0xFFF9FAFB); // gray-50
  static const Color textSecondaryDark = Color(0xFF9CA3AF); // gray-400
  static const Color textHintDark = Color(0xFF4B5563); // gray-600

  // ── Borders — light ───────────────────────────────────────────────────────
  static const Color border = Color(0xFFF3F4F6); // gray-100, subtle card borders
  static const Color divider = Color(0xFFE5E7EB); // gray-200, divider lines

  // ── Borders — dark ────────────────────────────────────────────────────────
  static const Color borderDark = Color(0xFF1F2937); // gray-800
  static const Color dividerDark = Color(0xFF374151); // gray-700

  // ── Shimmer / skeleton loading ────────────────────────────────────────────
  static const Color shimmerBase = Color(0xFFE5E7EB); // gray-200
  static const Color shimmerHighlight = Color(0xFFF9FAFB); // gray-50
  static const Color shimmerBaseDark = Color(0xFF374151); // gray-700
  static const Color shimmerHighlightDark = Color(0xFF1F2937); // gray-800

  // ── Neutrals ──────────────────────────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
}
