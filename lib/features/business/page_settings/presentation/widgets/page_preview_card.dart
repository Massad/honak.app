import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/entities/user.dart';
import 'package:honak/shared/widgets/app_image.dart';

class PagePreviewCard extends StatelessWidget {
  final UserPage page;
  final String? archetypeBadge;
  final VoidCallback? onEdit;

  const PagePreviewCard({
    super.key,
    required this.page,
    this.archetypeBadge,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Cover image with dark scrim
          Stack(
            children: [
              Container(
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.2),
                      AppColors.primary.withValues(alpha: 0.08),
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 24,
                    color: Colors.white54,
                  ),
                ),
              ),
              // Dark scrim overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.05),
                        Colors.black.withValues(alpha: 0.25),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Page info row with overlapping avatar
          Transform.translate(
            offset: const Offset(0, -22),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Edit pencil icon (far left)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: GestureDetector(
                      onTap: onEdit,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                        ),
                        child: Icon(
                          Icons.edit_outlined,
                          size: 15,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Name + handle
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (page.isVerified)
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    end: 4),
                                child: Icon(
                                  Icons.verified,
                                  size: 14,
                                  color: AppColors.primary,
                                ),
                              ),
                            Text(
                              page.name,
                              style:
                                  context.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (archetypeBadge != null) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary
                                      .withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  archetypeBadge!,
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                            ],
                            Text(
                              '@${page.slug}',
                              style: TextStyle(
                                fontSize: 10,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  // Avatar (overlapping cover)
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.surface,
                      border: Border.all(color: Theme.of(context).colorScheme.surface, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: AppImage(
                      url: page.avatarUrl,
                      width: 50,
                      height: 50,
                      borderRadius: BorderRadius.circular(10),
                      placeholderIcon: Icons.store,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
