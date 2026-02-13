import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/features/pages/presentation/providers/page_detail_providers.dart';
import 'package:honak/features/pages/presentation/widgets/sections/service_item_card.dart';
import 'package:honak/features/pages/presentation/widgets/sections/team_member_grid.dart';
import 'package:honak/features/pages/presentation/widgets/sections/booking_wizard_sheet.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';
import 'package:honak/features/pages/presentation/widgets/shared/packages_section.dart';
import 'package:honak/shared/widgets/error_view.dart';
import 'package:honak/shared/widgets/skeleton/skeleton.dart';

/// Service list with categories, search, pricing, duration, and team members.
/// Used by the serviceBooking archetype (salon, doctor, tutor).
class ServiceBookingSection extends ConsumerStatefulWidget {
  final String pageId;
  final String pageName;
  final int teamMembersCount;
  final List<Package> packages;

  const ServiceBookingSection({
    super.key,
    required this.pageId,
    this.pageName = '',
    this.teamMembersCount = 0,
    this.packages = const [],
  });

  @override
  ConsumerState<ServiceBookingSection> createState() =>
      _ServiceBookingSectionState();
}

class _ServiceBookingSectionState extends ConsumerState<ServiceBookingSection> {
  static const _pageSize = 12;

  String? _selectedCategory;
  String _searchQuery = '';
  int _visibleCount = _pageSize;

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

  void _openBookingWizard(
    BuildContext context,
    Item item,
    List<Map<String, dynamic>> teamMembers,
  ) {
    final durationMinutes = item.sortOrder > 0 ? item.sortOrder : 30;

    BookingWizardSheet.show(
      context: context,
      pageName: widget.pageName,
      serviceId: item.id,
      serviceName: item.nameAr,
      priceCents: item.price.cents,
      durationMinutes: durationMinutes,
      teamMembers: teamMembers,
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(pageItemsProvider(widget.pageId));
    // Pre-fetch team members for use in the booking wizard.
    final teamMembers = widget.teamMembersCount > 0
        ? ref.watch(pageTeamMembersProvider(widget.pageId)).valueOrNull ?? []
        : <Map<String, dynamic>>[];

    return itemsAsync.when(
      loading: () => const SkeletonProductCard(count: 4, grid: false),
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
            // Packages section
            if (widget.packages.isNotEmpty)
              SliverToBoxAdapter(
                child: PackagesSection(
                  packages: widget.packages,
                  archetype: 'service_booking',
                  pageName: widget.pageName,
                  existingCredits: widget.packages.isNotEmpty ? 2 : null,
                  existingCreditLabel: widget.packages.isNotEmpty
                      ? widget.packages.first.creditLabel
                      : null,
                ),
              ),

            // Category pills
            if (categories.isNotEmpty)
              SliverToBoxAdapter(
                child: _ServiceCategoryPills(
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
                    hintText: '\u0627\u0628\u062d\u062b \u0641\u064a \u0627\u0644\u062e\u062f\u0645\u0627\u062a...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: context.colorScheme.surfaceContainerHighest,
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
                child: _ServiceEmptyState(),
              )
            else ...[
              // Service list
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding:
                          const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: ServiceItemCard(
                        item: visible[index],
                        onBook: () => _openBookingWizard(
                          context,
                          visible[index],
                          teamMembers,
                        ),
                      ),
                    ),
                    childCount: visible.length,
                  ),
                ),
              ),

              // Show more
              if (hasMore)
                SliverToBoxAdapter(
                  child: _ServiceShowMoreButton(
                    visibleCount: visible.length,
                    totalCount: filtered.length,
                    onPressed: () => setState(() {
                      _visibleCount += _pageSize;
                    }),
                  ),
                ),
            ],

            // Team members grid
            if (widget.teamMembersCount > 0)
              SliverToBoxAdapter(
                child: _TeamMembersSection(pageId: widget.pageId),
              ),

            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xxl),
            ),
          ],
        );
      },
    );
  }
}

class _TeamMembersSection extends ConsumerWidget {
  final String pageId;

  const _TeamMembersSection({required this.pageId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamAsync = ref.watch(pageTeamMembersProvider(pageId));

    return teamAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: SkeletonListTile(count: 3),
      ),
      error: (_, __) => const SizedBox.shrink(),
      data: (members) {
        if (members.isEmpty) return const SizedBox.shrink();
        return TeamMemberGrid(members: members);
      },
    );
  }
}

class _ServiceCategoryPills extends StatelessWidget {
  final List<String> categories;
  final String? selected;
  final ValueChanged<String?> onSelected;

  const _ServiceCategoryPills({
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

class _ServiceShowMoreButton extends StatelessWidget {
  final int visibleCount;
  final int totalCount;
  final VoidCallback onPressed;

  const _ServiceShowMoreButton({
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

class _ServiceEmptyState extends StatelessWidget {
  const _ServiceEmptyState();

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
