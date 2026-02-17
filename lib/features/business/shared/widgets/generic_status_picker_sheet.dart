import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/shared/entities/status_config.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// A single option in the status picker.
class StatusOption<T> {
  const StatusOption({
    required this.status,
    required this.config,
    required this.isBackward,
  });

  final T status;
  final StatusConfig config;
  final bool isBackward;
}

/// Shows a generic status picker bottom sheet.
///
/// Both dropoff and queue features call this with their own status types.
/// Returns the selected status, or null if dismissed.
Future<T?> showGenericStatusPicker<T>(
  BuildContext context, {
  required String title,
  required String subtitle,
  required StatusConfig currentConfig,
  required List<StatusOption<T>> availableStatuses,
  Widget? activityLogPreview,
}) {
  return showAppSheet<T>(
    context,
    builder: (_) => _GenericStatusPickerSheet<T>(
      title: title,
      subtitle: subtitle,
      currentConfig: currentConfig,
      availableStatuses: availableStatuses,
      activityLogPreview: activityLogPreview,
    ),
  );
}

class _GenericStatusPickerSheet<T> extends StatelessWidget {
  const _GenericStatusPickerSheet({
    required this.title,
    required this.subtitle,
    required this.currentConfig,
    required this.availableStatuses,
    this.activityLogPreview,
  });

  final String title;
  final String subtitle;
  final StatusConfig currentConfig;
  final List<StatusOption<T>> availableStatuses;
  final Widget? activityLogPreview;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xxl),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: AppSpacing.sm),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: context.textTheme.titleSmall?.copyWith(
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          textDirection: Directionality.of(context),
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerLow,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Divider(
              height: 1,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),

            // Current status highlight
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.bizCurrentStatus,
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: currentConfig.bgColor,
                      borderRadius: AppRadius.cardInner,
                      border: Border.all(
                        color: currentConfig.borderColor,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          currentConfig.icon,
                          size: 16,
                          color: currentConfig.color,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          currentConfig.label,
                          style: TextStyle(
                            fontSize: 12,
                            color: currentConfig.color,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          context.l10n.bizCurrentLabel,
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Available statuses
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.bizMoveTo,
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ...availableStatuses.map((option) {
                    return Padding(
                      padding: const EdgeInsetsDirectional.only(bottom: 6),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context, option.status),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: option.isBackward
                                ? const Color(0xFFFFF8E1).withValues(alpha: 0.5)
                                : context.colorScheme.surface,
                            borderRadius: AppRadius.cardInner,
                            border: Border.all(
                              color: option.isBackward
                                  ? const Color(0xFFFFE082)
                                  : Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainerLow,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                option.config.icon,
                                size: 16,
                                color: option.config.color,
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Text(
                                  option.config.label,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: option.config.color,
                                  ),
                                ),
                              ),
                              if (option.isBackward)
                                Container(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF3E0),
                                    borderRadius: AppRadius.pill,
                                  ),
                                  child: Text(
                                    context.l10n.bizRevert,
                                    style: const TextStyle(
                                      fontSize: 9,
                                      color: Color(0xFFFF9800),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Optional activity log preview
            if (activityLogPreview != null) ...[
              Divider(
                height: 1,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
                child: activityLogPreview!,
              ),
            ],

            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}
