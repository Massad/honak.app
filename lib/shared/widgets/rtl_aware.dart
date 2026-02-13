import 'package:flutter/material.dart';

class RtlAware extends StatelessWidget {
  final Widget child;

  const RtlAware({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: child,
    );
  }

  static bool isRtl(BuildContext context) {
    return Directionality.of(context) == TextDirection.rtl;
  }

  static EdgeInsetsDirectional paddingStart(double value) {
    return EdgeInsetsDirectional.only(start: value);
  }

  static EdgeInsetsDirectional paddingEnd(double value) {
    return EdgeInsetsDirectional.only(end: value);
  }
}
