import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/directory_management/domain/entities/directory_floor.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant.dart';
import 'package:honak/features/business/directory_management/presentation/widgets/shared/tenant_card.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/features/pages/presentation/widgets/sections/directory_filter_sheet.dart';
import 'package:honak/features/pages/presentation/widgets/sections/directory_tab_widgets.dart';
import 'package:honak/shared/providers/api_provider.dart';
import 'package:honak/shared/widgets/error_view.dart';
import 'package:honak/shared/widgets/skeleton/skeleton.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

// ── Customer-facing directory data provider ──

class _DirectoryViewData {
  final List<Tenant> tenants;
  final List<DirectoryFloor> floors;

  const _DirectoryViewData({required this.tenants, required this.floors});
}

final _directoryViewDataProvider =
    FutureProvider.family<_DirectoryViewData, String>((ref, pageId) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get<_DirectoryViewData>(
    '/v1/pages/$pageId',
    fromJson: (json) {
      final map = json as Map<String, dynamic>;
      final tenantsList = (map['tenants'] as List?)
              ?.map((e) => Tenant.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      final floorsList = (map['floors'] as List?)
              ?.map((e) => DirectoryFloor.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      return _DirectoryViewData(tenants: tenantsList, floors: floorsList);
    },
  );
  if (response.isSuccess && response.data != null) return response.data!;
  throw Exception(response.error?.message ?? 'Failed to load directory');
});

// ── DirectoryTab widget ──

/// Full tenant browsing tab for directory pages (mall, plaza, complex).
/// Provides search, floor-grouped listing, filters, and pagination.
class DirectoryTab extends ConsumerStatefulWidget {
  final String pageId;
  final PageDetail page;

  const DirectoryTab({
    super.key,
    required this.pageId,
    required this.page,
  });

  @override
  ConsumerState<DirectoryTab> createState() => _DirectoryTabState();
}

class _DirectoryTabState extends ConsumerState<DirectoryTab> {
  static const _pageSize = 30;

  final _searchController = TextEditingController();
  Timer? _debounce;
  String _searchQuery = '';
  DirectoryFilters _filters = const DirectoryFilters();
  int _visibleCount = _pageSize;
  final Map<String, bool> _floorExpanded = {};

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _searchQuery = value;
          _visibleCount = _pageSize;
        });
      }
    });
  }

  /// Apply search, filters, and sort to tenants.
  List<Tenant> _applyFilters(
    List<Tenant> tenants,
    Map<String, DirectoryFloor> floorMap,
  ) {
    var filtered = tenants.toList();

    // Search by name (ar + en)
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((t) {
        return t.name.toLowerCase().contains(query) ||
            (t.nameEn?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    // Open only
    if (_filters.openOnly) {
      filtered = filtered
          .where((t) => t.isOpen && !t.temporarilyClosed)
          .toList();
    }

    // Floor filter
    if (_filters.selectedFloors.isNotEmpty) {
      filtered = filtered.where((t) {
        final floor = floorMap[t.floorId];
        return floor != null && _filters.selectedFloors.contains(floor.name);
      }).toList();
    }

    // Category filter
    if (_filters.selectedCategories.isNotEmpty) {
      filtered = filtered
          .where((t) => _filters.selectedCategories.contains(t.category))
          .toList();
    }

    // Sort
    switch (_filters.sortMode) {
      case DirectorySortMode.name:
        filtered.sort((a, b) => a.name.compareTo(b.name));
      case DirectorySortMode.floor:
        // Sort by floor order from floors list
        final floorOrder = <String, int>{};
        var i = 0;
        for (final f in floorMap.values) {
          floorOrder[f.id] = i++;
        }
        filtered.sort((a, b) =>
            (floorOrder[a.floorId] ?? 999)
                .compareTo(floorOrder[b.floorId] ?? 999));
      case DirectorySortMode.defaultOrder:
        break;
    }

    return filtered;
  }

  /// Preview count for filter sheet.
  int _previewCount(
    DirectoryFilters filters,
    List<Tenant> tenants,
    Map<String, DirectoryFloor> floorMap,
  ) {
    var filtered = tenants.toList();
    if (filters.openOnly) {
      filtered = filtered
          .where((t) => t.isOpen && !t.temporarilyClosed)
          .toList();
    }
    if (filters.selectedFloors.isNotEmpty) {
      filtered = filtered.where((t) {
        final floor = floorMap[t.floorId];
        return floor != null && filters.selectedFloors.contains(floor.name);
      }).toList();
    }
    if (filters.selectedCategories.isNotEmpty) {
      filtered = filtered
          .where((t) => filters.selectedCategories.contains(t.category))
          .toList();
    }
    return filtered.length;
  }

  /// Group tenants by floor ID, preserving floor order.
  Map<String, List<Tenant>> _groupByFloor(
    List<Tenant> tenants,
    List<DirectoryFloor> floors,
  ) {
    final groups = <String, List<Tenant>>{};
    // Initialize with floor order
    for (final floor in floors) {
      groups[floor.id] = [];
    }
    for (final tenant in tenants) {
      groups.putIfAbsent(tenant.floorId, () => []).add(tenant);
    }
    // Remove empty floors
    groups.removeWhere((_, tenants) => tenants.isEmpty);
    return groups;
  }

  /// Build category info from tenants.
  List<CategoryInfo> _buildCategories(List<Tenant> tenants) {
    final counts = <String, int>{};
    for (final t in tenants) {
      counts[t.category] = (counts[t.category] ?? 0) + 1;
    }
    return counts.entries
        .map((e) => CategoryInfo(name: e.key, count: e.value))
        .toList()
      ..sort((a, b) => b.count.compareTo(a.count));
  }

  void _openFilterSheet(
    List<Tenant> tenants,
    List<DirectoryFloor> floors,
    Map<String, DirectoryFloor> floorMap,
  ) async {
    final categories = _buildCategories(tenants);
    final result = await showDirectoryFilterSheet(
      context,
      current: _filters,
      floors: floors,
      categories: categories,
      totalCount: tenants.length,
      previewCount: (f) => _previewCount(f, tenants, floorMap),
    );
    if (result != null && mounted) {
      setState(() {
        _filters = result;
        _visibleCount = _pageSize;
      });
    }
  }

  void _clearAllFilters() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      _filters = const DirectoryFilters();
      _visibleCount = _pageSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataAsync = ref.watch(_directoryViewDataProvider(widget.pageId));

    return dataAsync.when(
      loading: () => const SkeletonListTile(count: 8),
      error: (error, _) => ErrorView(
        message: error.toString(),
        onRetry: () =>
            ref.invalidate(_directoryViewDataProvider(widget.pageId)),
      ),
      data: (data) => _buildContent(context, data.tenants, data.floors),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<Tenant> allTenants,
    List<DirectoryFloor> floors,
  ) {
    final floorMap = {for (final f in floors) f.id: f};
    final filtered = _applyFilters(allTenants, floorMap);
    final hasActiveFilters =
        _filters.hasActiveFilters || _searchQuery.isNotEmpty;
    final floorGroups = _groupByFloor(filtered, floors);

    // Pagination
    final visible = filtered.take(_visibleCount).toList();
    final hasMore = filtered.length > _visibleCount;
    final visibleSet = visible.toSet();

    return CustomScrollView(
      slivers: [
        // Search + filter bar
        SliverToBoxAdapter(
          child: _buildSearchBar(context, allTenants, floors, floorMap),
        ),

        // Active filters strip
        if (hasActiveFilters)
          SliverToBoxAdapter(
            child: ActiveFiltersStrip(
              openOnly: _filters.openOnly,
              selectedFloors: _filters.selectedFloors,
              selectedCategories: _filters.selectedCategories,
              onClearAll: _clearAllFilters,
              onToggleOpenOnly: () =>
                  setState(() => _filters = _filters.copyWith(openOnly: false)),
              onRemoveFloor: (floor) {
                final s = Set<String>.from(_filters.selectedFloors)
                  ..remove(floor);
                setState(() => _filters = _filters.copyWith(selectedFloors: s));
              },
              onRemoveCategory: (cat) {
                final s = Set<String>.from(_filters.selectedCategories)
                  ..remove(cat);
                setState(
                    () => _filters = _filters.copyWith(selectedCategories: s));
              },
            ),
          ),

        // Result count
        if (hasActiveFilters)
          SliverToBoxAdapter(
            child: DirectoryResultCount(
              visible: visible.length,
              total: allTenants.length,
            ),
          ),

        // Content: floor sections or empty state
        if (visible.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: DirectoryEmptyState(
              searchQuery: _searchQuery,
              hasFilters: _filters.hasActiveFilters,
              onClearFilters: _clearAllFilters,
            ),
          )
        else ...[
          // Floor-grouped tenant list
          ...floorGroups.entries.expand((entry) {
            final floorId = entry.key;
            final floor = floorMap[floorId];
            final floorTenants = entry.value
                .where((t) => visibleSet.contains(t))
                .toList();
            if (floorTenants.isEmpty) return <Widget>[];

            final isExpanded = _floorExpanded[floorId] ?? true;

            return [
              SliverToBoxAdapter(
                child: FloorSectionHeader(
                  floorName: floor?.name ?? floorId,
                  floorLabel: floor?.label,
                  tenantCount: entry.value.length,
                  isExpanded: isExpanded,
                  onToggle: () =>
                      setState(() => _floorExpanded[floorId] = !isExpanded),
                ),
              ),
              if (isExpanded)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final tenant = floorTenants[index];
                      return TenantCard(
                        tenant: tenant,
                        onTap: tenant.pageId != null
                            ? () =>
                                context.push(Routes.pagePath(tenant.pageId!))
                            : null,
                      );
                    },
                    childCount: floorTenants.length,
                  ),
                ),
            ];
          }),

          // Load more
          if (hasMore)
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: btn.Button(
                    onPressed: () =>
                        setState(() => _visibleCount += _pageSize),
                    label: '\u062a\u062d\u0645\u064a\u0644 \u0627\u0644\u0645\u0632\u064a\u062f (${visible.length} \u0645\u0646 ${filtered.length})',
                    variant: btn.Variant.text,
                  ),
                ),
              ),
            ),
        ],

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
      ],
    );
  }

  Widget _buildSearchBar(
    BuildContext context,
    List<Tenant> allTenants,
    List<DirectoryFloor> floors,
    Map<String, DirectoryFloor> floorMap,
  ) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          // "ابحث عن متجر، مطعم، خدمة..."
          hintText:
              '\u0627\u0628\u062d\u062b \u0639\u0646 \u0645\u062a\u062c\u0631\u060c \u0645\u0637\u0639\u0645\u060c \u062e\u062f\u0645\u0629...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _buildFilterButton(allTenants, floors, floorMap),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: context.colorScheme.surfaceContainerHighest,
          contentPadding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          isDense: true,
        ),
      ),
    );
  }

  Widget _buildFilterButton(
    List<Tenant> allTenants,
    List<DirectoryFloor> floors,
    Map<String, DirectoryFloor> floorMap,
  ) {
    final count = _filters.activeCount;
    return IconButton(
      icon: Badge(
        isLabelVisible: count > 0,
        label: Text('$count'),
        child: const Icon(Icons.tune),
      ),
      onPressed: () => _openFilterSheet(allTenants, floors, floorMap),
    );
  }
}
