import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Sort options for catalog items.
enum SortOption { defaultSort, priceLowHigh, priceHighLow, newest, popular }

/// Configuration for which filters to display based on archetype.
class FilterConfig {
  final bool showPriceRange;
  final bool showAvailability;
  final bool showDuration;
  final List<SortOption> sortOptions;
  final List<({String id, String label})> categories;

  const FilterConfig({
    this.showPriceRange = true,
    this.showAvailability = true,
    this.showDuration = false,
    this.sortOptions = const [
      SortOption.defaultSort,
      SortOption.priceLowHigh,
      SortOption.priceHighLow,
      SortOption.newest,
      SortOption.popular,
    ],
    this.categories = const [],
  });
}

/// Current state of the catalog filter selections.
class CatalogFilterState {
  final double? minPrice;
  final double? maxPrice;
  final bool showInStockOnly;
  final SortOption sort;
  final Set<String> selectedCategories;
  final String? duration;

  const CatalogFilterState({
    this.minPrice,
    this.maxPrice,
    this.showInStockOnly = false,
    this.sort = SortOption.defaultSort,
    this.selectedCategories = const {},
    this.duration,
  });

  CatalogFilterState copyWith({
    double? minPrice,
    double? maxPrice,
    bool? showInStockOnly,
    SortOption? sort,
    Set<String>? selectedCategories,
    String? duration,
    bool clearMinPrice = false,
    bool clearMaxPrice = false,
    bool clearDuration = false,
  }) {
    return CatalogFilterState(
      minPrice: clearMinPrice ? null : (minPrice ?? this.minPrice),
      maxPrice: clearMaxPrice ? null : (maxPrice ?? this.maxPrice),
      showInStockOnly: showInStockOnly ?? this.showInStockOnly,
      sort: sort ?? this.sort,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      duration: clearDuration ? null : (duration ?? this.duration),
    );
  }

  /// Returns the number of active filters (non-default values).
  int get activeCount {
    var count = 0;
    if (minPrice != null && minPrice! > 0) count++;
    if (maxPrice != null && maxPrice! < 100) count++;
    if (showInStockOnly) count++;
    if (sort != SortOption.defaultSort) count++;
    count += selectedCategories.length;
    if (duration != null) count++;
    return count;
  }

  static const empty = CatalogFilterState();
}

/// Bottom sheet for filtering catalog/menu/service items.
class CatalogFilterSheet extends StatefulWidget {
  final CatalogFilterState initialState;
  final FilterConfig config;
  final ValueChanged<CatalogFilterState> onApply;

  const CatalogFilterSheet({
    super.key,
    required this.initialState,
    required this.config,
    required this.onApply,
  });

  /// Shows the filter sheet as a modal bottom sheet.
  static Future<void> show({
    required BuildContext context,
    required CatalogFilterState initialState,
    required FilterConfig config,
    required ValueChanged<CatalogFilterState> onApply,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CatalogFilterSheet(
        initialState: initialState,
        config: config,
        onApply: onApply,
      ),
    );
  }

  @override
  State<CatalogFilterSheet> createState() => _CatalogFilterSheetState();
}

class _CatalogFilterSheetState extends State<CatalogFilterSheet> {
  late CatalogFilterState _state;
  late TextEditingController _minController;
  late TextEditingController _maxController;

