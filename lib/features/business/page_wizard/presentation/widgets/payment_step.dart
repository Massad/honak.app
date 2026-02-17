import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_wizard/presentation/providers/wizard_provider.dart';

class _PaymentOption {
  final int index;
  final IconData icon;
  final String title;
  final String subtitle;

  const _PaymentOption({
    required this.index,
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

const _paymentOptions = [
  _PaymentOption(
    index: 0,
    icon: Icons.payments_outlined,
    title: '\u0646\u0642\u062f\u0627\u064b',
    subtitle: '\u0627\u0644\u062f\u0641\u0639 \u0639\u0646\u062f \u0627\u0644\u0627\u0633\u062a\u0644\u0627\u0645 \u0623\u0648 \u0627\u0644\u062a\u0633\u0644\u064a\u0645',
  ),
  _PaymentOption(
    index: 1,
    icon: Icons.qr_code,
    title: '\u0643\u0644\u064a\u0643 (CLiq)',
    subtitle: '\u0623\u0636\u0641 \u0627\u0633\u0645 \u0627\u0644\u0645\u0633\u062a\u062e\u062f\u0645 \u0627\u0644\u062e\u0627\u0635 \u0628\u0643',
  ),
  _PaymentOption(
    index: 2,
    icon: Icons.account_balance_outlined,
    title: '\u062a\u062d\u0648\u064a\u0644 \u0628\u0646\u0643\u064a',
    subtitle: '\u0633\u064a\u062a\u0645 \u0639\u0631\u0636 \u0645\u0639\u0644\u0648\u0645\u0627\u062a \u0627\u0644\u062a\u062d\u0648\u064a\u0644 \u0644\u0644\u0639\u0645\u064a\u0644',
  ),
  _PaymentOption(
    index: 3,
    icon: Icons.phone_android_outlined,
    title: '\u0645\u062d\u0641\u0638\u0629 \u0625\u0644\u0643\u062a\u0631\u0648\u0646\u064a\u0629',
    subtitle: '\u0632\u064a\u0646 \u0643\u0627\u0634\u060c \u0623\u0648\u0631\u0646\u062c \u0645\u0648\u0646\u064a',
  ),
];

class PaymentStep extends ConsumerStatefulWidget {
  const PaymentStep({super.key});

  @override
  ConsumerState<PaymentStep> createState() => _PaymentStepState();
}

class _PaymentStepState extends ConsumerState<PaymentStep> {
  late final TextEditingController _cliqController;

  @override
  void initState() {
    super.initState();
    _cliqController =
        TextEditingController(text: ref.read(wizardProvider).cliqAlias);
  }

  @override
  void dispose() {
    _cliqController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(wizardProvider);
    final notifier = ref.read(wizardProvider.notifier);
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      children: [
        Text(
          '\u0637\u0631\u0642 \u0627\u0644\u062f\u0641\u0639',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          '\u0627\u062e\u062a\u0631 \u0637\u0631\u0642 \u0627\u0644\u062f\u0641\u0639 \u0627\u0644\u062a\u064a \u062a\u0642\u0628\u0644\u0647\u0627',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),

        ..._paymentOptions.map((option) {
          final isSelected = state.selectedPayments.contains(option.index);
          return Column(
            children: [
              _PaymentTile(
                option: option,
                selected: isSelected,
                onTap: () => notifier.togglePayment(option.index),
              ),
              // CLiq alias input
              if (option.index == 1 && isSelected) ...[
                const SizedBox(height: AppSpacing.sm),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: AppSpacing.huge),
                  child: Directionality(
                    textDirection: Directionality.of(context),
                    child: TextFormField(
                      controller: _cliqController,
                      textDirection: Directionality.of(context),
                      decoration: InputDecoration(
                        hintText: 'CLiq alias',
                        border:
                            OutlineInputBorder(borderRadius: AppRadius.button),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.md,
                        ),
                        isDense: true,
                      ),
                      onChanged: notifier.setCliqAlias,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
            ],
          );
        }),
      ],
    );
  }
}

class _PaymentTile extends StatelessWidget {
  final _PaymentOption option;
  final bool selected;
  final VoidCallback onTap;

  const _PaymentTile({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.cardInner,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withAlpha(15) : null,
          borderRadius: AppRadius.cardInner,
          border: Border.all(
            color: selected ? AppColors.primary : context.colorScheme.outlineVariant,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.check_box : Icons.check_box_outline_blank,
              color: selected ? AppColors.primary : context.colorScheme.onSurfaceVariant,
              size: 22,
            ),
            const SizedBox(width: AppSpacing.md),
            Icon(
              option.icon,
              color: selected ? AppColors.primary : context.colorScheme.onSurfaceVariant,
              size: 22,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: selected ? AppColors.primary : context.colorScheme.onSurface,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    option.subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
