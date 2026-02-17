import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/seasonal_pricing.dart';
import 'package:honak/shared/entities/money.dart';

// ═══════════════════════════════════════════════════════════════════
// Holidays Content
// ═══════════════════════════════════════════════════════════════════

class VillaHolidaysContent extends StatelessWidget {
  final List<HolidaySurcharge> holidays;
  final ValueChanged<int> onToggle;

  const VillaHolidaysContent({
    super.key,
    required this.holidays,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < holidays.length; i++) ...[
          _buildCard(context, holidays[i], i),
          const SizedBox(height: AppSpacing.sm),
        ],
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Text(
            context.l10n.villaHolidaySurchargeInfo,
            style: TextStyle(fontSize: 9, color: Color(0xFFB45309)),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, HolidaySurcharge h, int index) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: h.active
            ? AppColors.secondary.withValues(alpha: 0.04) : null,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: h.active
            ? AppColors.secondary.withValues(alpha: 0.2)
            : context.colorScheme.outlineVariant),
      ),
      child: Opacity(
        opacity: h.active ? 1.0 : 0.5,
        child: Row(
          children: [
            seasonalToggle(h.active, () => onToggle(index),
                color: AppColors.secondary),
            const SizedBox(width: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: h.active ? AppColors.secondary : AppColors.divider,
                borderRadius: AppRadius.pill,
              ),
              child: Text('+${h.surchargePercent}٪', style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w600,
                  color: h.active ? Colors.white : AppColors.textSecondary)),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(h.name, style: TextStyle(fontSize: 12,
                    color: context.colorScheme.onSurface)),
                Text('${h.startDate} — ${h.endDate}', style: const TextStyle(
                    fontSize: 9, color: AppColors.textHint)),
              ],
            ),
            const SizedBox(width: AppSpacing.sm),
            Icon(Icons.star, size: 14,
                color: h.active ? AppColors.secondary : AppColors.textHint),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// Discount Content (shared for Early Bird + Last Minute)
// ═══════════════════════════════════════════════════════════════════

class VillaDiscountContent extends StatelessWidget {
  final bool active;
  final int daysAhead;
  final int discountPercent;
  final Color color;
  final String toggleLabel;
  final List<int> dayOptions;
  final String infoText;
  final VoidCallback onToggleActive;
  final ValueChanged<int> onDaysChanged;
  final ValueChanged<int> onPercentChanged;

  const VillaDiscountContent({
    super.key,
    required this.active,
    required this.daysAhead,
    required this.discountPercent,
    required this.color,
    required this.toggleLabel,
    required this.dayOptions,
    required this.infoText,
    required this.onToggleActive,
    required this.onDaysChanged,
    required this.onPercentChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        seasonalToggleRow(toggleLabel, active, onToggleActive, color),
        if (active) ...[
          const SizedBox(height: AppSpacing.md),
          seasonalChipPicker(context.l10n.villaBookingBefore, dayOptions,
              daysAhead, color, onDaysChanged, suffix: context.l10n.villaDay),
          const SizedBox(height: AppSpacing.md),
          seasonalChipPicker(context.l10n.villaDiscountPercent, [5, 10, 15, 20],
              discountPercent, color, onPercentChanged, suffix: '٪'),
          const SizedBox(height: AppSpacing.md),
          seasonalInfoBox(color, infoText),
        ],
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// Shared Helper Widgets
// ═══════════════════════════════════════════════════════════════════

Widget seasonalToggle(bool value, VoidCallback onTap, {Color? color}) {
  final c = color ?? AppColors.success;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 32, height: 18,
      decoration: BoxDecoration(
        color: value ? c : AppColors.textHint,
        borderRadius: BorderRadius.circular(9),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 150),
        alignment: value ? AlignmentDirectional.centerEnd
            : AlignmentDirectional.centerStart,
        child: Container(
          width: 14, height: 14,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [BoxShadow(
                color: Colors.black.withValues(alpha: 0.1), blurRadius: 2)],
          ),
        ),
      ),
    ),
  );
}

Widget seasonalToggleRow(
    String label, bool value, VoidCallback onTap, Color color) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      seasonalToggle(value, onTap, color: color),
      Text(label, style: const TextStyle(
          fontSize: 12, color: AppColors.textSecondary)),
    ],
  );
}

