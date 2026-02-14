import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_wizard/presentation/providers/wizard_provider.dart';

class HoursStep extends ConsumerStatefulWidget {
  const HoursStep({super.key});

  @override
  ConsumerState<HoursStep> createState() => _HoursStepState();
}

class _HoursStepState extends ConsumerState<HoursStep> {
  late final TextEditingController _customController;

  @override
  void initState() {
    super.initState();
    _customController =
        TextEditingController(text: ref.read(wizardProvider).customHours);
  }

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(wizardProvider);
    final notifier = ref.read(wizardProvider.notifier);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ساعات العمل',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          _HoursOption(
            label: '\u0669 \u0635 \u2014 \u0665 \u0645 (\u0623\u064a\u0627\u0645 \u0627\u0644\u0639\u0645\u0644)',
            value: 'weekdays',
            selected: state.hoursPreset == 'weekdays',
            onTap: () => notifier.setHoursPreset('weekdays'),
          ),
          const SizedBox(height: AppSpacing.md),

          _HoursOption(
            label: '\u0662\u0664 \u0633\u0627\u0639\u0629 / \u0667 \u0623\u064a\u0627\u0645',
            value: '247',
            selected: state.hoursPreset == '247',
            onTap: () => notifier.setHoursPreset('247'),
          ),
          const SizedBox(height: AppSpacing.md),

          _HoursOption(
            label: '\u0645\u062e\u0635\u0635',
            value: 'custom',
            selected: state.hoursPreset == 'custom',
            onTap: () => notifier.setHoursPreset('custom'),
          ),

          if (state.hoursPreset == 'custom') ...[
            const SizedBox(height: AppSpacing.lg),
            TextFormField(
              controller: _customController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText:
                    '\u0645\u062b\u0627\u0644: \u0627\u0644\u0633\u0628\u062a-\u0627\u0644\u062e\u0645\u064a\u0633 \u0669\u0635-\u0669\u0645\u060c \u0627\u0644\u062c\u0645\u0639\u0629 \u0645\u063a\u0644\u0642',
                border: OutlineInputBorder(borderRadius: AppRadius.button),
                contentPadding: const EdgeInsets.all(AppSpacing.md),
              ),
              onChanged: notifier.setCustomHours,
            ),
          ],
        ],
      ),
    );
  }
}

class _HoursOption extends StatelessWidget {
  final String label;
  final String value;
  final bool selected;
  final VoidCallback onTap;

  const _HoursOption({
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.cardInner,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withAlpha(15) : null,
          borderRadius: AppRadius.cardInner,
          border: Border.all(
            color: selected ? AppColors.primary : context.colorScheme.outlineVariant,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.primary : context.colorScheme.onSurface,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