  @override
  void initState() {
    super.initState();
    _state = widget.initialState;
    _minController = TextEditingController(
      text: _state.minPrice != null && _state.minPrice! > 0
          ? _state.minPrice!.round().toString()
          : '',
    );
    _maxController = TextEditingController(
      text: _state.maxPrice != null && _state.maxPrice! < 100
          ? _state.maxPrice!.round().toString()
          : '',
    );
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _state = CatalogFilterState.empty;
      _minController.clear();
      _maxController.clear();
    });
  }

  String _sortLabel(SortOption option) {
    return switch (option) {
      SortOption.defaultSort => 'الافتراضي',
      SortOption.priceLowHigh => 'السعر: الأقل أولاً',
      SortOption.priceHighLow => 'السعر: الأعلى أولاً',
      SortOption.newest => 'الأحدث',
      SortOption.popular => 'الأكثر طلباً',
    };
  }

  String _durationLabel(String? duration) {
    return switch (duration) {
      null => 'الكل',
      'quick' => 'سريعة (<30 دقيقة)',
      'medium' => 'متوسطة (30-60 دقيقة)',
      'long' => 'طويلة (60+ دقيقة)',
      _ => duration,
    };
  }

  @override
  Widget build(BuildContext context) {
    final primary = context.colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: AppSpacing.md),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                Text(
                  'تصفية',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                // Reset button
                GestureDetector(
                  onTap: _reset,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.refresh,
                        size: 12,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        'إعادة تعيين',
                        style: TextStyle(
                          fontSize: 12,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Close button
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainerHighest
                          .withValues(alpha: 0.7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: context.colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
          // Body
          Flexible(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                // Price range
                if (widget.config.showPriceRange) ...[
                  _SectionTitle(title: 'نطاق السعر (د.أ)'),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: _PriceInput(
                          controller: _minController,
                          hint: 'من',
                          onChanged: (value) {
                            final v = double.tryParse(value);
                            setState(() {
                              _state = v != null && v > 0
                                  ? _state.copyWith(minPrice: v)
                                  : _state.copyWith(clearMinPrice: true);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                        ),
                        child: Text(
                          '—',
                          style: TextStyle(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _PriceInput(
                          controller: _maxController,
                          hint: 'إلى',
                          onChanged: (value) {
                            final v = double.tryParse(value);
                            setState(() {
                              _state = v != null && v > 0
                                  ? _state.copyWith(maxPrice: v)
                                  : _state.copyWith(clearMaxPrice: true);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],

                // Availability
                if (widget.config.showAvailability) ...[
                  _SectionTitle(title: 'التوفر'),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    children: [
                      _TogglePill(
                        label: 'الكل',
                        isSelected: !_state.showInStockOnly,
                        primary: primary,
                        onTap: () => setState(() {
                          _state =
                              _state.copyWith(showInStockOnly: false);
                        }),
                      ),
                      _TogglePill(
                        label: 'متوفر فقط',
                        isSelected: _state.showInStockOnly,
                        primary: primary,
                        onTap: () => setState(() {
                          _state =
                              _state.copyWith(showInStockOnly: true);
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],

                // Duration (for services)
                if (widget.config.showDuration) ...[
                  _SectionTitle(title: 'المدة'),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [null, 'quick', 'medium', 'long'].map((d) {
                      return _TogglePill(
                        label: _durationLabel(d),
                        isSelected: _state.duration == d,
                        primary: primary,
                        onTap: () => setState(() {
                          _state = d == null
                              ? _state.copyWith(clearDuration: true)
                              : _state.copyWith(duration: d);
                        }),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],

                // Sort
                if (widget.config.sortOptions.isNotEmpty) ...[
                  _SectionTitle(title: 'الترتيب'),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: widget.config.sortOptions.map((option) {
                      return _TogglePill(
                        label: _sortLabel(option),
                        isSelected: _state.sort == option,
                        primary: primary,
                        onTap: () => setState(() {
                          _state = _state.copyWith(sort: option);
                        }),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],

                // Category multi-select
                if (widget.config.categories.isNotEmpty) ...[
                  _SectionTitle(title: 'الفئات'),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: widget.config.categories.map((cat) {
                      final isSelected =
                          _state.selectedCategories.contains(cat.id);
                      return _TogglePill(
                        label: cat.label,
                        isSelected: isSelected,
                        primary: primary,
                        onTap: () {
                          setState(() {
                            final updated =
                                Set<String>.from(_state.selectedCategories);
                            if (isSelected) {
                              updated.remove(cat.id);
                            } else {
                              updated.add(cat.id);
                            }
                            _state = _state.copyWith(
                              selectedCategories: updated,
                            );
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
          // Apply button
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.lg + MediaQuery.of(context).padding.bottom,
            ),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  widget.onApply(_state);
                  Navigator.of(context).pop();
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('تطبيق'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Pill-shaped toggle button for filter options.
class _TogglePill extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color primary;
  final VoidCallback onTap;

  const _TogglePill({
    required this.label,
    required this.isSelected,
    required this.primary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? primary
              : context.colorScheme.surfaceContainerHighest
                  .withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected
                ? Colors.white
                : context.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

/// Price input field for min/max range.
class _PriceInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  const _PriceInput({
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 12,
          color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: context.colorScheme.outlineVariant,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: context.colorScheme.outlineVariant,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        isDense: true,
      ),
      style: context.textTheme.bodySmall,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
