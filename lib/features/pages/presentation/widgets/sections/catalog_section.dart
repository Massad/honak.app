import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/features/pages/presentation/providers/page_detail_providers.dart';
import 'package:honak/shared/widgets/offering_item_card.dart';
import 'package:honak/features/pages/presentation/widgets/sections/catalog_section_helpers.dart';
import 'package:honak/features/pages/presentation/widgets/sections/floating_cart_bar.dart';
import 'package:honak/features/pages/presentation/widgets/shared/catalog_filter_sheet.dart';
import 'package:honak/shared/mixins/section_filter_mixin.dart';
import 'package:honak/shared/mixins/section_cart_mixin.dart';
import 'package:honak/features/pages/presentation/widgets/shared/highlights_banner.dart';
import 'package:honak/features/pages/presentation/widgets/shared/packages_section.dart';
import 'package:honak/shared/widgets/credit_chip.dart';
import 'package:honak/shared/widgets/credit_history_sheet.dart';
import 'package:honak/shared/widgets/error_view.dart';
import 'package:honak/shared/widgets/skeleton/skeleton.dart';
import 'package:honak/shared/widgets/item_selection/category_filter_pills.dart';
import 'package:honak/shared/widgets/auth_gate.dart';
import 'package:honak/shared/widgets/section_search_bar.dart';

/// Product list with category filtering, search, cart, and pagination.
/// Used by the catalogOrder archetype (water delivery, grocery, retail).
class CatalogSection extends ConsumerStatefulWidget {
  final String pageId;
  final PageDetail? page;
  final int selectedBranchIndex;

  const CatalogSection({
    super.key,
    required this.pageId,
    this.page,
    this.selectedBranchIndex = 0,
  });

  @override
  ConsumerState<CatalogSection> createState() => _CatalogSectionState();
}