Widget seasonalChipPicker(String label, List<int> values, int selected,
    Color activeColor, ValueChanged<int> onSelected, {String suffix = ''}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(label, style: const TextStyle(
          fontSize: 10, color: AppColors.textHint)),
      const SizedBox(height: AppSpacing.xs),
      Row(
        children: values.map((v) {
          final isActive = v == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelected(v),
              child: Container(
                margin: EdgeInsetsDirectional.only(
                    start: v == values.first ? 0 : AppSpacing.sm),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: isActive ? activeColor : AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                alignment: Alignment.center,
                child: Text('$v $suffix'.trim(), style: TextStyle(
                  fontSize: 12,
                  color: isActive ? Colors.white : AppColors.textSecondary,
                )),
              ),
            ),
          );
        }).toList(),
      ),
    ],
  );
}

Widget seasonalInfoBox(Color color, String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(AppRadius.sm),
    ),
    child: Text(text, style: TextStyle(fontSize: 9,
        color: color.withValues(alpha: 0.8)),
        textAlign: TextAlign.right),
  );
}

Widget seasonalPriceBox(BuildContext context, String label, int cents) {
  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md, vertical: AppSpacing.sm),
    decoration: BoxDecoration(
      color: AppColors.surfaceVariant,
      borderRadius: BorderRadius.circular(AppRadius.sm),
    ),
    child: Column(
      children: [
        Text(label, style: const TextStyle(
            fontSize: 9, color: AppColors.textHint)),
        Text('${Money(cents).toJodString()} د.أ', style: TextStyle(
            fontSize: 14, color: context.colorScheme.onSurface)),
      ],
    ),
  );
}

Widget seasonalEditInput(BuildContext context, String label,
    TextEditingController ctrl, ValueChanged<String> onChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(label, style: const TextStyle(
          fontSize: 9, color: AppColors.textHint)),
      const SizedBox(height: AppSpacing.xs),
      TextField(
        controller: ctrl,
        textAlign: TextAlign.center,
        textDirection: Directionality.of(context),
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 13),
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true, fillColor: context.colorScheme.surface,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            borderSide: BorderSide(
                color: context.colorScheme.outlineVariant)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            borderSide: BorderSide(
                color: context.colorScheme.outlineVariant)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            borderSide: const BorderSide(color: AppColors.primary)),
          isDense: true,
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════
// Utilities
// ═══════════════════════════════════════════════════════════════════

Color parseSeasonColor(String hex) {
  try {
    final clean = hex.replaceFirst('#', '');
    return Color(int.parse('FF$clean', radix: 16));
  } catch (_) {
    return Colors.blue;
  }
}

IconData seasonIcon(String icon) {
  switch (icon) {
    case 'sun' || 'wb_sunny': return Icons.wb_sunny;
    case 'snowflake' || 'ac_unit': return Icons.ac_unit;
    case 'tree' || 'local_florist' || 'park': return Icons.park;
    case 'waves': return Icons.waves;
    case 'star': return Icons.star;
    default: return Icons.calendar_today;
  }
}

// ═══════════════════════════════════════════════════════════════════
// Default Data
// ═══════════════════════════════════════════════════════════════════

const defaultSeasons = <SeasonRule>[
  SeasonRule(id: 'summer', name: 'الصيف (ذروة)', icon: 'sun',
      startMonth: 6, startDay: 1, endMonth: 9, endDay: 15,
      weekdayCents: 25000, weekendCents: 35000, color: '#FF9800'),
  SeasonRule(id: 'winter', name: 'الشتاء', icon: 'snowflake',
      startMonth: 11, startDay: 1, endMonth: 2, endDay: 28,
      weekdayCents: 15000, weekendCents: 20000, color: '#1A73E8'),
  SeasonRule(id: 'spring', name: 'الربيع', icon: 'tree',
      startMonth: 3, startDay: 1, endMonth: 5, endDay: 31,
      weekdayCents: 18000, weekendCents: 28000, color: '#43A047'),
  SeasonRule(id: 'autumn', name: 'الخريف', icon: 'waves',
      startMonth: 9, startDay: 16, endMonth: 10, endDay: 31,
      weekdayCents: 17000, weekendCents: 25000, active: false,
      color: '#9C27B0'),
];

const defaultHolidays = <HolidaySurcharge>[
  HolidaySurcharge(id: 'eid-fitr', name: 'عيد الفطر',
      startDate: '04-10', endDate: '04-13', surchargePercent: 30),
  HolidaySurcharge(id: 'eid-adha', name: 'عيد الأضحى',
      startDate: '06-16', endDate: '06-19', surchargePercent: 30),
  HolidaySurcharge(id: 'new-year', name: 'رأس السنة',
      startDate: '12-30', endDate: '01-02', surchargePercent: 25),
  HolidaySurcharge(id: 'independence', name: 'عيد الاستقلال',
      startDate: '05-25', endDate: '05-25', surchargePercent: 15,
      active: false),
];
