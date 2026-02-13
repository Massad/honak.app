import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Small inline banner warning that displayed data may be stale.
///
/// Shows: ⚠️ "هذه البيانات قد لا تكون محدثة"
/// Returns [SizedBox.shrink] when [show] is false.
class DataSyncBadge extends StatelessWidget {
  final bool show;

  const DataSyncBadge({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        border: Border.all(
          color: context.colorScheme.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '\u26A0\uFE0F',
            style: context.textTheme.labelSmall,
          ),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: Text(
              // "هذه البيانات قد لا تكون محدثة"
              '\u0647\u0630\u0647 \u0627\u0644\u0628\u064a\u0627\u0646\u0627\u062a \u0642\u062f \u0644\u0627 \u062a\u0643\u0648\u0646 \u0645\u062d\u062f\u062b\u0629',
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
