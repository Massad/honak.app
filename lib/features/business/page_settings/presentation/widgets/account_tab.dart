import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/auth/auth_provider.dart';
import 'package:honak/shared/auth/auth_state.dart';
import 'package:honak/shared/providers/app_mode_provider.dart';
import 'package:honak/shared/providers/business_page_provider.dart';
import 'package:honak/shared/widgets/app_dialog.dart';
import 'package:honak/shared/widgets/button.dart';

import 'account_tab_cards.dart';
import 'settings_section.dart';

export 'account_tab_cards.dart';

class AccountTab extends ConsumerWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider).valueOrNull;
    final user = authState is Authenticated ? authState.user : null;
    final bizContext = ref.watch(businessContextProvider);
    final currentPage = bizContext?.page;

    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      children: [
        const SizedBox(height: AppSpacing.lg),
        // Profile card
        if (user != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: AccountProfileCard(
              user: user,
              onTap: () {
                ref.read(appModeProvider.notifier).switchToCustomerMode();
              },
            ),
          ),
        const SizedBox(height: AppSpacing.lg),
        // Business pages
        if (user != null && user.pages.isNotEmpty)
          SettingsSection(
            label: 'صفحاتي التجارية',
            child: Column(
              children: [
                // Active page
                if (currentPage != null)
                  AccountPageItem(
                    page: currentPage,
                    isActive: true,
                  ),
                // Other pages
                for (final page in user.pages.where(
                  (p) => p.id != currentPage?.id,
                )) ...[
                  const SizedBox(height: 6),
                  AccountPageItem(
                    page: page,
                    isActive: false,
                    onTap: () {
                      ref
                          .read(appModeProvider.notifier)
                          .switchToBusinessMode(page);
                    },
                  ),
                ],
                const SizedBox(height: AppSpacing.md),
                // Create new page
                Material(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => context.showSnackBar('قريباً: إنشاء صفحة'),
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'إنشاء صفحة جديدة',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Icon(
                            Icons.add_circle_outline,
                            size: 18,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: AppSpacing.xxl),
        // Switch to customer mode
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Material(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {
                ref.read(appModeProvider.notifier).switchToCustomerMode();
              },
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'العودة لوضع العميل',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Icon(
                      Icons.swap_horiz,
                      size: 20,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        // Logout
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Material(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => _showLogoutConfirmation(context, ref),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.error.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'تسجيل الخروج',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.error,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Icon(
                      Icons.logout,
                      size: 18,
                      color: AppColors.error,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showLogoutConfirmation(BuildContext context, WidgetRef ref) {
    showAppDialog<void>(
      context,
      builder: (ctx) => AlertDialog(
        title: const Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text('تسجيل الخروج'),
        ),
        content: const Text(
          'هل أنت متأكد من تسجيل الخروج؟',
          textAlign: TextAlign.end,
        ),
        actions: [
          Row(
            textDirection: Directionality.of(context),
            children: [
              Button(
                onPressed: () => Navigator.pop(ctx),
                label: 'إلغاء',
                variant: Variant.text,
              ),
              const SizedBox(width: AppSpacing.sm),
              Button(
                onPressed: () {
                  Navigator.pop(ctx);
                  ref.read(authProvider.notifier).logout();
                },
                label: 'خروج',
                variant: Variant.text,
                style: Style.danger,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
