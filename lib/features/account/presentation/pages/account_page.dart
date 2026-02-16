import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/button.dart' as btn;
import 'package:honak/features/account/presentation/pages/account_info_page.dart';
import 'package:honak/features/account/presentation/pages/help_support_page.dart';
import 'package:honak/features/account/presentation/pages/my_addresses_page.dart';
import 'package:honak/features/account/presentation/pages/notification_prefs_page.dart';
import 'package:honak/features/account/presentation/pages/privacy_security_page.dart';
import 'package:honak/features/account/presentation/pages/saved_pages_page.dart';
import 'package:honak/features/account/presentation/widgets/business_pages_section.dart';
import 'package:honak/features/account/presentation/widgets/menu_item.dart';
import 'package:honak/features/account/presentation/widgets/profile_header.dart';
import 'package:honak/shared/auth/auth_provider.dart';
import 'package:honak/shared/auth/auth_state.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider).valueOrNull;
    final isGuest = authState is AuthGuest;
    final user = authState is Authenticated ? authState.user : null;

    if (isGuest) {
      return _GuestView();
    }

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Profile header
          const ProfileHeader(),

          // Business pages or CTA
          if (user != null && user.pages.isNotEmpty)
            BusinessPagesSection(pages: user.pages)
          else
            const BusinessPagesCta(),

          // Menu items
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              0,
            ),
            child: Column(
              children: [
                AccountMenuItem(
                  icon: Icons.favorite_outline,
                  label: '\u0627\u0644\u0645\u062d\u0641\u0648\u0638\u0627\u062a',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SavedPagesPage(),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                AccountMenuItem(
                  icon: Icons.location_on_outlined,
                  label: '\u0639\u0646\u0627\u0648\u064a\u0646\u064a',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const MyAddressesPage(),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                AccountMenuItem(
                  icon: Icons.person_outline,
                  label: '\u0645\u0639\u0644\u0648\u0645\u0627\u062a \u0627\u0644\u062d\u0633\u0627\u0628',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const AccountInfoPage(),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                AccountMenuItem(
                  icon: Icons.notifications_outlined,
                  label: '\u0625\u0634\u0639\u0627\u0631\u0627\u062a\u064a',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const NotificationPrefsPage(),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                AccountMenuItem(
                  icon: Icons.shield_outlined,
                  label: '\u0627\u0644\u062e\u0635\u0648\u0635\u064a\u0629 \u0648\u0627\u0644\u0623\u0645\u0627\u0646',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const PrivacySecurityPage(),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                AccountMenuItem(
                  icon: Icons.language,
                  label: '\u0627\u0644\u0644\u063a\u0629',
                  subtitle: '\u0627\u0644\u0639\u0631\u0628\u064a\u0629',
                  onTap: () => context.push(Routes.settings),
                ),
                const SizedBox(height: AppSpacing.sm),
                AccountMenuItem(
                  icon: Icons.help_outline,
                  label: '\u0627\u0644\u0645\u0633\u0627\u0639\u062f\u0629 \u0648\u0627\u0644\u062f\u0639\u0645',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const HelpSupportPage(),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                // Sign out
                _SignOutButton(
                  onTap: () => _confirmLogout(context, ref),
                ),
                const SizedBox(height: AppSpacing.huge),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context, WidgetRef ref) {
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.logout),
        content: Text(context.l10n.logoutConfirm),
        actions: [
          btn.Button(
            onPressed: () => Navigator.pop(ctx),
            label: context.l10n.cancel,
            variant: btn.Variant.text,
          ),
          btn.Button(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(authProvider.notifier).logout();
            },
            label: context.l10n.logout,
          ),
        ],
      ),
    );
  }
}

// ── Guest view ──────────────────────────────────────────────────────────────

class _GuestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colorScheme.surfaceContainer,
                ),
                child: Icon(
                  Icons.person_outline,
                  size: 40,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                '\u0648\u0636\u0639 \u0627\u0644\u0632\u0627\u0626\u0631',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '\u0633\u062c\u0644 \u0627\u0644\u062f\u062e\u0648\u0644 \u0644\u0625\u062f\u0627\u0631\u0629 \u062d\u0633\u0627\u0628\u0643 \u0648\u0637\u0644\u0628\u0627\u062a\u0643',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxl),
              btn.Button(
                onPressed: () => context.go(Routes.welcome),
                label: '\u062a\u0633\u062c\u064a\u0644 \u0627\u0644\u062f\u062e\u0648\u0644',
                expand: true,
                size: btn.ButtonSize.large,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Sign out button ─────────────────────────────────────────────────────────

class _SignOutButton extends StatelessWidget {
  final VoidCallback onTap;

  const _SignOutButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.lg,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '\u062a\u0633\u062c\u064a\u0644 \u0627\u0644\u062e\u0631\u0648\u062c',
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.error,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              const Icon(
                Icons.logout,
                size: 20,
                color: AppColors.error,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
