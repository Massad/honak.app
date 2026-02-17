import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/explore/domain/entities/category.dart';
import 'package:honak/features/explore/domain/entities/page_summary.dart';
import 'package:honak/features/explore/presentation/providers/explore_providers.dart';
import 'package:honak/features/explore/presentation/providers/filter_provider.dart';
import 'package:honak/features/explore/presentation/widgets/filter_sheet.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/features/home/domain/entities/nearby_page.dart';
import 'package:honak/features/stories/presentation/providers/stories_provider.dart'
    show storyContentProvider;
import 'package:honak/features/stories/presentation/utils/story_launcher.dart';
import 'package:honak/shared/widgets/app_image.dart';
import 'package:honak/shared/widgets/error_view.dart';
import 'package:honak/shared/widgets/app_screen.dart';
import 'package:honak/shared/widgets/story_ring_avatar.dart';
import 'package:honak/shared/widgets/skeleton/skeleton.dart';

class ExplorePage extends ConsumerWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Pre-load story content so avatar taps can open viewer
    ref.watch(storyContentProvider);

    return AppScreen(
      title: Text(context.l10n.explore),
      showBack: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SearchBarTapTarget(),
            SizedBox(height: AppSpacing.md),
            _FilterTriggerBar(),
            SizedBox(height: AppSpacing.xxl),
            _CategoriesSection(),
            SizedBox(height: AppSpacing.xxl),
            _NearbySection(),
            SizedBox(height: AppSpacing.xxl),
            _TrendingPagesSection(),
            SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

// ── Search Bar — tap target that opens full-screen search ────────────────────

class _SearchBarTapTarget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.paddingH(AppSpacing.lg),
      child: GestureDetector(
        onTap: () => context.push(Routes.exploreSearch),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: context.colorScheme.onSurfaceVariant,
                size: 20,
              ),
              SizedBox(width: AppSpacing.md),
              Text(
                context.l10n.searchHint,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Filter Trigger Bar — full-width card matching Figma ─────────────────────
//
// Figma: white bg, rounded-2xl, border gray-100, shadow-sm
// Left:  SlidersHorizontal icon (blue) + "فلتر وترتيب" + active count badge
// Right: MapPin icon + current sort label ("الأقرب أولاً" / "الأكثر نشاطاً")

class _FilterTriggerBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(exploreFilterProvider);
    final activeCount = filterState.activeCount;
    final sortLabel = filterState.sortBy == ExploreSortBy.nearest
        ? context.l10n.closestFirst
        : filterState.sortBy == ExploreSortBy.popular
        ? context.l10n.mostActiveSort
        : context.l10n.closestFirst;

    return Padding(
      padding: AppSpacing.paddingH(AppSpacing.lg),
      child: GestureDetector(
        onTap: () =>
            showAppSheet(context, builder: (_) => const ExploreFilterSheet()),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: context.colorScheme.outlineVariant),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left: filter icon + label + badge
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.tune,
                    size: 14,
                    color: context.colorScheme.primary,
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Text(
                    context.l10n.filterAndSort,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  if (activeCount > 0) ...[
                    SizedBox(width: AppSpacing.xs),
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$activeCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              // Right: sort indicator
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 10,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  SizedBox(width: AppSpacing.xxs),
                  Text(
                    sortLabel,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Categories — 4-col grid with light bg, gray border, outline icons ───────
//
// Figma: bg-gray-50, text-gray-500, border-gray-100
// 56×56 rounded-2xl, icon 24px, label text-[10px] text-gray-700

class _CategoriesSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(activeCategoriesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppSpacing.paddingH(AppSpacing.lg),
          child: Text(
            context.l10n.categories,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
        ),
        SizedBox(height: AppSpacing.md),
        categoriesAsync.when(
          loading: () => const SkeletonGrid(
            count: 8,
            crossAxisCount: 4,
            childAspectRatio: 0.85,
          ),
          error: (error, _) => ErrorView(
            message: error.toString(),
            onRetry: () => ref.invalidate(activeCategoriesProvider),
          ),
          data: (categories) => _CategoriesGrid(categories: categories),
        ),
      ],
    );
  }
}

class _CategoriesGrid extends StatelessWidget {
  final List<Category> categories;

  const _CategoriesGrid({required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: AppSpacing.paddingH(AppSpacing.lg),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: AppSpacing.lg,
        crossAxisSpacing: AppSpacing.lg,
        childAspectRatio: 0.75,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) =>
          _CategoryTile(category: categories[index]),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final Category category;

  const _CategoryTile({required this.category});

  static final _iconMap = <String, IconData>{
    'restaurant': Icons.restaurant_outlined,
    'checkroom': Icons.checkroom_outlined,
    'local_grocery_store': Icons.local_grocery_store_outlined,
    'home_repair_service': Icons.home_repair_service_outlined,
    'spa': Icons.spa_outlined,
    'devices': Icons.devices_outlined,
    'local_hospital': Icons.local_hospital_outlined,
    'school': Icons.school_outlined,
    'directions_car': Icons.directions_car_outlined,
    'apartment': Icons.apartment_outlined,
    'pets': Icons.pets_outlined,
    'card_giftcard': Icons.card_giftcard_outlined,
    'fitness_center': Icons.fitness_center_outlined,
    'local_pharmacy': Icons.local_pharmacy_outlined,
    'build': Icons.build_outlined,
    'cleaning_services': Icons.cleaning_services_outlined,
    'local_cafe': Icons.local_cafe_outlined,
    'bakery_dining': Icons.bakery_dining_outlined,
    'storefront': Icons.storefront_outlined,
    'shopping_bag': Icons.shopping_bag_outlined,
    'medical_services': Icons.medical_services_outlined,
    'child_care': Icons.child_care_outlined,
    'sports_esports': Icons.sports_esports_outlined,
    'music_note': Icons.music_note_outlined,
    'camera_alt': Icons.camera_alt_outlined,
    'local_laundry_service': Icons.local_laundry_service_outlined,
    'local_florist': Icons.local_florist_outlined,
    'local_library': Icons.local_library_outlined,
    'flight': Icons.flight_outlined,
    'hotel': Icons.hotel_outlined,
    'landscape': Icons.landscape_outlined,
    'palette': Icons.palette_outlined,
    'print': Icons.print_outlined,
    'account_balance': Icons.account_balance_outlined,
    'volunteer_activism': Icons.volunteer_activism_outlined,
    'work': Icons.work_outlined,
    'handyman': Icons.handyman_outlined,
    'plumbing': Icons.plumbing_outlined,
    'electrical_services': Icons.electrical_services_outlined,
    'carpenter': Icons.carpenter_outlined,
    'delivery_dining': Icons.delivery_dining_outlined,
    'store': Icons.store_outlined,
    'business_center': Icons.business_center_outlined,
    'celebration': Icons.celebration_outlined,
    'groups': Icons.groups_outlined,
    'phonelink': Icons.phonelink_outlined,
    'shopping_cart': Icons.shopping_cart_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final icon = _iconMap[category.iconName] ?? Icons.category_outlined;

    return GestureDetector(
      onTap: () => context.push(
        Routes.exploreCategoryPath(category.id),
        extra: {'name': category.nameAr, 'types': category.types},
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Figma: bg-gray-50 border-gray-100, rounded-2xl, 56×56
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16), // rounded-2xl
              border: Border.all(color: context.colorScheme.outlineVariant),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 24,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            category.nameAr,
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 10,
              color: context.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ── Nearby — vertical list of horizontal rich cards ─────────────────────────
//
// Figma: vertical column (NOT horizontal scroll)
// Each card: bg-white p-3 rounded-xl border-gray-100 shadow-sm flex gap-3
// Layout: [72px square image] [content: name+verified | status, category·distance, metric+badges]

class _NearbySection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nearbyAsync = ref.watch(nearbyExploreProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppSpacing.paddingH(AppSpacing.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 18,
                    color: context.colorScheme.primary,
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Text(
                    context.l10n.nearYou,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  context.l10n.seeAll,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.md),
        nearbyAsync.when(
          loading: () => Padding(
            padding: AppSpacing.paddingH(AppSpacing.lg),
            child: const SkeletonCard(count: 3),
          ),
          error: (error, _) => ErrorView(
            message: error.toString(),
            onRetry: () => ref.invalidate(nearbyExploreProvider),
          ),
          data: (pages) => _NearbyCardsList(pages: pages),
        ),
      ],
    );
  }
}

class _NearbyCardsList extends StatelessWidget {
  final List<NearbyPage> pages;

  const _NearbyCardsList({required this.pages});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.paddingH(AppSpacing.lg),
      child: Column(
        children: [
          for (int i = 0; i < pages.length; i++) ...[
            _NearbyCard(page: pages[i]),
            if (i < pages.length - 1) SizedBox(height: AppSpacing.sm + 2),
          ],
        ],
      ),
    );
  }
}

class _NearbyCard extends ConsumerWidget {
  final NearbyPage page;

  const _NearbyCard({required this.page});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => context.push(Routes.pagePath(page.slug)),
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: context.colorScheme.outlineVariant,
          ), // gray-100
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Square image — 72×72 rounded, with story ring
            StoryRingAvatar(
              imageUrl: page.avatarUrl,
              name: page.name,
              size: 72,
              borderRadius: BorderRadius.circular(AppRadius.md),
              hasStories: page.hasActiveStories,
              onTap: page.hasActiveStories
                  ? () => openStoryViewer(context, ref, pageId: page.id)
                  : null,
            ),
            SizedBox(width: AppSpacing.md),
            // Content
            Expanded(
              child: SizedBox(
                height: 72,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Row 1: Name + verified | open/closed status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  page.name,
                                  style: context.textTheme.titleSmall?.copyWith(
                                    fontSize: 14,
                                    color: context.colorScheme.onSurface,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (page.isVerified) ...[
                                SizedBox(width: AppSpacing.xxs),
                                Icon(
                                  Icons.verified,
                                  size: 14,
                                  color: context.colorScheme.primary,
                                ),
                              ],
                            ],
                          ),
                        ),
                        SizedBox(width: AppSpacing.sm),
                        // Status badge: green "متاح" or red "مغلق"
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: page.isOpen
                                ? const Color(0xFFF0FDF4) // green-50
                                : const Color(0xFFFEF2F2), // red-50
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            page.isOpen
                                ? context.l10n.available
                                : context.l10n.closed,
                            style: TextStyle(
                              fontSize: 10,
                              color: page.isOpen
                                  ? const Color(0xFF16A34A) // green-600
                                  : const Color(0xFFDC2626), // red-600
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Row 2: Category · Distance
                    Row(
                      children: [
                        if (page.category != null) ...[
                          Flexible(
                            child: Text(
                              page.category!,
                              style: context.textTheme.bodySmall?.copyWith(
                                fontSize: 12,
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            ' · ',
                            style: context.textTheme.bodySmall?.copyWith(
                              fontSize: 12,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                        Text(
                          context.l10n.distanceKm(
                            page.distanceKm.toStringAsFixed(1),
                          ),
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    // Row 3: Metric badge
                    Row(
                      children: [
                        // Activity metric chip
                        if (page.weeklyOrders > 0)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: context.colorScheme.surfaceContainerLowest,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  size: 9,
                                  color: const Color(0xFF43A047), // green
                                ),
                                SizedBox(width: AppSpacing.xxs),
                                Text(
                                  context.l10n.weeklyOrdersCount(
                                    page.weeklyOrders,
                                  ),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: context.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        // Browse-only badge
                        if (page.browseOnly) ...[
                          SizedBox(width: AppSpacing.xs),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: context.colorScheme.outlineVariant,
                              borderRadius: AppRadius.pill,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.visibility_outlined,
                                  size: 9,
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  'تصفح فقط',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: context.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Trending — full-bleed overlay cards ──────────────────────────────────────
//
// Figma: 160×210 horizontal scroll, dark gradient, white text overlay
// Logo avatar top-right, category chip top-left, name+followers at bottom

class _TrendingPagesSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagesAsync = ref.watch(trendingPagesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppSpacing.paddingH(AppSpacing.lg),
          child: Row(
            children: [
              Icon(
                Icons.local_fire_department,
                size: 18,
                color: const Color(0xFFFF9800), // orange
              ),
              SizedBox(width: AppSpacing.sm),
              Text(
                context.l10n.trendingPages,
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.md),
        pagesAsync.when(
          loading: () => Padding(
            padding: AppSpacing.paddingH(AppSpacing.lg),
            child: const SkeletonCard(count: 2),
          ),
          error: (error, _) => ErrorView(
            message: error.toString(),
            onRetry: () => ref.invalidate(trendingPagesProvider),
          ),
          data: (pages) => _TrendingPagesList(pages: pages),
        ),
      ],
    );
  }
}

class _TrendingPagesList extends StatelessWidget {
  final List<PageSummary> pages;

  const _TrendingPagesList({required this.pages});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: AppSpacing.paddingH(AppSpacing.lg),
        itemCount: pages.length,
        separatorBuilder: (_, __) => SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) =>
            _TrendingOverlayCard(page: pages[index]),
      ),
    );
  }
}

class _TrendingOverlayCard extends StatelessWidget {
  final PageSummary page;

  const _TrendingOverlayCard({required this.page});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: GestureDetector(
        onTap: () => context.push(Routes.pagePath(page.slug)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: context.colorScheme.outlineVariant),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Full-bleed image
                AppImage(
                  url: page.coverUrl,
                  width: 160,
                  height: 210,
                  fit: BoxFit.cover,
                ),
                // Stronger gradient: from-black/80 via-black/20 to-transparent
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.80),
                        Colors.black.withValues(alpha: 0.20),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
                // Category chip — top start
                if (page.businessTypeName != null)
                  PositionedDirectional(
                    top: 10,
                    start: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: AppRadius.pill,
                      ),
                      child: Text(
                        page.businessTypeName!,
                        style: TextStyle(fontSize: 9, color: Colors.white),
                      ),
                    ),
                  ),
                // Bottom text overlay
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          page.name,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: AppSpacing.xxs),
                        Row(
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: 10,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                            SizedBox(width: AppSpacing.xxs),
                            Text(
                              context.l10n.followersCount(page.followersCount),
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
