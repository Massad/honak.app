import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/auth/auth_provider.dart';
import 'package:honak/shared/auth/auth_state.dart';
import 'package:honak/shared/entities/user.dart';
import 'package:honak/shared/providers/app_mode_provider.dart';
import 'package:honak/shared/widgets/app_image.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider).valueOrNull;
    final isGuest = authState is AuthGuest;
    final user = authState is Authenticated ? authState.user : null;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Profile header
          _ProfileHeader(user: user, isGuest: isGuest),

          // My business pages
          if (user != null && user.pages.isNotEmpty)
            _MyPagesSection(pages: user.pages),

          // Menu items
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              0,
            ),
            child: Column(
              children: [
                _MenuItem(
                  icon: Icons.favorite_outline,
                  label: 'المحفوظات',
                  onTap: () =>
                      context.showSnackBar('قريباً: المحفوظات'),
                ),
                const SizedBox(height: AppSpacing.sm),
                _MenuItem(
                  icon: Icons.location_on_outlined,
                  label: 'عناويني',
                  onTap: () =>
                      context.showSnackBar('قريباً: عناويني'),
                ),
                const SizedBox(height: AppSpacing.sm),
                _MenuItem(
                  icon: Icons.person_outline,
                  label: 'معلومات الحساب',
                  onTap: () =>
                      context.showSnackBar('قريباً: معلومات الحساب'),
                ),
                const SizedBox(height: AppSpacing.sm),
                _MenuItem(
                  icon: Icons.notifications_outlined,
                  label: 'إشعاراتي',
                  onTap: () =>
                      context.showSnackBar('قريباً: إشعاراتي'),
                ),
                const SizedBox(height: AppSpacing.sm),
                _MenuItem(
                  icon: Icons.shield_outlined,
                  label: 'الخصوصية والأمان',
                  onTap: () =>
                      context.showSnackBar('قريباً: الخصوصية والأمان'),
                ),
                const SizedBox(height: AppSpacing.sm),
                _MenuItem(
                  icon: Icons.language,
                  label: 'اللغة',
                  subtitle: 'العربية',
                  onTap: () =>
                      context.showSnackBar('قريباً: اللغة'),
                ),
                const SizedBox(height: AppSpacing.sm),
                _MenuItem(
                  icon: Icons.help_outline,
                  label: 'المساعدة والدعم',
                  onTap: () =>
                      context.showSnackBar('قريباً: المساعدة والدعم'),
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
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(authProvider.notifier).logout();
            },
            child: Text(context.l10n.logout),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Profile header — avatar, name, phone, settings
// ═══════════════════════════════════════════════════════════════

class _ProfileHeader extends StatelessWidget {
  final User? user;
  final bool isGuest;

  const _ProfileHeader({this.user, required this.isGuest});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        MediaQuery.of(context).padding.top + AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      child: Row(
        children: [
          // Settings icon
          IconButton(
            onPressed: () =>
                context.showSnackBar('قريباً: الإعدادات'),
            icon: Icon(
              Icons.settings_outlined,
              color: Colors.grey.shade400,
              size: 24,
            ),
          ),
          const Spacer(),
          // Name + phone
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isGuest
                    ? 'وضع الزائر'
                    : (user?.name ?? ''),
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (user?.phone.isNotEmpty == true) ...[
                const SizedBox(height: 2),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    user!.phone,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          // Avatar
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: user?.avatarUrl != null
                  ? AppImage(
                      url: user!.avatarUrl,
                      width: 60,
                      height: 60,
                    )
                  : Icon(
                      isGuest ? Icons.person_outline : Icons.person,
                      size: 32,
                      color: Colors.grey.shade400,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// My pages section — matches Figma: page cards with "إدارة" button
// ═══════════════════════════════════════════════════════════════

class _MyPagesSection extends ConsumerWidget {
  final List<UserPage> pages;

  const _MyPagesSection({required this.pages});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'صفحاتي التجارية',
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Icon(
                Icons.store,
                size: 16,
                color: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Page cards
          ...pages.map((page) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: _PageCard(
                  page: page,
                  onTap: () {
                    ref
                        .read(appModeProvider.notifier)
                        .switchToBusinessMode(page);
                  },
                ),
              )),

          // Create new page
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () =>
                  context.showSnackBar('قريباً: إنشاء صفحة جديدة'),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.md,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'إنشاء صفحة جديدة',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Icon(
                      Icons.add,
                      size: 18,
                      color: Colors.grey.shade500,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PageCard extends StatelessWidget {
  final UserPage page;
  final VoidCallback onTap;

  const _PageCard({required this.page, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Row(
            children: [
              // "إدارة" button
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'إدارة',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.store,
                      size: 12,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),

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
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: page.avatarUrl != null
                      ? AppImage(
                          url: page.avatarUrl,
                          width: 44,
                          height: 44,
                        )
                      : Icon(
                          Icons.store,
                          color: Colors.grey.shade400,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Menu item — white card, icon + label + chevron
// ═══════════════════════════════════════════════════════════════

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback? onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
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
            children: [
              Icon(
                Icons.chevron_left,
                size: 18,
                color: Colors.grey.shade300,
              ),
              if (subtitle != null) ...[
                const SizedBox(width: AppSpacing.sm),
                Text(
                  subtitle!,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
              const Spacer(),
              Text(
                label,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Icon(
                icon,
                size: 20,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Sign out button
// ═══════════════════════════════════════════════════════════════

class _SignOutButton extends StatelessWidget {
  final VoidCallback onTap;

  const _SignOutButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
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
                'تسجيل الخروج',
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.error,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Icon(
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
