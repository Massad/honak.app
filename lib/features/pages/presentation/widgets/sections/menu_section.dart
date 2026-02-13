import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/features/pages/presentation/providers/page_detail_providers.dart';
import 'package:honak/features/pages/presentation/widgets/sections/floating_cart_bar.dart';
import 'package:honak/features/pages/presentation/widgets/sections/menu_item_card.dart';
import 'package:honak/features/requests/domain/entities/cart.dart';
import 'package:honak/features/requests/presentation/widgets/order_request_sheet.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/entities/selected_item.dart';
import 'package:honak/features/pages/presentation/widgets/shared/highlights_banner.dart';
import 'package:honak/shared/widgets/credit_chip.dart';
import 'package:honak/shared/widgets/credit_history_sheet.dart';
import 'package:honak/shared/widgets/error_view.dart';
import 'package:honak/shared/widgets/item_selection/category_filter_pills.dart';
import 'package:honak/shared/widgets/item_selection/item_configuration_step.dart';

/// Browsable menu with categories, search, cart, and pagination.
/// Used by the menuOrder archetype (restaurant, cafe, bakery).
class MenuSection extends ConsumerStatefulWidget {
  final String pageId;
  final PageDetail? page;
  final int selectedBranchIndex;

  const MenuSection({
    super.key,
    required this.pageId,
    this.page,
    this.selectedBranchIndex = 0,
  });

  @override
  ConsumerState<MenuSection> createState() => _MenuSectionState();
}

class _MenuSectionState extends ConsumerState<MenuSection> {
  static const _pageSize = 12;

  String? _selectedCategory;
  String _searchQuery = '';
  int _visibleCount = _pageSize;
  final List<SelectedItem> _cart = [];

  List<Item> _filterItems(List<Item> items) {
    var filtered = items;

    if (_selectedCategory != null) {
      filtered = filtered
          .where((item) => item.categoryName == _selectedCategory)
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((item) {
        final nameMatch = item.nameAr.toLowerCase().contains(query);
        final descMatch =
            item.descriptionAr?.toLowerCase().contains(query) ?? false;
        return nameMatch || descMatch;
      }).toList();
    }

    return filtered;
  }

  List<String> _extractCategories(List<Item> items) {
    final categories = <String>{};
    for (final item in items) {
      if (item.categoryName != null && item.categoryName!.isNotEmpty) {
        categories.add(item.categoryName!);
      }
    }
    return categories.toList();
  }

  int get _cartItemCount =>
      _cart.fold(0, (sum, si) => sum + si.quantity);

  Money get _cartTotal =>
      Money(_cart.fold(0, (sum, si) => sum + si.totalPriceCents));

  int _quantityForItem(String itemId) =>
      _cart.where((si) => si.itemId == itemId).fold(0, (sum, si) => sum + si.quantity);

  void _handleQuantityChanged(Item item, int qty) {
    setState(() {
      if (qty <= 0) {
        _cart.removeWhere((si) => si.itemId == item.id);
      } else {
        final idx = _cart.indexWhere((si) => si.itemId == item.id);
        if (idx >= 0) {
          _cart[idx] = _cart[idx].copyWith(quantity: qty);
        } else {
          _cart.add(SelectedItem(
            itemId: item.id,
            name: item.nameAr,
            image: item.images.isNotEmpty ? item.images.first : null,
            basePriceCents: item.price.cents,
            quantity: qty,
          ));
        }
      }
    });
  }