class _CatalogSectionState extends ConsumerState<CatalogSection>
    with SectionFilterMixin, SectionCartMixin {
  // Mock credit history for demo (Phase 1)
  static final _mockCreditHistory = [
    CreditHistoryEntry(
      date: DateTime(2025, 12, 3),
      description: '\u0634\u0631\u0627\u0621 \u0628\u0627\u0642\u0629 10 \u0642\u0648\u0627\u0631\u064a\u0631',
      amount: 10,
    ),
    CreditHistoryEntry(
      date: DateTime(2025, 12, 7),
      description: '\u0637\u0644\u0628 #980 \u2014 \u062a\u0648\u0635\u064a\u0644 3 \u0642\u0648\u0627\u0631\u064a\u0631',
      amount: -3,
    ),
    CreditHistoryEntry(
      date: DateTime(2025, 12, 15),
      description: '\u0637\u0644\u0628 #1005 \u2014 \u062a\u0648\u0635\u064a\u0644 3 \u0642\u0648\u0627\u0631\u064a\u0631',
      amount: -3,
    ),
  ];

  CatalogFilterState _filterState = CatalogFilterState.empty;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Catalog-specific filter: applies base filter then adds price, stock,
  /// multi-category, and sort filters on top.
  List<Item> _filterItems(List<Item> items) {
    var filtered = baseFilterItems(items);

    // In-stock filter
    if (_filterState.showInStockOnly) {
      filtered = filtered.where((item) => item.inStock).toList();
    }

    // Price range filter
    if (_filterState.minPrice != null) {
      final minCents = (_filterState.minPrice! * 100).round();
      filtered =
          filtered.where((item) => item.price.cents >= minCents).toList();
    }
    if (_filterState.maxPrice != null && _filterState.maxPrice! < 100) {
      final maxCents = (_filterState.maxPrice! * 100).round();
      filtered =
          filtered.where((item) => item.price.cents <= maxCents).toList();
    }

    // Category multi-select from filter sheet
    if (_filterState.selectedCategories.isNotEmpty) {
      filtered = filtered
          .where((item) =>
              item.categoryName != null &&
              _filterState.selectedCategories.contains(item.categoryName))
          .toList();
    }

    // Sort
    switch (_filterState.sort) {
      case SortOption.priceLowHigh:
        filtered = [...filtered]
          ..sort((a, b) => a.price.cents.compareTo(b.price.cents));
      case SortOption.priceHighLow:
        filtered = [...filtered]
          ..sort((a, b) => b.price.cents.compareTo(a.price.cents));
      case SortOption.newest:
      case SortOption.popular:
        break;
      case SortOption.defaultSort:
        // Already sorted by baseFilterItems
        break;
    }

    return filtered;
  }

  void _openFilterSheet(List<Item> allItems) {
    final categories = extractCategories(allItems);
    CatalogFilterSheet.show(
      context: context,
      initialState: _filterState,
      config: FilterConfig(
        categories: categories
            .map((c) => (id: c, label: c))
            .toList(),
      ),
      onApply: (state) {
        setState(() {
          _filterState = state;
          visibleCount = SectionFilterMixin.sectionPageSize;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(pageItemsProvider(widget.pageId));
    final hasSpecials =
        widget.page != null && widget.page!.specials.isNotEmpty;

    return itemsAsync.when(
      loading: () => const SkeletonProductCard(count: 4, grid: false),
      error: (error, _) => ErrorView(
        message: error.toString(),
        onRetry: () => ref.invalidate(pageItemsProvider(widget.pageId)),
      ),
      data: (items) {
        final categories = extractCategories(items);
        final filtered = _filterItems(items);
        final visible = filtered.take(visibleCount).toList();
        final hasMore = filtered.length > visibleCount;

        return Stack(
          children: [
            CustomScrollView(
              slivers: [
                // Specials banner
                if (hasSpecials)
                  SliverToBoxAdapter(
                    child: SpecialsBanner(
                      specials: widget.page!.specials,
                    ),
                  ),

                // Credit chip
                if (widget.page != null &&
                    widget.page!.packages.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        AppSpacing.lg,
                        AppSpacing.sm,
                        AppSpacing.lg,
                        0,
                      ),
                      child: CreditChip(
                        remainingCredits:
                            widget.page!.packages.first.credits,
                        totalCredits:
                            widget.page!.packages.first.credits,
                        creditLabel:
                            widget.page!.packages.first.creditLabel ??
                                '\u0631\u0635\u064a\u062f',
                        onTapHistory: () {
                          final pkg = widget.page!.packages.first;
                          CreditHistorySheet.show(
                            context,
                            packageName: pkg.name,
                            pageName: widget.page!.name,
                            creditLabel:
                                pkg.creditLabel ?? '\u0631\u0635\u064a\u062f',
                            entries: _mockCreditHistory,
                            startsAt: DateTime(2025, 12, 3),
                            expiresAt: DateTime(2026, 4, 30),
                            remainingCredits: 4,
                            totalCredits: pkg.credits,
                          );
                        },
                      ),
                    ),
                  ),

                // Packages section
                if (widget.page != null &&
                    widget.page!.packages.isNotEmpty)
                  SliverToBoxAdapter(
                    child: PackagesSection(
                      packages: widget.page!.packages,
                      archetype: 'catalog_order',
                      pageName: widget.page!.name,
                      existingCredits: 6,
                      existingCreditLabel:
                          widget.page!.packages.first.creditLabel,
                    ),
                  ),

                // Category pills
                if (categories.isNotEmpty)
                  SliverToBoxAdapter(
                    child: CategoryFilterPills(
                      categories: categories,
                      selected: selectedCategory,
                      onSelected: selectCategory,
                    ),
                  ),

                // Search bar + filter button
                SliverToBoxAdapter(
                  child: SectionSearchBar(
                    hintText: '\u0627\u0628\u062d\u062b \u0641\u064a \u0627\u0644\u0645\u0646\u062a\u062c\u0627\u062a...',
                    onChanged: updateSearch,
                    controller: _searchController,
                    onClear: () {
                      _searchController.clear();
                      updateSearch('');
                    },
                    trailing: CatalogFilterButton(
                      activeCount: _filterState.activeCount,
                      onTap: () => _openFilterSheet(items),
                    ),
                  ),
                ),

                // Empty state
                if (visible.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: SectionEmptySearch(),
                  )
                else ...[
                  // Product list
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = visible[index];
                          return Padding(
                            padding:
                                const EdgeInsets.only(bottom: AppSpacing.sm),
                            child: OfferingItemCard(
                              item: item,
                              quantity: quantityForItem(item.id),
                              onQuantityChanged: (qty) =>
                                  handleQuantityChanged(item, qty),
                              onAdd: item.optionGroups.isNotEmpty
                                  ? () => showItemConfigSheet(context, item)
                                  : null,
                              activePriceChange:
                                  widget.page?.activePriceChange,
                            ),
                          );
                        },
                        childCount: visible.length,
                      ),
                    ),
                  ),

                  // Show more button
                  if (hasMore)
                    SliverToBoxAdapter(
                      child: SectionShowMoreButton(
                        visibleCount: visible.length,
                        totalCount: filtered.length,
                        onPressed: showMore,
                      ),
                    ),

                  // Highlights banner
                  if (widget.page?.catalogStrategy == 'highlights')
                    SliverToBoxAdapter(
                      child: HighlightsBanner(
                        carryCategories:
                            widget.page!.carryCategories,
                        onAskAvailability: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                '\u0633\u064a\u062a\u0645 \u0641\u062a\u062d \u0645\u062d\u0627\u062f\u062b\u0629 \u0645\u0639 \u0627\u0644\u0645\u062a\u062c\u0631 \u0642\u0631\u064a\u0628\u0627\u064b',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],

                // Bottom padding for cart bar
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: cart.isNotEmpty
                        ? AppSpacing.xxl + 80
                        : AppSpacing.xxl,
                  ),
                ),
              ],
            ),

            // Floating cart bar
            if (cart.isNotEmpty)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: FloatingCartBar(
                  itemCount: cartItemCount,
                  total: cartTotal,
                  onSendOrder: () => AuthGate.require(
                    context,
                    ref,
                    trigger: LoginPromptTrigger.order,
                    onAuthed: () => openOrderSheet(
                      context,
                      pageId: widget.pageId,
                      pageName: widget.page?.name ?? '',
                      paymentMethods: widget.page?.paymentMethods ?? const ['\u0646\u0642\u062f\u0627\u064b'],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
