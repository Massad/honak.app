import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Horizontal scrollable category filter pills with an "All" option.
///
/// Used by CatalogSection, MenuSection, ItemPickerSheet, and any
/// future filterable list. Replaces 3 duplicate implementations.
class CategoryFilterPills extends StatelessWidget {
  final List<String> categories;
  final String? selected;
  final ValueChanged<String?> onSelected;
  final String allLabel;

  const CategoryFilterPills({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelected,
    this.allLabel = 'الكل',
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        itemCount: categories.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final isAll = index == 0;
          final label = isAll ? allLabel : categories[index - 1];
          final isActive = isAll ? selected == null : selected == label;

          return GestureDetector(
            onTap: () => onSelected(isAll ? null : (selected == label ? null : label)),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: isActive
                    ? primary
                    : Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest
                        .withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(9999),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: primary.withValues(alpha: 0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isActive
                      ? Colors.white
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
