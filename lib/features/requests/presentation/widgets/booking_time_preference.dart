import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/core/extensions/context_ext.dart';

/// Time preference section with radio options and day/period pickers.
class BookingTimePreference extends StatelessWidget {
  final String preferredTime;
  final ValueChanged<String> onTimeChanged;
  final String? specificDay;
  final ValueChanged<String> onDayChanged;
  final String? specificPeriod;
  final ValueChanged<String> onPeriodChanged;
  final TextEditingController otherTextController;

  const BookingTimePreference({
    super.key,
    required this.preferredTime,
    required this.onTimeChanged,
    required this.specificDay,
    required this.onDayChanged,
    required this.specificPeriod,
    required this.onPeriodChanged,
    required this.otherTextController,
  });

  static const _days = [
    'السبت', 'الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة',
  ];
  static const _periods = ['صباحاً', 'بعد الظهر', 'مساءً'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الوقت المفضل',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _TimeOption(
          value: 'any_week',
          label: 'أي يوم هذا الأسبوع',
          selected: preferredTime == 'any_week',
          onTap: () => onTimeChanged('any_week'),
        ),
        const SizedBox(height: AppSpacing.sm),
        _TimeOption(
          value: 'specific',
          label: 'يوم محدد',
          selected: preferredTime == 'specific',
          onTap: () => onTimeChanged('specific'),
        ),
        if (preferredTime == 'specific') ...[
          const SizedBox(height: AppSpacing.sm),
          Padding(
            padding:
                const EdgeInsetsDirectional.only(start: AppSpacing.lg),
            child: Column(
              children: [
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: _days.map((day) {
                    final selected = specificDay == day;
                    return InkWell(
                      onTap: () => onDayChanged(day),
                      borderRadius:
                          BorderRadius.circular(AppRadius.sm),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.primary
                              : context.colorScheme.surfaceContainerLow,
                          borderRadius:
                              BorderRadius.circular(AppRadius.sm),
                          border: Border.all(
                            color: selected
                                ? AppColors.primary
                                : context.colorScheme.outlineVariant,
                          ),
                        ),
                        child: Text(
                          day,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: selected
                                ? Colors.white
                                : context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: _periods.map((p) {
                    final selected = specificPeriod == p;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          end: p != _periods.last ? AppSpacing.sm : 0,
                        ),
                        child: InkWell(
                          onTap: () => onPeriodChanged(p),
                          borderRadius:
                              BorderRadius.circular(AppRadius.sm),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.sm,
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.primary
                                  : context.colorScheme.surfaceContainerLow,
                              borderRadius:
                                  BorderRadius.circular(AppRadius.sm),
                              border: Border.all(
                                color: selected
                                    ? AppColors.primary
                                    : context.colorScheme.outlineVariant,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              p,
                              style:
                                  theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: selected
                                    ? Colors.white
                                    : context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        _TimeOption(
          value: 'other',
          label: 'آخر',
          selected: preferredTime == 'other',
          onTap: () => onTimeChanged('other'),
        ),
        if (preferredTime == 'other') ...[
          const SizedBox(height: AppSpacing.sm),
          TextFormField(
            controller: otherTextController,
            maxLines: 2,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText: 'حدد الوقت المفضل...',
              hintStyle: theme.textTheme.bodySmall
                  ?.copyWith(color: context.colorScheme.onSurfaceVariant),
              filled: true,
              fillColor: context.colorScheme.surfaceContainerLow,
              border: OutlineInputBorder(
                borderRadius: AppRadius.cardInner,
                borderSide: BorderSide(color: context.colorScheme.outlineVariant),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: AppRadius.cardInner,
                borderSide: BorderSide(color: context.colorScheme.outlineVariant),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: AppRadius.cardInner,
                borderSide: BorderSide(color: AppColors.primary),
              ),
              contentPadding: const EdgeInsets.all(AppSpacing.md),
            ),
          ),
        ],
      ],
    );
  }
}

class _TimeOption extends StatelessWidget {
  final String value;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TimeOption({
    required this.value,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.cardInner,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.05)
              : context.colorScheme.surface,
          borderRadius: AppRadius.cardInner,
          border: Border.all(
            color: selected ? AppColors.primary : context.colorScheme.outlineVariant,
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: selected ? AppColors.primary : context.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
