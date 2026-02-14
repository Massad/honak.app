import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/business_hours.dart';
import 'package:honak/features/business/page_settings/presentation/providers/hours_provider.dart';

/// Tab 1: Weekly schedule with split shifts.
class ScheduleTab extends ConsumerWidget {
  const ScheduleTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoursAsync = ref.watch(hoursProvider);

    return hoursAsync.when(
      data: (hours) => _HoursList(hours: hours),
      loading: () => const _ScheduleSkeleton(),
      error: (_, __) => Center(
        child: Text(
          'تعذر تحميل الجدول',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ),
    );
  }
}

class _HoursList extends ConsumerWidget {
  final List<BusinessHours> hours;

  const _HoursList({required this.hours});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        for (var i = 0; i < hours.length; i++) ...[
          _DayRow(
            hours: hours[i],
            onToggle: (open) {
              ref
                  .read(hoursProvider.notifier)
                  .toggleDay(hours[i].day, open);
            },
            onAddShift: () {
              ref.read(hoursProvider.notifier).addShift(
                    hours[i].day,
                    const TimeShift(open: '09:00', close: '17:00'),
                  );
            },
            onRemoveShift: (index) {
              ref
                  .read(hoursProvider.notifier)
                  .removeShift(hours[i].day, index);
            },
          ),
          if (i < hours.length - 1)
            Divider(height: 1, color: Theme.of(context).colorScheme.outlineVariant),
        ],
      ],
    );
  }
}

class _DayRow extends StatelessWidget {
  final BusinessHours hours;
  final ValueChanged<bool> onToggle;
  final VoidCallback onAddShift;
  final ValueChanged<int> onRemoveShift;

  const _DayRow({
    required this.hours,
    required this.onToggle,
    required this.onAddShift,
    required this.onRemoveShift,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Switch(
                value: hours.open,
                onChanged: onToggle,
                activeThumbColor: AppColors.primary,
              ),
              if (!hours.open)
                Text(
                  'مغلق',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              const Spacer(),
              Text(
                hours.day,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          if (hours.open) ...[
            for (var i = 0; i < hours.shifts.length; i++)
              Padding(
                padding:
                    const EdgeInsets.only(top: 4, right: 48),
                child: Row(
                  children: [
                    if (hours.shifts.length > 1)
                      InkWell(
                        onTap: () => onRemoveShift(i),
                        child: Icon(
                          Icons.remove_circle_outline,
                          size: 16,
                          color: AppColors.error,
                        ),
                      ),
                    const SizedBox(width: 4),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        '${hours.shifts[i].open} - ${hours.shifts[i].close}',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'وردية ${i + 1}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 4, right: 48),
              child: InkWell(
                onTap: onAddShift,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'إضافة وردية',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ScheduleSkeleton extends StatelessWidget {
  const _ScheduleSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: List.generate(7, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.shimmerBase,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }),
    );
  }
}
