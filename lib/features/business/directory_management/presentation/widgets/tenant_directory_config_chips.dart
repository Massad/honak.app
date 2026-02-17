import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Config chips bar — horizontal scroll with Floors, Categories, Amenities,
/// Featured, Maps. Each chip shows a count and opens its overlay on tap.
class TenantDirectoryConfigChips extends StatelessWidget {
  final int floorCount;
  final int categoryCount;
  final int amenityCount;
  final int featuredCount;
  final VoidCallback onFloorsTap;
  final VoidCallback onCategoriesTap;
  final VoidCallback onAmenitisTap;
  final VoidCallback onFeaturedTap;
  final VoidCallback onMapsTap;

  const TenantDirectoryConfigChips({
    super.key,
    required this.floorCount,
    required this.categoryCount,
    required this.amenityCount,
    required this.featuredCount,
    required this.onFloorsTap,
    required this.onCategoriesTap,
    required this.onAmenitisTap,
    required this.onFeaturedTap,
    required this.onMapsTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.lg,
        ),
        children: [
          _ConfigChip(
            icon: Icons.layers_outlined,
            label: context.l10n.dirChipFloors,
            count: floorCount,
            onTap: onFloorsTap,
          ),
          const SizedBox(width: AppSpacing.sm),
          _ConfigChip(
            icon: Icons.label_outline,
            label: context.l10n.dirChipCategories,
            count: categoryCount,
            onTap: onCategoriesTap,
          ),
          const SizedBox(width: AppSpacing.sm),
          _ConfigChip(
            icon: Icons.shield_outlined,
            label: context.l10n.dirChipAmenities,
            count: amenityCount,
            onTap: onAmenitisTap,
          ),
          const SizedBox(width: AppSpacing.sm),
          _ConfigChip(
            icon: Icons.auto_awesome_outlined,
            label: context.l10n.dirChipFeatured,
            count: featuredCount,
            onTap: onFeaturedTap,
          ),
          const SizedBox(width: AppSpacing.sm),
          _ConfigChip(
            icon: Icons.map_outlined,
            label: context.l10n.dirChipMaps,
            count: null,
            onTap: onMapsTap,
          ),
        ],
      ),
    );
  }
}

class _ConfigChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final int? count;
  final VoidCallback onTap;

  const _ConfigChip({
    required this.icon,
    required this.label,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerHighest,
          borderRadius: AppRadius.pill,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: context.colorScheme.onSurfaceVariant),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            if (count != null) ...[
              const SizedBox(width: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 1,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: AppRadius.pill,
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
