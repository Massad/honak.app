import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/features/catalog/presentation/providers/item_detail_provider.dart';
import 'package:honak/features/requests/domain/entities/cart.dart';
import 'package:honak/features/requests/presentation/providers/cart_provider.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/entities/selected_item.dart';
import 'package:honak/shared/widgets/app_direction.dart';
import 'package:honak/shared/widgets/app_image.dart';
import 'package:honak/shared/widgets/error_view.dart';
import 'package:honak/shared/widgets/item_selection/item_option_selector.dart';
import 'package:honak/shared/widgets/money_text.dart';
import 'package:honak/shared/widgets/skeleton/skeleton.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

class ItemDetailPage extends ConsumerStatefulWidget {
  final String itemId;

  const ItemDetailPage({super.key, required this.itemId});

  @override
  ConsumerState<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends ConsumerState<ItemDetailPage> {
  final Map<String, Set<String>> _selectedOptions = {};
  final Map<String, String> _textInputs = {};

  int _calculateModifier() {
    int modifier = 0;
    final itemAsync = ref.read(itemDetailProvider(widget.itemId));
    final item = itemAsync.valueOrNull;
    if (item == null) return 0;

    for (final group in item.optionGroups) {
      final selected = _selectedOptions[group.id];
      if (selected == null) continue;
      for (final option in group.options) {
        if (selected.contains(option.id)) {
          modifier += option.priceModifier;
        }
      }
    }
    return modifier;
  }

  void _addToCart(Item item) {
    // Build SelectedItem from current selection state
    final selectedOpts = <String, List<SelectedOption>>{};
    for (final group in item.optionGroups) {
      final ids = _selectedOptions[group.id];
      if (ids == null || ids.isEmpty) continue;
      selectedOpts[group.id] = group.options
          .where((o) => ids.contains(o.id))
          .map((o) => SelectedOption.fromItemOption(o))
          .toList();
    }

    final si = SelectedItem(
      itemId: item.id,
      name: item.nameAr,
      image: item.images.isNotEmpty ? item.images.first : null,
      basePriceCents: item.price.cents,
      selectedOptions: selectedOpts,
      textInputs: Map.from(_textInputs),
    );

    final cartItem = CartItem.fromSelectedItem(si);
    final pageId = item.pageId ?? '';

    ref
        .read(cartProvider.notifier)
        .addItem(
          pageId,
          '', // pageName resolved when order sheet opens from section
          null,
          cartItem,
        );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('تمت الإضافة للسلة')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final itemAsync = ref.watch(itemDetailProvider(widget.itemId));

    return Scaffold(
      body: itemAsync.when(
        loading: () => const _ItemDetailSkeleton(),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(itemDetailProvider(widget.itemId)),
        ),
        data: (item) => _ItemDetailContent(
          item: item,
          selectedOptions: _selectedOptions,
          textInputs: _textInputs,
          onOptionSelected: (groupId, optionId, type) {
            setState(() {
              if (type == 'single_select') {
                _selectedOptions[groupId] = {optionId};
              } else {
                final current = _selectedOptions[groupId] ?? {};
                if (current.contains(optionId)) {
                  current.remove(optionId);
                } else {
                  current.add(optionId);
                }
                _selectedOptions[groupId] = current;
              }
            });
          },
          onTextInput: (groupId, value) {
            _textInputs[groupId] = value;
          },
          totalPrice: Money(item.price.cents + _calculateModifier()),
          onAddToCart: () => _addToCart(item),
        ),
      ),
    );
  }
}

class _ItemDetailContent extends StatelessWidget {
  final Item item;
  final Map<String, Set<String>> selectedOptions;
  final Map<String, String> textInputs;
  final void Function(String groupId, String optionId, String type)
  onOptionSelected;
  final void Function(String groupId, String value) onTextInput;
  final Money totalPrice;
  final VoidCallback onAddToCart;

  const _ItemDetailContent({
    required this.item,
    required this.selectedOptions,
    required this.textInputs,
    required this.onOptionSelected,
    required this.onTextInput,
    required this.totalPrice,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    icon: Icon(AppDirection.backIcon(context), size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: _ImageCarousel(images: item.images),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppSpacing.screenPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.nameAr,
                              style: context.textTheme.headlineSmall,
                            ),
                          ),
                          if (!item.inStock)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.xxs,
                              ),
                              decoration: BoxDecoration(
                                color: context.colorScheme.errorContainer,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                context.l10n.outOfStock,
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: context.colorScheme.error,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.sm),
                      MoneyText(
                        money: item.price,
                        style: context.textTheme.titleLarge?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (item.categoryName != null) ...[
                        SizedBox(height: AppSpacing.md),
                        Chip(
                          label: Text(item.categoryName!),
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                      if (item.descriptionAr != null &&
                          item.descriptionAr!.isNotEmpty) ...[
                        SizedBox(height: AppSpacing.lg),
                        Text(
                          item.descriptionAr!,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                      if (item.optionGroups.isNotEmpty) ...[
                        SizedBox(height: AppSpacing.xxl),
                        ItemOptionSelector(
                          optionGroups: item.optionGroups,
                          selectedOptions: selectedOptions,
                          textInputs: textInputs,
                          onOptionSelected: onOptionSelected,
                          onTextInput: onTextInput,
                        ),
                      ],
                      SizedBox(height: AppSpacing.huge),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        _BottomBar(
          totalPrice: totalPrice,
          inStock: item.inStock,
          onAddToCart: onAddToCart,
        ),
      ],
    );
  }
}

class _ImageCarousel extends StatefulWidget {
  final List<String> images;

  const _ImageCarousel({required this.images});

  @override
  State<_ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<_ImageCarousel> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Container(
        color: context.colorScheme.surfaceContainerHighest,
        child: Icon(
          Icons.fastfood_outlined,
          size: 64,
          color: context.colorScheme.outline,
        ),
      );
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          itemCount: widget.images.length,
          onPageChanged: (index) => setState(() => _currentPage = index),
          itemBuilder: (context, index) => AppImage(
            url: widget.images[index],
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        if (widget.images.length > 1)
          Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.white
                        : Colors.white54,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  final Money totalPrice;
  final bool inStock;
  final VoidCallback onAddToCart;

  const _BottomBar({
    required this.totalPrice,
    required this.inStock,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.lg + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          top: BorderSide(color: context.colorScheme.outlineVariant),
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.l10n.totalPrice,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              MoneyText(
                money: totalPrice,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(width: AppSpacing.lg),
          Expanded(
            child: btn.Button(
              onPressed: inStock ? onAddToCart : null,
              label: context.l10n.addToCart,
              size: btn.ButtonSize.large,
              expand: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemDetailSkeleton extends StatelessWidget {
  const _ItemDetailSkeleton();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SkeletonBox(height: 300, borderRadius: 0),
            Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonText(width: 200, height: 24),
                        SizedBox(height: AppSpacing.md),
                        SkeletonText(width: 80, height: 20),
                        SizedBox(height: AppSpacing.lg),
                        const SkeletonText(lines: 3),
                      ],
                    ),
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
