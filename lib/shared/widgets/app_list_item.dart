import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_direction.dart';

enum AppListItemAffordance { none, chevron }

class AppListItem extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Widget? trailing;
  final AppListItemAffordance affordance;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;

  const AppListItem({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.trailing,
    this.affordance = AppListItemAffordance.none,
    this.onTap,
    this.padding = const EdgeInsetsDirectional.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.md,
    ),
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final resolvedTrailing =
        trailing ??
        (affordance == AppListItemAffordance.chevron
            ? Icon(
                AppDirection.chevronStartIcon(context),
                size: 18,
                color: colorScheme.outline,
              )
            : null);
    final resolvedRadius = borderRadius ?? AppRadius.card;

    return Material(
      color: backgroundColor ?? colorScheme.surface,
      borderRadius: resolvedRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: resolvedRadius,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: resolvedRadius,
            border: borderColor == null
                ? null
                : Border.all(color: borderColor!),
          ),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: AppSpacing.md),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style:
                          titleStyle ??
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style:
                            subtitleStyle ??
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
              if (resolvedTrailing != null) ...[
                const SizedBox(width: AppSpacing.sm),
                resolvedTrailing,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
