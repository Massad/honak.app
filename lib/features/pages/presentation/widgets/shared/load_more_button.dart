import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Pagination button (NOT infinite scroll).
/// Shows "Show More" button with a count of showing/total items.
class LoadMoreButton extends StatelessWidget {
  final int showing;
  final int total;
  final VoidCallback onLoadMore;
  final bool isLoading;

  const LoadMoreButton({
    super.key,
    required this.showing,
    required this.total,
    required this.onLoadMore,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppSpacing.lg),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading)
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              TextButton(
                onPressed: onLoadMore,
                child: Text(
                  '\u0639\u0631\u0636 \u0627\u0644\u0645\u0632\u064a\u062f',
                  style: context.textTheme.labelLarge?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            SizedBox(height: AppSpacing.xs),
            Text(
              '\u0639\u0631\u0636 $showing \u0645\u0646 $total \u0645\u0646\u062a\u062c',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
