import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/presentation/providers/settings_provider.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';

class CancellationPolicy extends ConsumerStatefulWidget {
  final VoidCallback onClose;

  const CancellationPolicy({super.key, required this.onClose});

  @override
  ConsumerState<CancellationPolicy> createState() =>
      _CancellationPolicyState();
}

class _CancellationPolicyState
    extends ConsumerState<CancellationPolicy> {
  final _feeAmountController = TextEditingController();
  bool _synced = false;

  @override
  void dispose() {
    _feeAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(pageSettingsProvider);
    final settings = settingsAsync.valueOrNull;
    if (settings == null) {
      return Column(
        children: [
          SubScreenAppBar(
            title: 'سياسة الإلغاء',
            onClose: widget.onClose,
          ),
          const Expanded(
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      );
    }

    if (!_synced) {
      _synced = true;
      _feeAmountController.text =
          settings.lateCancelFeeAmount > 0
              ? settings.lateCancelFeeAmount.toString()
              : '';
    }

    final cancelWindowHours = settings.cancelWindowHours.toDouble();
    final noShowAction = settings.noShowAction;
    final feeType = settings.lateCancelFeeType;

    return Column(
      children: [
        SubScreenAppBar(
          title: 'سياسة الإلغاء',
          onClose: widget.onClose,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              _SectionLabel('نافذة الإلغاء (ساعات)'),
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${cancelWindowHours.toInt()} ساعة',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          'يمكن للعميل الإلغاء قبل',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: cancelWindowHours,
                      min: 1,
                      max: 72,
                      divisions: 71,
                      activeColor: AppColors.primary,
                      onChanged: (v) {
                        ref
                            .read(pageSettingsProvider.notifier)
                            .updateCancellationPolicy(
                                windowHours: v.toInt());
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _SectionLabel('إجراء عدم الحضور'),
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: Colors.grey.shade200),
                ),
                child: DropdownButton<String>(
                  value: noShowAction,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(
                      value: 'warn',
                      child: Align(
                        alignment:
                            AlignmentDirectional.centerEnd,
                        child: Text('تحذير فقط'),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'block',
                      child: Align(
                        alignment:
                            AlignmentDirectional.centerEnd,
                        child: Text('حظر مؤقت'),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'fee',
                      child: Align(
                        alignment:
                            AlignmentDirectional.centerEnd,
                        child: Text('رسوم عدم حضور'),
                      ),
                    ),
                  ],
                  onChanged: (v) {
                    if (v != null) {
                      ref
                          .read(pageSettingsProvider.notifier)
                          .updateCancellationPolicy(
                              noShowAction: v);
                    }
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _SectionLabel('رسوم إلغاء متأخر'),
              const SizedBox(height: AppSpacing.sm),
              _FeeTypeOption(
                label: 'بدون رسوم',
                selected: feeType == 'none',
                onTap: () => ref
                    .read(pageSettingsProvider.notifier)
                    .updateCancellationPolicy(
                        feeType: 'none', feeAmount: 0),
              ),
              const SizedBox(height: AppSpacing.sm),
              _FeeTypeOption(
                label: 'مبلغ ثابت (دينار)',
                selected: feeType == 'fixed',
                onTap: () => ref
                    .read(pageSettingsProvider.notifier)
                    .updateCancellationPolicy(feeType: 'fixed'),
              ),
              const SizedBox(height: AppSpacing.sm),
              _FeeTypeOption(
                label: 'نسبة مئوية (%)',
                selected: feeType == 'percent',
                onTap: () => ref
                    .read(pageSettingsProvider.notifier)
                    .updateCancellationPolicy(
                        feeType: 'percent'),
              ),
              if (feeType != 'none') ...[
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: _feeAmountController,
                  textAlign: TextAlign.end,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: feeType == 'fixed'
                        ? 'المبلغ بالدينار'
                        : 'النسبة المئوية',
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade400,
                    ),
                    suffixText:
                        feeType == 'percent' ? '%' : 'د.أ',
                    isDense: true,
                    contentPadding:
                        const EdgeInsets.all(AppSpacing.md),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Colors.grey.shade200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Colors.grey.shade200),
                    ),
                  ),
                  onChanged: (v) {
                    final amount = int.tryParse(v) ?? 0;
                    ref
                        .read(pageSettingsProvider.notifier)
                        .updateCancellationPolicy(
                            feeAmount: amount);
                  },
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _FeeTypeOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FeeTypeOption({
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
                  fontWeight: selected
                      ? FontWeight.w500
                      : FontWeight.normal,
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
