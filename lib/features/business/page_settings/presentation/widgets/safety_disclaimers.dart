import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/page_settings.dart';
import 'package:honak/features/business/page_settings/presentation/providers/settings_provider.dart';
import 'package:honak/features/business/page_settings/presentation/providers/templates_provider.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/disclaimer_card.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

class SafetyDisclaimers extends ConsumerWidget {
  final VoidCallback onClose;

  const SafetyDisclaimers({super.key, required this.onClose});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(pageSettingsProvider);
    final disclaimers =
        settingsAsync.valueOrNull?.disclaimers ?? [];

    return Column(
      children: [
        SubScreenAppBar(
          title: 'تنبيهات السلامة',
          onClose: onClose,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              for (var i = 0; i < disclaimers.length; i++) ...[
                DisclaimerCard(
                  disclaimer: disclaimers[i],
                  onToggle: (v) {
                    ref
                        .read(pageSettingsProvider.notifier)
                        .toggleDisclaimer(
                            disclaimers[i].id, v);
                  },
                  onTextChanged: (text) {
                    ref
                        .read(pageSettingsProvider.notifier)
                        .updateDisclaimerText(
                            disclaimers[i].id, text);
                  },
                  onTitleChanged: (title) {
                    ref
                        .read(pageSettingsProvider.notifier)
                        .updateDisclaimerTitle(
                            disclaimers[i].id, title);
                  },
                  onRemove: () {
                    ref
                        .read(pageSettingsProvider.notifier)
                        .removeDisclaimer(disclaimers[i].id);
                  },
                ),
                if (i < disclaimers.length - 1)
                  const SizedBox(height: AppSpacing.sm),
              ],
              const SizedBox(height: AppSpacing.lg),
              // Add new disclaimer
              Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(14),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () {
                          final id =
                              'disc_${DateTime.now().millisecondsSinceEpoch}';
                          ref
                              .read(pageSettingsProvider.notifier)
                              .addDisclaimer(SafetyDisclaimer(
                                id: id,
                                text: '',
                                title: '',
                                sortOrder:
                                    disclaimers.length,
                              ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(
                              AppSpacing.md),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(14),
                            border: Border.all(
                              color: AppColors.primary
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Text(
                                'إضافة تنبيه جديد',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                  width: AppSpacing.sm),
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
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Material(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () =>
                          _showTemplates(context, ref),
                      child: Container(
                        padding: const EdgeInsets.all(
                            AppSpacing.md),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(14),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outlineVariant,
                          ),
                        ),
                        child: Icon(
                          Icons.library_books_outlined,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showTemplates(BuildContext context, WidgetRef ref) {
    final templatesAsync = ref.read(templatesProvider);
    final templates = templatesAsync.valueOrNull;
    if (templates == null) {
      context.showSnackBar('جاري تحميل القوالب...');
      return;
    }

    final list = templates['disclaimer_templates'] as List? ?? [];

    showAppSheet(
      context,
      maxHeightFraction: 0.8,
      builder: (ctx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Text(
                'قوالب جاهزة',
                style:
                    ctx.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg),
                itemBuilder: (ctx, i) {
                  final t =
                      list[i] as Map<String, dynamic>;
                  return ListTile(
                    title: Text(
                      t['title'] as String? ?? '',
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      t['text'] as String? ?? '',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: DisclaimerTypeBadge(
                        type: t['type'] as String? ??
                            'policy'),
                    onTap: () {
                      final id =
                          'disc_${DateTime.now().millisecondsSinceEpoch}';
                      ref
                          .read(pageSettingsProvider
                              .notifier)
                          .addDisclaimer(
                            SafetyDisclaimer(
                              id: id,
                              type: t['type']
                                      as String? ??
                                  'custom',
                              title: t['title']
                                      as String? ??
                                  '',
                              text: t['text']
                                      as String? ??
                                  '',
                            ),
                          );
                      Navigator.pop(ctx);
                      context.showSnackBar(
                          'تم إضافة التنبيه');
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
