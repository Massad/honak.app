import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_hours.freezed.dart';
part 'business_hours.g.dart';

@freezed
class TimeShift with _$TimeShift {
  const factory TimeShift({
    required String open,
    required String close,
  }) = _TimeShift;

  factory TimeShift.fromJson(Map<String, dynamic> json) =>
      _$TimeShiftFromJson(json);
}

@freezed
class BlockedDate with _$BlockedDate {
  const factory BlockedDate({
    required String date,
    String? reason,
  }) = _BlockedDate;

  factory BlockedDate.fromJson(Map<String, dynamic> json) =>
      _$BlockedDateFromJson(json);
}

@freezed
class BusinessHours with _$BusinessHours {
  const BusinessHours._();

  const factory BusinessHours({
    required String day,
    @Default(true) bool open,
    @Default([]) List<TimeShift> shifts,
  }) = _BusinessHours;

  factory BusinessHours.fromJson(Map<String, dynamic> json) =>
      _$BusinessHoursFromJson(json);

  /// First shift open time (backward compat).
  String? get openTime => shifts.isNotEmpty ? shifts.first.open : null;

  /// First shift close time (backward compat).
  String? get closeTime => shifts.isNotEmpty ? shifts.first.close : null;
}
