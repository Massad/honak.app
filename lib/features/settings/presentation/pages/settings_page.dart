import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/l10n/arb/app_localizations.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/auth/auth_provider.dart';
import 'package:honak/shared/auth/auth_state.dart';
import 'package:honak/shared/providers/locale_provider.dart';
import 'package:honak/shared/providers/theme_mode_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider).valueOrNull ?? const Locale('ar');
    final isArabic = locale.languageCode == 'ar';
    final authState = ref.watch(authProvider).valueOrNull;
    final isAuthenticated = authState is Authenticated;
    final themeMode =
        ref.watch(themeModeProvider).valueOrNull ?? ThemeMode.system;
    final cs = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.settings),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              // Language section
              _SectionHeader(title: context.l10n.language),
              const SizedBox(height: AppSpacing.sm),
              _SettingsCard(
                child: Row(
                  children: [
                    Icon(Icons.language, size: 20, color: cs.primary),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        context.l10n.appLanguage,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    DropdownButton<String>(
                      value: isArabic ? 'ar' : 'en',
                      underline: const SizedBox.shrink(),
                      items: const [
                        DropdownMenuItem(
                          value: 'ar',
                          child: Text('العربية'),
                        ),
                        DropdownMenuItem(
                          value: 'en',
                          child: Text('English'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          ref
                              .read(localeProvider.notifier)
                              .setLocale(Locale(value));
                        }
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Theme section
              _SectionHeader(title: context.l10n.appearance),
              const SizedBox(height: AppSpacing.sm),
              _SettingsCard(
                child: Row(
                  children: [
                    Icon(Icons.palette_outlined, size: 20, color: cs.primary),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        context.l10n.appearance,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    SegmentedButton<ThemeMode>(
                      segments: const [
                        ButtonSegment(
                          value: ThemeMode.light,
                          icon: Icon(Icons.light_mode, size: 16),
                        ),
                        ButtonSegment(
                          value: ThemeMode.system,
                          icon: Icon(Icons.settings_suggest, size: 16),
                        ),
                        ButtonSegment(
                          value: ThemeMode.dark,
                          icon: Icon(Icons.dark_mode, size: 16),
                        ),
                      ],
                      selected: {themeMode},
                      onSelectionChanged: (value) {
                        ref
                            .read(themeModeProvider.notifier)
                            .setThemeMode(value.first);
                      },
                      showSelectedIcon: false,
                      style: const ButtonStyle(
                        visualDensity: VisualDensity.compact,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),

              // About section
              _SectionHeader(title: context.l10n.aboutApp),
              const SizedBox(height: AppSpacing.sm),
              _SettingsCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, size: 20, color: cs.primary),
                        const SizedBox(width: AppSpacing.md),
                        Text(
                          'حُنَك',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 32),
                      child: Text(
                        '1.0.0 (Phase 1)',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Delete account
              if (isAuthenticated) ...[
                const SizedBox(height: AppSpacing.xxxl),
                Center(
                  child: TextButton(
                    onPressed: () => _confirmDeleteAccount(context),
                    child: Text(
                      context.l10n.deleteAccount,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: cs.error,
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.huge),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDeleteAccount(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteAccount),
        content: Text(l10n.deleteAccountConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: cs.error,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(l10n.comingSoon)),
                );
            },
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}

// ── Section header ──────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}

// ── Settings card container ─────────────────────────────────────────────────

class _SettingsCard extends StatelessWidget {
  final Widget child;

  const _SettingsCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: child,
    );
  }
}
