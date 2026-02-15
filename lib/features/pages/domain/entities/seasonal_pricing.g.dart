// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seasonal_pricing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SeasonRuleImpl _$$SeasonRuleImplFromJson(Map<String, dynamic> json) =>
    _$SeasonRuleImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String? ?? 'calendar_today',
      startMonth: (json['start_month'] as num).toInt(),
      startDay: (json['start_day'] as num).toInt(),
      endMonth: (json['end_month'] as num).toInt(),
      endDay: (json['end_day'] as num).toInt(),
      weekdayCents: (json['weekday_cents'] as num).toInt(),
      weekendCents: (json['weekend_cents'] as num).toInt(),
      currency: json['currency'] as String? ?? 'JOD',
      active: json['active'] as bool? ?? true,
      color: json['color'] as String? ?? '#1A73E8',
    );

Map<String, dynamic> _$$SeasonRuleImplToJson(_$SeasonRuleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'start_month': instance.startMonth,
      'start_day': instance.startDay,
      'end_month': instance.endMonth,
      'end_day': instance.endDay,
      'weekday_cents': instance.weekdayCents,
      'weekend_cents': instance.weekendCents,
      'currency': instance.currency,
      'active': instance.active,
      'color': instance.color,
    };

_$HolidaySurchargeImpl _$$HolidaySurchargeImplFromJson(
  Map<String, dynamic> json,
) => _$HolidaySurchargeImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  startDate: json['start_date'] as String,
  endDate: json['end_date'] as String,
  surchargePercent: (json['surcharge_percent'] as num).toInt(),
  active: json['active'] as bool? ?? true,
);

Map<String, dynamic> _$$HolidaySurchargeImplToJson(
  _$HolidaySurchargeImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'start_date': instance.startDate,
  'end_date': instance.endDate,
  'surcharge_percent': instance.surchargePercent,
  'active': instance.active,
};

_$EarlyBirdDiscountImpl _$$EarlyBirdDiscountImplFromJson(
  Map<String, dynamic> json,
) => _$EarlyBirdDiscountImpl(
  daysAhead: (json['days_ahead'] as num?)?.toInt() ?? 14,
  discountPercent: (json['discount_percent'] as num?)?.toInt() ?? 10,
  active: json['active'] as bool? ?? false,
);

Map<String, dynamic> _$$EarlyBirdDiscountImplToJson(
  _$EarlyBirdDiscountImpl instance,
) => <String, dynamic>{
  'days_ahead': instance.daysAhead,
  'discount_percent': instance.discountPercent,
  'active': instance.active,
};

_$LastMinuteDealImpl _$$LastMinuteDealImplFromJson(Map<String, dynamic> json) =>
    _$LastMinuteDealImpl(
      hoursBeforeCheckin: (json['hours_before_checkin'] as num?)?.toInt() ?? 48,
      daysAhead: (json['days_ahead'] as num?)?.toInt() ?? 2,
      discountPercent: (json['discount_percent'] as num?)?.toInt() ?? 20,
      active: json['active'] as bool? ?? false,
      label: json['label'] as String? ?? 'عرض اللحظة الأخيرة',
    );

Map<String, dynamic> _$$LastMinuteDealImplToJson(
  _$LastMinuteDealImpl instance,
) => <String, dynamic>{
  'hours_before_checkin': instance.hoursBeforeCheckin,
  'days_ahead': instance.daysAhead,
  'discount_percent': instance.discountPercent,
  'active': instance.active,
  'label': instance.label,
};

_$SeasonalPricingImpl _$$SeasonalPricingImplFromJson(
  Map<String, dynamic> json,
) => _$SeasonalPricingImpl(
  seasons:
      (json['seasons'] as List<dynamic>?)
          ?.map((e) => SeasonRule.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  holidays:
      (json['holidays'] as List<dynamic>?)
          ?.map((e) => HolidaySurcharge.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  earlyBird: json['early_bird'] == null
      ? null
      : EarlyBirdDiscount.fromJson(json['early_bird'] as Map<String, dynamic>),
  lastMinute: json['last_minute'] == null
      ? null
      : LastMinuteDeal.fromJson(json['last_minute'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$SeasonalPricingImplToJson(
  _$SeasonalPricingImpl instance,
) => <String, dynamic>{
  'seasons': instance.seasons,
  'holidays': instance.holidays,
  'early_bird': instance.earlyBird,
  'last_minute': instance.lastMinute,
};
