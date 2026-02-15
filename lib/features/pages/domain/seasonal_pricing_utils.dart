import 'package:honak/features/pages/domain/entities/seasonal_pricing.dart';

// ─────────────────────────────────────────────────────────────
// Result types (plain Dart — internal calculation results)
// ─────────────────────────────────────────────────────────────

class NightPriceResult {
  final int baseCents;
  final int finalCents;
  final String? seasonName;
  final bool isWeekend;
  final String? holidayName;
  final int surchargePercent;
  final int discountPercent;
  final String? discountType; // 'early_bird' | 'last_minute'

  const NightPriceResult({
    required this.baseCents,
    required this.finalCents,
    this.seasonName,
    this.isWeekend = false,
    this.holidayName,
    this.surchargePercent = 0,
    this.discountPercent = 0,
    this.discountType,
  });

  int get savingsCents => baseCents - finalCents;
}

class StayTotalResult {
  final int totalCents;
  final List<NightPriceResult> nights;
  final int totalSavingsCents;

  const StayTotalResult({
    required this.totalCents,
    required this.nights,
    required this.totalSavingsCents,
  });
}

// ─────────────────────────────────────────────────────────────
// Season matching
// ─────────────────────────────────────────────────────────────

/// Whether [month]/[day] falls within a season's date range.
/// Handles year-wrap (e.g. Nov 1 → Feb 28).
bool isDateInSeason(int month, int day, SeasonRule season) {
  final start = season.startMonth * 100 + season.startDay;
  final end = season.endMonth * 100 + season.endDay;
  final current = month * 100 + day;

  if (start <= end) {
    // Normal range (e.g. Jun 1 → Sep 15)
    return current >= start && current <= end;
  } else {
    // Year-wrap range (e.g. Nov 1 → Feb 28)
    return current >= start || current <= end;
  }
}

/// Returns the first active season matching [date], or null.
SeasonRule? getSeasonForDate(DateTime date, List<SeasonRule> seasons) {
  for (final season in seasons) {
    if (season.active && isDateInSeason(date.month, date.day, season)) {
      return season;
    }
  }
  return null;
}

/// Convenience: get current season based on today.
SeasonRule? getCurrentSeason(List<SeasonRule> seasons) =>
    getSeasonForDate(DateTime.now(), seasons);

// ─────────────────────────────────────────────────────────────
// Holiday matching
// ─────────────────────────────────────────────────────────────

/// Returns the first active holiday matching [date], or null.
/// Holiday dates are in "MM-DD" format.
HolidaySurcharge? getHolidayForDate(
  DateTime date,
  List<HolidaySurcharge> holidays,
) {
  final monthDay =
      '${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  for (final holiday in holidays) {
    if (!holiday.active) continue;
    final start = holiday.startDate;
    final end = holiday.endDate;
    if (start.compareTo(end) <= 0) {
      if (monthDay.compareTo(start) >= 0 && monthDay.compareTo(end) <= 0) {
        return holiday;
      }
    } else {
      // Year-wrap holiday (unlikely but handled)
      if (monthDay.compareTo(start) >= 0 || monthDay.compareTo(end) <= 0) {
        return holiday;
      }
    }
  }
  return null;
}

// ─────────────────────────────────────────────────────────────
// Weekend detection (Jordan: Friday + Saturday)
// ─────────────────────────────────────────────────────────────

bool isJordanWeekend(DateTime date) =>
    date.weekday == DateTime.friday || date.weekday == DateTime.saturday;

// ─────────────────────────────────────────────────────────────
// Night price calculation
// ─────────────────────────────────────────────────────────────

