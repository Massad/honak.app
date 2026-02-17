import 'package:flutter/material.dart';
import 'package:honak/core/l10n/arb/app_localizations.dart';
import 'package:honak/core/theme/feed_colors.dart';
import 'package:honak/shared/widgets/app_direction.dart';

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

  TextDirection get textDirection => Directionality.of(this);

  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  bool get isLtr => !isRtl;

  /// Selects one of two values based on current directionality.
  T byDirection<T>({required T ltr, required T rtl}) => isRtl ? rtl : ltr;

  /// Resolves start/end padding to physical left/right for current locale.
  EdgeInsets directionalInsets({
    double start = 0,
    double end = 0,
    double top = 0,
    double bottom = 0,
  }) {
    return EdgeInsetsDirectional.fromSTEB(
      start,
      top,
      end,
      bottom,
    ).resolve(textDirection);
  }

  /// Resolves start/end alignment to physical left/right for current locale.
  Alignment directionalAlignment({double start = -1, double y = 0}) {
    return AlignmentDirectional(start, y).resolve(textDirection);
  }

  IconData get backIcon => AppDirection.backIcon(this);

  IconData get forwardIcon => AppDirection.forwardIcon(this);

  IconData get chevronStartIcon => AppDirection.chevronStartIcon(this);

  IconData get chevronEndIcon => AppDirection.chevronEndIcon(this);

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
