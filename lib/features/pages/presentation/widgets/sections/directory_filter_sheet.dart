import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/directory_management/domain/entities/directory_floor.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// Filter state for the directory tab.
class DirectoryFilters {
  final bool openOnly;
  final Set<String> selectedFloors;
  final Set<String> selectedCategories;
  final DirectorySortMode sortMode;

  const DirectoryFilters({
    this.openOnly = false,
    this.selectedFloors = const {},
    this.selectedCategories = const {},
    this.sortMode = DirectorySortMode.defaultOrder,
  });

  bool get hasActiveFilters =>
      openOnly ||
      selectedFloors.isNotEmpty ||
      selectedCategories.isNotEmpty ||
      sortMode != DirectorySortMode.defaultOrder;

  int get activeCount =>
      (openOnly ? 1 : 0) +
      selectedFloors.length +
      selectedCategories.length +
      (sortMode != DirectorySortMode.defaultOrder ? 1 : 0);

  DirectoryFilters copyWith({
    bool? openOnly,
    Set<String>? selectedFloors,
    Set<String>? selectedCategories,
    DirectorySortMode? sortMode,
  }) {
    return DirectoryFilters(
      openOnly: openOnly ?? this.openOnly,
      selectedFloors: selectedFloors ?? this.selectedFloors,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      sortMode: sortMode ?? this.sortMode,
    );
  }
}

enum DirectorySortMode { defaultOrder, name, floor }

/// Category info with count of tenants.
class CategoryInfo {
  final String name;
  final int count;

  const CategoryInfo({required this.name, required this.count});
}

/// Shows the directory filter bottom sheet.
Future<DirectoryFilters?> showDirectoryFilterSheet(
  BuildContext context, {
  required DirectoryFilters current,
  required List<DirectoryFloor> floors,
  required List<CategoryInfo> categories,
  required int totalCount,
  required int Function(DirectoryFilters) previewCount,
}) {
  return showAppSheet<DirectoryFilters>(
    context,
    builder: (ctx) => _FilterSheetContent(
      current: current,
      floors: floors,
      categories: categories,
      totalCount: totalCount,
      previewCount: previewCount,
    ),
  );
}

class _FilterSheetContent extends StatefulWidget {
  final DirectoryFilters current;
  final List<DirectoryFloor> floors;
  final List<CategoryInfo> categories;
  final int totalCount;
  final int Function(DirectoryFilters) previewCount;

  const _FilterSheetContent({
    required this.current,
    required this.floors,
    required this.categories,
    required this.totalCount,
    required this.previewCount,
  });

  @override
  State<_FilterSheetContent> createState() => _FilterSheetContentState();
}

class _FilterSheetContentState extends State<_FilterSheetContent> {
  late DirectoryFilters _draft;

  @override
  void initState() {
    super.initState();
    _draft = widget.current;
  }

  void _reset() => setState(() => _draft = const DirectoryFilters());

  void _toggleFloor(String floorName) {
    final newSet = Set<String>.from(_draft.selectedFloors);
    if (newSet.contains(floorName)) {
      newSet.remove(floorName);
    } else {
      newSet.add(floorName);
    }
    setState(() => _draft = _draft.copyWith(selectedFloors: newSet));
  }

  void _toggleCategory(String category) {
    final newSet = Set<String>.from(_draft.selectedCategories);
    if (newSet.contains(category)) {
      newSet.remove(category);
    } else {
      newSet.add(category);
    }
    setState(() => _draft = _draft.copyWith(selectedCategories: newSet));
  }

  @override
  Widget build(BuildContext context) {
    final preview = widget.previewCount(_draft);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSheetHeader(
          // "تصفية"
          title: '\u062a\u0635\u0641\u064a\u0629',
          onClose: () => Navigator.pop(context),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Status toggle ──
                // "الحالة"
                _SectionLabel(label: '\u0627\u0644\u062d\u0627\u0644\u0629'),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    ChoiceChip(
                      // "الكل"
                      label: const Text('\u0627\u0644\u0643\u0644'),
                      selected: !_draft.openOnly,
                      onSelected: (_) =>
                          setState(() => _draft = _draft.copyWith(openOnly: false)),
                      showCheckmark: false,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    ChoiceChip(
                      // "مفتوح فقط"
                      label: const Text(
                        '\u0645\u0641\u062a\u0648\u062d \u0641\u0642\u0637',
                      ),
                      selected: _draft.openOnly,
                      onSelected: (_) =>
                          setState(() => _draft = _draft.copyWith(openOnly: true)),
                      showCheckmark: false,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),

                // ── Floors multi-select ──
                if (widget.floors.isNotEmpty) ...[
                  // "الطوابق"
                  _SectionLabel(
                    label: '\u0627\u0644\u0637\u0648\u0627\u0628\u0642',
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: widget.floors.map((floor) {
                      final selected = _draft.selectedFloors.contains(floor.name);
                      return FilterChip(
                        label: Text('${floor.name} (${floor.tenantCount})'),
                        selected: selected,
                        showCheckmark: false,
                        onSelected: (_) => _toggleFloor(floor.name),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],

                // ── Categories multi-select ──
                if (widget.categories.isNotEmpty) ...[
                  // "التصنيفات"
                  _SectionLabel(
                    label: '\u0627\u0644\u062a\u0635\u0646\u064a\u0641\u0627\u062a',
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: widget.categories.map((cat) {
                      final selected =
                          _draft.selectedCategories.contains(cat.name);
                      return FilterChip(
                        label: Text('${cat.name} (${cat.count})'),
                        selected: selected,
                        showCheckmark: false,
                        onSelected: (_) => _toggleCategory(cat.name),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],

                // ── Sort ──
                // "الترتيب"
                _SectionLabel(
                  label: '\u0627\u0644\u062a\u0631\u062a\u064a\u0628',
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  children: [
                    ChoiceChip(
                      // "افتراضي"
                      label: const Text('\u0627\u0641\u062a\u0631\u0627\u0636\u064a'),
                      selected:
                          _draft.sortMode == DirectorySortMode.defaultOrder,
                      onSelected: (_) => setState(() => _draft = _draft.copyWith(
                          sortMode: DirectorySortMode.defaultOrder)),
                      showCheckmark: false,
                    ),
                    ChoiceChip(
                      // "الاسم"
                      label: const Text('\u0627\u0644\u0627\u0633\u0645'),
                      selected: _draft.sortMode == DirectorySortMode.name,
                      onSelected: (_) => setState(() => _draft =
                          _draft.copyWith(sortMode: DirectorySortMode.name)),
                      showCheckmark: false,
                    ),
                    ChoiceChip(
                      // "الطابق"
                      label: const Text('\u0627\u0644\u0637\u0627\u0628\u0642'),
                      selected: _draft.sortMode == DirectorySortMode.floor,
                      onSelected: (_) => setState(() => _draft =
                          _draft.copyWith(sortMode: DirectorySortMode.floor)),
                      showCheckmark: false,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ),

        // ── Preview + action buttons ──
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.lg,
          ),
          child: Column(
            children: [
              Text(
                // "عرض X من Y وحدة"
                '\u0639\u0631\u0636 $preview \u0645\u0646 ${widget.totalCount} \u0648\u062d\u062f\u0629',
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                textDirection: TextDirection.ltr,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _reset,
                      // "إعادة تعيين"
                      child: const Text(
                        '\u0625\u0639\u0627\u062f\u0629 \u062a\u0639\u064a\u064a\u0646',
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => Navigator.pop(context, _draft),
                      // "تطبيق"
                      child: const Text('\u062a\u0637\u0628\u064a\u0642'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: context.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
