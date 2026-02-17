import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/availability_data.dart';

// ═══════════════════════════════════════════════════════════════════
// Time Options (30-min steps 07:00–22:00)
// ═══════════════════════════════════════════════════════════════════

const timeOptions = [
  '07:00', '07:30', '08:00', '08:30', '09:00', '09:30',
  '10:00', '10:30', '11:00', '11:30', '12:00', '12:30',
  '13:00', '13:30', '14:00', '14:30', '15:00', '15:30',
  '16:00', '16:30', '17:00', '17:30', '18:00', '18:30',
  '19:00', '19:30', '20:00', '20:30', '21:00', '21:30', '22:00',
];

// ═══════════════════════════════════════════════════════════════════
// Day Schedule + Shift
// ═══════════════════════════════════════════════════════════════════

class DaySchedule {
  bool enabled;
  String start;
  String end;
  List<Shift> extraShifts;

  DaySchedule({
    required this.enabled,
    this.start = '09:00',
    this.end = '18:00',
    List<Shift>? extraShifts,
  }) : extraShifts = extraShifts ?? [];
}

class Shift {
  String start;
  String end;
  Shift(this.start, this.end);
}

// ═══════════════════════════════════════════════════════════════════
// Weekly Schedule Tab
// Matches Figma WeeklyScheduleTab pixel-for-pixel.
// ═══════════════════════════════════════════════════════════════════

class WeeklyScheduleTab extends StatelessWidget {
  final Map<String, DaySchedule> weekly;
  final String? expandedDay;
  final ValueChanged<String> onExpandDay;
  final VoidCallback onChanged;

  const WeeklyScheduleTab({
    super.key,
    required this.weekly,
    required this.expandedDay,
    required this.onExpandDay,
    required this.onChanged,
  });

  int get _enabledCount =>
      weekdays.where((d) => weekly[d.id]?.enabled ?? false).length;

  void _toggleDay(String dayId) {
    weekly[dayId]!.enabled = !weekly[dayId]!.enabled;
    onChanged();
  }

  void _updateHours(String dayId, String field, String value) {
    final ds = weekly[dayId]!;
    if (field == 'start') {
      ds.start = value;
    } else {
      ds.end = value;
    }
    onChanged();
  }

  void _copyToAll(String sourceDayId) {
    final source = weekly[sourceDayId]!;
    for (final d in weekdays) {
      if (d.id != sourceDayId && (weekly[d.id]?.enabled ?? false)) {
        weekly[d.id]!.start = source.start;
        weekly[d.id]!.end = source.end;
      }
    }
    onChanged();
  }

  void _addShift(String dayId) {
    weekly[dayId]!.extraShifts.add(Shift('17:00', '22:00'));
    onChanged();
  }

  void _removeShift(String dayId, int index) {
    weekly[dayId]!.extraShifts.removeAt(index);
    onChanged();
  }

