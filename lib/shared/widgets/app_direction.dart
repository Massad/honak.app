import 'package:flutter/material.dart';

/// Centralized helpers for text direction and directional icons.
abstract final class AppDirection {
  static bool isRtl(BuildContext context) =>
      Directionality.of(context) == TextDirection.rtl;

  static IconData backIcon(BuildContext context) =>
      isRtl(context) ? Icons.arrow_forward : Icons.arrow_back;

  static IconData forwardIcon(BuildContext context) =>
      isRtl(context) ? Icons.arrow_back : Icons.arrow_forward;

  static IconData chevronStartIcon(BuildContext context) =>
      isRtl(context) ? Icons.chevron_right : Icons.chevron_left;

  static IconData chevronEndIcon(BuildContext context) =>
      isRtl(context) ? Icons.chevron_left : Icons.chevron_right;

  static IconData resolveDirectionalIcon(
    IconData icon, {
    required bool isRtl,
  }) {
    if (!isRtl) return icon;

    if (icon == Icons.arrow_forward) return Icons.arrow_back;
    if (icon == Icons.arrow_back) return Icons.arrow_forward;
    if (icon == Icons.arrow_forward_ios) return Icons.arrow_back_ios_new;
    if (icon == Icons.arrow_back_ios) return Icons.arrow_forward_ios;
    if (icon == Icons.arrow_back_ios_new) return Icons.arrow_forward_ios;
    if (icon == Icons.chevron_right) return Icons.chevron_left;
    if (icon == Icons.chevron_left) return Icons.chevron_right;
    return icon;
  }
}
