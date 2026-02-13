import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/presentation/widgets/reservation_steps.dart';

/// Date step: check-in/out dates, optional space selector, night count badge,
/// and time selection (FG6).
class ReservationDateStep extends StatelessWidget {
  final bool isVillaType;
  final List<Map<String, dynamic>> spaces;
  final String? activeSpaceId;
  final ValueChanged<String?> onSpaceChanged;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final ValueChanged<DateTime> onCheckInPicked;
  final ValueChanged<DateTime> onCheckOutPicked;
  final String? checkInTime;
  final String? checkOutTime;
  final VoidCallback onPickCheckInTime;
  final VoidCallback onPickCheckOutTime;

  const ReservationDateStep({
    super.key,
    required this.isVillaType,
    required this.spaces,
    required this.activeSpaceId,
    required this.onSpaceChanged,
    required this.checkIn,
    required this.checkOut,
    required this.onCheckInPicked,
    required this.onCheckOutPicked,
    this.checkInTime,
    this.checkOutTime,
    required this.onPickCheckInTime,
    required this.onPickCheckOutTime,
  });

  int? get _nightCount {
    if (checkIn == null || checkOut == null) return null;
    return checkOut!.difference(checkIn!).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Space selector (venues only)
        if (!isVillaType && spaces.isNotEmpty) ...[
          Text(
            'القاعة / المساحة',
            style: theme.textTheme.labelSmall
                ?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.sm),
          ...spaces.map((space) {
            final id = space['id']?.toString();
            final selected = activeSpaceId == id;
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: InkWell(
                onTap: () => onSpaceChanged(id),
                borderRadius: AppRadius.cardInner,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primary.withValues(alpha: 0.05)
                        : Colors.white,
                    borderRadius: AppRadius.cardInner,
                    border: Border.all(
                      color: selected ? AppColors.primary : AppColors.divider,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            space['name'] as String? ?? '',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: selected ? AppColors.primary : null,
                            ),
                          ),
                          if (space['capacity'] != null) ...[
                            const SizedBox(height: AppSpacing.xxs),
                            Row(
                              children: [
                                Icon(Icons.people,
                                    size: 10, color: AppColors.textHint),
                                const SizedBox(width: AppSpacing.xxs),
                                Text(
                                  'سعة ${space['capacity']}',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: AppColors.textHint,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                      if (space['price_from'] != null)
                        Text(
                          'من ${space['price_from']} د.أ',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: selected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: AppSpacing.lg),
        ],
        // Date range picker
        Text(
          'تاريخ ووقت الحجز',
          style: theme.textTheme.labelSmall
              ?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),
        _DateRow(label: 'الوصول', date: checkIn, onPick: onCheckInPicked),
        const SizedBox(height: AppSpacing.sm),
        _DateRow(label: 'المغادرة', date: checkOut, onPick: onCheckOutPicked),
        // FG6: Time selection
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _TimeChip(
                label: 'وقت الوصول',
                value: checkInTime,
                onTap: onPickCheckInTime,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _TimeChip(
                label: 'وقت المغادرة',
                value: checkOutTime,
                onTap: onPickCheckOutTime,
              ),
            ),
          ],
        ),
        // Night count badge
        if (_nightCount != null && _nightCount! > 0) ...[
          const SizedBox(height: AppSpacing.md),
          NightCountBadge(nightCount: _nightCount!),
        ],
      ],
    );
  }
}

class _DateRow extends StatelessWidget {
  final String label;
  final DateTime? date;
  final ValueChanged<DateTime> onPick;

  const _DateRow({
    required this.label,
    required this.date,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          locale: const Locale('ar'),
        );
        if (picked != null) onPick(picked);
      },
      borderRadius: AppRadius.cardInner,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: AppRadius.cardInner,
          border: Border.all(
            color: date != null ? AppColors.primary : AppColors.divider,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today,
                size: 14,
                color: date != null ? AppColors.primary : AppColors.textHint),
            const SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: theme.textTheme.labelSmall
                  ?.copyWith(color: AppColors.textHint),
            ),
            const Spacer(),
            Text(
              date != null
                  ? '${date!.day}/${date!.month}/${date!.year}'
                  : 'اختر التاريخ',
              style: theme.textTheme.bodySmall?.copyWith(
                color: date != null ? null : AppColors.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeChip extends StatelessWidget {
  final String label;
  final String? value;
  final VoidCallback onTap;

  const _TimeChip({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: AppRadius.cardInner,
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Icon(Icons.access_time,
                size: 14, color: AppColors.textSecondary),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                value ?? label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: value != null
                      ? AppColors.textPrimary
                      : AppColors.textHint,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
