import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/account/presentation/widgets/sub_screen_header.dart';
import 'package:honak/features/saved/domain/entities/saved_page.dart';
import 'package:honak/features/saved/presentation/providers/saved_provider.dart';
import 'package:honak/shared/widgets/app_image.dart';

class SavedPagesPage extends ConsumerWidget {
  const SavedPagesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedPages = ref.watch(savedPagesProvider);

    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerLowest,
      appBar: const SubScreenHeader(title: 'المحفوظات'),
      body: savedPages.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(
          child: Text(
            'حدث خطأ',
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        data: (pages) {
          if (pages.isEmpty) return const _EmptyState();

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.lg,
            ),
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: AppSpacing.xs,
                  bottom: AppSpacing.sm,
                ),
                child: Text(
                  '${pages.length} صفحة محفوظة',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
              ),
              ...pages.asMap().entries.map((entry) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom:
                        entry.key < pages.length - 1 ? AppSpacing.sm : 0,
                  ),
                  child: _SavedPageCard(
                    page: entry.value,
                    onTap: () {
                      final handle = entry.value.handle;
                      if (handle != null) {
                        context.push(Routes.pagePath(handle));
                      }
                    },
                    onRemove: () {
                      context.showSnackBar('تم إزالة الصفحة من المحفوظات');
                    },
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

class _SavedPageCard extends StatelessWidget {
  final SavedPage page;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _SavedPageCard({
    required this.page,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppRadius.card,
        child: InkWell(
          borderRadius: AppRadius.card,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                // Logo
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.cardInner,
                    color: context.colorScheme.surfaceContainerLowest,
                    border: Border.all(color: AppColors.divider),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: AppImage(
                    url: page.logoUrl,
                    width: 48,
                    height: 48,
                    placeholderIcon: Icons.store,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              page.name,
                              style: context.textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (page.verified) ...[
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.verified,
                              size: 12,
                              color: AppColors.primary,
                            ),
                          ],
                        ],
                      ),
                      if (page.categoryName != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          page.categoryName!,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: AppColors.textHint,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),

                // Remove button
                IconButton(
                  onPressed: onRemove,
                  icon: Icon(
                    Icons.bookmark_remove_outlined,
                    size: 18,
                    color: AppColors.textHint,
                  ),
                  tooltip: 'إزالة',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.bookmark_outline,
              size: 40,
              color: AppColors.divider,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'لا توجد صفحات محفوظة',
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.textHint,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'احفظ صفحاتك المفضلة للوصول السريع',
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
