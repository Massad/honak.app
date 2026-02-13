import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/features/pages/presentation/providers/page_detail_providers.dart';
import 'package:honak/features/pages/presentation/widgets/sections/directory_announcements.dart';
import 'package:honak/features/pages/presentation/widgets/sections/directory_featured_tenants.dart';
import 'package:honak/features/pages/presentation/widgets/sections/directory_floors_preview.dart';
import 'package:honak/features/pages/presentation/widgets/sections/directory_stats_grid.dart';
import 'package:honak/features/pages/presentation/widgets/sections/directory_tenant_card.dart';
import 'package:honak/shared/widgets/error_view.dart';

/// Tenant listing with search, floor filtering, and pagination.
/// Used by the directory archetype (mall, plaza, complex).
class DirectorySection extends ConsumerStatefulWidget {
  final String pageId;
  final PageDetail? page;

  const DirectorySection({super.key, required this.pageId, this.page});

  @override
  ConsumerState<DirectorySection> createState() => _DirectorySectionState();
}

class _DirectorySectionState extends ConsumerState<DirectorySection> {
  static const _pageSize = 12;

  // "\u0627\u0644\u0643\u0644" = الكل
  static const _allLabel = '\u0627\u0644\u0643\u0644';
  static const _floors = [
    _allLabel,
    // "\u0627\u0644\u0637\u0627\u0628\u0642 \u0627\u0644\u0623\u0648\u0644" = الطابق الأول
    '\u0627\u0644\u0637\u0627\u0628\u0642 \u0627\u0644\u0623\u0648\u0644',
    // "\u0627\u0644\u0637\u0627\u0628\u0642 \u0627\u0644\u062b\u0627\u0646\u064a" = الطابق الثاني
    '\u0627\u0644\u0637\u0627\u0628\u0642 \u0627\u0644\u062b\u0627\u0646\u064a',
    // "\u0627\u0644\u0637\u0627\u0628\u0642 \u0627\u0644\u062b\u0627\u0644\u062b" = الطابق الثالث
    '\u0627\u0644\u0637\u0627\u0628\u0642 \u0627\u0644\u062b\u0627\u0644\u062b',
  ];

  String _selectedFloor = _allLabel;
  String _searchQuery = '';
  int _visibleCount = _pageSize;

  List<Item> _filterItems(List<Item> items) {
    var filtered = items;

    if (_selectedFloor != _allLabel) {
      filtered = filtered
          .where((item) => item.categoryName == _selectedFloor)
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

  void _selectFloor(String floor) {
    setState(() {
      _selectedFloor = floor;
      _visibleCount = _pageSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(pageItemsProvider(widget.pageId));
    final page = widget.page;

    return itemsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ErrorView(
        message: error.toString(),
        onRetry: () => ref.invalidate(pageItemsProvider(widget.pageId)),
      ),
      data: (items) {
        final filtered = _filterItems(items);
        final visible = filtered.take(_visibleCount).toList();
        final hasMore = filtered.length > _visibleCount;

        return CustomScrollView(
          slivers: [
            // ── Enhanced sections (above search) ──

            // 1. Quick stats grid
            if (page?.directoryStats != null)
              SliverToBoxAdapter(
                child: DirectoryStatsGrid(stats: page!.directoryStats!),
              ),

            // 2. Mall announcements
            if (page != null && page.mallAnnouncements.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: DirectoryAnnouncements(
                    announcements: page.mallAnnouncements,
                  ),
                ),
              ),

            // 3. Featured tenants
            if (page != null && page.featuredTenantIds.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: DirectoryFeaturedTenants(
                    featuredIds: page.featuredTenantIds,
                    allItems: items,
                  ),
                ),
              ),

            // 4. Floors preview
            if (page?.directoryStats != null &&
                page!.directoryStats!.floors > 0)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: DirectoryFloorsPreview(
                    floorCount: page.directoryStats!.floors,
                    allItems: items,
                    onFloorSelected: _selectFloor,
                  ),
                ),
              ),

            // Divider between enhanced sections and search/list
            if (page != null &&
                (page.directoryStats != null ||
                    page.mallAnnouncements.isNotEmpty ||
                    page.featuredTenantIds.isNotEmpty))
              const SliverToBoxAdapter(
                child: Divider(height: 1),
              ),

            // ── Existing content ──

            // Search bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                child: TextField(
                  onChanged: (value) => setState(() {
                    _searchQuery = value;
                    _visibleCount = _pageSize;
                  }),
                  decoration: InputDecoration(
                    // "\u0627\u0628\u062d\u062b \u0641\u064a \u0627\u0644\u062f\u0644\u064a\u0644..." = ابحث في الدليل...
                    hintText:
                        '\u0627\u0628\u062d\u062b \u0641\u064a \u0627\u0644\u062f\u0644\u064a\u0644...',
                    prefixIcon: const Icon(Icons.search),
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
              ),
            ),

            // Floor filter chips
            SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                  itemCount: _floors.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final floor = _floors[index];
                    return FilterChip(
                      label: Text(floor),
                      selected: _selectedFloor == floor,
                      onSelected: (_) => _selectFloor(floor),
                      showCheckmark: false,
                      visualDensity: VisualDensity.compact,
                    );
                  },
                ),
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
                        Icons.search_off,
                        size: 48,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        // "\u0644\u0627 \u062a\u0648\u062c\u062f \u0646\u062a\u0627\u0626\u062c" = لا توجد نتائج
                        '\u0644\u0627 \u062a\u0648\u062c\u062f \u0646\u062a\u0627\u0626\u062c',
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else ...[
              // Tenant cards
              SliverPadding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: const EdgeInsetsDirectional.only(
                        bottom: AppSpacing.sm,
                      ),
                      child: DirectoryTenantCard(item: visible[index]),
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
                          // "\u0639\u0631\u0636 \u0627\u0644\u0645\u0632\u064a\u062f" = عرض المزيد
                          '\u0639\u0631\u0636 \u0627\u0644\u0645\u0632\u064a\u062f (${visible.length} / ${filtered.length})',
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

