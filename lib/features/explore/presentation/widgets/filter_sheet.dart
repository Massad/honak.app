import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/explore/presentation/providers/explore_providers.dart';
import 'package:honak/features/explore/presentation/providers/filter_provider.dart';

class ExploreFilterSheet extends ConsumerStatefulWidget {
  const ExploreFilterSheet({super.key});

  @override
  ConsumerState<ExploreFilterSheet> createState() => _ExploreFilterSheetState();
}

class _ExploreFilterSheetState extends ConsumerState<ExploreFilterSheet> {
  late ExploreFilterState _draft;

  @override
  void initState() {
    super.initState();
    _draft = ref.read(exploreFilterProvider);
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Drag handle provided by theme's showDragHandle: true
            // Header
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.filter,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () => setState(
                      () => _draft = ExploreFilterState.empty,
                    ),
                    child: Text(context.l10n.filterReset),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Scrollable content
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: EdgeInsets.all(AppSpacing.lg),
                children: [
                  // Category toggles
                  Text(
                    context.l10n.filterCategory,
                    style: context.textTheme.titleSmall,
                  ),
                  SizedBox(height: AppSpacing.md),
                  categoriesAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (categories) => Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: categories.map((cat) {
                        final isSelected = _draft.category == cat.id;
                        return FilterChip(
                          label: Text(cat.nameAr),
                          selected: isSelected,
                          onSelected: (_) => setState(
                            () => _draft = _draft.copyWith(
                              category: isSelected ? null : cat.id,
                              clearCategory: isSelected,
                            ),
                          ),
                          showCheckmark: false,
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: AppSpacing.xxl),

                  // Distance slider
                  Text(
                    context.l10n.filterDistance,
                    style: context.textTheme.titleSmall,
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Slider(
                    value: _draft.maxDistanceKm ?? 50,
                    min: 1,
                    max: 50,
                    divisions: 49,
                    label: '${(_draft.maxDistanceKm ?? 50).toInt()} km',
                    onChanged: (value) => setState(
                      () => _draft = _draft.copyWith(
                        maxDistanceKm: value >= 50 ? null : value,
                        clearDistance: value >= 50,
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.xxl),

                  // Sort by
                  Text(
                    context.l10n.filterSortBy,
                    style: context.textTheme.titleSmall,
                  ),
                  SizedBox(height: AppSpacing.sm),
                  ...[
                    (ExploreSortBy.popular, context.l10n.filterPopular),
                    (ExploreSortBy.nearest, context.l10n.filterNearest),
                    (ExploreSortBy.highestRated, context.l10n.filterHighestRated),
                  ].map(
                    (entry) {
                      final isSelected = _draft.sortBy == entry.$1;
                      return ListTile(
                        leading: Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                          color: isSelected
                              ? context.colorScheme.primary
                              : context.colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                        title: Text(entry.$2),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        onTap: () => setState(
                          () => _draft = _draft.copyWith(sortBy: entry.$1),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Apply button
            Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    ref.read(exploreFilterProvider.notifier).update(_draft);
                    Navigator.of(context).pop();
                  },
                  child: Text(context.l10n.filterApply),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
