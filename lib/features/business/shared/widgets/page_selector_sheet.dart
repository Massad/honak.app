import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/auth/auth_provider.dart';
import 'package:honak/shared/auth/auth_state.dart';
import 'package:honak/shared/entities/user.dart';
import 'package:honak/shared/providers/app_mode_provider.dart';
import 'package:honak/shared/providers/business_page_provider.dart';
import 'package:honak/shared/widgets/cached_image.dart';

class PageSelectorSheet extends ConsumerWidget {
  const PageSelectorSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider).valueOrNull;
    final pages =
        authState is Authenticated ? authState.user.pages : <UserPage>[];
    final activePage = ref.watch(currentBusinessPageProvider).valueOrNull;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'صفحاتي التجارية',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Icon(Icons.store, size: 18, color: AppColors.primary),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Page list
            ...pages.map((page) {
              final isActive = activePage?.id == page.id;
              return _PageTile(
                page: page,
                isActive: isActive,
                onTap: () {
                  ref
                      .read(currentBusinessPageProvider.notifier)
                      .selectPage(page);
                  Navigator.pop(context);
                },
              );
            }),

            const Divider(height: 1, indent: AppSpacing.lg, endIndent: AppSpacing.lg),

            // Back to customer mode
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    Navigator.pop(context);
                    ref.read(appModeProvider.notifier).switchToCustomerMode();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.lg,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'العودة لوضع العميل',
                          style: context.textTheme.titleSmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Icon(
                          Icons.store_outlined,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageTile extends StatelessWidget {
  final UserPage page;
  final bool isActive;
  final VoidCallback onTap;

  const _PageTile({
    required this.page,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      child: Material(
        color: isActive ? const Color(0xFFF0F7FF) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isActive
                    ? AppColors.primary.withValues(alpha: 0.3)
                    : Colors.grey.shade100,
              ),
            ),
            child: Row(
              children: [
                // Active indicator or chevron
                if (isActive)
                  Icon(
                    Icons.check_circle,
                    size: 20,
                    color: AppColors.primary,
                  )
                else
                  Icon(
                    Icons.chevron_left,
                    size: 18,
                    color: Colors.grey.shade300,
                  ),
                const SizedBox(width: AppSpacing.sm),

                // Name + type
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (page.isVerified) ...[
                            Icon(
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
                      if (page.businessTypeName != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          '@${page.slug} · ${page.businessTypeName}',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: Colors.grey.shade400,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.md),

                // Avatar
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: page.avatarUrl != null
                        ? CachedImage(
                            imageUrl: page.avatarUrl,
                            width: 40,
                            height: 40,
                          )
                        : Icon(
                            Icons.store,
                            size: 20,
                            color: Colors.grey.shade400,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
