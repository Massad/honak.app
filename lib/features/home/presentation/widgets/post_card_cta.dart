import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Compact 28px pill CTA button with arrow indicator — Figma style.
class CompactCta extends StatelessWidget {
  final String label;
  final Color? color;
  final VoidCallback? onPressed;

  /// If true, renders full-width (used for offer cards).
  final bool fullWidth;

  /// If true, renders as outlined instead of filled.
  final bool outlined;

  const CompactCta({
    super.key,
    required this.label,
    this.color,
    this.onPressed,
    this.fullWidth = false,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    if (outlined) {
      return btn.Button(
        onPressed: onPressed,
        label: label,
        icon: const btn.ButtonIcon(Icons.arrow_forward),
        variant: btn.Variant.outlined,
        size: btn.ButtonSize.small,
      );
    }

    if (fullWidth) {
      return btn.Button(
        onPressed: onPressed,
        label: label,
        icon: const btn.ButtonIcon(Icons.arrow_forward),
        expand: true,
      );
    }

    return btn.Button(
      onPressed: onPressed,
      label: label,
      icon: const btn.ButtonIcon(Icons.arrow_forward),
      size: btn.ButtonSize.small,
    );
  }
}

/// Share icon button used inside card bodies at bottom-end.
class ShareIcon extends StatelessWidget {
  final VoidCallback? onTap;

  const ShareIcon({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.share_outlined,
        size: 18,
        color: context.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
