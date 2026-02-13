import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// No results found state for catalog/menu searches.
class EmptySearchState extends StatelessWidget {
  const EmptySearchState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.paddingAll(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 40,
              color: context.colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: AppSpacing.lg),
            Text(
              '\u0644\u0627 \u062a\u0648\u062c\u062f \u0646\u062a\u0627\u0626\u062c',
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              '\u062c\u0631\u0651\u0628 \u0643\u0644\u0645\u0627\u062a \u0645\u062e\u062a\u0644\u0641\u0629 \u0623\u0648 \u062a\u0635\u0641\u062d \u0627\u0644\u0641\u0626\u0627\u062a',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
