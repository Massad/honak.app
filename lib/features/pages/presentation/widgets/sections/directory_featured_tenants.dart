import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/shared/widgets/app_image.dart';

/// 3-column grid of featured tenant avatars (max 6).
class DirectoryFeaturedTenants extends StatelessWidget {
  final List<String> featuredIds;
  final List<Item> allItems;

  const DirectoryFeaturedTenants({
    super.key,
    required this.featuredIds,
    required this.allItems,
  });

  @override
  Widget build(BuildContext context) {
    final displayed = featuredIds.take(6).toList();

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.star,
                size: 20,
                color: Colors.amber.shade700,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                // "\u0627\u0644\u0645\u0645\u064a\u0632\u0648\u0646" = المميزون
                '\u0627\u0644\u0645\u0645\u064a\u0632\u0648\u0646',
                style: context.textTheme.titleSmall,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.sm,
              childAspectRatio: 0.85,
            ),
            itemCount: displayed.length,
            itemBuilder: (context, index) {
              final tenantId = displayed[index];
              final item = allItems.where((i) => i.id == tenantId).firstOrNull;
              return _FeaturedTenantCell(
                tenantId: tenantId,
                item: item,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FeaturedTenantCell extends StatelessWidget {
  final String tenantId;
  final Item? item;

  const _FeaturedTenantCell({
    required this.tenantId,
    this.item,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item?.pageId != null
          ? () => context.push(Routes.pagePath(item!.pageId!))
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: context.colorScheme.outlineVariant
                    .withValues(alpha: 0.3),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: item != null && item!.images.isNotEmpty
                ? AppImage(
                    url: item!.images.first,
                    fit: BoxFit.cover,
                    placeholderIcon: Icons.storefront,
                  )
                : Icon(
                    Icons.storefront,
                    color: context.colorScheme.onSurfaceVariant,
                    size: 24,
                  ),
          ),
          const SizedBox(height: AppSpacing.xs),
          // Name
          Text(
            item?.nameAr ?? tenantId,
            style: context.textTheme.labelSmall,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // Floor · Unit
          if (item?.categoryName != null || item?.descriptionAr != null)
            Text(
              [
                if (item?.categoryName != null) item!.categoryName!,
                if (item?.descriptionAr != null) item!.descriptionAr!,
              ].join(' \u00b7 '),
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                fontSize: 9,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
