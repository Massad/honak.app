import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/presentation/providers/settings_provider.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';

class ReturnPolicy extends ConsumerWidget {
  final VoidCallback onClose;

  const ReturnPolicy({super.key, required this.onClose});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(pageSettingsProvider);
    final settings = settingsAsync.valueOrNull;
    if (settings == null) {
      return Column(
        children: [
          SubScreenAppBar(title: 'سياسة الإرجاع', onClose: onClose),
          const Expanded(
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      );
    }

    final windowDays = settings.returnWindowDays;
    final returnType = settings.returnType;
    final returnCost = settings.returnCost;
    final acceptsReturns = windowDays > 0;

    void updatePolicy({int? days, String? type, String? cost}) {
      ref.read(pageSettingsProvider.notifier).updateReturnPolicy(
            windowDays: days,
            returnType: type,
            returnCost: cost,
          );
    }

    return Column(
      children: [
        SubScreenAppBar(title: 'سياسة الإرجاع', onClose: onClose),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              _ToggleRow(
                label: 'قبول الإرجاع',
                desc: acceptsReturns
                    ? 'العملاء يمكنهم إرجاع المنتجات'
                    : 'لا يتم قبول إرجاع المنتجات',
                value: acceptsReturns,
                onChanged: (v) =>
                    updatePolicy(days: v ? 7 : 0),
              ),
              if (acceptsReturns) ...[
                const SizedBox(height: AppSpacing.lg),
                _SectionLabel('نافذة الإرجاع (أيام)'),
                const SizedBox(height: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border:
                        Border.all(color: Colors.grey.shade100),
                  ),
                  child: Row(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: windowDays > 1
                                ? () => updatePolicy(
                                    days: windowDays - 1)
                                : null,
                            icon: const Icon(
                                Icons.remove_circle_outline,
                                size: 20),
                            color: AppColors.primary,
                          ),
                          Text(
                            '$windowDays',
                            style: context.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          IconButton(
                            onPressed: windowDays < 30
                                ? () => updatePolicy(
                                    days: windowDays + 1)
                                : null,
                            icon: const Icon(
                                Icons.add_circle_outline,
                                size: 20),
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        'يوم',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                _SectionLabel('نوع الإرجاع'),
                const SizedBox(height: AppSpacing.sm),
                _RadioOption(
                  label: 'استبدال وإرجاع',
                  selected: returnType == 'both',
                  onTap: () => updatePolicy(type: 'both'),
                ),
                const SizedBox(height: AppSpacing.sm),
                _RadioOption(
                  label: 'استبدال فقط',
                  selected: returnType == 'exchange',
                  onTap: () => updatePolicy(type: 'exchange'),
                ),
                const SizedBox(height: AppSpacing.sm),
                _RadioOption(
                  label: 'إرجاع واسترداد فقط',
                  selected: returnType == 'refund',
                  onTap: () => updatePolicy(type: 'refund'),
                ),
                const SizedBox(height: AppSpacing.lg),
                _SectionLabel('تكلفة الإرجاع'),
                const SizedBox(height: AppSpacing.sm),
                _RadioOption(
                  label: 'مجاني',
                  selected: returnCost == 'free',
                  onTap: () => updatePolicy(cost: 'free'),
                ),
                const SizedBox(height: AppSpacing.sm),
                _RadioOption(
                  label: 'على حساب العميل',
                  selected: returnCost == 'customer',
                  onTap: () => updatePolicy(cost: 'customer'),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String label;
  final String desc;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.label,
    required this.desc,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
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
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RadioOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _RadioOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? AppColors.primary.withValues(alpha: 0.05)
          : Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected
                  ? AppColors.primary.withValues(alpha: 0.3)
                  : Colors.grey.shade200,
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
                    : Colors.grey.shade300,
              ),
              const Spacer(),
              Text(
                label,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight:
                      selected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
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
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
