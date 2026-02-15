import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/config/business_type_config.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/catalog_management/presentation/pages/wizard_page.dart';
import 'package:honak/features/business/catalog_management/presentation/providers/provider.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/active_filter_strip.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/category_manager.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/filter_bottom_sheet.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/load_more_button.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/mass_action_bar.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/package_manager_section.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/truck_manager_section.dart';
import 'package:honak/features/business/shared/widgets/item_card.dart';
import 'package:honak/shared/widgets/catalog_search_bar.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/item_list_skeleton.dart';
import 'package:honak/features/business/shared/domain/entities/biz_category.dart';
import 'package:honak/features/business/shared/domain/entities/biz_item.dart';
import 'package:honak/features/business/catalog_management/domain/entities/price_change.dart';
import 'package:honak/features/business/catalog_management/presentation/providers/price_change_provider.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/price_change/price_change_banner.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/price_change/price_change_history.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/price_change/wizard_page.dart'
    as pc_wizard;
import 'package:honak/features/business/catalog_management/presentation/widgets/stock_manager_sheet.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/team_assign_sheet.dart';
import 'package:honak/features/business/page_settings/presentation/providers/team_provider.dart';
import 'package:honak/shared/extensions/sort_extensions.dart';
import 'package:honak/shared/providers/business_page_provider.dart';

enum _ManageMode { normal, select, reorder }

const _pageSize = 20;

class BusinessManagePage extends ConsumerStatefulWidget {
  const BusinessManagePage({super.key});

  @override
  ConsumerState<BusinessManagePage> createState() =>
      _BusinessManagePageState();
}

class _BusinessManagePageState extends ConsumerState<BusinessManagePage> {
  int _activeTab = 0;
  String _searchQuery = '';
  String _filterCategoryId = '';
  String _filterStatus = 'all';

  _ManageMode _mode = _ManageMode.normal;
  final Set<String> _selected = {};
  List<BizItem> _reorderItems = [];
  int _visibleCount = _pageSize;

  // ── Mode transitions ──────────────────────────────────────────

  void _enterSelectMode([String? preSelectId]) {
    setState(() {
      _mode = _ManageMode.select;
      _selected.clear();
      if (preSelectId != null) _selected.add(preSelectId);
    });
  }

  void _exitSelectMode() {
    setState(() {
      _mode = _ManageMode.normal;
      _selected.clear();
    });
  }

  void _enterReorderMode(List<BizItem> items) {
    setState(() {
      _mode = _ManageMode.reorder;
      _reorderItems = List.of(items);
      _selected.clear();
    });
  }

  void _exitReorderMode() {
    // Auto-saved — each arrow tap applies immediately
    setState(() => _mode = _ManageMode.normal);
  }

  void _moveItem(int index, int direction) {
    final newIdx = index + direction;
    if (newIdx < 0 || newIdx >= _reorderItems.length) return;
    setState(() {
      final item = _reorderItems.removeAt(index);
      _reorderItems.insert(newIdx, item);
    });
  }

  // ── Selection helpers ─────────────────────────────────────────

  void _toggleSelect(String id) {
    setState(() {
      if (_selected.contains(id)) {
        _selected.remove(id);
      } else {
        _selected.add(id);
      }
    });
  }

  void _toggleAll(List<BizItem> items) {
    setState(() {
      if (_selected.length == items.length) {
        _selected.clear();
      } else {
        _selected.addAll(items.map((i) => i.id));
      }
    });
  }

  // ── Item tap handling ─────────────────────────────────────────

  void _handleItemTap(
    BizItem item,
    ItemManagementConfig? config,
    String pageId,
    List<BizCategory> categories,
  ) {
    if (_mode == _ManageMode.select) {
      _toggleSelect(item.id);
    } else if (_mode == _ManageMode.normal) {
      _editItem(item, config, pageId, categories);
    }
  }

  void _handleLongPress(String itemId) {
    if (_mode == _ManageMode.normal) {
      _enterSelectMode(itemId);
    }
  }

  // ── Mass actions ──────────────────────────────────────────────

