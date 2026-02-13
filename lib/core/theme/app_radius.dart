import 'package:flutter/material.dart';

/// Standardized border radius constants — matching Figma/Tailwind scale.
///
/// Raw `double` values for manual use, plus semantic [BorderRadius] objects
/// for common patterns.
abstract final class AppRadius {
  // ── Raw values ──────────────────────────────────────────────────────────
  static const double xxs = 4; // badges, tiny chips
  static const double xs = 6; // offer badge, small rounded
  static const double sm = 8; // buttons, inputs
  static const double md = 12; // inner images, medium containers
  static const double lg = 16; // main cards
  static const double xl = 20; // large containers
  static const double xxl = 24; // sheets, dialogs

  // ── Semantic BorderRadius ───────────────────────────────────────────────
  /// Main card container — 16px (Tailwind `rounded-2xl`).
  static final BorderRadius card = BorderRadius.circular(lg);

  /// Inner card elements, status cards — 12px (Tailwind `rounded-xl`).
  static final BorderRadius cardInner = BorderRadius.circular(md);

  /// Buttons, CTAs — 12px.
  static final BorderRadius button = BorderRadius.circular(md);

  /// Small badges, chips — 4px.
  static final BorderRadius badge = BorderRadius.circular(xxs);

  /// Rounded images inside cards — 12px.
  static final BorderRadius image = BorderRadius.circular(md);

  /// Pill shapes (tags, follow pills) — fully rounded.
  static final BorderRadius pill = BorderRadius.circular(9999);
}
