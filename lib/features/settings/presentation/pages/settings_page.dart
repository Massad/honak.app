import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/auth/auth_provider.dart';
import 'package:honak/shared/auth/auth_state.dart';
import 'package:honak/shared/providers/locale_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  // Local state for theme (Phase 2)
  String _themeMode = 'system';
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);
    final isArabic = locale.languageCode == 'ar';
    final authState = ref.watch(authProvider).valueOrNull;
    final isAuthenticated = authState is Authenticated;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('\u0627\u0644\u0625\u0639\u062f\u0627\u062f\u0627\u062a'),
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
              _SectionHeader(title: '\u0627\u0644\u0644\u063a\u0629'),
              const SizedBox(height: AppSpacing.sm),
              _SettingsCard(
                child: Row(
                  children: [
                    const Icon(Icons.language, size: 20, color: AppColors.primary),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        '\u0644\u063a\u0629 \u0627\u0644\u062a\u0637\u0628\u064a\u0642',
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    DropdownButton<String>(
                      value: isArabic ? 'ar' : 'en',
                      underline: const SizedBox.shrink(),
                      items: const [
                        DropdownMenuItem(
                          value: 'ar',
                          child: Text('\u0627\u0644\u0639\u0631\u0628\u064a\u0629'),
                        ),
                        DropdownMenuItem(
                          value: 'en',
                          child: Text('English'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          ref.read(localeProvider.notifier).state = Locale(value);
                        }
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Theme section
              _SectionHeader(title: '\u0627\u0644\u0645\u0638\u0647\u0631'),
              const SizedBox(height: AppSpacing.sm),
              _SettingsCard(
                child: Row(
                  children: [
                    const Icon(Icons.palette_outlined, size: 20, color: AppColors.primary),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        '\u0627\u0644\u0645\u0638\u0647\u0631',
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(
                          value: 'light',
                          icon: Icon(Icons.light_mode, size: 16),
                        ),
                        ButtonSegment(
                          value: 'system',
                          icon: Icon(Icons.settings_suggest, size: 16),
                        ),
                        ButtonSegment(
                          value: 'dark',
                          icon: Icon(Icons.dark_mode, size: 16),
                        ),
                      ],
                      selected: {_themeMode},
                      onSelectionChanged: (value) {
                        setState(() => _themeMode = value.first);
                      },
                      showSelectedIcon: false,
                      style: ButtonStyle(
                        visualDensity: VisualDensity.compact,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Notifications section
              _SectionHeader(title: '\u0627\u0644\u0625\u0634\u0639\u0627\u0631\u0627\u062a'),
              const SizedBox(height: AppSpacing.sm),
              _SettingsCard(
                child: Row(
                  children: [
                    const Icon(Icons.notifications_outlined, size: 20, color: AppColors.primary),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        '\u062a\u0641\u0639\u064a\u0644 \u0627\u0644\u0625\u0634\u0639\u0627\u0631\u0627\u062a',
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    Switch(
                      value: _notificationsEnabled,
                      onChanged: (value) {
                        setState(() => _notificationsEnabled = value);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),

              // About section
              _SectionHeader(title: '\u062d\u0648\u0644 \u0627\u0644\u062a\u0637\u0628\u064a\u0642'),
              const SizedBox(height: AppSpacing.sm),
              _SettingsCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.info_outline, size: 20, color: AppColors.primary),
                        const SizedBox(width: AppSpacing.md),
                        Text(
                          '\u062d\u064f\u0646\u064e\u0643',
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
                          color: Colors.grey.shade500,
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
                      '\u062d\u0630\u0641 \u0627\u0644\u062d\u0633\u0627\u0628',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.error,
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
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('\u062d\u0630\u0641 \u0627\u0644\u062d\u0633\u0627\u0628'),
        content: const Text(
          '\u0647\u0644 \u0623\u0646\u062a \u0645\u062a\u0623\u0643\u062f \u0645\u0646 \u062d\u0630\u0641 \u062d\u0633\u0627\u0628\u0643\u061f \u0644\u0627 \u064a\u0645\u0643\u0646 \u0627\u0644\u062a\u0631\u0627\u062c\u0639 \u0639\u0646 \u0647\u0630\u0627 \u0627\u0644\u0625\u062c\u0631\u0627\u0621.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              context.showSnackBar('\u0642\u0631\u064a\u0628\u0627\u064b');
            },
            child: const Text('\u062d\u0630\u0641'),
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
        color: Colors.grey.shade600,
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: child,
    );
  }
}
