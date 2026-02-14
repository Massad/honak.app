import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/features/pages/presentation/providers/page_detail_providers.dart';
import 'package:honak/features/pages/presentation/widgets/sections/directory_announcements.dart';
import 'package:honak/shared/widgets/skeleton/skeleton.dart';
import 'package:honak/features/pages/presentation/widgets/sections/directory_featured_tenants.dart';
import 'package:honak/features/pages/presentation/widgets/sections/directory_floors_preview.dart';
import 'package:honak/features/pages/presentation/widgets/sections/directory_stats_grid.dart';
import 'package:honak/features/pages/presentation/widgets/sections/directory_amenities_grid.dart';
import 'package:honak/shared/widgets/error_view.dart';

/// Overview tab for directory archetype (mall, plaza, complex).
/// Shows stats, announcements, featured tenants, floors preview, amenities.
class DirectorySection extends ConsumerWidget {
  final String pageId;
  final PageDetail? page;

  const DirectorySection({super.key, required this.pageId, this.page});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(pageItemsProvider(pageId));

    return itemsAsync.when(
      loading: () => const SkeletonListTile(count: 6),
      error: (error, _) => ErrorView(
        message: error.toString(),
        onRetry: () => ref.invalidate(pageItemsProvider(pageId)),
      ),
      data: (items) => _DirectoryOverview(
        page: page,
        items: items,
      ),
    );
  }
}

class _DirectoryOverview extends StatelessWidget {
  final PageDetail? page;
  final List<Item> items;

  const _DirectoryOverview({required this.page, required this.items});

  /// Derive unique floors from items' categoryName + categoryId, preserving order.
  List<({String id, String name, int count})> _deriveFloors() {
    final seen = <String>{};
    final floors = <({String id, String name, int count})>[];
    for (final item in items) {
      final name = item.categoryName;
      final id = item.categoryId;
      if (name != null && name.isNotEmpty && seen.add(name)) {
        final count = items.where((i) => i.categoryName == name).length;
        floors.add((id: id ?? name, name: name, count: count));
      }
    }
    return floors;
  }

  @override
  Widget build(BuildContext context) {
    final floors = _deriveFloors();

    return CustomScrollView(
      slivers: [
        // 1. Quick stats grid
        if (page?.directoryStats != null)
          SliverToBoxAdapter(
            child: DirectoryStatsGrid(stats: page!.directoryStats!),
          ),

        // 2. Mall announcements
        if (page != null && page!.mallAnnouncements.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: DirectoryAnnouncements(
                announcements: page!.mallAnnouncements,
              ),
            ),
          ),

        // 3. Featured tenants
        if (page != null && page!.featuredTenantIds.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: DirectoryFeaturedTenants(
                featuredIds: page!.featuredTenantIds,
                allItems: items,
              ),
            ),
          ),

        // 4. Floors preview — derived from actual items data
        if (floors.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: DirectoryFloorsPreview(
                floors: floors,
                allItems: items,
              ),
            ),
          ),

        // 5. Amenities grid
        if (page != null && page!.amenities.isNotEmpty)
          SliverToBoxAdapter(
            child: DirectoryAmenitiesGrid(amenities: page!.amenities),
          ),

        // 6. Parking info
        if (page?.parkingInfo != null && page!.parkingInfo!.isNotEmpty)
          SliverToBoxAdapter(
            child: _ParkingBanner(info: page!.parkingInfo!),
          ),

        const SliverToBoxAdapter(
          child: SizedBox(height: AppSpacing.xxl),
        ),
      ],
    );
  }
}

/// Blue parking info banner at bottom of overview.
class _ParkingBanner extends StatelessWidget {
  final String info;

  const _ParkingBanner({required this.info});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: context.colorScheme.primaryContainer.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              Icons.local_parking,
              size: 18,
              color: context.colorScheme.primary,
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                info,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
