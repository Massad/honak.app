import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/features/pages/presentation/providers/page_detail_providers.dart';
import 'package:honak/features/requests/presentation/widgets/inquiry_request_sheet.dart';
import 'package:honak/shared/widgets/app_image.dart';
import 'package:honak/shared/widgets/error_view.dart';
import 'package:honak/shared/widgets/auth_gate.dart';
import 'package:honak/shared/extensions/sort_extensions.dart';
import 'package:honak/shared/widgets/skeleton/skeleton.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Gallery grid with category pills, inquiry CTA, and custom work CTA.
/// Used by the portfolioInquiry archetype (photographer, designer).
class PortfolioSection extends ConsumerStatefulWidget {
  final String pageId;
  final String pageName;

  const PortfolioSection({
    super.key,
    required this.pageId,
    this.pageName = '',
  });

  @override
  ConsumerState<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends ConsumerState<PortfolioSection> {
  static const _pageSize = 12;

  String? _selectedCategory;
  int _visibleCount = _pageSize;

  List<Item> _filterItems(List<Item> items) {
    var filtered = items;
    if (_selectedCategory != null) {
      filtered = filtered
          .where((item) => item.categoryName == _selectedCategory)
          .toList();
    }
    return filtered.sortedByOrder((i) => i.sortOrder);
  }

  List<String> _extractCategories(List<Item> items) {
    final sorted = items.sortedByOrder((i) => i.sortOrder);
    final categories = <String>[];
    final seen = <String>{};
    for (final item in sorted) {
      if (item.categoryName != null &&
          item.categoryName!.isNotEmpty &&
          seen.add(item.categoryName!)) {
        categories.add(item.categoryName!);
      }
    }
    return categories;
  }

  void _openInquirySheet(BuildContext context) {
    InquiryRequestSheet.show(
      context: context,
      pageName: widget.pageName,
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

  void _openImageViewer(BuildContext context, Item item) {
    if (item.images.isEmpty) return;
    showDialog(
      context: context,
      builder: (context) => _PortfolioImageViewer(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(pageItemsProvider(widget.pageId));

    return itemsAsync.when(
      loading: () => const SkeletonProductCard(count: 9, grid: true),
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
                // Category pills
                if (categories.isNotEmpty)
                  SliverToBoxAdapter(
                    child: _PortfolioCategoryPills(
                      categories: categories,
                      selected: _selectedCategory,
                      onSelected: (cat) => setState(() {
                        _selectedCategory = cat;
                        _visibleCount = _pageSize;
                      }),
                    ),
                  ),

                // Empty state
                if (visible.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.photo_library_outlined,
                            size: 48,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'لا توجد أعمال بعد',
                            style:
                                context.textTheme.bodyLarge?.copyWith(
                              color:
                                  context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else ...[
                  // Gallery grid (3 columns)
                  SliverPadding(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: AppSpacing.xxs,
                        crossAxisSpacing: AppSpacing.xxs,
                        childAspectRatio: 1,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _PortfolioThumbnail(
                          item: visible[index],
                          onTap: () =>
                              _openImageViewer(context, visible[index]),
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
                          child: btn.Button(
                            onPressed: () => setState(() {
                              _visibleCount += _pageSize;
                            }),
                            label: 'عرض المزيد (${visible.length} من ${filtered.length})',
                            variant: btn.Variant.text,
                          ),
                        ),
                      ),
                    ),
                ],

                // Custom work CTA section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          children: [
                            Text(
                              'تحتاج عمل مخصص؟',
                              style:
                                  context.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              'أرسل استفسارك وسنتواصل معك',
                              style:
                                  context.textTheme.bodySmall?.copyWith(
                                color:
                                    context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            btn.Button(
                              onPressed: () => AuthGate.require(
                                context,
                                ref,
                                trigger: LoginPromptTrigger.general,
                                onAuthed: () => _openInquirySheet(context),
                              ),
                              label: 'إرسال استفسار',
                              expand: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom padding for FAB
                const SliverToBoxAdapter(
                  child: SizedBox(height: 80),
                ),
              ],
            ),

            // Inquiry FAB
            Positioned(
              bottom: AppSpacing.lg,
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              child: btn.Button(
                onPressed: () => AuthGate.require(
                  context,
                  ref,
                  trigger: LoginPromptTrigger.general,
                  onAuthed: () => _openInquirySheet(context),
                ),
                label: 'استفسر الآن',
                icon: const btn.ButtonIcon(Icons.chat_outlined),
                expand: true,
                size: btn.ButtonSize.large,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PortfolioCategoryPills extends StatelessWidget {
  final List<String> categories;
  final String? selected;
  final ValueChanged<String?> onSelected;

  const _PortfolioCategoryPills({
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

class _PortfolioThumbnail extends StatelessWidget {
  final Item item;
  final VoidCallback onTap;

  const _PortfolioThumbnail({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppImage(
        url: item.images.isNotEmpty ? item.images.first : null,
        fit: BoxFit.cover,
        placeholderIcon: Icons.photo_outlined,
      ),
    );
  }
}

class _PortfolioImageViewer extends StatelessWidget {
  final Item item;

  const _PortfolioImageViewer({required this.item});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(AppSpacing.lg),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Close button
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
            ),
          ),
          // Image
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: AppImage(
              url:
                  item.images.isNotEmpty ? item.images.first : null,
              fit: BoxFit.contain,
            ),
          ),
          // Caption
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.nameAr,
                  style: context.textTheme.titleSmall,
                ),
                if (item.descriptionAr != null &&
                    item.descriptionAr!.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    item.descriptionAr!,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
