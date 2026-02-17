import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/l10n/arb/app_localizations.dart';

/// Weekly calendar view showing bookings by day.
/// Only for service_booking and reservation archetypes.
class BookingCalendar extends StatelessWidget {
  const BookingCalendar({super.key});

  // Mock booking data: count per day
  static const _counts = [8, 5, 3, 6, 4, 7, 2];
  static const _maxCount = 8;

  static List<String> _dayNames(AppLocalizations l10n) => [
        l10n.insightsDaySat,
        l10n.insightsDaySun,
        l10n.insightsDayMon,
        l10n.insightsDayTue,
        l10n.insightsDayWed,
        l10n.insightsDayThu,
        l10n.insightsDayFri,
      ];

  @override
  Widget build(BuildContext context) {
    final days = _dayNames(context.l10n);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: const [
          BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 1)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.insightsBookingSchedule,
            style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 12),
          // Week navigator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.chevron_right, size: 20, color: Color(0xFF9CA3AF)),
              Text(
                context.l10n.insightsCurrentWeek,
                style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
              const Icon(Icons.chevron_left, size: 20, color: Color(0xFF9CA3AF)),
            ],
          ),
          const SizedBox(height: 12),
          // 7-column grid
          Row(
            children: List.generate(7, (i) {
              final intensity = _maxCount > 0 ? _counts[i] / _maxCount : 0.0;
              return Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: i > 0 ? 4 : 0,
                  ),
                  child: Column(
                    children: [
                      Text(
                        days[i],
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color.lerp(
                            const Color(0xFFEFF6FF),
                            const Color(0xFF1A73E8),
                            intensity,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${_counts[i]}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: intensity > 0.5
                                  ? Colors.white
                                  : const Color(0xFF1A73E8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
