import 'package:flutter/material.dart';
import 'package:honak/shared/entities/money.dart';

class MoneyText extends StatelessWidget {
  final Money money;
  final String locale;
  final TextStyle? style;
  final TextStyle? freeStyle;

  const MoneyText({
    super.key,
    required this.money,
    this.locale = 'ar',
    this.style,
    this.freeStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (money.isFree) {
      return Text(
        money.toFormatted(locale: locale),
        style: freeStyle ??
            style?.copyWith(color: theme.colorScheme.primary) ??
            theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
      );
    }

    return Text(
      money.toFormatted(locale: locale),
      style: style ?? theme.textTheme.bodyMedium,
    );
  }
}
