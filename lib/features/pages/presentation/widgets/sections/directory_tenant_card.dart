import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/shared/widgets/app_image.dart';

/// Card displaying a single tenant in the directory listing.
class DirectoryTenantCard extends StatelessWidget {
  final Item item;

  const DirectoryTenantCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(Routes.productPath(item.id)),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: AppImage(
                    url:
                        item.images.isNotEmpty ? item.images.first : null,
                    fit: BoxFit.cover,
                    placeholderIcon: Icons.storefront,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.nameAr,
                      style: context.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        if (item.categoryName != null &&
                            item.categoryName!.isNotEmpty)
                          Container(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xxs,
                            ),
                            decoration: BoxDecoration(
                              color: context.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.layers_outlined,
                                  size: 12,
                                  color: context
                                      .colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(width: AppSpacing.xxs),
                                Text(
                                  item.categoryName!,
                                  style:
                                      context.textTheme.labelSmall?.copyWith(
                                    color: context
                                        .colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (item.categoryName != null &&
                            item.categoryName!.isNotEmpty &&
                            item.descriptionAr != null)
                          const SizedBox(width: AppSpacing.sm),
                        if (item.descriptionAr != null &&
                            item.descriptionAr!.isNotEmpty)
                          Flexible(
                            child: Container(
                              padding:
                                  const EdgeInsetsDirectional.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.xxs,
                              ),
                              decoration: BoxDecoration(
                                color: context
                                    .colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                item.descriptionAr!,
                                style: context.textTheme.labelSmall
                                    ?.copyWith(
                                  color: context
                                      .colorScheme.onSurfaceVariant,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_left,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
