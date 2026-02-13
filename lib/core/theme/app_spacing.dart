import 'package:flutter/material.dart';

abstract final class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 48;

  // EdgeInsets helpers
  static EdgeInsets paddingAll(double size) => EdgeInsets.all(size);
  static EdgeInsets paddingH(double size) =>
      EdgeInsets.symmetric(horizontal: size);
  static EdgeInsets paddingV(double size) =>
      EdgeInsets.symmetric(vertical: size);

  // SizedBox helpers
  static SizedBox hGap(double size) => SizedBox(width: size);
  static SizedBox vGap(double size) => SizedBox(height: size);

  // Common paddings
  static const EdgeInsets screenPadding =
      EdgeInsets.symmetric(horizontal: lg, vertical: lg);
  static const EdgeInsets cardPadding = EdgeInsets.all(lg);
  static const EdgeInsets listItemPadding =
      EdgeInsets.symmetric(horizontal: lg, vertical: md);
  static const EdgeInsets sectionPadding =
      EdgeInsets.symmetric(horizontal: lg, vertical: xxl);
  static const EdgeInsets inputPadding =
      EdgeInsets.symmetric(horizontal: md, vertical: md);
  static const EdgeInsets chipPadding =
      EdgeInsets.symmetric(horizontal: md, vertical: xs);
  static const EdgeInsets dialogPadding = EdgeInsets.all(xxl);
  static const EdgeInsets bottomSheetPadding =
      EdgeInsets.fromLTRB(lg, sm, lg, lg);
}
