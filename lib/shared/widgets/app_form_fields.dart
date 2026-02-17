import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';

class AppLabeledField extends StatelessWidget {
  final String label;
  final Widget child;
  final String? hint;
  final String? errorText;
  final bool requiredMark;
  final EdgeInsetsGeometry padding;

  const AppLabeledField({
    super.key,
    required this.label,
    required this.child,
    this.hint,
    this.errorText,
    this.requiredMark = false,
    this.padding = const EdgeInsetsDirectional.only(bottom: AppSpacing.lg),
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (requiredMark)
                Text(
                  ' *',
                  style: textTheme.labelLarge?.copyWith(
                    color: colorScheme.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          child,
          if (hint != null || errorText != null) ...[
            const SizedBox(height: 6),
            Text(
              errorText ?? hint!,
              style: textTheme.bodySmall?.copyWith(
                color: errorText != null
                    ? colorScheme.error
                    : colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
