import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';

/// Horizontal scroll of floor cards with tenant counts and category tags.
/// Matches Figma: floor icon, name, label, category chips, tenant count.
class DirectoryFloorsPreview extends StatelessWidget {
  final List<({String id, String name, int count})> floors;
  final List<Item> allItems;

  const DirectoryFloorsPreview({
    super.key,
    required this.floors,
    required this.allItems,
  });

  /// Get unique category tags for items on this floor.
  List<String> _floorCategories(String floorName) {
    return allItems
        .where((item) => item.categoryName == floorName)
        .map((item) => item.categoryName)
        .whereType<String>()
        .toSet()
        .take(3)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.lg,
          ),
          child: Row(
            children: [
              Icon(
                Icons.layers,
                size: 20,
                color: context.colorScheme.primary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                // "الطوابق"
                '\u0627\u0644\u0637\u0648\u0627\u0628\u0642',
                style: context.textTheme.titleSmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        // Cards
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.lg,
            ),
            itemCount: floors.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) {
              final floor = floors[index];
              return _FloorCard(
                floorName: floor.name,
                tenantCount: floor.count,
                label: _floorLabel(floor.name),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Get the floor label from page fixture data (via items description).
  String? _floorLabel(String floorName) {
    // Find the first item on this floor and check for label-like metadata
    // For now, derive from items' tags or return null
    final categories = _floorCategories(floorName);
    return categories.isNotEmpty ? categories.join(' \u00b7 ') : null;
  }
}

class _FloorCard extends StatelessWidget {
  final String floorName;
  final int tenantCount;
  final String? label;

  const _FloorCard({
    required this.floorName,
    required this.tenantCount,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 140),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest
            .withValues(alpha: 0.5),
        border: Border.all(
          color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
        borderRadius: AppRadius.cardInner,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: context.colorScheme.primary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Flexible(
                child: Text(
                  floorName,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (label != null) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(
              label!,
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const Spacer(),
          Text(
            // "{count} متجر"
            '$tenantCount \u0645\u062a\u062c\u0631',
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