  void _applyMassStatus(String status) {
    // Mock — in real app, batch API call
    _exitSelectMode();
    _showToast('تم تحديث حالة ${_selected.length} عنصر');
  }

  void _applyMassDelete() {
    _exitSelectMode();
    _showToast('تم حذف ${_selected.length} عنصر');
  }

  // ── Pagination ────────────────────────────────────────────────

  void _loadMore() {
    setState(() => _visibleCount += _pageSize);
  }

  void _resetPagination() {
    _visibleCount = _pageSize;
  }

  // ── Filter helpers ────────────────────────────────────────────

  bool get _isFiltering =>
      _searchQuery.isNotEmpty ||
      _filterCategoryId.isNotEmpty ||
      _filterStatus != 'all';

  int get _activeFilterCount =>
      (_filterCategoryId.isNotEmpty ? 1 : 0) +
      (_filterStatus != 'all' ? 1 : 0);

  List<ActiveFilter> _buildActiveFilters(List<BizCategory> categories) {
    final filters = <ActiveFilter>[];
    if (_filterCategoryId.isNotEmpty) {
      final name =
          categories.where((c) => c.id == _filterCategoryId).firstOrNull?.name;
      if (name != null) {
        filters.add(ActiveFilter(
          key: 'category',
          label: name,
          bgColor: AppColors.primary.withValues(alpha: 0.08),
          textColor: AppColors.primary,
        ));
      }
    }
    if (_filterStatus != 'all') {
      final label = switch (_filterStatus) {
        'active' => 'متوفر',
        'out_of_stock' => 'غير متوفر',
        'hidden' => 'مخفي',
        _ => _filterStatus,
      };
      filters.add(ActiveFilter(
        key: 'status',
        label: label,
        bgColor: Colors.orange.shade50,
        textColor: Colors.orange.shade700,
      ));
    }
    return filters;
  }

  void _removeFilter(String key) {
    setState(() {
      if (key == 'category') _filterCategoryId = '';
      if (key == 'status') _filterStatus = 'all';
      _resetPagination();
    });
  }

  void _clearAllFilters() {
    setState(() {
      _searchQuery = '';
      _filterCategoryId = '';
      _filterStatus = 'all';
      _resetPagination();
    });
  }

  List<BizItem> _applyFilters(List<BizItem> items) {
    var result = items;

    if (_filterCategoryId.isNotEmpty) {
      result =
          result.where((i) => i.categoryId == _filterCategoryId).toList();
    }

    if (_filterStatus == 'active') {
      result = result.where((i) => i.status == 'active').toList();
    } else if (_filterStatus == 'out_of_stock') {
      result = result.where((i) => i.status == 'out_of_stock').toList();
    } else if (_filterStatus == 'hidden') {
      result = result.where((i) => i.status == 'hidden').toList();
    }

    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      result = result.where((i) {
        return i.name.toLowerCase().contains(q) ||
            (i.description?.toLowerCase().contains(q) ?? false) ||
            (i.categoryName?.toLowerCase().contains(q) ?? false);
      }).toList();
    }

