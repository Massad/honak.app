import 'package:flutter/material.dart';
import 'package:honak/core/l10n/arb/app_localizations.dart';
import 'package:honak/core/theme/feed_colors.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  FeedColors get feedColors => Theme.of(this).extension<FeedColors>()!;

  AppLocalizations get l10n => AppLocalizations.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: isError ? colorScheme.error : null,
        ),
      );
  }
}
