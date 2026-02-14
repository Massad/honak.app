import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/presentation/providers/settings_provider.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';

class EngagementSettings extends ConsumerWidget {
  final VoidCallback onClose;

  const EngagementSettings({super.key, required this.onClose});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(pageSettingsProvider);
    final level =
        settingsAsync.valueOrNull?.engagementLevel ?? 'full';
    final orderApproval =
        settingsAsync.valueOrNull?.orderApproval ?? 'manual';

    return Column(
      children: [
        SubScreenAppBar(
          title: 'مستوى التواجد',
          onClose: onClose,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              _EngagementCard(
                label: 'تواجد كامل',
                desc: 'كتالوج مرئي، طلبات عبر هونك، تتبع كامل',
                badgeLabel: 'موصى به',
                badgeColor: AppColors.success,
                selected: level == 'full',
                onTap: () => ref
                    .read(pageSettingsProvider.notifier)
                    .updateEngagement('full'),
              ),
              const SizedBox(height: AppSpacing.md),
              _EngagementCard(
                label: 'عرض فقط',
                desc:
                    'الكتالوج مرئي، الطلبات عبر واتساب أو الهاتف',
                badgeLabel: 'عرض',
                badgeColor: AppColors.primary,
                selected: level == 'showcase',
                onTap: () => ref
                    .read(pageSettingsProvider.notifier)
                    .updateEngagement('showcase'),
              ),
              const SizedBox(height: AppSpacing.md),
              _EngagementCard(
                label: 'تواجد بسيط',
                desc: 'معلومات أساسية فقط (الاسم، العنوان، الهاتف)',
                badgeLabel: 'أساسي',
                badgeColor: Theme.of(context).colorScheme.onSurfaceVariant,
                selected: level == 'visibility',
                onTap: () => ref
                    .read(pageSettingsProvider.notifier)
                    .updateEngagement('visibility'),
              ),
              const SizedBox(height: AppSpacing.xxl),
              // Order approval radio
              _SectionLabel('معالجة الطلبات'),
              const SizedBox(height: AppSpacing.sm),
              _ApprovalOption(
                label: 'مراجعة يدوية',
                desc: 'كل طلب يحتاج موافقتك أولاً',
                selected: orderApproval == 'manual',
                onTap: () => ref
                    .read(pageSettingsProvider.notifier)
                    .updateOrderApproval('manual'),
              ),
              const SizedBox(height: AppSpacing.sm),
              _ApprovalOption(
                label: 'قبول تلقائي',
                desc: 'الطلبات تُقبل مباشرة بدون مراجعة',
                selected: orderApproval == 'auto',
                onTap: () => ref
                    .read(pageSettingsProvider.notifier)
                    .updateOrderApproval('auto'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Text(
        text,
        style: context.textTheme.bodySmall?.copyWith(
          color: context.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ApprovalOption extends StatelessWidget {
  final String label;
  final String desc;
  final bool selected;
  final VoidCallback onTap;

  const _ApprovalOption({
    required this.label,
    required this.desc,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? AppColors.primary.withValues(alpha: 0.05)
          : Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? AppColors.primary.withValues(alpha: 0.3)
                  : Theme.of(context).colorScheme.surfaceContainerLow,
            ),
          ),
          child: Row(
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                size: 18,
                color: selected
                    ? AppColors.primary
                    : Theme.of(context).colorScheme.outline,
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    label,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EngagementCard extends StatelessWidget {
  final String label;
  final String desc;
  final String badgeLabel;
  final Color badgeColor;
  final bool selected;
  final VoidCallback onTap;

  const _EngagementCard({
    required this.label,
    required this.desc,
    required this.badgeLabel,
    required this.badgeColor,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? badgeColor.withValues(alpha: 0.05)
          : Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? badgeColor.withValues(alpha: 0.3)
                  : Theme.of(context).colorScheme.surfaceContainerLow,
            ),
          ),
          child: Row(
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                size: 18,
                color: selected ? badgeColor : Theme.of(context).colorScheme.outline,
              ),
              const Spacer(),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color:
                                badgeColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            badgeLabel,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: badgeColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          label,
                          style: context.textTheme.bodyMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      desc,
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
