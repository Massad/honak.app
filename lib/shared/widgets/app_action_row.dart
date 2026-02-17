import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

class AppActionRow extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final btn.Style primaryStyle;
  final btn.Variant secondaryVariant;
  final bool primaryExpanded;
  final bool secondaryExpanded;

  const AppActionRow({
    super.key,
    required this.primaryLabel,
    required this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    this.primaryStyle = btn.Style.primary,
    this.secondaryVariant = btn.Variant.outlined,
    this.primaryExpanded = true,
    this.secondaryExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    final hasSecondary = secondaryLabel != null;

    Widget primary = btn.Button(
      onPressed: onPrimary,
      label: primaryLabel,
      style: primaryStyle,
      size: btn.ButtonSize.large,
      expand: primaryExpanded,
    );

    if (!hasSecondary) return primary;

    Widget secondary = btn.Button(
      onPressed: onSecondary,
      label: secondaryLabel!,
      variant: secondaryVariant,
      size: btn.ButtonSize.large,
      expand: secondaryExpanded,
    );

    if (primaryExpanded || secondaryExpanded) {
      primary = Expanded(flex: 2, child: primary);
      secondary = Expanded(child: secondary);
    }

    return Row(
      children: [
        secondary,
        const SizedBox(width: AppSpacing.md),
        primary,
      ],
    );
  }
}
