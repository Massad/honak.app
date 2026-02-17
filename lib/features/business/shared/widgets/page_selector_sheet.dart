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
import 'package:honak/shared/widgets/app_direction.dart';
import 'package:honak/shared/widgets/app_image.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

class PageSelectorSheet extends ConsumerWidget {
  const PageSelectorSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider).valueOrNull;
    final pages =
        authState is Authenticated ? authState.user.pages : <UserPage>[];
    final activePage = ref.watch(currentBusinessPageProvider).valueOrNull;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
                color: Theme.of(context).colorScheme.outline,
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
                    context.l10n.bizMyPages,
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
              child: btn.Button(
                onPressed: () {
                  Navigator.pop(context);
                  ref.read(appModeProvider.notifier).switchToCustomerMode();
                },
                label: context.l10n.bizBackToCustomerMode,
                icon: btn.ButtonIcon(Icons.store_outlined),
                variant: btn.Variant.outlined,
                size: btn.ButtonSize.large,
                expand: true,
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
        color: isActive ? const Color(0xFFF0F7FF) : Theme.of(context).colorScheme.surface,
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
                    : Theme.of(context).colorScheme.surfaceContainerLow,
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
                    AppDirection.chevronStartIcon(context),
                    size: 18,
                    color: Theme.of(context).colorScheme.outline,
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
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                    color: Theme.of(context).colorScheme.surfaceContainerLow,
                    border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                  ),
                  child: AppImage(
                    url: page.avatarUrl,
                    width: 40,
                    height: 40,
                    borderRadius: BorderRadius.circular(10),
                    placeholderIcon: Icons.store,
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
