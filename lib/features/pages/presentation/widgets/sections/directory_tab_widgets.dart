import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Collapsible floor section header with floor name, label, and tenant count.
class FloorSectionHeader extends StatelessWidget {
  final String floorName;
  final String? floorLabel;
  final int tenantCount;
  final bool isExpanded;
  final VoidCallback onToggle;

  const FloorSectionHeader({
    super.key,
    required this.floorName,
    this.floorLabel,
    required this.tenantCount,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onToggle,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Icon(
              Icons.layers_outlined,
              size: 18,
              color: context.colorScheme.primary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: floorName,
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (floorLabel != null)
                      TextSpan(
                        text: ' \u2014 $floorLabel',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    TextSpan(
                      // " · X متجر"
                      text: ' \u00b7 $tenantCount \u0645\u062a\u062c\u0631',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

/// Result count bar: "X من Y متجر".
class DirectoryResultCount extends StatelessWidget {
  final int visible;
  final int total;

  const DirectoryResultCount({
    super.key,
    required this.visible,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Text(
        '$visible \u0645\u0646 $total \u0645\u062a\u062c\u0631',
        style: context.textTheme.bodySmall?.copyWith(
          color: context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

/// Empty state for directory search/filter results.
class DirectoryEmptyState extends StatelessWidget {
  final String? searchQuery;
  final bool hasFilters;
  final VoidCallback? onClearFilters;

  const DirectoryEmptyState({
    super.key,
    this.searchQuery,
    this.hasFilters = false,
    this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    final hasSearch = searchQuery != null && searchQuery!.isNotEmpty;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.storefront_outlined,
              size: 48,
              color: context.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              hasSearch
                  // "لا توجد نتائج لـ 'query'"
                  ? '\u0644\u0627 \u062a\u0648\u062c\u062f \u0646\u062a\u0627\u0626\u062c \u0644\u0640 \'$searchQuery\''
                  // "لا توجد نتائج"
                  : '\u0644\u0627 \u062a\u0648\u062c\u062f \u0646\u062a\u0627\u0626\u062c',
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (hasFilters || hasSearch) ...[
              const SizedBox(height: AppSpacing.md),
              btn.Button(
                onPressed: onClearFilters,
                label: '\u0645\u0633\u062d \u0627\u0644\u0641\u0644\u0627\u062a\u0631',
                icon: const btn.ButtonIcon(Icons.filter_alt_off),
                variant: btn.Variant.text,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Horizontal strip of active filter chips with clear-all.
class ActiveFiltersStrip extends StatelessWidget {
  final bool openOnly;
  final Set<String> selectedFloors;
  final Set<String> selectedCategories;
  final VoidCallback onClearAll;
  final VoidCallback onToggleOpenOnly;
  final ValueChanged<String> onRemoveFloor;
  final ValueChanged<String> onRemoveCategory;

  const ActiveFiltersStrip({
    super.key,
    required this.openOnly,
    required this.selectedFloors,
    this.selectedCategories = const {},
    required this.onClearAll,
    required this.onToggleOpenOnly,
    required this.onRemoveFloor,
    required this.onRemoveCategory,
  });

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[];

    if (openOnly) {
      chips.add(_RemovableChip(
        // "مفتوح فقط"
        label: '\u0645\u0641\u062a\u0648\u062d \u0641\u0642\u0637',
        onRemove: onToggleOpenOnly,
      ));
    }

    for (final floor in selectedFloors) {
      chips.add(_RemovableChip(label: floor, onRemove: () => onRemoveFloor(floor)));
    }

    for (final cat in selectedCategories) {
      chips.add(_RemovableChip(label: cat, onRemove: () => onRemoveCategory(cat)));
    }

    final totalActive =
        (openOnly ? 1 : 0) + selectedFloors.length + selectedCategories.length;
    if (totalActive > 1) {
      chips.insert(
        0,
        ActionChip(
          // "مسح الكل"
          label: const Text('\u0645\u0633\u062d \u0627\u0644\u0643\u0644'),
          onPressed: onClearAll,
          visualDensity: VisualDensity.compact,
        ),
      );
    }

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.lg,
        ),
        itemCount: chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (_, index) => chips[index],
      ),
    );
  }
}

class _RemovableChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const _RemovableChip({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(label),
      onDeleted: onRemove,
      deleteIcon: const Icon(Icons.close, size: 16),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