/// Calculate the price for a single night.
///
/// Priority chain:
/// 1. Base price from season (weekday/weekend)
/// 2. +holiday surcharge %
/// 3. -last-minute OR -early-bird discount (mutually exclusive, last-minute wins)
NightPriceResult calculateNightPrice({
  required DateTime date,
  required SeasonalPricing pricing,
  int fallbackWeekdayCents = 0,
  int fallbackWeekendCents = 0,
  DateTime? bookingDate,
}) {
  final weekend = isJordanWeekend(date);
  final season = getSeasonForDate(date, pricing.seasons);

  // 1. Base price
  int baseCents;
  if (season != null) {
    baseCents = weekend ? season.weekendCents : season.weekdayCents;
  } else {
    baseCents = weekend ? fallbackWeekendCents : fallbackWeekdayCents;
  }

  int workingCents = baseCents;
  String? holidayName;
  int surchargePercent = 0;
  int discountPercent = 0;
  String? discountType;

  // 2. Holiday surcharge
  final holiday = getHolidayForDate(date, pricing.holidays);
  if (holiday != null) {
    holidayName = holiday.name;
    surchargePercent = holiday.surchargePercent;
    workingCents += (baseCents * surchargePercent / 100).round();
  }

  // 3. Discount (last-minute wins over early-bird)
  final now = bookingDate ?? DateTime.now();
  final daysUntil = date.difference(now).inDays;

  final lastMinute = pricing.lastMinute;
  final earlyBird = pricing.earlyBird;

  if (lastMinute != null &&
      lastMinute.active &&
      daysUntil <= lastMinute.daysAhead &&
      daysUntil >= 0) {
    discountPercent = lastMinute.discountPercent;
    discountType = 'last_minute';
    workingCents -= (workingCents * discountPercent / 100).round();
  } else if (earlyBird != null &&
      earlyBird.active &&
      daysUntil >= earlyBird.daysAhead) {
    discountPercent = earlyBird.discountPercent;
    discountType = 'early_bird';
    workingCents -= (workingCents * discountPercent / 100).round();
  }

  return NightPriceResult(
    baseCents: baseCents,
    finalCents: workingCents,
    seasonName: season?.name,
    isWeekend: weekend,
    holidayName: holidayName,
    surchargePercent: surchargePercent,
    discountPercent: discountPercent,
    discountType: discountType,
  );
}

/// Calculate total stay cost for a date range.
StayTotalResult calculateStayTotal({
  required DateTime checkIn,
  required DateTime checkOut,
  required SeasonalPricing pricing,
  int fallbackWeekdayCents = 0,
  int fallbackWeekendCents = 0,
  DateTime? bookingDate,
}) {
  final nights = <NightPriceResult>[];
  var current = checkIn;
  while (current.isBefore(checkOut)) {
    nights.add(calculateNightPrice(
      date: current,
      pricing: pricing,
      fallbackWeekdayCents: fallbackWeekdayCents,
      fallbackWeekendCents: fallbackWeekendCents,
      bookingDate: bookingDate,
    ));
    current = current.add(const Duration(days: 1));
  }

  final totalCents = nights.fold<int>(0, (sum, n) => sum + n.finalCents);
  final totalSavings = nights.fold<int>(0, (sum, n) => sum + n.savingsCents);

  return StayTotalResult(
    totalCents: totalCents,
    nights: nights,
    totalSavingsCents: totalSavings,
  );
}

// ─────────────────────────────────────────────────────────────
// Display helpers
// ─────────────────────────────────────────────────────────────

/// Format a season date range as "D MMM – D MMM" in Arabic.
String formatSeasonRange(SeasonRule season) {
  const months = [
    '',
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];
  return '${season.startDay} ${months[season.startMonth]} – ${season.endDay} ${months[season.endMonth]}';
}

/// Maps month (1-12) to a season color for the mini timeline.
/// Returns null for months not covered by any active season.
SeasonRule? getSeasonForMonth(int month, List<SeasonRule> seasons) {
  // Use the 15th of the month as representative day
  for (final season in seasons) {
    if (season.active && isDateInSeason(month, 15, season)) {
      return season;
    }
  }
  return null;
}
