import 'package:flutter/material.dart';

/// Theme-aware colors for the home feed.
///
/// Access via `context.feedColors` (from `ContextExt`).
/// Registered as a [ThemeExtension] in both light and dark themes.
@immutable
class FeedColors extends ThemeExtension<FeedColors> {
  /// Offer/deal accent — warm orange.
  final Color offerAccent;

  /// Offer gradient start (red).
  final Color offerGradientStart;

  /// Offer gradient end (warm orange-red).
  final Color offerGradientEnd;

  /// Promoted card background.
  final Color promotedBg;

  /// Promoted card border.
  final Color promotedBorder;

  /// Promoted card CTA color (muted slate).
  final Color promotedCta;

  /// High-emphasis text on status cards (opaque pastel bg).
  final Color statusTextPrimary;

  /// Medium-emphasis text on status cards.
  final Color statusTextSecondary;

  /// Photo type badge — purple.
  final Color photoBadge;

  /// Story ring gradient start.
  final Color storyRingStart;

  /// Story ring gradient end — cyan.
  final Color storyRingEnd;

  /// Status card: warning background.
  final Color statusWarningBg;

  /// Status card: warning border.
  final Color statusWarningBorder;

  /// Status card: warning icon background.
  final Color statusWarningIconBg;

  /// Status card: warning icon/text color.
  final Color statusWarningColor;

  /// Status card: warning text color (darker).
  final Color statusWarningText;

  /// Status card: info background.
  final Color statusInfoBg;

  /// Status card: info border.
  final Color statusInfoBorder;

  /// Status card: info icon background.
  final Color statusInfoIconBg;

  /// Status card: info text color.
  final Color statusInfoText;

  /// Update card accent gradient start.
  final Color updateAccentStart;

  /// Update card accent gradient end.
  final Color updateAccentEnd;

  /// Soft palette for status card backgrounds (picked by page id hash).
  final List<Color> statusPalette;

  const FeedColors({
    required this.offerAccent,
    required this.offerGradientStart,
    required this.offerGradientEnd,
    required this.promotedBg,
    required this.promotedBorder,
    required this.promotedCta,
    required this.statusTextPrimary,
    required this.statusTextSecondary,
    required this.photoBadge,
    required this.storyRingStart,
    required this.storyRingEnd,
    required this.statusWarningBg,
    required this.statusWarningBorder,
    required this.statusWarningIconBg,
    required this.statusWarningColor,
    required this.statusWarningText,
    required this.statusInfoBg,
    required this.statusInfoBorder,
    required this.statusInfoIconBg,
    required this.statusInfoText,
    required this.updateAccentStart,
    required this.updateAccentEnd,
    required this.statusPalette,
  });

  static const light = FeedColors(
    offerAccent: Color(0xFFFF6B47),
    offerGradientStart: Color(0xFFE53935),
    offerGradientEnd: Color(0xFFFF6B47),
    promotedBg: Color(0xFFF8FAFC),
    promotedBorder: Color(0xFFE2E8F0),
    promotedCta: Color(0xFF64748B),
    statusTextPrimary: Color(0xFF1E293B),
    statusTextSecondary: Color(0xFF334155),
    photoBadge: Color(0xFF7B1FA2),
    storyRingStart: Color(0xFF1A73E8),
    storyRingEnd: Color(0xFF22D3EE),
    // Status card: warning
    statusWarningBg: Color(0xFFFFF8E1), // amber-50
    statusWarningBorder: Color(0xFFFFD54F), // amber-200
    statusWarningIconBg: Color(0xFFFFECB3), // amber-100
    statusWarningColor: Color(0xFFE65100), // amber-600
    statusWarningText: Color(0xFF7C4700), // amber-800
    // Status card: info
    statusInfoBg: Color(0xFFE3F2FD), // blue-50
    statusInfoBorder: Color(0xFF90CAF9), // blue-200
    statusInfoIconBg: Color(0xFFBBDEFB), // blue-100
    statusInfoText: Color(0xFF0D47A1), // blue-800
    // Update card accent
    updateAccentStart: Color(0xFF1A73E8),
    updateAccentEnd: Color(0xFF4DA3FF),
    statusPalette: [
      Color(0xFFE3F2FD), // muted blue
      Color(0xFFE8F5E9), // sage green
      Color(0xFFFFF8E1), // warm beige
      Color(0xFFF3E5F5), // light lavender
      Color(0xFFE0F7FA), // soft cyan
      Color(0xFFFCE4EC), // blush pink
    ],
  );

  static const dark = FeedColors(
    offerAccent: Color(0xFFFF8A70),
    offerGradientStart: Color(0xFFE53935),
    offerGradientEnd: Color(0xFFFF6B47),
    promotedBg: Color(0xFF1E293B),
    promotedBorder: Color(0xFF334155),
    promotedCta: Color(0xFF94A3B8),
    statusTextPrimary: Color(0xFFF1F5F9),
    statusTextSecondary: Color(0xFFCBD5E1),
    photoBadge: Color(0xFFCE93D8),
    storyRingStart: Color(0xFF4DA3FF),
    storyRingEnd: Color(0xFF22D3EE),
    // Status card: warning (dark mode)
    statusWarningBg: Color(0xFF3E2723),
    statusWarningBorder: Color(0xFFFF8F00),
    statusWarningIconBg: Color(0xFF4E342E),
    statusWarningColor: Color(0xFFFFB74D),
    statusWarningText: Color(0xFFFFCC80),
    // Status card: info (dark mode)
    statusInfoBg: Color(0xFF0D47A1),
    statusInfoBorder: Color(0xFF42A5F5),
    statusInfoIconBg: Color(0xFF1565C0),
    statusInfoText: Color(0xFFBBDEFB),
    // Update card accent
    updateAccentStart: Color(0xFF4DA3FF),
    updateAccentEnd: Color(0xFF82C4FF),
    statusPalette: [
      Color(0xFF0D47A1), // deep blue
      Color(0xFF1B5E20), // deep green
      Color(0xFF4E342E), // warm brown
      Color(0xFF4A148C), // deep purple
      Color(0xFF006064), // deep cyan
      Color(0xFF880E4F), // deep pink
    ],
  );

