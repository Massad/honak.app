// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_hours.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TimeShift _$TimeShiftFromJson(Map<String, dynamic> json) {
  return _TimeShift.fromJson(json);
}

/// @nodoc
mixin _$TimeShift {
  String get open => throw _privateConstructorUsedError;
  String get close => throw _privateConstructorUsedError;

  /// Serializes this TimeShift to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimeShift
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeShiftCopyWith<TimeShift> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeShiftCopyWith<$Res> {
  factory $TimeShiftCopyWith(TimeShift value, $Res Function(TimeShift) then) =
      _$TimeShiftCopyWithImpl<$Res, TimeShift>;
  @useResult
  $Res call({String open, String close});
}

/// @nodoc
class _$TimeShiftCopyWithImpl<$Res, $Val extends TimeShift>
    implements $TimeShiftCopyWith<$Res> {
  _$TimeShiftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeShift
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? open = null, Object? close = null}) {
    return _then(
      _value.copyWith(
            open: null == open
                ? _value.open
                : open // ignore: cast_nullable_to_non_nullable
                      as String,
            close: null == close
                ? _value.close
                : close // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimeShiftImplCopyWith<$Res>
    implements $TimeShiftCopyWith<$Res> {
  factory _$$TimeShiftImplCopyWith(
    _$TimeShiftImpl value,
    $Res Function(_$TimeShiftImpl) then,
  ) = __$$TimeShiftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String open, String close});
}

/// @nodoc
class __$$TimeShiftImplCopyWithImpl<$Res>
    extends _$TimeShiftCopyWithImpl<$Res, _$TimeShiftImpl>
    implements _$$TimeShiftImplCopyWith<$Res> {
  __$$TimeShiftImplCopyWithImpl(
    _$TimeShiftImpl _value,
    $Res Function(_$TimeShiftImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimeShift
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? open = null, Object? close = null}) {
    return _then(
      _$TimeShiftImpl(
        open: null == open
            ? _value.open
            : open // ignore: cast_nullable_to_non_nullable
                  as String,
        close: null == close
            ? _value.close
            : close // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeShiftImpl implements _TimeShift {
  const _$TimeShiftImpl({required this.open, required this.close});

  factory _$TimeShiftImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeShiftImplFromJson(json);

  @override
  final String open;
  @override
  final String close;

  @override
  String toString() {
    return 'TimeShift(open: $open, close: $close)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeShiftImpl &&
            (identical(other.open, open) || other.open == open) &&
            (identical(other.close, close) || other.close == close));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, open, close);

  /// Create a copy of TimeShift
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeShiftImplCopyWith<_$TimeShiftImpl> get copyWith =>
      __$$TimeShiftImplCopyWithImpl<_$TimeShiftImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeShiftImplToJson(this);
  }
}

abstract class _TimeShift implements TimeShift {
  const factory _TimeShift({
    required final String open,
    required final String close,
  }) = _$TimeShiftImpl;

  factory _TimeShift.fromJson(Map<String, dynamic> json) =
      _$TimeShiftImpl.fromJson;

  @override
  String get open;
  @override
  String get close;

  /// Create a copy of TimeShift
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeShiftImplCopyWith<_$TimeShiftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BlockedDate _$BlockedDateFromJson(Map<String, dynamic> json) {
  return _BlockedDate.fromJson(json);
}

/// @nodoc
mixin _$BlockedDate {
  String get date => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;

  /// Serializes this BlockedDate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BlockedDate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BlockedDateCopyWith<BlockedDate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlockedDateCopyWith<$Res> {
  factory $BlockedDateCopyWith(
    BlockedDate value,
    $Res Function(BlockedDate) then,
  ) = _$BlockedDateCopyWithImpl<$Res, BlockedDate>;
  @useResult
  $Res call({String date, String? reason});
}

/// @nodoc
class _$BlockedDateCopyWithImpl<$Res, $Val extends BlockedDate>
    implements $BlockedDateCopyWith<$Res> {
  _$BlockedDateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BlockedDate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? reason = freezed}) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BlockedDateImplCopyWith<$Res>
    implements $BlockedDateCopyWith<$Res> {
  factory _$$BlockedDateImplCopyWith(
    _$BlockedDateImpl value,
    $Res Function(_$BlockedDateImpl) then,
  ) = __$$BlockedDateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, String? reason});
}

