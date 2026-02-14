import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/saved/domain/entities/saved_page.dart';
import 'package:honak/features/saved/presentation/providers/saved_provider.dart';
import 'package:honak/shared/widgets/shimmer_loading.dart';

class SavedListPage extends ConsumerWidget {
  const SavedListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedPages = ref.watch(savedPagesProvider);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('\u0627\u0644\u0645\u062d\u0641\u0648\u0638\u0627\u062a'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Directionality(
          textDirection: Directionality.of(context),
          child: savedPages.when(
            loading: () => const _SavedListSkeleton(),
            error: (error, _) => Center(
              child: Text(
                '\u062d\u062f\u062b \u062e\u0637\u0623',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            data: (pages) {
              if (pages.isEmpty) {
                return _EmptyState();
              }
              return ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.lg),
                itemCount: pages.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) => _SavedPageCard(
                  page: pages[index],
                  onTap: () {
                    final handle = pages[index].handle;
                    if (handle != null) {
                      context.push(Routes.pagePath(handle));
                    }
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ── Empty state ─────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite_outline,
            size: 48,
            color: context.colorScheme.outline,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            '\u0644\u0627 \u062a\u0648\u062c\u062f \u0635\u0641\u062d\u0627\u062a \u0645\u062d\u0641\u0648\u0638\u0629',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Saved page card ─────────────────────────────────────────────────────────

class _SavedPageCard extends StatelessWidget {
  final SavedPage page;
  final VoidCallback onTap;

  const _SavedPageCard({required this.page, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              // Chevron
              Icon(
                Icons.chevron_left,
                size: 18,
                color: context.colorScheme.outline,
              ),
              const Spacer(),

              // Name + handle + category
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (page.verified) ...[
                          const Icon(
                            Icons.verified,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                        ],
                        Flexible(
                          child: Text(
                            page.name,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (page.categoryName != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              page.categoryName!,
                              style: context.textTheme.labelSmall?.copyWith(
                                color: AppColors.primary,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        if (page.handle != null) ...[
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            '@${page.handle}',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Logo placeholder
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: context.colorScheme.surfaceContainerLow,
                  border: Border.all(color: context.colorScheme.outlineVariant),
                ),
                child: Icon(
                  Icons.store,
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

// ── Skeleton loader ─────────────────────────────────────────────────────────

class _SavedListSkeleton extends StatelessWidget {
  const _SavedListSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: 4,
      itemBuilder: (_, __) => const Padding(
        padding: EdgeInsets.only(bottom: AppSpacing.sm),
        child: ShimmerListItem(),
      ),
    );
  }
}
