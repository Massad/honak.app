import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/explore/domain/entities/category.dart';
import 'package:honak/features/explore/domain/entities/page_summary.dart';
import 'package:honak/features/explore/presentation/providers/explore_providers.dart';
import 'package:honak/features/explore/presentation/widgets/browse_card.dart';
import 'package:honak/features/explore/presentation/widgets/sort_sheet.dart';
import 'package:honak/shared/widgets/error_view.dart';
import 'package:honak/shared/widgets/app_screen.dart';
import 'package:honak/shared/widgets/skeleton/skeleton.dart';

class CategoryBrowsePage extends ConsumerStatefulWidget {
  final String categorySlug;
  final String categoryName;
  final List<BusinessSubType>? types;
  final String? selectedTypeId;

  const CategoryBrowsePage({
    super.key,
    required this.categorySlug,
    required this.categoryName,
    this.types,
    this.selectedTypeId,
  });

  @override
  ConsumerState<CategoryBrowsePage> createState() => _CategoryBrowsePageState();
}

class _CategoryBrowsePageState extends ConsumerState<CategoryBrowsePage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _activeType = 'الكل';
  CategorySortBy _sortBy = CategorySortBy.nearest;

  bool get _isGovernment => widget.categorySlug == 'cat_government';

  @override
  void initState() {
    super.initState();
    if (_isGovernment) _sortBy = CategorySortBy.popular;
    if (widget.selectedTypeId != null) _activeType = widget.selectedTypeId!;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pagesAsync = ref.watch(categoryPagesProvider(widget.categorySlug));

    return AppScreen(
      title: Text(widget.categoryName),
      showBack: true,
      body: pagesAsync.when(
        loading: () => Padding(
          padding: AppSpacing.screenPadding,
          child: const SkeletonCard(count: 4),
        ),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () =>
              ref.invalidate(categoryPagesProvider(widget.categorySlug)),
        ),
        data: (pages) => _buildContent(context, pages),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<PageSummary> allPages) {
    final filtered = _applyFilters(allPages);

    final hasProvidedTypes = widget.types != null && widget.types!.isNotEmpty;

    // Build type counts from all pages (not filtered) — fallback path
    // Use businessTypeId as key so selectedTypeId can match
    final typeCounts = <String, ({String name, int count})>{};
    if (!hasProvidedTypes) {
      for (final page in allPages) {
        final id = page.businessTypeId ?? page.businessTypeName ?? '';
        final name = page.businessTypeName ?? id;
        if (id.isNotEmpty) {
          final existing = typeCounts[id];
          typeCounts[id] = (name: name, count: (existing?.count ?? 0) + 1);
        }
      }
    }

    return Column(
      children: [
        // Search bar
        _buildSearchBar(context),
        // Type filter chips
        if (hasProvidedTypes)
          _buildProvidedTypeChips(context, allPages)
        else if (typeCounts.isNotEmpty)
          _buildFallbackTypeChips(context, typeCounts, allPages.length),
        // Result bar + sort
        _buildResultBar(context, filtered.length, allPages.length),
        // List
        Expanded(
          child: filtered.isEmpty
              ? _buildEmptyState(context)
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (_, index) => BrowseCard(page: filtered[index]),
                ),
        ),
      ],
    );
  }

  List<PageSummary> _applyFilters(List<PageSummary> pages) {
    var result = pages.toList();

    // Type filter — always use businessTypeId for consistency
    if (_activeType != 'الكل') {
      result = result
          .where(
            (p) =>
                p.businessTypeId == _activeType ||
                p.businessTypeName == _activeType,
          )
          .toList();
    }

    // Search filter
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      result = result
          .where(
            (p) =>
                p.name.toLowerCase().contains(q) ||
                (p.businessTypeName?.toLowerCase().contains(q) ?? false) ||
                (p.subCategory?.toLowerCase().contains(q) ?? false),
          )
          .toList();
    }

    // Sort
    switch (_sortBy) {
      case CategorySortBy.nearest:
        result.sort(
          (a, b) =>
              _parseDistance(a.distance).compareTo(_parseDistance(b.distance)),
        );
      case CategorySortBy.popular:
        result.sort((a, b) => b.followersCount.compareTo(a.followersCount));
      case CategorySortBy.alphabetical:
        result.sort((a, b) => a.name.compareTo(b.name));
    }

    return result;
  }

  double _parseDistance(String? distance) {
    if (distance == null) return 999;
    final match = RegExp(r'([\d.]+)').firstMatch(distance);
    return match != null ? double.tryParse(match.group(1)!) ?? 999 : 999;
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: context.colorScheme.outlineVariant),
        ),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: 'ابحث في ${widget.categoryName}...',
          hintStyle: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 14,
            color: context.colorScheme.onSurfaceVariant,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 14,
                    color: context.colorScheme.outline,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                )
              : null,
          filled: true,
          fillColor: context.colorScheme.surfaceContainerLowest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
            borderSide: BorderSide(color: context.colorScheme.outlineVariant),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
            borderSide: BorderSide(color: context.colorScheme.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
            borderSide: const BorderSide(color: Color(0xFF1A73E8)),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 10,
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackTypeChips(
    BuildContext context,
    Map<String, ({String name, int count})> typeCounts,
    int totalCount,
  ) {
    final sortedTypes = typeCounts.entries.toList()
      ..sort((a, b) => b.value.count.compareTo(a.value.count));

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: context.colorScheme.outlineVariant),
        ),
      ),
      child: SizedBox(
        height: 30,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _TypeChip(
              label: 'الكل',
              count: totalCount,
              isActive: _activeType == 'الكل',
              onTap: () => setState(() => _activeType = 'الكل'),
            ),
            ...sortedTypes.map(
              (e) => _TypeChip(
                label: e.value.name,
                count: e.value.count,
                isActive: _activeType == e.key,
                onTap: () => setState(() => _activeType = e.key),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProvidedTypeChips(
    BuildContext context,
    List<PageSummary> allPages,
  ) {
    final typeList = widget.types!;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: context.colorScheme.outlineVariant),
        ),
      ),
      child: SizedBox(
        height: 30,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _TypeChip(
              label: 'الكل',
              count: allPages.length,
              isActive: _activeType == 'الكل',
              onTap: () => setState(() => _activeType = 'الكل'),
            ),
            ...typeList.map((type) {
              final count = allPages
                  .where((p) => p.businessTypeId == type.id)
                  .length;
              return _TypeChip(
                label: type.name,
                count: count,
                isActive: _activeType == type.id,
                onTap: () => setState(() => _activeType = type.id),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildResultBar(
    BuildContext context,
    int filteredCount,
    int totalCount,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            filteredCount == totalCount
                ? '$totalCount صفحة'
                : '$filteredCount من $totalCount صفحة',
            style: TextStyle(
              fontSize: 10,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          _SortTrigger(
            label: sortLabel(_sortBy),
            onTap: () async {
              final result = await showSortSheet(
                context,
                current: _sortBy,
                isGovernment: _isGovernment,
              );
              if (result != null) setState(() => _sortBy = result);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.storefront_outlined,
            size: 48,
            color: context.colorScheme.outline,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            _searchQuery.isNotEmpty
                ? 'لا توجد نتائج لـ "$_searchQuery"'
                : 'لا توجد صفحات في هذا القسم بعد',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Private Widgets ───────────────────────────────────────

class _TypeChip extends StatelessWidget {
  final String label;
  final int count;
  final bool isActive;
  final VoidCallback onTap;

  const _TypeChip({
    required this.label,
    required this.count,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isActive ? Colors.blue.shade50 : Colors.transparent,
            borderRadius: AppRadius.pill,
            border: Border.all(
              color: isActive
                  ? const Color(0xFF1A73E8)
                  : context.colorScheme.surfaceContainer,
            ),
          ),
          child: Text(
            '$label ($count)',
            style: TextStyle(
              fontSize: 12,
              color: isActive
                  ? const Color(0xFF1A73E8)
                  : context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

class _SortTrigger extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SortTrigger({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.tune,
              size: 11,
              color: context.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 2),
            Icon(
              Icons.expand_more,
              size: 10,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
