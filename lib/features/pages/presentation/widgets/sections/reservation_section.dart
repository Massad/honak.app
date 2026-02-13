import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/features/pages/presentation/providers/page_detail_providers.dart';
import 'package:honak/features/pages/presentation/widgets/sections/villa_detail_card.dart';
import 'package:honak/features/requests/presentation/widgets/reservation_request_sheet.dart';
import 'package:honak/shared/widgets/cached_image.dart';
import 'package:honak/shared/widgets/error_view.dart';
import 'package:honak/shared/widgets/money_text.dart';

/// Space cards with category filtering, pagination, and villa support.
/// Used by the reservation archetype (hotel, event venue, villa/chalet).
class ReservationSection extends ConsumerStatefulWidget {
  final String pageId;
  final PageDetail? page;

  const ReservationSection({
    super.key,
    required this.pageId,
    this.page,
  });

  @override
  ConsumerState<ReservationSection> createState() =>
      _ReservationSectionState();
}

class _ReservationSectionState extends ConsumerState<ReservationSection> {
  static const _pageSize = 12;

  String? _selectedCategory;
  int _visibleCount = _pageSize;

  bool get _isVilla =>
      widget.page?.pricing != null || widget.page?.bedrooms != null;

  List<Item> _filterItems(List<Item> items) {
    if (_selectedCategory == null) return items;
    return items
        .where((item) => item.categoryName == _selectedCategory)
        .toList();
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

  void _openReservationSheet(BuildContext context, List<Item> items) {
    final spaces = items
        .map((item) => {
              'id': item.id,
              'name': item.nameAr,
              'price_cents': item.price.cents,
              'in_stock': item.inStock,
            })
        .toList();

    ReservationRequestSheet.show(
      context: context,
      pageName: widget.page?.name ?? '',
      spaces: spaces,
      isVillaType: _isVilla,
      maxGuests: widget.page?.maxGuests,
      paymentMethods: widget.page?.paymentMethods ?? const [],
      onSubmit: (data) {
        Navigator.of(context).pop();
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

        return CustomScrollView(
          slivers: [
            // Villa detail card (for villa/chalet pages)
            if (_isVilla && widget.page != null)
              SliverToBoxAdapter(
                child: VillaDetailCard(page: widget.page!),
              ),

            // Gallery strip for event venues with gallery images
            if (!_isVilla &&
                widget.page != null &&
                widget.page!.galleryImages.isNotEmpty)
              SliverToBoxAdapter(
                child: _GalleryStrip(
                  images: widget.page!.galleryImages,
                ),
              ),

            // Category pills
            if (categories.isNotEmpty)
              SliverToBoxAdapter(
                child: _ReservationCategoryPills(
                  categories: categories,
                  selected: _selectedCategory,
                  onSelected: (cat) => setState(() {
                    _selectedCategory = cat;
                    _visibleCount = _pageSize;
                  }),
                ),
              ),

            // Empty state
            if (visible.isEmpty && !_isVilla)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.hotel_outlined,
                        size: 48,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'لا توجد مساحات متاحة',
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else if (visible.isNotEmpty) ...[
              // Space cards list
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppSpacing.md,
                      ),
                      child: _SpaceCard(
                        item: visible[index],
                        onBook: () =>
                            _openReservationSheet(context, items),
                      ),
                    ),
                    childCount: visible.length,
                  ),
                ),
              ),

              // Show more
              if (hasMore)
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                      ),
                      child: TextButton(
                        onPressed: () => setState(() {
                          _visibleCount += _pageSize;
                        }),
                        child: Text(
                          'عرض المزيد (${visible.length} من ${filtered.length})',
                        ),
                      ),
                    ),
                  ),
                ),
            ],

            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xxl),
            ),
          ],
        );
      },
    );
  }
}

class _GalleryStrip extends StatelessWidget {
  final List<String> images;

  const _GalleryStrip({required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        itemCount: images.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) => ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 280,
            child: CachedImage(
              imageUrl: images[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class _ReservationCategoryPills extends StatelessWidget {
  final List<String> categories;
  final String? selected;
  final ValueChanged<String?> onSelected;

  const _ReservationCategoryPills({
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        itemCount: categories.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          if (index == 0) {
            return FilterChip(
              label: const Text('الكل'),
              selected: selected == null,
              onSelected: (_) => onSelected(null),
              showCheckmark: false,
              visualDensity: VisualDensity.compact,
            );
          }
          final category = categories[index - 1];
          return FilterChip(
            label: Text(category),
            selected: selected == category,
            onSelected: (_) =>
                onSelected(selected == category ? null : category),
            showCheckmark: false,
            visualDensity: VisualDensity.compact,
          );
        },
      ),
    );
  }
}

class _SpaceCard extends StatelessWidget {
  final Item item;
  final VoidCallback? onBook;

  const _SpaceCard({required this.item, this.onBook});

  @override
  Widget build(BuildContext context) {
    // Derive capacity from option groups count or use a placeholder
    final capacity = item.optionGroups.isNotEmpty
        ? item.optionGroups.length * 10
        : null;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(Routes.productPath(item.id)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image (16:9)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedImage(
                    imageUrl: item.images.isNotEmpty
                        ? item.images.first
                        : null,
                    fit: BoxFit.cover,
                    placeholderIcon: Icons.meeting_room_outlined,
                  ),
                  if (!item.inStock)
                    Container(
                      color: Colors.black.withValues(alpha: 0.54),
                      alignment: Alignment.center,
                      child: Text(
                        'محجوز',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Details
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.nameAr,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.descriptionAr != null &&
                      item.descriptionAr!.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      item.descriptionAr!,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      MoneyText(
                        money: item.price,
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      Text(
                        ' / ليلة',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      if (capacity != null) ...[
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xxs,
                          ),
                          decoration: BoxDecoration(
                            color: context
                                .colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.people_outline,
                                size: 14,
                                color: context.colorScheme
                                    .onSecondaryContainer,
                              ),
                              const SizedBox(width: AppSpacing.xxs),
                              Text(
                                '$capacity شخص',
                                style: context.textTheme.labelSmall
                                    ?.copyWith(
                                  color: context.colorScheme
                                      .onSecondaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (item.inStock && onBook != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: onBook,
                        child: const Text('\u0637\u0644\u0628 \u062d\u062c\u0632'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