  @override
  FeedColors copyWith({
    Color? offerAccent,
    Color? offerGradientStart,
    Color? offerGradientEnd,
    Color? promotedBg,
    Color? promotedBorder,
    Color? promotedCta,
    Color? statusTextPrimary,
    Color? statusTextSecondary,
    Color? photoBadge,
    Color? storyRingStart,
    Color? storyRingEnd,
    Color? statusWarningBg,
    Color? statusWarningBorder,
    Color? statusWarningIconBg,
    Color? statusWarningColor,
    Color? statusWarningText,
    Color? statusInfoBg,
    Color? statusInfoBorder,
    Color? statusInfoIconBg,
    Color? statusInfoText,
    Color? updateAccentStart,
    Color? updateAccentEnd,
    List<Color>? statusPalette,
  }) {
    return FeedColors(
      offerAccent: offerAccent ?? this.offerAccent,
      offerGradientStart: offerGradientStart ?? this.offerGradientStart,
      offerGradientEnd: offerGradientEnd ?? this.offerGradientEnd,
      promotedBg: promotedBg ?? this.promotedBg,
      promotedBorder: promotedBorder ?? this.promotedBorder,
      promotedCta: promotedCta ?? this.promotedCta,
      statusTextPrimary: statusTextPrimary ?? this.statusTextPrimary,
      statusTextSecondary: statusTextSecondary ?? this.statusTextSecondary,
      photoBadge: photoBadge ?? this.photoBadge,
      storyRingStart: storyRingStart ?? this.storyRingStart,
      storyRingEnd: storyRingEnd ?? this.storyRingEnd,
      statusWarningBg: statusWarningBg ?? this.statusWarningBg,
      statusWarningBorder: statusWarningBorder ?? this.statusWarningBorder,
      statusWarningIconBg: statusWarningIconBg ?? this.statusWarningIconBg,
      statusWarningColor: statusWarningColor ?? this.statusWarningColor,
      statusWarningText: statusWarningText ?? this.statusWarningText,
      statusInfoBg: statusInfoBg ?? this.statusInfoBg,
      statusInfoBorder: statusInfoBorder ?? this.statusInfoBorder,
      statusInfoIconBg: statusInfoIconBg ?? this.statusInfoIconBg,
      statusInfoText: statusInfoText ?? this.statusInfoText,
      updateAccentStart: updateAccentStart ?? this.updateAccentStart,
      updateAccentEnd: updateAccentEnd ?? this.updateAccentEnd,
      statusPalette: statusPalette ?? this.statusPalette,
    );
  }

  @override
  FeedColors lerp(FeedColors? other, double t) {
    if (other is! FeedColors) return this;
    return FeedColors(
      offerAccent: Color.lerp(offerAccent, other.offerAccent, t)!,
      offerGradientStart:
          Color.lerp(offerGradientStart, other.offerGradientStart, t)!,
      offerGradientEnd:
          Color.lerp(offerGradientEnd, other.offerGradientEnd, t)!,
      promotedBg: Color.lerp(promotedBg, other.promotedBg, t)!,
      promotedBorder: Color.lerp(promotedBorder, other.promotedBorder, t)!,
      promotedCta: Color.lerp(promotedCta, other.promotedCta, t)!,
      statusTextPrimary:
          Color.lerp(statusTextPrimary, other.statusTextPrimary, t)!,
      statusTextSecondary:
          Color.lerp(statusTextSecondary, other.statusTextSecondary, t)!,
      photoBadge: Color.lerp(photoBadge, other.photoBadge, t)!,
      storyRingStart: Color.lerp(storyRingStart, other.storyRingStart, t)!,
      storyRingEnd: Color.lerp(storyRingEnd, other.storyRingEnd, t)!,
      statusWarningBg:
          Color.lerp(statusWarningBg, other.statusWarningBg, t)!,
      statusWarningBorder:
          Color.lerp(statusWarningBorder, other.statusWarningBorder, t)!,
      statusWarningIconBg:
          Color.lerp(statusWarningIconBg, other.statusWarningIconBg, t)!,
      statusWarningColor:
          Color.lerp(statusWarningColor, other.statusWarningColor, t)!,
      statusWarningText:
          Color.lerp(statusWarningText, other.statusWarningText, t)!,
      statusInfoBg: Color.lerp(statusInfoBg, other.statusInfoBg, t)!,
      statusInfoBorder:
          Color.lerp(statusInfoBorder, other.statusInfoBorder, t)!,
      statusInfoIconBg:
          Color.lerp(statusInfoIconBg, other.statusInfoIconBg, t)!,
      statusInfoText: Color.lerp(statusInfoText, other.statusInfoText, t)!,
      updateAccentStart:
          Color.lerp(updateAccentStart, other.updateAccentStart, t)!,
      updateAccentEnd:
          Color.lerp(updateAccentEnd, other.updateAccentEnd, t)!,
      statusPalette: [
        for (int i = 0; i < statusPalette.length; i++)
          Color.lerp(statusPalette[i], other.statusPalette[i], t)!,
      ],
    );
  }
}