  void _showItemConfigSheet(Item item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SizedBox(
        height: MediaQuery.of(ctx).size.height * 0.85,
        child: ItemConfigurationStep(
          item: item,
          confirmLabel: 'إضافة للسلة',
          onConfirm: (selectedItem) {
            Navigator.of(ctx).pop();
            setState(() => _cart.add(selectedItem));
          },
          onBack: () => Navigator.of(ctx).pop(),
        ),
      ),
    );
  }

  void _openOrderSheet(BuildContext context) {
    final cartItems = _cart.map((si) => CartItem.fromSelectedItem(si)).toList();

    final cart = Cart(
      pageId: widget.pageId,
      pageName: widget.page?.name ?? '',
      items: cartItems,
    );

    OrderRequestSheet.show(
      context: context,
      cart: cart,
      pageName: widget.page?.name ?? '',
      paymentMethods: widget.page?.paymentMethods ?? const ['نقداً'],
      onSubmit: (data) {
        Navigator.of(context).pop();
        setState(() => _cart.clear());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              '\u062a\u0645 \u0625\u0631\u0633\u0627\u0644 \u0637\u0644\u0628\u0643 \u0628\u0646\u062c\u0627\u062d \u2014 \u0633\u064a\u062a\u0645 \u0627\u0644\u0631\u062f \u0642\u0631\u064a\u0628\u0627\u064b',
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(pageItemsProvider(widget.pageId));
    final modifiersNote = widget.page?.modifiersNote;
    final hasSpecials =
        widget.page != null && widget.page!.specials.isNotEmpty;

    return itemsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ErrorView(
        message: error.toString(),
        onRetry: () => ref.invalidate(pageItemsProvider(widget.pageId)),
      ),
      data: (items) {
        final categories = _extractCategories(items);
        final filtered = _filterItems(items);
        final visible = filtered.take(_visibleCount).toList();
        final hasMore = filtered.length > _visibleCount;

        return Stack(
          children: [
            CustomScrollView(
              slivers: [
                // Specials banner
                if (hasSpecials)
                  SliverToBoxAdapter(
                    child: _MenuSpecialsBanner(
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
                          CreditHistorySheet.show(
                            context,
                            creditLabel:
                                widget.page!.packages.first
                                    .creditLabel ??
                                    '\u0631\u0635\u064a\u062f',
                            entries: const [],
                          );
                        },
                      ),
                    ),
                  ),

                // Modifiers note banner
                if (modifiersNote != null && modifiersNote.isNotEmpty)
                  SliverToBoxAdapter(
                    child: _ModifiersBanner(note: modifiersNote),
                  ),

                // Category pills
                if (categories.isNotEmpty)
                  SliverToBoxAdapter(
                    child: CategoryFilterPills(
                      categories: categories,
                      selected: _selectedCategory,
                      onSelected: (cat) => setState(() {
                        _selectedCategory = cat;
                        _visibleCount = _pageSize;
                      }),
                    ),
                  ),

                // Search bar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.sm,
                    ),
                    child: TextField(
                      onChanged: (value) => setState(() {
                        _searchQuery = value;
                        _visibleCount = _pageSize;
                      }),
                      decoration: InputDecoration(
                        hintText: 'ابحث في القائمة...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor:
                            context.colorScheme.surfaceContainerHighest,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                          vertical: AppSpacing.md,
                        ),
                        isDense: true,
                      ),
                    ),
                  ),
                ),

                // Empty state
                if (visible.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: _MenuEmptyState(),
                  )
                else ...[
                  // Menu items list
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = visible[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.sm,
                            ),
                            child: MenuItemCard(
                              item: item,
                              quantity: _quantityForItem(item.id),
                              onQuantityChanged: (qty) =>
                                  _handleQuantityChanged(item, qty),
                              onAdd: item.optionGroups.isNotEmpty
                                  ? () => _showItemConfigSheet(item)
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
                      child: _MenuShowMoreButton(
                        visibleCount: visible.length,
                        totalCount: filtered.length,
                        onPressed: () => setState(() {
                          _visibleCount += _pageSize;
                        }),
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
                                'سيتم فتح محادثة مع المتجر قريباً',
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
                    height: _cart.isNotEmpty
                        ? AppSpacing.xxl + 80
                        : AppSpacing.xxl,
                  ),
                ),
              ],
            ),

            // Floating cart bar
            if (_cart.isNotEmpty)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: FloatingCartBar(
                  itemCount: _cartItemCount,
                  total: _cartTotal,
                  onSendOrder: () => _openOrderSheet(context),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _MenuSpecialsBanner extends StatelessWidget {
  final List<String> specials;

  const _MenuSpecialsBanner({required this.specials});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.xs,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange.shade300,
              Colors.yellow.shade600,
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.auto_awesome, color: Colors.white, size: 24),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // "عروض خاصة"
                    '\u0639\u0631\u0648\u0636 \u062e\u0627\u0635\u0629',
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    specials.first,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModifiersBanner extends StatelessWidget {
  final String note;

  const _ModifiersBanner({required this.note});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xs,
        ),
        children: note
            .split('،')
            .map((part) => part.trim())
            .where((part) => part.isNotEmpty)
            .map(
              (part) => Padding(
                padding:
                    const EdgeInsetsDirectional.only(end: AppSpacing.xs),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    part,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Colors.orange.shade800,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _MenuShowMoreButton extends StatelessWidget {
  final int visibleCount;
  final int totalCount;
  final VoidCallback onPressed;

  const _MenuShowMoreButton({
    required this.visibleCount,
    required this.totalCount,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            'عرض المزيد ($visibleCount من $totalCount)',
          ),
        ),
      ),
    );
  }
}

class _MenuEmptyState extends StatelessWidget {
  const _MenuEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off,
            size: 48,
            color: context.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'لا توجد نتائج',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