    return result;
  }

  // ── Navigation ────────────────────────────────────────────────

  void _openPriceWizard(
    List<BizItem> items,
    String itemsLabel, {
    PriceChange? editChange,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => pc_wizard.PriceChangeWizardPage(
          items: items,
          itemsLabel: itemsLabel,
          editChange: editChange,
          onComplete: (change) {
            ref.read(priceChangeProvider.notifier).applyChange(change);
            _showToast('تم تطبيق تغيير الأسعار');
          },
        ),
      ),
    );
  }

  void _openPriceHistory(
    PriceChange? active,
    List<PriceChange> history,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          body: PriceChangeHistory(
            activePriceChange: active,
            history: history,
            onClose: () => Navigator.of(context).pop(),
            onStopActive: () {
              ref.read(priceChangeProvider.notifier).stopActive();
              Navigator.of(context).pop();
              _showToast('تم إيقاف تغيير الأسعار');
            },
            onReuse: (change) {
              Navigator.of(context).pop();
              final pageId =
                  ref.read(businessContextProvider)?.page.id ?? '';
              final items =
                  ref.read(bizItemsProvider(pageId)).valueOrNull ?? [];
              final config = ref.read(businessContextProvider)?.config;
              final label =
                  config?.itemManagement?.itemsLabelAr ?? 'الأصناف';
              _openPriceWizard(items, label);
            },
          ),
        ),
      ),
    );
  }

  void _openItemWizard(
    ItemManagementConfig? itemConfig,
    String pageId,
    List<BizCategory> categories,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ItemWizardPage(
          config: itemConfig,
          pageId: pageId,
          categories: categories,
        ),
      ),
    );
  }

  void _editItem(
    BizItem item,
    ItemManagementConfig? itemConfig,
    String pageId,
    List<BizCategory> categories,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ItemWizardPage(
          item: item,
          config: itemConfig,
          pageId: pageId,
          categories: categories,
        ),
      ),
    );
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  // ── Build grouped items (normal / select mode) ────────────────

  List<Widget> _buildItems({
    required List<BizItem> visible,
    required List<BizItem> allFiltered,
    required List<BizCategory> categories,
    required ItemManagementConfig? config,
    required String pageId,
    required bool grouped,
  }) {
    if (grouped && !_isFiltering) {
      return _buildGroupedItems(visible, categories, config, pageId);
    }
    return _buildFlatItems(visible, config, pageId, categories);
  }

  List<Widget> _buildFlatItems(
    List<BizItem> items,
    ItemManagementConfig? config,
    String pageId,
    List<BizCategory> categories,
  ) {
    return items
        .map((item) => Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.sm),
              child: ItemCard(
                item: item,
                config: config,
                isSelected: _selected.contains(item.id),
                selectModeActive: _mode == _ManageMode.select,
                onTap: () =>
                    _handleItemTap(item, config, pageId, categories),
                onLongPress: () => _handleLongPress(item.id),
              ),
            ))
        .toList();
  }

  List<Widget> _buildGroupedItems(
    List<BizItem> items,
    List<BizCategory> categories,
    ItemManagementConfig? config,
    String pageId,
  ) {
    final grouped = <String?, List<BizItem>>{};
    for (final item in items) {
      grouped.putIfAbsent(item.categoryId, () => []).add(item);
    }

    // Sort items within each category group by sortOrder
    for (final group in grouped.values) {
      group.sortByOrder((i) => i.sortOrder);
    }

    // Build a map of categoryId → sortOrder from the categories list
    final catOrderMap = <String, int>{
      for (final c in categories) c.id: c.sortOrder,
    };

    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) {
        if (a == null) return 1;
        if (b == null) return -1;
        final orderA = catOrderMap[a] ?? 999;
        final orderB = catOrderMap[b] ?? 999;
        return orderA.compareTo(orderB);
      });

    final widgets = <Widget>[];
    for (int i = 0; i < sortedKeys.length; i++) {
      final catId = sortedKeys[i];
      final catItems = grouped[catId]!;
      final catName = catItems.first.categoryName;

      if (sortedKeys.length > 1 && catName != null) {
        if (i > 0) widgets.add(const SizedBox(height: AppSpacing.lg));
        widgets.add(Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.sm),
          child: Text(
            catName,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ));
      }

      for (final item in catItems) {
        widgets.add(Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.sm),
          child: ItemCard(
            item: item,
            config: config,
            isSelected: _selected.contains(item.id),
            selectModeActive: _mode == _ManageMode.select,
            onTap: () => _handleItemTap(item, config, pageId, categories),
            onLongPress: () => _handleLongPress(item.id),
          ),
        ));
      }
    }
    return widgets;
  }

  // ── Build reorder items ───────────────────────────────────────

  List<Widget> _buildReorderItems(ItemManagementConfig? config) {
    return [
      // Done button
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.sm),
        child: Row(
          children: [
            GestureDetector(
              onTap: _exitReorderMode,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, size: 11, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Text(
                      'تم',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Info banner
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.md),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.15)),
          ),
          child: const Text(
            'استخدم الأسهم لتغيير ترتيب العناصر — الترتيب يظهر كما هو في صفحتك',
            style: TextStyle(fontSize: 11, color: AppColors.primary),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      ...List.generate(_reorderItems.length, (index) {
        final item = _reorderItems[index];
        return Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.sm),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Index badge
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Icon(Icons.drag_handle, size: 16, color: Theme.of(context).colorScheme.outline),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (item.categoryName != null)
                        Text(
                          item.categoryName!,
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ),
                // Up/down arrows
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ArrowButton(
                      icon: Icons.arrow_upward,
                      enabled: index > 0,
                      onTap: () => _moveItem(index, -1),
                    ),
                    const SizedBox(height: 2),
                    _ArrowButton(
                      icon: Icons.arrow_downward,
                      enabled: index < _reorderItems.length - 1,
                      onTap: () => _moveItem(index, 1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
      const SizedBox(height: 80),
    ];
  }

  // ── Build ─────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final bizContext = ref.watch(businessContextProvider);
    if (bizContext == null) return const SizedBox.shrink();

    final manageTabs = bizContext.config?.manageTabs ?? [];
    final pageId = bizContext.page.id;
    final config = bizContext.config;
    final itemConfig = config?.itemManagement;
    final int clampedTab = _activeTab.clamp(0, max(manageTabs.length - 1, 0));
    final activeTabId =
        manageTabs.isNotEmpty ? manageTabs[clampedTab].id : 'items';
    final label = manageTabs.isNotEmpty
        ? manageTabs[clampedTab].labelAr
        : bizContext.manageTabLabel;

    final itemsAsync = ref.watch(bizItemsProvider(pageId));
    final categoriesAsync = ref.watch(bizCategoriesProvider(pageId));

    return Stack(
      children: [
        ListView(
          children: [
            // Pill tab strip
            if (manageTabs.isNotEmpty)
              _ManageTabStrip(
                tabs: manageTabs,
                activeIndex: _activeTab,
                onTabChanged: (i) => setState(() {
                  _activeTab = i;
                  _clearAllFilters();
                  _exitSelectMode();
                }),
              ),

            // Price changes banner
            if (_mode == _ManageMode.normal)
              _PriceChangeBannerWrapper(
                onOpenWizard: (items, label, editChange) =>
                    _openPriceWizard(items, label, editChange: editChange),
                onOpenHistory: (active, history) =>
                    _openPriceHistory(active, history),
              ),

            // Tab content — items, packages, or trucks based on active tab
            if (activeTabId == 'packages')
              const PackageManagerSection()
            else if (activeTabId == 'trucks')
              const TruckManagerSection()
            else
              ...itemsAsync.when(
                loading: () => [const ItemListSkeleton()],
                error: (err, _) => [
                  _ErrorState(
                    message: 'خطأ في تحميل $label',
                    onRetry: () => ref.invalidate(bizItemsProvider(pageId)),
                  ),
                ],
                data: (items) {
                  final categories = categoriesAsync.valueOrNull ?? [];
                  final filtered = _applyFilters(items);
                  final addLabel = itemConfig?.addLabelAr ?? 'إضافة $label';
                  final itemsLabel = itemConfig?.itemsLabelAr ?? label;
                  final itemLabel = itemConfig?.itemLabelAr ?? label;

                  // Reorder mode
                  if (_mode == _ManageMode.reorder) {
                    return _buildReorderItems(itemConfig);
                  }

                  final visible =
                      filtered.sublist(0, min(_visibleCount, filtered.length));
                  final remaining = filtered.length - visible.length;

                  return [
                    // Section header
                    _SectionHeader(
                      label: itemsLabel,
                      count: items.length,
                      addLabel: addLabel,
                      onAdd: () =>
                          _openItemWizard(itemConfig, pageId, categories),
                      hideAdd: _mode == _ManageMode.select,
                    ),

                    // Toolbar
                    if (items.isNotEmpty)
                      _Toolbar(
                        mode: _mode,
                        selectedCount: _selected.length,
                        totalCount: items.length,
                        categoryCount: categories.length,
                        hasStock: items.any((i) => i.stock != null),
                        onReorder: () => _enterReorderMode(items),
                        onSelect: _enterSelectMode,
                        onStockManager: () => showStockManagerSheet(
                          context,
                          pageId: pageId,
                        ),
                        onExitReorder: _exitReorderMode,
                        onToggleAll: () => _toggleAll(items),
                        allSelected: _selected.length == items.length,
                        onExitSelect: _exitSelectMode,
                        onManageCategories: () => openCategoryManager(
                          context,
                          categories: categories,
                          itemLabelAr: itemConfig?.itemLabelAr ?? 'عنصر',
                          onChanged: (_) {},
                        ),
                      ),

                    // Search + filter button
                    if (items.isNotEmpty && _mode != _ManageMode.select)
                      CatalogSearchBar(
                        query: _searchQuery,
                        onChanged: (q) => setState(() {
                          _searchQuery = q;
                          _resetPagination();
                        }),
                        hintText: 'بحث في $itemsLabel...',
                        onFilterTap: () => showFilterSheet(
                          context,
                          categories: categories,
                          activeCategoryId: _filterCategoryId,
                          activeStatus: _filterStatus,
                          totalCount: items.length,
                          filteredCount: filtered.length,
                          itemLabelAr: itemLabel,
                          itemsLabelAr: itemsLabel,
                          onApply: (catId, status) {
                            setState(() {
                              _filterCategoryId = catId;
                              _filterStatus = status;
                              _resetPagination();
                            });
                          },
                        ),
                        activeFilterCount: _activeFilterCount,
                      ),

                    // Active filter tags
                    if (_isFiltering && _activeFilterCount > 0)
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: ActiveFilterStrip(
                          filters: _buildActiveFilters(categories),
                          onRemove: _removeFilter,
                          onClearAll:
                              _activeFilterCount > 1 ? _clearAllFilters : null,
                        ),
                      ),

                    // Result count
                    if (_isFiltering)
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.sm),
                        child: Text(
                          filtered.length == items.length
                              ? '${items.length} $itemLabel'
                              : '${filtered.length} من ${items.length} $itemLabel',
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),

                    // Items list
                    if (items.isEmpty)
                      _EmptyItemState(
                        label: itemsLabel,
                        addLabel: addLabel,
                        onAdd: () =>
                            _openItemWizard(itemConfig, pageId, categories),
                      )
                    else if (filtered.isEmpty)
                      _FilteredEmptyState(
                        query: _searchQuery,
                        onClear: _clearAllFilters,
                      )
                    else ...[
                      ..._buildItems(
                        visible: visible,
                        allFiltered: filtered,
                        categories: categories,
                        config: itemConfig,
                        pageId: pageId,
                        grouped: (config?.itemManagement?.hasCategory ?? false) &&
                            categories.isNotEmpty,
                      ),
                      // Load more
                      if (remaining > 0)
                        LoadMoreButton(
                          remaining: remaining,
                          pageSize: _pageSize,
                          onLoadMore: _loadMore,
                        ),
                    ],

                    const SizedBox(height: 80),
                  ];
                },
              ),
          ],
        ),

        // Mass action bar overlay (select mode with items selected)
        if (_mode == _ManageMode.select && _selected.isNotEmpty)
          Positioned.fill(
            child: MassActionBar(
              selectedCount: _selected.length,
              config: itemConfig,
              hasTeam: itemConfig?.providerAssignment == true,
              onExit: _exitSelectMode,
              onStatusChange: _applyMassStatus,
              onDelete: _applyMassDelete,
              onOpenDiscount: itemConfig?.canDiscount == true
                  ? () => showMassDiscountSheet(
                        context,
                        selectedCount: _selected.length,
                        itemLabelAr: itemConfig!.itemLabelAr,
                        onApply: (percent) {
                          _exitSelectMode();
                          _showToast('تم تطبيق خصم $percent٪');
                        },
                      )
                  : null,
              onOpenCategory: itemConfig?.hasCategory == true
                  ? () {
                      _exitSelectMode();
                      _showToast('قريباً');
                    }
                  : null,
              onOpenTeam: itemConfig?.providerAssignment == true
                  ? () {
                      final members =
                          ref.read(teamProvider).valueOrNull ?? [];
                      if (members.isEmpty) {
                        _showToast('لا يوجد أعضاء فريق');
                        return;
                      }
                      showTeamAssignSheet(
                        context,
                        selectedCount: _selected.length,
                        itemLabelAr: itemConfig!.itemLabelAr,
                        members: members,
                        onApply: (teamIds) {
                          _exitSelectMode();
                          _showToast(
                            'تم تعيين ${teamIds.length} عضو لـ ${_selected.length} عنصر',
                          );
                        },
                      );
                    }
                  : null,
            ),
          ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Price change banner — watches provider
// ═══════════════════════════════════════════════════════════════

class _PriceChangeBannerWrapper extends ConsumerWidget {
  final void Function(
          List<BizItem> items, String label, PriceChange? editChange)
      onOpenWizard;
  final void Function(PriceChange? active, List<PriceChange> history)
      onOpenHistory;

  const _PriceChangeBannerWrapper({
    required this.onOpenWizard,
    required this.onOpenHistory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pcAsync = ref.watch(priceChangeProvider);
    final bizContext = ref.watch(businessContextProvider);
    if (bizContext == null) return const SizedBox.shrink();

    final pageId = bizContext.page.id;
    final config = bizContext.config;
    final itemsLabel = config?.itemManagement?.itemsLabelAr ?? 'الأصناف';

    return pcAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (pcState) {
        return PriceChangeBanner(
          activePriceChange: pcState.active,
          historyCount: pcState.history.length,
          onCreateNew: () {
            final items =
                ref.read(bizItemsProvider(pageId)).valueOrNull ?? [];
            onOpenWizard(items, itemsLabel, null);
          },
          onEdit: () {
            final items =
                ref.read(bizItemsProvider(pageId)).valueOrNull ?? [];
            onOpenWizard(items, itemsLabel, pcState.active);
          },
          onStop: () {
            ref.read(priceChangeProvider.notifier).stopActive();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم إيقاف تغيير الأسعار'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          onViewHistory: () =>
              onOpenHistory(pcState.active, pcState.history),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Pill tab strip
// ═══════════════════════════════════════════════════════════════

class _ManageTabStrip extends StatelessWidget {
  final List<ManageTab> tabs;
  final int activeIndex;
  final ValueChanged<int> onTabChanged;

  const _ManageTabStrip({
    required this.tabs,
    required this.activeIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.xs),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final isActive = i == activeIndex;
          return Padding(
            padding:
                EdgeInsetsDirectional.only(start: i > 0 ? AppSpacing.sm : 0),
            child: GestureDetector(
              onTap: () => onTabChanged(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tabs[i].labelAr,
                  style: TextStyle(
                    fontSize: 12,
                    color: isActive ? Colors.white : Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Section header
// ═══════════════════════════════════════════════════════════════

class _SectionHeader extends StatelessWidget {
  final String label;
  final int count;
  final String addLabel;
  final VoidCallback onAdd;
  final bool hideAdd;

  const _SectionHeader({
    required this.label,
    required this.count,
    required this.addLabel,
    required this.onAdd,
    this.hideAdd = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.sm),
      child: Row(
        children: [
          Text(
            label,
            style: context.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          if (count > 0) ...[
            const SizedBox(width: AppSpacing.sm),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
          ],
          const Spacer(),
          if (!hideAdd)
            GestureDetector(
              onTap: onAdd,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add, size: 14, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      addLabel,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Toolbar — mode-aware
// ═══════════════════════════════════════════════════════════════

class _Toolbar extends StatelessWidget {
  final _ManageMode mode;
  final int selectedCount;
  final int totalCount;
  final int categoryCount;
  final bool hasStock;
  final VoidCallback onReorder;
  final VoidCallback onSelect;
  final VoidCallback? onStockManager;
  final VoidCallback onExitReorder;
  final VoidCallback onToggleAll;
  final bool allSelected;
  final VoidCallback onExitSelect;
  final VoidCallback onManageCategories;

  const _Toolbar({
    required this.mode,
    required this.selectedCount,
    required this.totalCount,
    required this.categoryCount,
    this.hasStock = false,
    required this.onReorder,
    required this.onSelect,
    this.onStockManager,
    required this.onExitReorder,
    required this.onToggleAll,
    required this.allSelected,
    required this.onExitSelect,
    required this.onManageCategories,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.md),
      child: switch (mode) {
        _ManageMode.normal => _buildNormalToolbar(),
        _ManageMode.select => _buildSelectToolbar(),
        _ManageMode.reorder => _buildReorderToolbar(),
      },
    );
  }

  Widget _buildNormalToolbar() {
    return Row(
      children: [
        if (totalCount > 1)
          _ToolbarChip(
            label: 'ترتيب',
            icon: Icons.swap_vert,
            onTap: onReorder,
          ),
        if (totalCount > 1) const SizedBox(width: 6),
        _ToolbarChip(
          label: 'تحديد',
          icon: Icons.check_box_outline_blank,
          onTap: onSelect,
        ),
        if (hasStock && onStockManager != null) ...[
          const SizedBox(width: 6),
          _ToolbarChip(
            label: 'مخزون',
            icon: Icons.inventory_2_outlined,
            onTap: onStockManager!,
          ),
        ],
        const Spacer(),
        if (categoryCount > 0)
          GestureDetector(
            onTap: onManageCategories,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.settings, size: 9, color: AppColors.primary),
                const SizedBox(width: 4),
                Text(
                  'التصنيفات ($categoryCount)',
                  style: const TextStyle(
                      fontSize: 10, color: AppColors.primary),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSelectToolbar() {
    return Row(
      children: [
        _ToolbarChip(
          label: allSelected ? 'إلغاء الكل' : 'تحديد الكل',
          icon: allSelected
              ? Icons.check_box
              : Icons.check_box_outline_blank,
          onTap: onToggleAll,
          active: true,
        ),
        const SizedBox(width: 6),
        _ToolbarChip(
          label: 'إلغاء',
          icon: Icons.close,
          onTap: onExitSelect,
        ),
        if (selectedCount > 0) ...[
          const SizedBox(width: 6),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$selectedCount محدد',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildReorderToolbar() {
    return Row(
      children: [
        _ToolbarChip(
          label: 'تم',
          icon: Icons.check,
          onTap: onExitReorder,
          active: true,
        ),
        const Spacer(),
        Text(
          'اسحب لتغيير الترتيب',
          style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
        ),
      ],
    );
  }
}

class _ToolbarChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool active;

  const _ToolbarChip({
    required this.label,
    required this.icon,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: active
              ? AppColors.primary.withValues(alpha: 0.08)
              : Theme.of(context).colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 11,
                color: active ? AppColors.primary : Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: active ? AppColors.primary : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Arrow button for reorder mode
// ═══════════════════════════════════════════════════════════════

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _ArrowButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: enabled
              ? AppColors.primary.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 14,
          color: enabled ? AppColors.primary : Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Empty states
// ═══════════════════════════════════════════════════════════════

class _EmptyItemState extends StatelessWidget {
  final String label;
  final String addLabel;
  final VoidCallback onAdd;

  const _EmptyItemState({
    required this.label,
    required this.addLabel,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl, vertical: AppSpacing.xxxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.06),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              size: 30,
              color: AppColors.primary.withValues(alpha: 0.4),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'لا يوجد $label بعد',
            style: context.textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'أضف $label لتظهر في صفحتك',
            style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.xl),
          Material(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onAdd,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl, vertical: AppSpacing.md),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      addLabel,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    const Icon(Icons.add, size: 18, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilteredEmptyState extends StatelessWidget {
  final String query;
  final VoidCallback onClear;

  const _FilteredEmptyState({
    required this.query,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 32,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            query.isNotEmpty
                ? 'لا توجد نتائج لـ "$query"'
                : 'لا يوجد عناصر بهذه التصفية',
            style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.md),
          GestureDetector(
            onTap: onClear,
            child: const Text(
              'مسح التصفية',
              style: TextStyle(fontSize: 12, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Error state
// ═══════════════════════════════════════════════════════════════

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: AppColors.error.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            message,
            style: context.textTheme.bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.lg),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }
}
