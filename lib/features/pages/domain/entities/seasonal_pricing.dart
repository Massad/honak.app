import 'package:freezed_annotation/freezed_annotation.dart';

part 'seasonal_pricing.freezed.dart';
part 'seasonal_pricing.g.dart';

/// A named pricing season with date range and per-night rates.
@freezed
class SeasonRule with _$SeasonRule {
  const factory SeasonRule({
    required String id,
    required String name,
    @Default('calendar_today') String icon,
    @JsonKey(name: 'start_month') required int startMonth,
    @JsonKey(name: 'start_day') required int startDay,
    @JsonKey(name: 'end_month') required int endMonth,
    @JsonKey(name: 'end_day') required int endDay,
    @JsonKey(name: 'weekday_cents') required int weekdayCents,
    @JsonKey(name: 'weekend_cents') required int weekendCents,
    @Default('JOD') String currency,
    @Default(true) bool active,
    @Default('#1A73E8') String color,
  }) = _SeasonRule;

  factory SeasonRule.fromJson(Map<String, dynamic> json) =>
      _$SeasonRuleFromJson(json);
}

/// A holiday surcharge applied on top of the season base price.
@freezed
class HolidaySurcharge with _$HolidaySurcharge {
  const factory HolidaySurcharge({
    required String id,
    required String name,
    @JsonKey(name: 'start_date') required String startDate,
    @JsonKey(name: 'end_date') required String endDate,
    @JsonKey(name: 'surcharge_percent') required int surchargePercent,
    @Default(true) bool active,
  }) = _HolidaySurcharge;

  factory HolidaySurcharge.fromJson(Map<String, dynamic> json) =>
      _$HolidaySurchargeFromJson(json);
}

/// Discount for booking well in advance.
@freezed
class EarlyBirdDiscount with _$EarlyBirdDiscount {
  const factory EarlyBirdDiscount({
    @JsonKey(name: 'days_ahead') @Default(14) int daysAhead,
    @JsonKey(name: 'discount_percent') @Default(10) int discountPercent,
    @Default(false) bool active,
  }) = _EarlyBirdDiscount;

  factory EarlyBirdDiscount.fromJson(Map<String, dynamic> json) =>
      _$EarlyBirdDiscountFromJson(json);
}

/// Last-minute deal for upcoming unbooked dates.
@freezed
class LastMinuteDeal with _$LastMinuteDeal {
  const factory LastMinuteDeal({
    @JsonKey(name: 'hours_before_checkin') @Default(48) int hoursBeforeCheckin,
    @JsonKey(name: 'days_ahead') @Default(2) int daysAhead,
    @JsonKey(name: 'discount_percent') @Default(20) int discountPercent,
    @Default(false) bool active,
    @Default('عرض اللحظة الأخيرة') String label,
  }) = _LastMinuteDeal;

  factory LastMinuteDeal.fromJson(Map<String, dynamic> json) =>
      _$LastMinuteDealFromJson(json);
}

/// Top-level wrapper for all seasonal pricing config on a page.
@freezed
class SeasonalPricing with _$SeasonalPricing {
  const factory SeasonalPricing({
    @Default([]) List<SeasonRule> seasons,
    @Default([]) List<HolidaySurcharge> holidays,
    @JsonKey(name: 'early_bird') EarlyBirdDiscount? earlyBird,
    @JsonKey(name: 'last_minute') LastMinuteDeal? lastMinute,
  }) = _SeasonalPricing;

  factory SeasonalPricing.fromJson(Map<String, dynamic> json) =>
      _$SeasonalPricingFromJson(json);
}
