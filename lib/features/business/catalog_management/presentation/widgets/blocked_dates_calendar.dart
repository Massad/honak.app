import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/availability_data.dart';

// ═══════════════════════════════════════════════════════════════════
// Mini Blocked Calendar — view-only month grid with colored blocks
// Matches Figma MiniBlockedCalendar pixel-for-pixel.
// ═══════════════════════════════════════════════════════════════════

class MiniBlockedCalendar extends StatelessWidget {
  final DateTime month;
  final List<BlockedDate> blocks;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const MiniBlockedCalendar({
    super.key,
    required this.month,
    required this.blocks,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final firstDayOffset =
        satFirstIndex(DateTime(month.year, month.month, 1).weekday);
    final today = DateTime.now();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
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
      child: Column(
        children: [
          // View-only label
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.l10n.blockViewBlockedDates,
                  style: const TextStyle(fontSize: 9, color: AppColors.textHint)),
              const SizedBox(width: 6),
              const Icon(Icons.calendar_today, size: 12, color: AppColors.textHint),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Month navigation — RTL: first child on RIGHT = PREV
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onPrev,
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.chevron_right, size: 16,
                      color: AppColors.textHint),
                ),
              ),
              Text('${arabicMonths[month.month - 1]} ${month.year}',
                  style: TextStyle(
                      fontSize: 14,
                      color: context.colorScheme.onSurface)),
              GestureDetector(
                onTap: onNext,
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.chevron_left, size: 16,
                      color: AppColors.textHint),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Weekday headers (Saturday-first)
          Row(
            children: weekdays.map((d) {
              return Expanded(
                child: Center(
                  child: Text(d.short,
                      style: const TextStyle(
                          fontSize: 9, color: AppColors.textHint)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 4),

          // Day grid
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            children: [
              for (int i = 0; i < firstDayOffset; i++)
                const SizedBox(height: 28),
              for (int day = 1; day <= daysInMonth; day++)
                _dayCell(context, day, today),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Legend
          Container(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            decoration: const BoxDecoration(
              border:
                  Border(top: BorderSide(color: AppColors.surfaceVariant)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _legendDot(const Color(0xFF7B1FA2), context.l10n.blockLegendRange),
                const SizedBox(width: AppSpacing.md),
                _legendDot(AppColors.error, context.l10n.blockLegendSpecific),
                const SizedBox(width: AppSpacing.md),
                _legendDot(AppColors.secondary, context.l10n.blockLegendWeekly),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dayCell(BuildContext context, int day, DateTime today) {
    final blockType =
        isDateBlocked(month.year, month.month, day, blocks);
    final isToday = month.year == today.year &&
        month.month == today.month &&
        day == today.day;

    Color? bg;
    Color textColor = AppColors.textSecondary;
    if (blockType != null) {
      bg = blockBg[blockType];
      textColor = blockColors[blockType]!;
    }

    return Container(
      height: 28,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border:
            isToday ? Border.all(color: AppColors.primary, width: 1) : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text('$day', style: TextStyle(fontSize: 10, color: textColor)),
          if (blockType != null)
            Positioned(
              bottom: 2,
              child: Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: blockColors[blockType],
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      children: [
        Text(label,
            style: const TextStyle(fontSize: 9, color: AppColors.textHint)),
        const SizedBox(width: 4),
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ],
    );
  }
}
