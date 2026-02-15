import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/shared/widgets/app_image.dart';

/// Compact item row for picker lists.
///
/// Shows image + name + description + price + optional radio indicator.
/// When [showRadio] is true, a radio circle appears at the **end** side
/// (left in RTL, right in LTR) and the row highlights when [isSelected].
class ItemTile extends StatelessWidget {
  final Item item;
  final VoidCallback onTap;
  final bool isSelected;
  final bool showRadio;

  const ItemTile({
    super.key,
    required this.item,
    required this.onTap,
    this.isSelected = false,
    this.showRadio = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: showRadio ? BorderRadius.circular(12) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsetsDirectional.symmetric(
          vertical: AppSpacing.sm,
          horizontal: showRadio ? AppSpacing.md : 0,
        ),
        decoration: showRadio
            ? BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.04)
                    : cs.surface,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.4)
                      : cs.outlineVariant,
                  width: isSelected ? 1.5 : 1,
                ),
                borderRadius: BorderRadius.circular(12),
              )
            : null,
        child: Row(
          children: [
            if (item.images.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AppImage(
                  url: item.images.first,
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                  placeholderIcon: Icons.image_outlined,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.nameAr,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: cs.onSurface,
                    ),
                  ),
                  if (item.descriptionAr != null)
                    Text(
                      item.descriptionAr!,
                      style: TextStyle(
                        fontSize: 12,
                        color: cs.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.price.toFormattedArabic(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                if (item.optionGroups.isNotEmpty)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 2),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${item.optionGroups.length} خيارات',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Radio indicator — end side (LEFT in RTL)
            if (showRadio) ...[
              const SizedBox(width: AppSpacing.sm),
              _RadioIndicator(isSelected: isSelected),
            ],
          ],
        ),
      ),
    );
  }
}

class _RadioIndicator extends StatelessWidget {
  final bool isSelected;
  const _RadioIndicator({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.primary : Colors.transparent,
        border: Border.all(
          color: isSelected ? AppColors.primary : cs.outline,
          width: 2,
        ),
      ),
      child: isSelected
          ? const Icon(Icons.check, size: 14, color: Colors.white)
          : null,
    );
  }
}
