import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/features/pages/presentation/providers/page_detail_providers.dart';
import 'package:honak/features/pages/presentation/widgets/sections/service_item_card.dart';
import 'package:honak/features/pages/presentation/widgets/sections/team_member_grid.dart';
import 'package:honak/features/pages/presentation/widgets/sections/catalog_section_helpers.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/item_selection/item_picker_sheet.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';
import 'package:honak/features/pages/presentation/widgets/shared/packages_section.dart';
import 'package:honak/shared/mixins/section_filter_mixin.dart';
import 'package:honak/shared/widgets/error_view.dart';
import 'package:honak/shared/widgets/auth_gate.dart';
import 'package:honak/shared/widgets/item_selection/category_filter_pills.dart';
import 'package:honak/shared/widgets/section_search_bar.dart';
import 'package:honak/shared/widgets/skeleton/skeleton.dart';

/// Service list with categories, search, pricing, duration, and team members.
/// Used by the serviceBooking archetype (salon, doctor, tutor).
class ServiceBookingSection extends ConsumerStatefulWidget {
  final String pageId;
  final String pageName;
  final int teamMembersCount;
  final List<Package> packages;

  /// Optional slivers to prepend (e.g. queue or dropoff views).
  /// These are inserted into the same [CustomScrollView] to avoid nesting
  /// scrollable widgets.
  final List<Widget> headerSlivers;

  /// If provided, called instead of the default booking wizard when a
  /// service item is tapped. Used by queue-type pages to show the
  /// [QueueOrScheduleSheet] instead.
  final void Function(Item item)? onBookServiceOverride;

  const ServiceBookingSection({
    super.key,
    required this.pageId,
    this.pageName = '',
    this.teamMembersCount = 0,
    this.packages = const [],
    this.headerSlivers = const [],
    this.onBookServiceOverride,
  });

  @override
  ConsumerState<ServiceBookingSection> createState() =>
      _ServiceBookingSectionState();
}

class _ServiceBookingSectionState extends ConsumerState<ServiceBookingSection>
    with SectionFilterMixin {
  /// Builds the sliver list for the service booking section.
  /// Exposed so parent widgets (queue/dropoff wrappers) can embed these
  /// slivers directly into their own CustomScrollView instead of nesting.
  List<Widget> buildSlivers(
    BuildContext context, {
    required List<String> categories,
    required List<Item> visible,
    required List<Item> filtered,
    required bool hasMore,
    required List<Map<String, dynamic>> teamMembers,
  }) {
    return [
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
          child: CategoryFilterPills(
            categories: categories,
            selected: selectedCategory,
            onSelected: selectCategory,
          ),
        ),

      // Search bar
      SliverToBoxAdapter(
        child: SectionSearchBar(
          hintText: '\u0627\u0628\u062d\u062b \u0641\u064a \u0627\u0644\u062e\u062f\u0645\u0627\u062a...',
          onChanged: updateSearch,
        ),
      ),

      // Empty state
      if (visible.isEmpty)
        const SliverToBoxAdapter(
          child: SectionEmptySearch(),
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
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: ServiceItemCard(
                  item: visible[index],
                  onBook: () => AuthGate.require(
                    context,
                    ref,
                    trigger: LoginPromptTrigger.book,
                    onAuthed: () {
                      if (widget.onBookServiceOverride != null) {
                        widget.onBookServiceOverride!(visible[index]);
                      } else {
                        _openBookingWizard(
                          context,
                          visible[index],
                          teamMembers,
                        );
                      }
                    },
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
            child: SectionShowMoreButton(
              visibleCount: visible.length,
              totalCount: filtered.length,
              onPressed: showMore,
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
    ];
  }

  void _openBookingWizard(
    BuildContext context,
    Item item,
    List<Map<String, dynamic>> teamMembers,
  ) {
    final durationMinutes = item.sortOrder > 0 ? item.sortOrder : 30;
    showAppSheet(
      context,
      builder: (_) => ItemPickerSheet(
        pageSlug: '',
        wizardMode: PickerWizardMode.book,
        preSelectedItem: item,
        teamMembers: teamMembers,
        pageName: widget.pageName,
        durationMinutes: durationMinutes,
        title: 'حجز موعد',
        onBookingConfirmed: (_) {},
      ),
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
        final categories = extractCategories(items);
        final filtered = baseFilterItems(items);
        final visible = filtered.take(visibleCount).toList();
        final hasMore = filtered.length > visibleCount;

        return CustomScrollView(
          slivers: [
            ...widget.headerSlivers,
            ...buildSlivers(
              context,
              categories: categories,
              visible: visible,
              filtered: filtered,
              hasMore: hasMore,
              teamMembers: teamMembers,
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
