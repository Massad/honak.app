import 'dart:math';

import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Step 2: Date & time selection.
class DateTimeStepContent extends StatelessWidget {
  final int durationMinutes;
  final DateTime? selectedDate;
  final String? selectedTime;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<String> onTimeSelected;

  const DateTimeStepContent({
    super.key,
    required this.durationMinutes,
    required this.selectedDate,
    required this.selectedTime,
    required this.onDateSelected,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      children: [
        Text(
          // \u0627\u062e\u062a\u0631 \u0627\u0644\u062a\u0627\u0631\u064a\u062e = "Choose date"
          '\u0627\u062e\u062a\u0631 \u0627\u0644\u062a\u0627\u0631\u064a\u062e',
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _HorizontalDatePicker(
          selectedDate: selectedDate,
          onSelected: onDateSelected,
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          // \u0627\u062e\u062a\u0631 \u0627\u0644\u0648\u0642\u062a = "Choose time"
          '\u0627\u062e\u062a\u0631 \u0627\u0644\u0648\u0642\u062a',
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        if (selectedDate != null)
          _TimeSlotGrid(
            durationMinutes: durationMinutes,
            selectedTime: selectedTime,
            onSelected: onTimeSelected,
            seedDate: selectedDate!,
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
            child: Center(
              child: Text(
                // \u0627\u062e\u062a\u0631 \u062a\u0627\u0631\u064a\u062e\u0627\u064b \u0623\u0648\u0644\u0627\u064b
                '\u0627\u062e\u062a\u0631 \u062a\u0627\u0631\u064a\u062e\u0627\u064b \u0623\u0648\u0644\u0627\u064b',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Horizontal date picker strip (14 days starting from tomorrow)
// ---------------------------------------------------------------------------

class _HorizontalDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onSelected;

  const _HorizontalDatePicker({
    required this.selectedDate,
    required this.onSelected,
  });

  // Arabic day abbreviations: Mon..Sun
  static const _dayLetters = [
    '\u0646', // Mon
    '\u062b', // Tue
    '\u0631', // Wed
    '\u062e', // Thu
    '\u062c', // Fri
    '\u0633', // Sat
    '\u062d', // Sun
  ];

  @override
  Widget build(BuildContext context) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final dates = List.generate(
      14,
      (i) => DateTime(tomorrow.year, tomorrow.month, tomorrow.day + i),
    );

    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected = selectedDate != null &&
              selectedDate!.year == date.year &&
              selectedDate!.month == date.month &&
              selectedDate!.day == date.day;

          return _DateChip(
            dayLetter: _dayLetters[date.weekday - 1],
            dayNumber: date.day,
            isSelected: isSelected,
            onTap: () => onSelected(date),
          );
        },
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  final String dayLetter;
  final int dayNumber;
  final bool isSelected;
  final VoidCallback onTap;

  const _DateChip({
    required this.dayLetter,
    required this.dayNumber,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? context.colorScheme.primary
          : context.colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 48,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dayLetter,
                style: context.textTheme.labelSmall?.copyWith(
                  color: isSelected
                      ? context.colorScheme.onPrimary
                      : context.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                '$dayNumber',
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? context.colorScheme.onPrimary
                      : context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Time slot grid
// ---------------------------------------------------------------------------

class _TimeSlotGrid extends StatelessWidget {
  final int durationMinutes;
  final String? selectedTime;
  final ValueChanged<String> onSelected;
  final DateTime seedDate;

  const _TimeSlotGrid({
    required this.durationMinutes,
    required this.selectedTime,
    required this.onSelected,
    required this.seedDate,
  });

  List<String> _generateSlots() {
    final step = durationMinutes >= 60 ? 60 : 30;
    final slots = <String>[];
    for (var hour = 9; hour < 21; hour++) {
      for (var min = 0; min < 60; min += step) {
        if (hour * 60 + min + step > 21 * 60) break;
        final h = hour.toString().padLeft(2, '0');
        final m = min.toString().padLeft(2, '0');
        slots.add('$h:$m');
      }
    }
    return slots;
  }

  Set<String> _bookedSlots(List<String> slots) {
    // Deterministic "booked" slots seeded by date for demo.
    final rng = Random(seedDate.day * 7 + seedDate.month);
    final count = 2 + rng.nextInt(2);
    final booked = <String>{};
    while (booked.length < count && booked.length < slots.length) {
      booked.add(slots[rng.nextInt(slots.length)]);
    }
    return booked;
  }

  @override
  Widget build(BuildContext context) {
    final slots = _generateSlots();
    final booked = _bookedSlots(slots);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: AppSpacing.sm,
        crossAxisSpacing: AppSpacing.sm,
        childAspectRatio: 2.2,
      ),
      itemCount: slots.length,
      itemBuilder: (context, index) {
        final slot = slots[index];
        final isBooked = booked.contains(slot);
        final isSelected = slot == selectedTime;

        return _TimeChip(
          time: slot,
          isSelected: isSelected,
          isBooked: isBooked,
          onTap: isBooked ? null : () => onSelected(slot),
        );
      },
    );
  }
}

class _TimeChip extends StatelessWidget {
  final String time;
  final bool isSelected;
  final bool isBooked;
  final VoidCallback? onTap;

  const _TimeChip({
    required this.time,
    required this.isSelected,
    required this.isBooked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color fgColor;
    if (isBooked) {
      bgColor = context.colorScheme.surfaceContainerHighest;
      fgColor = context.colorScheme.onSurfaceVariant.withValues(alpha: 0.4);
    } else if (isSelected) {
      bgColor = context.colorScheme.primary;
      fgColor = context.colorScheme.onPrimary;
    } else {
      bgColor = context.colorScheme.surfaceContainerLow;
      fgColor = context.colorScheme.onSurface;
    }

    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Center(
          child: Text(
            time,
            style: context.textTheme.bodySmall?.copyWith(
              color: fgColor,
              fontWeight: isSelected ? FontWeight.bold : null,
              decoration: isBooked ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ),
    );
  }
}