/// @nodoc
class __$$BlockedDateImplCopyWithImpl<$Res>
    extends _$BlockedDateCopyWithImpl<$Res, _$BlockedDateImpl>
    implements _$$BlockedDateImplCopyWith<$Res> {
  __$$BlockedDateImplCopyWithImpl(
    _$BlockedDateImpl _value,
    $Res Function(_$BlockedDateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BlockedDate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? reason = freezed}) {
    return _then(
      _$BlockedDateImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BlockedDateImpl implements _BlockedDate {
  const _$BlockedDateImpl({required this.date, this.reason});

  factory _$BlockedDateImpl.fromJson(Map<String, dynamic> json) =>
      _$$BlockedDateImplFromJson(json);

  @override
  final String date;
  @override
  final String? reason;

  @override
  String toString() {
    return 'BlockedDate(date: $date, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockedDateImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, reason);

  /// Create a copy of BlockedDate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockedDateImplCopyWith<_$BlockedDateImpl> get copyWith =>
      __$$BlockedDateImplCopyWithImpl<_$BlockedDateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BlockedDateImplToJson(this);
  }
}

abstract class _BlockedDate implements BlockedDate {
  const factory _BlockedDate({
    required final String date,
    final String? reason,
  }) = _$BlockedDateImpl;

  factory _BlockedDate.fromJson(Map<String, dynamic> json) =
      _$BlockedDateImpl.fromJson;

  @override
  String get date;
  @override
  String? get reason;

  /// Create a copy of BlockedDate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlockedDateImplCopyWith<_$BlockedDateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BusinessHours _$BusinessHoursFromJson(Map<String, dynamic> json) {
  return _BusinessHours.fromJson(json);
}

/// @nodoc
mixin _$BusinessHours {
  String get day => throw _privateConstructorUsedError;
  bool get open => throw _privateConstructorUsedError;
  List<TimeShift> get shifts => throw _privateConstructorUsedError;

  /// Serializes this BusinessHours to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusinessHours
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessHoursCopyWith<BusinessHours> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessHoursCopyWith<$Res> {
  factory $BusinessHoursCopyWith(
    BusinessHours value,
    $Res Function(BusinessHours) then,
  ) = _$BusinessHoursCopyWithImpl<$Res, BusinessHours>;
  @useResult
  $Res call({String day, bool open, List<TimeShift> shifts});
}

/// @nodoc
class _$BusinessHoursCopyWithImpl<$Res, $Val extends BusinessHours>
    implements $BusinessHoursCopyWith<$Res> {
  _$BusinessHoursCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessHours
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? day = null, Object? open = null, Object? shifts = null}) {
    return _then(
      _value.copyWith(
            day: null == day
                ? _value.day
                : day // ignore: cast_nullable_to_non_nullable
                      as String,
            open: null == open
                ? _value.open
                : open // ignore: cast_nullable_to_non_nullable
                      as bool,
            shifts: null == shifts
                ? _value.shifts
                : shifts // ignore: cast_nullable_to_non_nullable
                      as List<TimeShift>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BusinessHoursImplCopyWith<$Res>
    implements $BusinessHoursCopyWith<$Res> {
  factory _$$BusinessHoursImplCopyWith(
    _$BusinessHoursImpl value,
    $Res Function(_$BusinessHoursImpl) then,
  ) = __$$BusinessHoursImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String day, bool open, List<TimeShift> shifts});
}

/// @nodoc
class __$$BusinessHoursImplCopyWithImpl<$Res>
    extends _$BusinessHoursCopyWithImpl<$Res, _$BusinessHoursImpl>
    implements _$$BusinessHoursImplCopyWith<$Res> {
  __$$BusinessHoursImplCopyWithImpl(
    _$BusinessHoursImpl _value,
    $Res Function(_$BusinessHoursImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusinessHours
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? day = null, Object? open = null, Object? shifts = null}) {
    return _then(
      _$BusinessHoursImpl(
        day: null == day
            ? _value.day
            : day // ignore: cast_nullable_to_non_nullable
                  as String,
        open: null == open
            ? _value.open
            : open // ignore: cast_nullable_to_non_nullable
                  as bool,
        shifts: null == shifts
            ? _value._shifts
            : shifts // ignore: cast_nullable_to_non_nullable
                  as List<TimeShift>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessHoursImpl extends _BusinessHours {
  const _$BusinessHoursImpl({
    required this.day,
    this.open = true,
    final List<TimeShift> shifts = const [],
  }) : _shifts = shifts,
       super._();

  factory _$BusinessHoursImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessHoursImplFromJson(json);

  @override
  final String day;
  @override
  @JsonKey()
  final bool open;
  final List<TimeShift> _shifts;
  @override
  @JsonKey()
  List<TimeShift> get shifts {
    if (_shifts is EqualUnmodifiableListView) return _shifts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shifts);
  }

  @override
  String toString() {
    return 'BusinessHours(day: $day, open: $open, shifts: $shifts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessHoursImpl &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.open, open) || other.open == open) &&
            const DeepCollectionEquality().equals(other._shifts, _shifts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    day,
    open,
    const DeepCollectionEquality().hash(_shifts),
  );

  /// Create a copy of BusinessHours
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessHoursImplCopyWith<_$BusinessHoursImpl> get copyWith =>
      __$$BusinessHoursImplCopyWithImpl<_$BusinessHoursImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessHoursImplToJson(this);
  }
}

abstract class _BusinessHours extends BusinessHours {
  const factory _BusinessHours({
    required final String day,
    final bool open,
    final List<TimeShift> shifts,
  }) = _$BusinessHoursImpl;
  const _BusinessHours._() : super._();

  factory _BusinessHours.fromJson(Map<String, dynamic> json) =
      _$BusinessHoursImpl.fromJson;

  @override
  String get day;
  @override
  bool get open;
  @override
  List<TimeShift> get shifts;

  /// Create a copy of BusinessHours
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessHoursImplCopyWith<_$BusinessHoursImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
