import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';

/// Horizontal scroll of floor cards with tenant counts.
class DirectoryFloorsPreview extends StatelessWidget {
  final int floorCount;
  final List<Item> allItems;
  final ValueChanged<String> onFloorSelected;

  /// Static floor names matching the directory filter chips.
  static const _floorNames = [
    // "\u0627\u0644\u0637\u0627\u0628\u0642 \u0627\u0644\u0623\u0631\u0636\u064a" = الطابق الأرضي
    '\u0627\u0644\u0637\u0627\u0628\u0642 \u0627\u0644\u0623\u0631\u0636\u064a',
    // "\u0627\u0644\u0637\u0627\u0628\u0642 \u0627\u0644\u0623\u0648\u0644" = الطابق الأول
    '\u0627\u0644\u0637\u0627\u0628\u0642 \u0627\u0644\u0623\u0648\u0644',
    // "\u0627\u0644\u0637\u0627\u0628\u0642 \u0627\u0644\u062b\u0627\u0646\u064a" = الطابق الثاني
    '\u0627\u0644\u0637\u0627\u0628\u0642 \u0627\u0644\u062b\u0627\u0646\u064a',
    // "\u0627\u0644\u0637\u0627\u0628\u0642 \u0627\u0644\u062b\u0627\u0644\u062b" = الطابق الثالث
    '\u0627\u0644\u0637\u0627\u0628\u0642 \u0627\u0644\u062b\u0627\u0644\u062b',
  ];

  const DirectoryFloorsPreview({
    super.key,
    required this.floorCount,
    required this.allItems,
    required this.onFloorSelected,
  });

  @override
  Widget build(BuildContext context) {
    final floors = _floorNames.take(floorCount).toList();

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
                // "\u0627\u0644\u0637\u0648\u0627\u0628\u0642" = الطوابق
                '\u0627\u0644\u0637\u0648\u0627\u0628\u0642',
                style: context.textTheme.titleSmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        // Cards
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.lg,
            ),
            itemCount: floors.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) {
              final floorName = floors[index];
              final tenantCount = allItems
                  .where((item) => item.categoryName == floorName)
                  .length;
              final categories = allItems
                  .where((item) => item.categoryName == floorName)
                  .map((item) => item.descriptionAr)
                  .whereType<String>()
                  .toSet()
                  .take(3)
                  .toList();

              return _FloorCard(
                floorName: floorName,
                tenantCount: tenantCount,
                categories: categories,
                onTap: () => onFloorSelected(floorName),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FloorCard extends StatelessWidget {
  final String floorName;
  final int tenantCount;
  final List<String> categories;
  final VoidCallback onTap;

  const _FloorCard({
    required this.floorName,
    required this.tenantCount,
    required this.categories,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                const SizedBox(width: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer,
                    borderRadius: AppRadius.badge,
                  ),
                  child: Text(
                    '$tenantCount',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            if (categories.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                categories.join(' \u00b7 '),
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
