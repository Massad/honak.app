// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_hours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeShiftImpl _$$TimeShiftImplFromJson(Map<String, dynamic> json) =>
    _$TimeShiftImpl(
      open: json['open'] as String,
      close: json['close'] as String,
    );

Map<String, dynamic> _$$TimeShiftImplToJson(_$TimeShiftImpl instance) =>
    <String, dynamic>{'open': instance.open, 'close': instance.close};

_$BlockedDateImpl _$$BlockedDateImplFromJson(Map<String, dynamic> json) =>
    _$BlockedDateImpl(
      date: json['date'] as String,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$$BlockedDateImplToJson(_$BlockedDateImpl instance) =>
    <String, dynamic>{'date': instance.date, 'reason': instance.reason};

_$BusinessHoursImpl _$$BusinessHoursImplFromJson(Map<String, dynamic> json) =>
    _$BusinessHoursImpl(
      day: json['day'] as String,
      open: json['open'] as bool? ?? true,
      shifts:
          (json['shifts'] as List<dynamic>?)
              ?.map((e) => TimeShift.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$BusinessHoursImplToJson(_$BusinessHoursImpl instance) =>
    <String, dynamic>{
      'day': instance.day,
      'open': instance.open,
      'shifts': instance.shifts,
    };
