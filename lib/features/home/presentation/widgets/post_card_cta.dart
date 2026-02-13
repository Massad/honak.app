import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

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
    final btnColor = color ?? context.colorScheme.primary;

    if (outlined) {
      return SizedBox(
        height: 28,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: btnColor,
            side: BorderSide(color: btnColor.withValues(alpha: 0.5)),
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            visualDensity: VisualDensity.compact,
            textStyle: context.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label),
              SizedBox(width: AppSpacing.xs),
              Icon(Icons.arrow_forward, size: 10),
            ],
          ),
        ),
      );
    }

    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        height: 40,
        child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: btnColor,
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.button,
            ),
            textStyle: context.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label),
              SizedBox(width: AppSpacing.sm),
              Icon(Icons.arrow_forward, size: 16),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: 28,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: btnColor,
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          visualDensity: VisualDensity.compact,
          textStyle: context.textTheme.labelSmall,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label),
            SizedBox(width: AppSpacing.xs),
            Icon(Icons.arrow_forward, size: 12),
          ],
        ),
      ),
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
