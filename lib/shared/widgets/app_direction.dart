import 'package:flutter/material.dart';

/// Centralized helpers for text direction and directional icons.
abstract final class AppDirection {
  static bool isRtl(BuildContext context) =>
      Directionality.of(context) == TextDirection.rtl;

  // Use semantic back icon and let Flutter mirror icons that support RTL.
  static IconData backIcon(BuildContext context) => Icons.arrow_back;

  // Use semantic forward icon and let Flutter mirror icons that support RTL.
  static IconData forwardIcon(BuildContext context) => Icons.arrow_forward;

  static IconData chevronStartIcon(BuildContext context) =>
      isRtl(context) ? Icons.chevron_right : Icons.chevron_left;

  static IconData chevronEndIcon(BuildContext context) =>
      isRtl(context) ? Icons.chevron_left : Icons.chevron_right;

  static IconData resolveDirectionalIcon(IconData icon, {required bool isRtl}) {
    if (!isRtl) return icon;
    if (icon.matchTextDirection) return icon;

    if (icon == Icons.arrow_forward_ios) return Icons.arrow_back_ios_new;
    if (icon == Icons.arrow_back_ios) return Icons.arrow_forward_ios;
    if (icon == Icons.arrow_back_ios_new) return Icons.arrow_forward_ios;
    if (icon == Icons.chevron_right) return Icons.chevron_left;
    if (icon == Icons.chevron_left) return Icons.chevron_right;
    return icon;
  }
}