  void _updateShift(String dayId, int index, String field, String value) {
    final shift = weekly[dayId]!.extraShifts[index];
    if (field == 'start') {
      shift.start = value;
    } else {
      shift.end = value;
    }
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Summary info box
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: const Color(0xFFBBDEFB)),
          ),
          child: Text(
            context.l10n.scheduleWorkDays,
            style: const TextStyle(fontSize: 11, color: AppColors.primary),
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Day cards
        for (final day in weekdays) ...[
          _dayCard(context, day),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }

  Widget _dayCard(
      BuildContext context, ({String id, String label, String short}) day) {
    final ds = weekly[day.id]!;
    final isExpanded = expandedDay == day.id;
    final shifts = ds.extraShifts;

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: context.colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Opacity(
        opacity: ds.enabled ? 1.0 : 0.6,
        child: Column(
          children: [
            // Day header
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  // Toggle
                  GestureDetector(
                    onTap: () => _toggleDay(day.id),
                    child: Container(
                      width: 40,
                      height: 22,
                      decoration: BoxDecoration(
                        color: ds.enabled
                            ? AppColors.primary
                            : AppColors.textHint,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: AnimatedAlign(
                        duration: const Duration(milliseconds: 150),
                        alignment: ds.enabled
                            ? AlignmentDirectional.centerEnd
                            : AlignmentDirectional.centerStart,
                        child: Container(
                          width: 18,
                          height: 18,
                          margin:
                              const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(9),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 2),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  // Day name + hours
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(day.label,
                            style: TextStyle(
                                fontSize: 14,
                                color: ds.enabled
                                    ? context.colorScheme.onSurface
                                    : AppColors.textHint)),
                        if (ds.enabled && shifts.isEmpty)
                          Text('${ds.start} — ${ds.end}',
                              style: const TextStyle(
                                  fontSize: 10, color: AppColors.textHint)),
                        if (ds.enabled && shifts.isNotEmpty)
                          Text(
                            '${ds.start}—${ds.end}'
                            '${shifts.map((s) => ' · ${s.start}—${s.end}').join()}',
                            style: const TextStyle(
                                fontSize: 10, color: AppColors.textHint),
                          ),
                        if (!ds.enabled)
                          Text(context.l10n.scheduleClosed,
                              style: const TextStyle(
                                  fontSize: 10, color: AppColors.textHint)),
                      ],
                    ),
                  ),
                  // Expand chevron
                  if (ds.enabled)
                    GestureDetector(
                      onTap: () => onExpandDay(day.id),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: AnimatedRotation(
                          turns: isExpanded ? 0.5 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: const Icon(Icons.expand_more,
                              size: 16, color: AppColors.textHint),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Expanded editor
            if (ds.enabled && isExpanded)
              _buildExpandedEditor(context, day.id, ds, shifts),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedEditor(BuildContext context, String dayId,
      DaySchedule ds, List<Shift> shifts) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        border: Border(
            top: BorderSide(color: context.colorScheme.outlineVariant)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Main shift
          Text(context.l10n.scheduleFirstShift,
              style: const TextStyle(fontSize: 10, color: AppColors.textHint)),
          const SizedBox(height: AppSpacing.sm),
          _timePickerRow(
            context,
            ds.start,
            ds.end,
            (v) => _updateHours(dayId, 'start', v),
            (v) => _updateHours(dayId, 'end', v),
          ),

          // Extra shifts
          for (int i = 0; i < shifts.length; i++) ...[
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                GestureDetector(
                  onTap: () => _removeShift(dayId, i),
                  child: const Icon(Icons.delete_outline,
                      size: 12, color: AppColors.error),
                ),
                const Spacer(),
                Text(context.l10n.scheduleExtraShift(i + 2),
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.textHint)),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            _timePickerRow(
              context,
              shifts[i].start,
              shifts[i].end,
              (v) => _updateShift(dayId, i, 'start', v),
              (v) => _updateShift(dayId, i, 'end', v),
            ),
          ],
          const SizedBox(height: AppSpacing.md),

          // Action buttons
          Row(
            children: [
              // Copy to all
              Expanded(
                child: GestureDetector(
                  onTap: () => _copyToAll(dayId),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.l10n.scheduleCopyToAll,
                            style: const TextStyle(
                                fontSize: 10, color: AppColors.primary)),
                        SizedBox(width: 4),
                        Icon(Icons.copy,
                            size: 12, color: AppColors.primary),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              // Add shift
              Expanded(
                child: GestureDetector(
                  onTap: () => _addShift(dayId),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.sm),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      border: Border.all(color: AppColors.textHint),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.l10n.scheduleAddShift,
                            style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.textSecondary)),
                        SizedBox(width: 4),
                        Icon(Icons.add,
                            size: 12, color: AppColors.textSecondary),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _timePickerRow(
    BuildContext context,
    String start,
    String end,
    ValueChanged<String> onStartChanged,
    ValueChanged<String> onEndChanged,
  ) {
    return Row(
      children: [
        Expanded(child: _timeDropdown(context, start, onStartChanged)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text('—', style: TextStyle(color: AppColors.textHint)),
        ),
        Expanded(child: _timeDropdown(context, end, onEndChanged)),
      ],
    );
  }

  Widget _timeDropdown(
      BuildContext context, String value, ValueChanged<String> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: timeOptions.contains(value) ? value : timeOptions.first,
          isExpanded: true,
          isDense: true,
          style: TextStyle(
              fontSize: 13, color: context.colorScheme.onSurface),
          icon: const Icon(Icons.expand_more,
              size: 14, color: AppColors.textHint),
          items: timeOptions
              .map((t) => DropdownMenuItem(
                    value: t,
                    child: Text(t,
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(fontSize: 13)),
                  ))
              .toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}
