// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_sub_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PageHours _$PageHoursFromJson(Map<String, dynamic> json) {
  return _PageHours.fromJson(json);
}

/// @nodoc
mixin _$PageHours {
  @JsonKey(name: 'open_time')
  String? get openTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'close_time')
  String? get closeTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'open_days')
  List<String> get openDays => throw _privateConstructorUsedError;

  /// Serializes this PageHours to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PageHours
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PageHoursCopyWith<PageHours> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageHoursCopyWith<$Res> {
  factory $PageHoursCopyWith(PageHours value, $Res Function(PageHours) then) =
      _$PageHoursCopyWithImpl<$Res, PageHours>;
  @useResult
  $Res call({
    @JsonKey(name: 'open_time') String? openTime,
    @JsonKey(name: 'close_time') String? closeTime,
    @JsonKey(name: 'open_days') List<String> openDays,
  });
}

/// @nodoc
class _$PageHoursCopyWithImpl<$Res, $Val extends PageHours>
    implements $PageHoursCopyWith<$Res> {
  _$PageHoursCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PageHours
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? openTime = freezed,
    Object? closeTime = freezed,
    Object? openDays = null,
  }) {
    return _then(
      _value.copyWith(
            openTime: freezed == openTime
                ? _value.openTime
                : openTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            closeTime: freezed == closeTime
                ? _value.closeTime
                : closeTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            openDays: null == openDays
                ? _value.openDays
                : openDays // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PageHoursImplCopyWith<$Res>
    implements $PageHoursCopyWith<$Res> {
  factory _$$PageHoursImplCopyWith(
    _$PageHoursImpl value,
    $Res Function(_$PageHoursImpl) then,
  ) = __$$PageHoursImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'open_time') String? openTime,
    @JsonKey(name: 'close_time') String? closeTime,
    @JsonKey(name: 'open_days') List<String> openDays,
  });
}

/// @nodoc
class __$$PageHoursImplCopyWithImpl<$Res>
    extends _$PageHoursCopyWithImpl<$Res, _$PageHoursImpl>
    implements _$$PageHoursImplCopyWith<$Res> {
  __$$PageHoursImplCopyWithImpl(
    _$PageHoursImpl _value,
    $Res Function(_$PageHoursImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PageHours
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? openTime = freezed,
    Object? closeTime = freezed,
    Object? openDays = null,
  }) {
    return _then(
      _$PageHoursImpl(
        openTime: freezed == openTime
            ? _value.openTime
            : openTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        closeTime: freezed == closeTime
            ? _value.closeTime
            : closeTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        openDays: null == openDays
            ? _value._openDays
            : openDays // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PageHoursImpl implements _PageHours {
  const _$PageHoursImpl({
    @JsonKey(name: 'open_time') this.openTime,
    @JsonKey(name: 'close_time') this.closeTime,
    @JsonKey(name: 'open_days') final List<String> openDays = const [],
  }) : _openDays = openDays;

  factory _$PageHoursImpl.fromJson(Map<String, dynamic> json) =>
      _$$PageHoursImplFromJson(json);

  @override
  @JsonKey(name: 'open_time')
  final String? openTime;
  @override
  @JsonKey(name: 'close_time')
  final String? closeTime;
  final List<String> _openDays;
  @override
  @JsonKey(name: 'open_days')
  List<String> get openDays {
    if (_openDays is EqualUnmodifiableListView) return _openDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_openDays);
  }

  @override
  String toString() {
    return 'PageHours(openTime: $openTime, closeTime: $closeTime, openDays: $openDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PageHoursImpl &&
            (identical(other.openTime, openTime) ||
                other.openTime == openTime) &&
            (identical(other.closeTime, closeTime) ||
                other.closeTime == closeTime) &&
            const DeepCollectionEquality().equals(other._openDays, _openDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    openTime,
    closeTime,
    const DeepCollectionEquality().hash(_openDays),
  );

  /// Create a copy of PageHours
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PageHoursImplCopyWith<_$PageHoursImpl> get copyWith =>
      __$$PageHoursImplCopyWithImpl<_$PageHoursImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PageHoursImplToJson(this);
  }
}

abstract class _PageHours implements PageHours {
  const factory _PageHours({
    @JsonKey(name: 'open_time') final String? openTime,
    @JsonKey(name: 'close_time') final String? closeTime,
    @JsonKey(name: 'open_days') final List<String> openDays,
  }) = _$PageHoursImpl;

  factory _PageHours.fromJson(Map<String, dynamic> json) =
      _$PageHoursImpl.fromJson;

  @override
  @JsonKey(name: 'open_time')
  String? get openTime;
  @override
  @JsonKey(name: 'close_time')
  String? get closeTime;
  @override
  @JsonKey(name: 'open_days')
  List<String> get openDays;

  /// Create a copy of PageHours
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PageHoursImplCopyWith<_$PageHoursImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TemporarilyClosed _$TemporarilyClosedFromJson(Map<String, dynamic> json) {
  return _TemporarilyClosed.fromJson(json);
}

/// @nodoc
mixin _$TemporarilyClosed {
  String? get reason => throw _privateConstructorUsedError;
  @JsonKey(name: 'reopen_date')
  String? get reopenDate => throw _privateConstructorUsedError;

  /// Serializes this TemporarilyClosed to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TemporarilyClosed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TemporarilyClosedCopyWith<TemporarilyClosed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TemporarilyClosedCopyWith<$Res> {
  factory $TemporarilyClosedCopyWith(
    TemporarilyClosed value,
    $Res Function(TemporarilyClosed) then,
  ) = _$TemporarilyClosedCopyWithImpl<$Res, TemporarilyClosed>;
  @useResult
  $Res call({String? reason, @JsonKey(name: 'reopen_date') String? reopenDate});
}

/// @nodoc
class _$TemporarilyClosedCopyWithImpl<$Res, $Val extends TemporarilyClosed>
    implements $TemporarilyClosedCopyWith<$Res> {
  _$TemporarilyClosedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TemporarilyClosed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? reason = freezed, Object? reopenDate = freezed}) {
    return _then(
      _value.copyWith(
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
            reopenDate: freezed == reopenDate
                ? _value.reopenDate
                : reopenDate // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TemporarilyClosedImplCopyWith<$Res>
    implements $TemporarilyClosedCopyWith<$Res> {
  factory _$$TemporarilyClosedImplCopyWith(
    _$TemporarilyClosedImpl value,
    $Res Function(_$TemporarilyClosedImpl) then,
  ) = __$$TemporarilyClosedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? reason, @JsonKey(name: 'reopen_date') String? reopenDate});
}

/// @nodoc
class __$$TemporarilyClosedImplCopyWithImpl<$Res>
    extends _$TemporarilyClosedCopyWithImpl<$Res, _$TemporarilyClosedImpl>
    implements _$$TemporarilyClosedImplCopyWith<$Res> {
  __$$TemporarilyClosedImplCopyWithImpl(
    _$TemporarilyClosedImpl _value,
    $Res Function(_$TemporarilyClosedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TemporarilyClosed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? reason = freezed, Object? reopenDate = freezed}) {
    return _then(
      _$TemporarilyClosedImpl(
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
        reopenDate: freezed == reopenDate
            ? _value.reopenDate
            : reopenDate // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TemporarilyClosedImpl implements _TemporarilyClosed {
  const _$TemporarilyClosedImpl({
    this.reason,
    @JsonKey(name: 'reopen_date') this.reopenDate,
  });

  factory _$TemporarilyClosedImpl.fromJson(Map<String, dynamic> json) =>
      _$$TemporarilyClosedImplFromJson(json);

  @override
  final String? reason;
  @override
  @JsonKey(name: 'reopen_date')
  final String? reopenDate;

  @override
  String toString() {
    return 'TemporarilyClosed(reason: $reason, reopenDate: $reopenDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TemporarilyClosedImpl &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.reopenDate, reopenDate) ||
                other.reopenDate == reopenDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, reason, reopenDate);

  /// Create a copy of TemporarilyClosed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TemporarilyClosedImplCopyWith<_$TemporarilyClosedImpl> get copyWith =>
      __$$TemporarilyClosedImplCopyWithImpl<_$TemporarilyClosedImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TemporarilyClosedImplToJson(this);
  }
}

abstract class _TemporarilyClosed implements TemporarilyClosed {
  const factory _TemporarilyClosed({
    final String? reason,
    @JsonKey(name: 'reopen_date') final String? reopenDate,
  }) = _$TemporarilyClosedImpl;

  factory _TemporarilyClosed.fromJson(Map<String, dynamic> json) =
      _$TemporarilyClosedImpl.fromJson;

  @override
  String? get reason;
  @override
  @JsonKey(name: 'reopen_date')
  String? get reopenDate;

  /// Create a copy of TemporarilyClosed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TemporarilyClosedImplCopyWith<_$TemporarilyClosedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Relocated _$RelocatedFromJson(Map<String, dynamic> json) {
  return _Relocated.fromJson(json);
}

/// @nodoc
mixin _$Relocated {
  @JsonKey(name: 'new_address')
  String? get newAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'map_url')
  String? get mapUrl => throw _privateConstructorUsedError;

  /// Serializes this Relocated to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Relocated
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RelocatedCopyWith<Relocated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RelocatedCopyWith<$Res> {
  factory $RelocatedCopyWith(Relocated value, $Res Function(Relocated) then) =
      _$RelocatedCopyWithImpl<$Res, Relocated>;
  @useResult
  $Res call({
    @JsonKey(name: 'new_address') String? newAddress,
    @JsonKey(name: 'map_url') String? mapUrl,
  });
}

/// @nodoc
class _$RelocatedCopyWithImpl<$Res, $Val extends Relocated>
    implements $RelocatedCopyWith<$Res> {
  _$RelocatedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Relocated
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? newAddress = freezed, Object? mapUrl = freezed}) {
    return _then(
      _value.copyWith(
            newAddress: freezed == newAddress
                ? _value.newAddress
                : newAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            mapUrl: freezed == mapUrl
                ? _value.mapUrl
                : mapUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RelocatedImplCopyWith<$Res>
    implements $RelocatedCopyWith<$Res> {
  factory _$$RelocatedImplCopyWith(
    _$RelocatedImpl value,
    $Res Function(_$RelocatedImpl) then,
  ) = __$$RelocatedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'new_address') String? newAddress,
    @JsonKey(name: 'map_url') String? mapUrl,
  });
}

/// @nodoc
class __$$RelocatedImplCopyWithImpl<$Res>
    extends _$RelocatedCopyWithImpl<$Res, _$RelocatedImpl>
    implements _$$RelocatedImplCopyWith<$Res> {
  __$$RelocatedImplCopyWithImpl(
    _$RelocatedImpl _value,
    $Res Function(_$RelocatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Relocated
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? newAddress = freezed, Object? mapUrl = freezed}) {
    return _then(
      _$RelocatedImpl(
        newAddress: freezed == newAddress
            ? _value.newAddress
            : newAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        mapUrl: freezed == mapUrl
            ? _value.mapUrl
            : mapUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RelocatedImpl implements _Relocated {
  const _$RelocatedImpl({
    @JsonKey(name: 'new_address') this.newAddress,
    @JsonKey(name: 'map_url') this.mapUrl,
  });

  factory _$RelocatedImpl.fromJson(Map<String, dynamic> json) =>
      _$$RelocatedImplFromJson(json);

  @override
  @JsonKey(name: 'new_address')
  final String? newAddress;
  @override
  @JsonKey(name: 'map_url')
  final String? mapUrl;

  @override
  String toString() {
    return 'Relocated(newAddress: $newAddress, mapUrl: $mapUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RelocatedImpl &&
            (identical(other.newAddress, newAddress) ||
                other.newAddress == newAddress) &&
            (identical(other.mapUrl, mapUrl) || other.mapUrl == mapUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, newAddress, mapUrl);

  /// Create a copy of Relocated
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RelocatedImplCopyWith<_$RelocatedImpl> get copyWith =>
      __$$RelocatedImplCopyWithImpl<_$RelocatedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RelocatedImplToJson(this);
  }
}

abstract class _Relocated implements Relocated {
  const factory _Relocated({
    @JsonKey(name: 'new_address') final String? newAddress,
    @JsonKey(name: 'map_url') final String? mapUrl,
  }) = _$RelocatedImpl;

  factory _Relocated.fromJson(Map<String, dynamic> json) =
      _$RelocatedImpl.fromJson;

  @override
  @JsonKey(name: 'new_address')
  String? get newAddress;
  @override
  @JsonKey(name: 'map_url')
  String? get mapUrl;

  /// Create a copy of Relocated
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RelocatedImplCopyWith<_$RelocatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Branch _$BranchFromJson(Map<String, dynamic> json) {
  return _Branch.fromJson(json);
}

/// @nodoc
mixin _$Branch {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get hours => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get neighborhood => throw _privateConstructorUsedError;
  List<String> get coverage => throw _privateConstructorUsedError;

  /// Serializes this Branch to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Branch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BranchCopyWith<Branch> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BranchCopyWith<$Res> {
  factory $BranchCopyWith(Branch value, $Res Function(Branch) then) =
      _$BranchCopyWithImpl<$Res, Branch>;
  @useResult
  $Res call({
    String id,
    String name,
    String? address,
    String? phone,
    String? hours,
    String? city,
    String? neighborhood,
    List<String> coverage,
  });
}

/// @nodoc
class _$BranchCopyWithImpl<$Res, $Val extends Branch>
    implements $BranchCopyWith<$Res> {
  _$BranchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Branch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = freezed,
    Object? phone = freezed,
    Object? hours = freezed,
    Object? city = freezed,
    Object? neighborhood = freezed,
    Object? coverage = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            hours: freezed == hours
                ? _value.hours
                : hours // ignore: cast_nullable_to_non_nullable
                      as String?,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            neighborhood: freezed == neighborhood
                ? _value.neighborhood
                : neighborhood // ignore: cast_nullable_to_non_nullable
                      as String?,
            coverage: null == coverage
                ? _value.coverage
                : coverage // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BranchImplCopyWith<$Res> implements $BranchCopyWith<$Res> {
  factory _$$BranchImplCopyWith(
    _$BranchImpl value,
    $Res Function(_$BranchImpl) then,
  ) = __$$BranchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? address,
    String? phone,
    String? hours,
    String? city,
    String? neighborhood,
    List<String> coverage,
  });
}

/// @nodoc
class __$$BranchImplCopyWithImpl<$Res>
    extends _$BranchCopyWithImpl<$Res, _$BranchImpl>
    implements _$$BranchImplCopyWith<$Res> {
  __$$BranchImplCopyWithImpl(
    _$BranchImpl _value,
    $Res Function(_$BranchImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Branch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = freezed,
    Object? phone = freezed,
    Object? hours = freezed,
    Object? city = freezed,
    Object? neighborhood = freezed,
    Object? coverage = null,
  }) {
    return _then(
      _$BranchImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        hours: freezed == hours
            ? _value.hours
            : hours // ignore: cast_nullable_to_non_nullable
                  as String?,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        neighborhood: freezed == neighborhood
            ? _value.neighborhood
            : neighborhood // ignore: cast_nullable_to_non_nullable
                  as String?,
        coverage: null == coverage
            ? _value._coverage
            : coverage // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BranchImpl implements _Branch {
  const _$BranchImpl({
    required this.id,
    required this.name,
    this.address,
    this.phone,
    this.hours,
    this.city,
    this.neighborhood,
    final List<String> coverage = const [],
  }) : _coverage = coverage;

  factory _$BranchImpl.fromJson(Map<String, dynamic> json) =>
      _$$BranchImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? address;
  @override
  final String? phone;
  @override
  final String? hours;
  @override
  final String? city;
  @override
  final String? neighborhood;
  final List<String> _coverage;
  @override
  @JsonKey()
  List<String> get coverage {
    if (_coverage is EqualUnmodifiableListView) return _coverage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coverage);
  }

  @override
  String toString() {
    return 'Branch(id: $id, name: $name, address: $address, phone: $phone, hours: $hours, city: $city, neighborhood: $neighborhood, coverage: $coverage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BranchImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.neighborhood, neighborhood) ||
                other.neighborhood == neighborhood) &&
            const DeepCollectionEquality().equals(other._coverage, _coverage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    address,
    phone,
    hours,
    city,
    neighborhood,
    const DeepCollectionEquality().hash(_coverage),
  );

  /// Create a copy of Branch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BranchImplCopyWith<_$BranchImpl> get copyWith =>
      __$$BranchImplCopyWithImpl<_$BranchImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BranchImplToJson(this);
  }
}

abstract class _Branch implements Branch {
  const factory _Branch({
    required final String id,
    required final String name,
    final String? address,
    final String? phone,
    final String? hours,
    final String? city,
    final String? neighborhood,
    final List<String> coverage,
  }) = _$BranchImpl;

  factory _Branch.fromJson(Map<String, dynamic> json) = _$BranchImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get address;
  @override
  String? get phone;
  @override
  String? get hours;
  @override
  String? get city;
  @override
  String? get neighborhood;
  @override
  List<String> get coverage;

  /// Create a copy of Branch
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BranchImplCopyWith<_$BranchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CoverageZone _$CoverageZoneFromJson(Map<String, dynamic> json) {
  return _CoverageZone.fromJson(json);
}

/// @nodoc
mixin _$CoverageZone {
  String get city => throw _privateConstructorUsedError;
  List<CoverageArea> get areas => throw _privateConstructorUsedError;

  /// Serializes this CoverageZone to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CoverageZone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoverageZoneCopyWith<CoverageZone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoverageZoneCopyWith<$Res> {
  factory $CoverageZoneCopyWith(
    CoverageZone value,
    $Res Function(CoverageZone) then,
  ) = _$CoverageZoneCopyWithImpl<$Res, CoverageZone>;
  @useResult
  $Res call({String city, List<CoverageArea> areas});
}

/// @nodoc
class _$CoverageZoneCopyWithImpl<$Res, $Val extends CoverageZone>
    implements $CoverageZoneCopyWith<$Res> {
  _$CoverageZoneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CoverageZone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? city = null, Object? areas = null}) {
    return _then(
      _value.copyWith(
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            areas: null == areas
                ? _value.areas
                : areas // ignore: cast_nullable_to_non_nullable
                      as List<CoverageArea>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CoverageZoneImplCopyWith<$Res>
    implements $CoverageZoneCopyWith<$Res> {
  factory _$$CoverageZoneImplCopyWith(
    _$CoverageZoneImpl value,
    $Res Function(_$CoverageZoneImpl) then,
  ) = __$$CoverageZoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String city, List<CoverageArea> areas});
}

/// @nodoc
class __$$CoverageZoneImplCopyWithImpl<$Res>
    extends _$CoverageZoneCopyWithImpl<$Res, _$CoverageZoneImpl>
    implements _$$CoverageZoneImplCopyWith<$Res> {
  __$$CoverageZoneImplCopyWithImpl(
    _$CoverageZoneImpl _value,
    $Res Function(_$CoverageZoneImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CoverageZone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? city = null, Object? areas = null}) {
    return _then(
      _$CoverageZoneImpl(
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        areas: null == areas
            ? _value._areas
            : areas // ignore: cast_nullable_to_non_nullable
                  as List<CoverageArea>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CoverageZoneImpl implements _CoverageZone {
  const _$CoverageZoneImpl({
    required this.city,
    final List<CoverageArea> areas = const [],
  }) : _areas = areas;

  factory _$CoverageZoneImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoverageZoneImplFromJson(json);

  @override
  final String city;
  final List<CoverageArea> _areas;
  @override
  @JsonKey()
  List<CoverageArea> get areas {
    if (_areas is EqualUnmodifiableListView) return _areas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areas);
  }

  @override
  String toString() {
    return 'CoverageZone(city: $city, areas: $areas)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoverageZoneImpl &&
            (identical(other.city, city) || other.city == city) &&
            const DeepCollectionEquality().equals(other._areas, _areas));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    city,
    const DeepCollectionEquality().hash(_areas),
  );

  /// Create a copy of CoverageZone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoverageZoneImplCopyWith<_$CoverageZoneImpl> get copyWith =>
      __$$CoverageZoneImplCopyWithImpl<_$CoverageZoneImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CoverageZoneImplToJson(this);
  }
}

abstract class _CoverageZone implements CoverageZone {
  const factory _CoverageZone({
    required final String city,
    final List<CoverageArea> areas,
  }) = _$CoverageZoneImpl;

  factory _CoverageZone.fromJson(Map<String, dynamic> json) =
      _$CoverageZoneImpl.fromJson;

  @override
  String get city;
  @override
  List<CoverageArea> get areas;

  /// Create a copy of CoverageZone
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoverageZoneImplCopyWith<_$CoverageZoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CoverageArea _$CoverageAreaFromJson(Map<String, dynamic> json) {
  return _CoverageArea.fromJson(json);
}

/// @nodoc
mixin _$CoverageArea {
  String get name => throw _privateConstructorUsedError;
  List<String> get neighbourhoods => throw _privateConstructorUsedError;

  /// Serializes this CoverageArea to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CoverageArea
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoverageAreaCopyWith<CoverageArea> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoverageAreaCopyWith<$Res> {
  factory $CoverageAreaCopyWith(
    CoverageArea value,
    $Res Function(CoverageArea) then,
  ) = _$CoverageAreaCopyWithImpl<$Res, CoverageArea>;
  @useResult
  $Res call({String name, List<String> neighbourhoods});
}

/// @nodoc
class _$CoverageAreaCopyWithImpl<$Res, $Val extends CoverageArea>
    implements $CoverageAreaCopyWith<$Res> {
  _$CoverageAreaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CoverageArea
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? neighbourhoods = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            neighbourhoods: null == neighbourhoods
                ? _value.neighbourhoods
                : neighbourhoods // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CoverageAreaImplCopyWith<$Res>
    implements $CoverageAreaCopyWith<$Res> {
  factory _$$CoverageAreaImplCopyWith(
    _$CoverageAreaImpl value,
    $Res Function(_$CoverageAreaImpl) then,
  ) = __$$CoverageAreaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<String> neighbourhoods});
}

/// @nodoc
class __$$CoverageAreaImplCopyWithImpl<$Res>
    extends _$CoverageAreaCopyWithImpl<$Res, _$CoverageAreaImpl>
    implements _$$CoverageAreaImplCopyWith<$Res> {
  __$$CoverageAreaImplCopyWithImpl(
    _$CoverageAreaImpl _value,
    $Res Function(_$CoverageAreaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CoverageArea
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? neighbourhoods = null}) {
    return _then(
      _$CoverageAreaImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        neighbourhoods: null == neighbourhoods
            ? _value._neighbourhoods
            : neighbourhoods // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CoverageAreaImpl implements _CoverageArea {
  const _$CoverageAreaImpl({
    required this.name,
    final List<String> neighbourhoods = const [],
  }) : _neighbourhoods = neighbourhoods;

  factory _$CoverageAreaImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoverageAreaImplFromJson(json);

  @override
  final String name;
  final List<String> _neighbourhoods;
  @override
  @JsonKey()
  List<String> get neighbourhoods {
    if (_neighbourhoods is EqualUnmodifiableListView) return _neighbourhoods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_neighbourhoods);
  }

  @override
  String toString() {
    return 'CoverageArea(name: $name, neighbourhoods: $neighbourhoods)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoverageAreaImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(
              other._neighbourhoods,
              _neighbourhoods,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    const DeepCollectionEquality().hash(_neighbourhoods),
  );

  /// Create a copy of CoverageArea
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoverageAreaImplCopyWith<_$CoverageAreaImpl> get copyWith =>
      __$$CoverageAreaImplCopyWithImpl<_$CoverageAreaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CoverageAreaImplToJson(this);
  }
}

abstract class _CoverageArea implements CoverageArea {
  const factory _CoverageArea({
    required final String name,
    final List<String> neighbourhoods,
  }) = _$CoverageAreaImpl;

  factory _CoverageArea.fromJson(Map<String, dynamic> json) =
      _$CoverageAreaImpl.fromJson;

  @override
  String get name;
  @override
  List<String> get neighbourhoods;

  /// Create a copy of CoverageArea
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoverageAreaImplCopyWith<_$CoverageAreaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReturnPolicy _$ReturnPolicyFromJson(Map<String, dynamic> json) {
  return _ReturnPolicy.fromJson(json);
}

/// @nodoc
mixin _$ReturnPolicy {
  @JsonKey(name: 'accepts_returns')
  bool get acceptsReturns => throw _privateConstructorUsedError;
  @JsonKey(name: 'window_days')
  int? get windowDays => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get cost => throw _privateConstructorUsedError;
  @JsonKey(name: 'conditions_ar')
  List<String> get conditionsAr => throw _privateConstructorUsedError;

  /// Serializes this ReturnPolicy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReturnPolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReturnPolicyCopyWith<ReturnPolicy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReturnPolicyCopyWith<$Res> {
  factory $ReturnPolicyCopyWith(
    ReturnPolicy value,
    $Res Function(ReturnPolicy) then,
  ) = _$ReturnPolicyCopyWithImpl<$Res, ReturnPolicy>;
  @useResult
  $Res call({
    @JsonKey(name: 'accepts_returns') bool acceptsReturns,
    @JsonKey(name: 'window_days') int? windowDays,
    String? type,
    String? cost,
    @JsonKey(name: 'conditions_ar') List<String> conditionsAr,
  });
}

/// @nodoc
class _$ReturnPolicyCopyWithImpl<$Res, $Val extends ReturnPolicy>
    implements $ReturnPolicyCopyWith<$Res> {
  _$ReturnPolicyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReturnPolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? acceptsReturns = null,
    Object? windowDays = freezed,
    Object? type = freezed,
    Object? cost = freezed,
    Object? conditionsAr = null,
  }) {
    return _then(
      _value.copyWith(
            acceptsReturns: null == acceptsReturns
                ? _value.acceptsReturns
                : acceptsReturns // ignore: cast_nullable_to_non_nullable
                      as bool,
            windowDays: freezed == windowDays
                ? _value.windowDays
                : windowDays // ignore: cast_nullable_to_non_nullable
                      as int?,
            type: freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String?,
            cost: freezed == cost
                ? _value.cost
                : cost // ignore: cast_nullable_to_non_nullable
                      as String?,
            conditionsAr: null == conditionsAr
                ? _value.conditionsAr
                : conditionsAr // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReturnPolicyImplCopyWith<$Res>
    implements $ReturnPolicyCopyWith<$Res> {
  factory _$$ReturnPolicyImplCopyWith(
    _$ReturnPolicyImpl value,
    $Res Function(_$ReturnPolicyImpl) then,
  ) = __$$ReturnPolicyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'accepts_returns') bool acceptsReturns,
    @JsonKey(name: 'window_days') int? windowDays,
    String? type,
    String? cost,
    @JsonKey(name: 'conditions_ar') List<String> conditionsAr,
  });
}

/// @nodoc
class __$$ReturnPolicyImplCopyWithImpl<$Res>
    extends _$ReturnPolicyCopyWithImpl<$Res, _$ReturnPolicyImpl>
    implements _$$ReturnPolicyImplCopyWith<$Res> {
  __$$ReturnPolicyImplCopyWithImpl(
    _$ReturnPolicyImpl _value,
    $Res Function(_$ReturnPolicyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReturnPolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? acceptsReturns = null,
    Object? windowDays = freezed,
    Object? type = freezed,
    Object? cost = freezed,
    Object? conditionsAr = null,
  }) {
    return _then(
      _$ReturnPolicyImpl(
        acceptsReturns: null == acceptsReturns
            ? _value.acceptsReturns
            : acceptsReturns // ignore: cast_nullable_to_non_nullable
                  as bool,
        windowDays: freezed == windowDays
            ? _value.windowDays
            : windowDays // ignore: cast_nullable_to_non_nullable
                  as int?,
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String?,
        cost: freezed == cost
            ? _value.cost
            : cost // ignore: cast_nullable_to_non_nullable
                  as String?,
        conditionsAr: null == conditionsAr
            ? _value._conditionsAr
            : conditionsAr // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReturnPolicyImpl implements _ReturnPolicy {
  const _$ReturnPolicyImpl({
    @JsonKey(name: 'accepts_returns') this.acceptsReturns = false,
    @JsonKey(name: 'window_days') this.windowDays,
    this.type,
    this.cost,
    @JsonKey(name: 'conditions_ar') final List<String> conditionsAr = const [],
  }) : _conditionsAr = conditionsAr;

  factory _$ReturnPolicyImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReturnPolicyImplFromJson(json);

  @override
  @JsonKey(name: 'accepts_returns')
  final bool acceptsReturns;
  @override
  @JsonKey(name: 'window_days')
  final int? windowDays;
  @override
  final String? type;
  @override
  final String? cost;
  final List<String> _conditionsAr;
  @override
  @JsonKey(name: 'conditions_ar')
  List<String> get conditionsAr {
    if (_conditionsAr is EqualUnmodifiableListView) return _conditionsAr;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conditionsAr);
  }

  @override
  String toString() {
    return 'ReturnPolicy(acceptsReturns: $acceptsReturns, windowDays: $windowDays, type: $type, cost: $cost, conditionsAr: $conditionsAr)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReturnPolicyImpl &&
            (identical(other.acceptsReturns, acceptsReturns) ||
                other.acceptsReturns == acceptsReturns) &&
            (identical(other.windowDays, windowDays) ||
                other.windowDays == windowDays) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            const DeepCollectionEquality().equals(
              other._conditionsAr,
              _conditionsAr,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    acceptsReturns,
    windowDays,
    type,
    cost,
    const DeepCollectionEquality().hash(_conditionsAr),
  );

  /// Create a copy of ReturnPolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReturnPolicyImplCopyWith<_$ReturnPolicyImpl> get copyWith =>
      __$$ReturnPolicyImplCopyWithImpl<_$ReturnPolicyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReturnPolicyImplToJson(this);
  }
}

abstract class _ReturnPolicy implements ReturnPolicy {
  const factory _ReturnPolicy({
    @JsonKey(name: 'accepts_returns') final bool acceptsReturns,
    @JsonKey(name: 'window_days') final int? windowDays,
    final String? type,
    final String? cost,
    @JsonKey(name: 'conditions_ar') final List<String> conditionsAr,
  }) = _$ReturnPolicyImpl;

  factory _ReturnPolicy.fromJson(Map<String, dynamic> json) =
      _$ReturnPolicyImpl.fromJson;

  @override
  @JsonKey(name: 'accepts_returns')
  bool get acceptsReturns;
  @override
  @JsonKey(name: 'window_days')
  int? get windowDays;
  @override
  String? get type;
  @override
  String? get cost;
  @override
  @JsonKey(name: 'conditions_ar')
  List<String> get conditionsAr;

  /// Create a copy of ReturnPolicy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReturnPolicyImplCopyWith<_$ReturnPolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExternalLink _$ExternalLinkFromJson(Map<String, dynamic> json) {
  return _ExternalLink.fromJson(json);
}

/// @nodoc
mixin _$ExternalLink {
  String get platform => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  /// Serializes this ExternalLink to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExternalLink
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExternalLinkCopyWith<ExternalLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExternalLinkCopyWith<$Res> {
  factory $ExternalLinkCopyWith(
    ExternalLink value,
    $Res Function(ExternalLink) then,
  ) = _$ExternalLinkCopyWithImpl<$Res, ExternalLink>;
  @useResult
  $Res call({String platform, String label, String url});
}

/// @nodoc
class _$ExternalLinkCopyWithImpl<$Res, $Val extends ExternalLink>
    implements $ExternalLinkCopyWith<$Res> {
  _$ExternalLinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExternalLink
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? platform = null,
    Object? label = null,
    Object? url = null,
  }) {
    return _then(
      _value.copyWith(
            platform: null == platform
                ? _value.platform
                : platform // ignore: cast_nullable_to_non_nullable
                      as String,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExternalLinkImplCopyWith<$Res>
    implements $ExternalLinkCopyWith<$Res> {
  factory _$$ExternalLinkImplCopyWith(
    _$ExternalLinkImpl value,
    $Res Function(_$ExternalLinkImpl) then,
  ) = __$$ExternalLinkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String platform, String label, String url});
}

/// @nodoc
class __$$ExternalLinkImplCopyWithImpl<$Res>
    extends _$ExternalLinkCopyWithImpl<$Res, _$ExternalLinkImpl>
    implements _$$ExternalLinkImplCopyWith<$Res> {
  __$$ExternalLinkImplCopyWithImpl(
    _$ExternalLinkImpl _value,
    $Res Function(_$ExternalLinkImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExternalLink
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? platform = null,
    Object? label = null,
    Object? url = null,
  }) {
    return _then(
      _$ExternalLinkImpl(
        platform: null == platform
            ? _value.platform
            : platform // ignore: cast_nullable_to_non_nullable
                  as String,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExternalLinkImpl implements _ExternalLink {
  const _$ExternalLinkImpl({
    required this.platform,
    required this.label,
    required this.url,
  });

  factory _$ExternalLinkImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExternalLinkImplFromJson(json);

  @override
  final String platform;
  @override
  final String label;
  @override
  final String url;

  @override
  String toString() {
    return 'ExternalLink(platform: $platform, label: $label, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExternalLinkImpl &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, platform, label, url);

  /// Create a copy of ExternalLink
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExternalLinkImplCopyWith<_$ExternalLinkImpl> get copyWith =>
      __$$ExternalLinkImplCopyWithImpl<_$ExternalLinkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExternalLinkImplToJson(this);
  }
}

abstract class _ExternalLink implements ExternalLink {
  const factory _ExternalLink({
    required final String platform,
    required final String label,
    required final String url,
  }) = _$ExternalLinkImpl;

  factory _ExternalLink.fromJson(Map<String, dynamic> json) =
      _$ExternalLinkImpl.fromJson;

  @override
  String get platform;
  @override
  String get label;
  @override
  String get url;

  /// Create a copy of ExternalLink
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExternalLinkImplCopyWith<_$ExternalLinkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PriceChange _$PriceChangeFromJson(Map<String, dynamic> json) {
  return _PriceChange.fromJson(json);
}

/// @nodoc
mixin _$PriceChange {
  String get direction => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;
  String? get scope => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this PriceChange to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PriceChange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PriceChangeCopyWith<PriceChange> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceChangeCopyWith<$Res> {
  factory $PriceChangeCopyWith(
    PriceChange value,
    $Res Function(PriceChange) then,
  ) = _$PriceChangeCopyWithImpl<$Res, PriceChange>;
  @useResult
  $Res call({
    String direction,
    String method,
    int value,
    String? scope,
    String? reason,
    String status,
  });
}

/// @nodoc
class _$PriceChangeCopyWithImpl<$Res, $Val extends PriceChange>
    implements $PriceChangeCopyWith<$Res> {
  _$PriceChangeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PriceChange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? direction = null,
    Object? method = null,
    Object? value = null,
    Object? scope = freezed,
    Object? reason = freezed,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            direction: null == direction
                ? _value.direction
                : direction // ignore: cast_nullable_to_non_nullable
                      as String,
            method: null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                      as String,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as int,
            scope: freezed == scope
                ? _value.scope
                : scope // ignore: cast_nullable_to_non_nullable
                      as String?,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PriceChangeImplCopyWith<$Res>
    implements $PriceChangeCopyWith<$Res> {
  factory _$$PriceChangeImplCopyWith(
    _$PriceChangeImpl value,
    $Res Function(_$PriceChangeImpl) then,
  ) = __$$PriceChangeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String direction,
    String method,
    int value,
    String? scope,
    String? reason,
    String status,
  });
}

/// @nodoc
class __$$PriceChangeImplCopyWithImpl<$Res>
    extends _$PriceChangeCopyWithImpl<$Res, _$PriceChangeImpl>
    implements _$$PriceChangeImplCopyWith<$Res> {
  __$$PriceChangeImplCopyWithImpl(
    _$PriceChangeImpl _value,
    $Res Function(_$PriceChangeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PriceChange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? direction = null,
    Object? method = null,
    Object? value = null,
    Object? scope = freezed,
    Object? reason = freezed,
    Object? status = null,
  }) {
    return _then(
      _$PriceChangeImpl(
        direction: null == direction
            ? _value.direction
            : direction // ignore: cast_nullable_to_non_nullable
                  as String,
        method: null == method
            ? _value.method
            : method // ignore: cast_nullable_to_non_nullable
                  as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as int,
        scope: freezed == scope
            ? _value.scope
            : scope // ignore: cast_nullable_to_non_nullable
                  as String?,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceChangeImpl implements _PriceChange {
  const _$PriceChangeImpl({
    required this.direction,
    required this.method,
    required this.value,
    this.scope,
    this.reason,
    this.status = 'active',
  });

  factory _$PriceChangeImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceChangeImplFromJson(json);

  @override
  final String direction;
  @override
  final String method;
  @override
  final int value;
  @override
  final String? scope;
  @override
  final String? reason;
  @override
  @JsonKey()
  final String status;

  @override
  String toString() {
    return 'PriceChange(direction: $direction, method: $method, value: $value, scope: $scope, reason: $reason, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceChangeImpl &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.scope, scope) || other.scope == scope) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, direction, method, value, scope, reason, status);

  /// Create a copy of PriceChange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceChangeImplCopyWith<_$PriceChangeImpl> get copyWith =>
      __$$PriceChangeImplCopyWithImpl<_$PriceChangeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceChangeImplToJson(this);
  }
}

abstract class _PriceChange implements PriceChange {
  const factory _PriceChange({
    required final String direction,
    required final String method,
    required final int value,
    final String? scope,
    final String? reason,
    final String status,
  }) = _$PriceChangeImpl;

  factory _PriceChange.fromJson(Map<String, dynamic> json) =
      _$PriceChangeImpl.fromJson;

  @override
  String get direction;
  @override
  String get method;
  @override
  int get value;
  @override
  String? get scope;
  @override
  String? get reason;
  @override
  String get status;

  /// Create a copy of PriceChange
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PriceChangeImplCopyWith<_$PriceChangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Package _$PackageFromJson(Map<String, dynamic> json) {
  return _Package.fromJson(json);
}

/// @nodoc
mixin _$Package {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_cents')
  int get priceCents => throw _privateConstructorUsedError;
  int get credits => throw _privateConstructorUsedError;
  @JsonKey(name: 'credit_label')
  String? get creditLabel => throw _privateConstructorUsedError;

  /// Serializes this Package to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Package
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PackageCopyWith<Package> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackageCopyWith<$Res> {
  factory $PackageCopyWith(Package value, $Res Function(Package) then) =
      _$PackageCopyWithImpl<$Res, Package>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    @JsonKey(name: 'price_cents') int priceCents,
    int credits,
    @JsonKey(name: 'credit_label') String? creditLabel,
  });
}

/// @nodoc
class _$PackageCopyWithImpl<$Res, $Val extends Package>
    implements $PackageCopyWith<$Res> {
  _$PackageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Package
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? priceCents = null,
    Object? credits = null,
    Object? creditLabel = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            priceCents: null == priceCents
                ? _value.priceCents
                : priceCents // ignore: cast_nullable_to_non_nullable
                      as int,
            credits: null == credits
                ? _value.credits
                : credits // ignore: cast_nullable_to_non_nullable
                      as int,
            creditLabel: freezed == creditLabel
                ? _value.creditLabel
                : creditLabel // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PackageImplCopyWith<$Res> implements $PackageCopyWith<$Res> {
  factory _$$PackageImplCopyWith(
    _$PackageImpl value,
    $Res Function(_$PackageImpl) then,
  ) = __$$PackageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    @JsonKey(name: 'price_cents') int priceCents,
    int credits,
    @JsonKey(name: 'credit_label') String? creditLabel,
  });
}

/// @nodoc
class __$$PackageImplCopyWithImpl<$Res>
    extends _$PackageCopyWithImpl<$Res, _$PackageImpl>
    implements _$$PackageImplCopyWith<$Res> {
  __$$PackageImplCopyWithImpl(
    _$PackageImpl _value,
    $Res Function(_$PackageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Package
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? priceCents = null,
    Object? credits = null,
    Object? creditLabel = freezed,
  }) {
    return _then(
      _$PackageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        priceCents: null == priceCents
            ? _value.priceCents
            : priceCents // ignore: cast_nullable_to_non_nullable
                  as int,
        credits: null == credits
            ? _value.credits
            : credits // ignore: cast_nullable_to_non_nullable
                  as int,
        creditLabel: freezed == creditLabel
            ? _value.creditLabel
            : creditLabel // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PackageImpl implements _Package {
  const _$PackageImpl({
    required this.id,
    required this.name,
    this.description,
    @JsonKey(name: 'price_cents') required this.priceCents,
    required this.credits,
    @JsonKey(name: 'credit_label') this.creditLabel,
  });

  factory _$PackageImpl.fromJson(Map<String, dynamic> json) =>
      _$$PackageImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey(name: 'price_cents')
  final int priceCents;
  @override
  final int credits;
  @override
  @JsonKey(name: 'credit_label')
  final String? creditLabel;

  @override
  String toString() {
    return 'Package(id: $id, name: $name, description: $description, priceCents: $priceCents, credits: $credits, creditLabel: $creditLabel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PackageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priceCents, priceCents) ||
                other.priceCents == priceCents) &&
            (identical(other.credits, credits) || other.credits == credits) &&
            (identical(other.creditLabel, creditLabel) ||
                other.creditLabel == creditLabel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    priceCents,
    credits,
    creditLabel,
  );

  /// Create a copy of Package
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PackageImplCopyWith<_$PackageImpl> get copyWith =>
      __$$PackageImplCopyWithImpl<_$PackageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PackageImplToJson(this);
  }
}

abstract class _Package implements Package {
  const factory _Package({
    required final String id,
    required final String name,
    final String? description,
    @JsonKey(name: 'price_cents') required final int priceCents,
    required final int credits,
    @JsonKey(name: 'credit_label') final String? creditLabel,
  }) = _$PackageImpl;

  factory _Package.fromJson(Map<String, dynamic> json) = _$PackageImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  @JsonKey(name: 'price_cents')
  int get priceCents;
  @override
  int get credits;
  @override
  @JsonKey(name: 'credit_label')
  String? get creditLabel;

  /// Create a copy of Package
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PackageImplCopyWith<_$PackageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Amenity _$AmenityFromJson(Map<String, dynamic> json) {
  return _Amenity.fromJson(json);
}

/// @nodoc
mixin _$Amenity {
  String get icon => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;

  /// Serializes this Amenity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Amenity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AmenityCopyWith<Amenity> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmenityCopyWith<$Res> {
  factory $AmenityCopyWith(Amenity value, $Res Function(Amenity) then) =
      _$AmenityCopyWithImpl<$Res, Amenity>;
  @useResult
  $Res call({String icon, String label});
}

/// @nodoc
class _$AmenityCopyWithImpl<$Res, $Val extends Amenity>
    implements $AmenityCopyWith<$Res> {
  _$AmenityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Amenity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? icon = null, Object? label = null}) {
    return _then(
      _value.copyWith(
            icon: null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AmenityImplCopyWith<$Res> implements $AmenityCopyWith<$Res> {
  factory _$$AmenityImplCopyWith(
    _$AmenityImpl value,
    $Res Function(_$AmenityImpl) then,
  ) = __$$AmenityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String icon, String label});
}

/// @nodoc
class __$$AmenityImplCopyWithImpl<$Res>
    extends _$AmenityCopyWithImpl<$Res, _$AmenityImpl>
    implements _$$AmenityImplCopyWith<$Res> {
  __$$AmenityImplCopyWithImpl(
    _$AmenityImpl _value,
    $Res Function(_$AmenityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Amenity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? icon = null, Object? label = null}) {
    return _then(
      _$AmenityImpl(
        icon: null == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AmenityImpl implements _Amenity {
  const _$AmenityImpl({required this.icon, required this.label});

  factory _$AmenityImpl.fromJson(Map<String, dynamic> json) =>
      _$$AmenityImplFromJson(json);

  @override
  final String icon;
  @override
  final String label;

  @override
  String toString() {
    return 'Amenity(icon: $icon, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmenityImpl &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, icon, label);

  /// Create a copy of Amenity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AmenityImplCopyWith<_$AmenityImpl> get copyWith =>
      __$$AmenityImplCopyWithImpl<_$AmenityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AmenityImplToJson(this);
  }
}

abstract class _Amenity implements Amenity {
  const factory _Amenity({
    required final String icon,
    required final String label,
  }) = _$AmenityImpl;

  factory _Amenity.fromJson(Map<String, dynamic> json) = _$AmenityImpl.fromJson;

  @override
  String get icon;
  @override
  String get label;

  /// Create a copy of Amenity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AmenityImplCopyWith<_$AmenityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VillaPricing _$VillaPricingFromJson(Map<String, dynamic> json) {
  return _VillaPricing.fromJson(json);
}

/// @nodoc
mixin _$VillaPricing {
  @JsonKey(name: 'weekday_cents')
  int get weekdayCents => throw _privateConstructorUsedError;
  @JsonKey(name: 'weekend_cents')
  int get weekendCents => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;

  /// Serializes this VillaPricing to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VillaPricing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VillaPricingCopyWith<VillaPricing> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VillaPricingCopyWith<$Res> {
  factory $VillaPricingCopyWith(
    VillaPricing value,
    $Res Function(VillaPricing) then,
  ) = _$VillaPricingCopyWithImpl<$Res, VillaPricing>;
  @useResult
  $Res call({
    @JsonKey(name: 'weekday_cents') int weekdayCents,
    @JsonKey(name: 'weekend_cents') int weekendCents,
    String currency,
  });
}

/// @nodoc
class _$VillaPricingCopyWithImpl<$Res, $Val extends VillaPricing>
    implements $VillaPricingCopyWith<$Res> {
  _$VillaPricingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VillaPricing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekdayCents = null,
    Object? weekendCents = null,
    Object? currency = null,
  }) {
    return _then(
      _value.copyWith(
            weekdayCents: null == weekdayCents
                ? _value.weekdayCents
                : weekdayCents // ignore: cast_nullable_to_non_nullable
                      as int,
            weekendCents: null == weekendCents
                ? _value.weekendCents
                : weekendCents // ignore: cast_nullable_to_non_nullable
                      as int,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VillaPricingImplCopyWith<$Res>
    implements $VillaPricingCopyWith<$Res> {
  factory _$$VillaPricingImplCopyWith(
    _$VillaPricingImpl value,
    $Res Function(_$VillaPricingImpl) then,
  ) = __$$VillaPricingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'weekday_cents') int weekdayCents,
    @JsonKey(name: 'weekend_cents') int weekendCents,
    String currency,
  });
}

/// @nodoc
class __$$VillaPricingImplCopyWithImpl<$Res>
    extends _$VillaPricingCopyWithImpl<$Res, _$VillaPricingImpl>
    implements _$$VillaPricingImplCopyWith<$Res> {
  __$$VillaPricingImplCopyWithImpl(
    _$VillaPricingImpl _value,
    $Res Function(_$VillaPricingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VillaPricing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekdayCents = null,
    Object? weekendCents = null,
    Object? currency = null,
  }) {
    return _then(
      _$VillaPricingImpl(
        weekdayCents: null == weekdayCents
            ? _value.weekdayCents
            : weekdayCents // ignore: cast_nullable_to_non_nullable
                  as int,
        weekendCents: null == weekendCents
            ? _value.weekendCents
            : weekendCents // ignore: cast_nullable_to_non_nullable
                  as int,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VillaPricingImpl implements _VillaPricing {
  const _$VillaPricingImpl({
    @JsonKey(name: 'weekday_cents') required this.weekdayCents,
    @JsonKey(name: 'weekend_cents') required this.weekendCents,
    this.currency = 'JOD',
  });

  factory _$VillaPricingImpl.fromJson(Map<String, dynamic> json) =>
      _$$VillaPricingImplFromJson(json);

  @override
  @JsonKey(name: 'weekday_cents')
  final int weekdayCents;
  @override
  @JsonKey(name: 'weekend_cents')
  final int weekendCents;
  @override
  @JsonKey()
  final String currency;

  @override
  String toString() {
    return 'VillaPricing(weekdayCents: $weekdayCents, weekendCents: $weekendCents, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VillaPricingImpl &&
            (identical(other.weekdayCents, weekdayCents) ||
                other.weekdayCents == weekdayCents) &&
            (identical(other.weekendCents, weekendCents) ||
                other.weekendCents == weekendCents) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, weekdayCents, weekendCents, currency);

  /// Create a copy of VillaPricing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VillaPricingImplCopyWith<_$VillaPricingImpl> get copyWith =>
      __$$VillaPricingImplCopyWithImpl<_$VillaPricingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VillaPricingImplToJson(this);
  }
}

abstract class _VillaPricing implements VillaPricing {
  const factory _VillaPricing({
    @JsonKey(name: 'weekday_cents') required final int weekdayCents,
    @JsonKey(name: 'weekend_cents') required final int weekendCents,
    final String currency,
  }) = _$VillaPricingImpl;

  factory _VillaPricing.fromJson(Map<String, dynamic> json) =
      _$VillaPricingImpl.fromJson;

  @override
  @JsonKey(name: 'weekday_cents')
  int get weekdayCents;
  @override
  @JsonKey(name: 'weekend_cents')
  int get weekendCents;
  @override
  String get currency;

  /// Create a copy of VillaPricing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VillaPricingImplCopyWith<_$VillaPricingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceOffered _$ServiceOfferedFromJson(Map<String, dynamic> json) {
  return _ServiceOffered.fromJson(json);
}

/// @nodoc
mixin _$ServiceOffered {
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this ServiceOffered to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceOffered
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceOfferedCopyWith<ServiceOffered> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceOfferedCopyWith<$Res> {
  factory $ServiceOfferedCopyWith(
    ServiceOffered value,
    $Res Function(ServiceOffered) then,
  ) = _$ServiceOfferedCopyWithImpl<$Res, ServiceOffered>;
  @useResult
  $Res call({String name, String? description});
}

/// @nodoc
class _$ServiceOfferedCopyWithImpl<$Res, $Val extends ServiceOffered>
    implements $ServiceOfferedCopyWith<$Res> {
  _$ServiceOfferedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceOffered
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? description = freezed}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ServiceOfferedImplCopyWith<$Res>
    implements $ServiceOfferedCopyWith<$Res> {
  factory _$$ServiceOfferedImplCopyWith(
    _$ServiceOfferedImpl value,
    $Res Function(_$ServiceOfferedImpl) then,
  ) = __$$ServiceOfferedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? description});
}

/// @nodoc
class __$$ServiceOfferedImplCopyWithImpl<$Res>
    extends _$ServiceOfferedCopyWithImpl<$Res, _$ServiceOfferedImpl>
    implements _$$ServiceOfferedImplCopyWith<$Res> {
  __$$ServiceOfferedImplCopyWithImpl(
    _$ServiceOfferedImpl _value,
    $Res Function(_$ServiceOfferedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServiceOffered
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? description = freezed}) {
    return _then(
      _$ServiceOfferedImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceOfferedImpl implements _ServiceOffered {
  const _$ServiceOfferedImpl({required this.name, this.description});

  factory _$ServiceOfferedImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceOfferedImplFromJson(json);

  @override
  final String name;
  @override
  final String? description;

  @override
  String toString() {
    return 'ServiceOffered(name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceOfferedImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, description);

  /// Create a copy of ServiceOffered
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceOfferedImplCopyWith<_$ServiceOfferedImpl> get copyWith =>
      __$$ServiceOfferedImplCopyWithImpl<_$ServiceOfferedImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceOfferedImplToJson(this);
  }
}

abstract class _ServiceOffered implements ServiceOffered {
  const factory _ServiceOffered({
    required final String name,
    final String? description,
  }) = _$ServiceOfferedImpl;

  factory _ServiceOffered.fromJson(Map<String, dynamic> json) =
      _$ServiceOfferedImpl.fromJson;

  @override
  String get name;
  @override
  String? get description;

  /// Create a copy of ServiceOffered
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceOfferedImplCopyWith<_$ServiceOfferedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PriceRange _$PriceRangeFromJson(Map<String, dynamic> json) {
  return _PriceRange.fromJson(json);
}

/// @nodoc
mixin _$PriceRange {
  @JsonKey(name: 'min_cents')
  int get minCents => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_cents')
  int get maxCents => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this PriceRange to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PriceRange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PriceRangeCopyWith<PriceRange> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceRangeCopyWith<$Res> {
  factory $PriceRangeCopyWith(
    PriceRange value,
    $Res Function(PriceRange) then,
  ) = _$PriceRangeCopyWithImpl<$Res, PriceRange>;
  @useResult
  $Res call({
    @JsonKey(name: 'min_cents') int minCents,
    @JsonKey(name: 'max_cents') int maxCents,
    String? note,
  });
}

/// @nodoc
class _$PriceRangeCopyWithImpl<$Res, $Val extends PriceRange>
    implements $PriceRangeCopyWith<$Res> {
  _$PriceRangeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PriceRange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minCents = null,
    Object? maxCents = null,
    Object? note = freezed,
  }) {
    return _then(
      _value.copyWith(
            minCents: null == minCents
                ? _value.minCents
                : minCents // ignore: cast_nullable_to_non_nullable
                      as int,
            maxCents: null == maxCents
                ? _value.maxCents
                : maxCents // ignore: cast_nullable_to_non_nullable
                      as int,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PriceRangeImplCopyWith<$Res>
    implements $PriceRangeCopyWith<$Res> {
  factory _$$PriceRangeImplCopyWith(
    _$PriceRangeImpl value,
    $Res Function(_$PriceRangeImpl) then,
  ) = __$$PriceRangeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'min_cents') int minCents,
    @JsonKey(name: 'max_cents') int maxCents,
    String? note,
  });
}

/// @nodoc
class __$$PriceRangeImplCopyWithImpl<$Res>
    extends _$PriceRangeCopyWithImpl<$Res, _$PriceRangeImpl>
    implements _$$PriceRangeImplCopyWith<$Res> {
  __$$PriceRangeImplCopyWithImpl(
    _$PriceRangeImpl _value,
    $Res Function(_$PriceRangeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PriceRange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minCents = null,
    Object? maxCents = null,
    Object? note = freezed,
  }) {
    return _then(
      _$PriceRangeImpl(
        minCents: null == minCents
            ? _value.minCents
            : minCents // ignore: cast_nullable_to_non_nullable
                  as int,
        maxCents: null == maxCents
            ? _value.maxCents
            : maxCents // ignore: cast_nullable_to_non_nullable
                  as int,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceRangeImpl implements _PriceRange {
  const _$PriceRangeImpl({
    @JsonKey(name: 'min_cents') required this.minCents,
    @JsonKey(name: 'max_cents') required this.maxCents,
    this.note,
  });

  factory _$PriceRangeImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceRangeImplFromJson(json);

  @override
  @JsonKey(name: 'min_cents')
  final int minCents;
  @override
  @JsonKey(name: 'max_cents')
  final int maxCents;
  @override
  final String? note;

  @override
  String toString() {
    return 'PriceRange(minCents: $minCents, maxCents: $maxCents, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceRangeImpl &&
            (identical(other.minCents, minCents) ||
                other.minCents == minCents) &&
            (identical(other.maxCents, maxCents) ||
                other.maxCents == maxCents) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, minCents, maxCents, note);

  /// Create a copy of PriceRange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceRangeImplCopyWith<_$PriceRangeImpl> get copyWith =>
      __$$PriceRangeImplCopyWithImpl<_$PriceRangeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceRangeImplToJson(this);
  }
}

abstract class _PriceRange implements PriceRange {
  const factory _PriceRange({
    @JsonKey(name: 'min_cents') required final int minCents,
    @JsonKey(name: 'max_cents') required final int maxCents,
    final String? note,
  }) = _$PriceRangeImpl;

  factory _PriceRange.fromJson(Map<String, dynamic> json) =
      _$PriceRangeImpl.fromJson;

  @override
  @JsonKey(name: 'min_cents')
  int get minCents;
  @override
  @JsonKey(name: 'max_cents')
  int get maxCents;
  @override
  String? get note;

  /// Create a copy of PriceRange
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PriceRangeImplCopyWith<_$PriceRangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PageAlert _$PageAlertFromJson(Map<String, dynamic> json) {
  return _PageAlert.fromJson(json);
}

/// @nodoc
mixin _$PageAlert {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String get priority => throw _privateConstructorUsedError;
  List<String> get areas => throw _privateConstructorUsedError;

  /// Serializes this PageAlert to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PageAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PageAlertCopyWith<PageAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageAlertCopyWith<$Res> {
  factory $PageAlertCopyWith(PageAlert value, $Res Function(PageAlert) then) =
      _$PageAlertCopyWithImpl<$Res, PageAlert>;
  @useResult
  $Res call({
    String id,
    String title,
    String body,
    String priority,
    List<String> areas,
  });
}

/// @nodoc
class _$PageAlertCopyWithImpl<$Res, $Val extends PageAlert>
    implements $PageAlertCopyWith<$Res> {
  _$PageAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PageAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? priority = null,
    Object? areas = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            body: null == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                      as String,
            priority: null == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as String,
            areas: null == areas
                ? _value.areas
                : areas // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PageAlertImplCopyWith<$Res>
    implements $PageAlertCopyWith<$Res> {
  factory _$$PageAlertImplCopyWith(
    _$PageAlertImpl value,
    $Res Function(_$PageAlertImpl) then,
  ) = __$$PageAlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String body,
    String priority,
    List<String> areas,
  });
}

/// @nodoc
class __$$PageAlertImplCopyWithImpl<$Res>
    extends _$PageAlertCopyWithImpl<$Res, _$PageAlertImpl>
    implements _$$PageAlertImplCopyWith<$Res> {
  __$$PageAlertImplCopyWithImpl(
    _$PageAlertImpl _value,
    $Res Function(_$PageAlertImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PageAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? priority = null,
    Object? areas = null,
  }) {
    return _then(
      _$PageAlertImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        body: null == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String,
        priority: null == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as String,
        areas: null == areas
            ? _value._areas
            : areas // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PageAlertImpl implements _PageAlert {
  const _$PageAlertImpl({
    required this.id,
    required this.title,
    required this.body,
    this.priority = 'info',
    final List<String> areas = const [],
  }) : _areas = areas;

  factory _$PageAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$PageAlertImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String body;
  @override
  @JsonKey()
  final String priority;
  final List<String> _areas;
  @override
  @JsonKey()
  List<String> get areas {
    if (_areas is EqualUnmodifiableListView) return _areas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areas);
  }

  @override
  String toString() {
    return 'PageAlert(id: $id, title: $title, body: $body, priority: $priority, areas: $areas)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PageAlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            const DeepCollectionEquality().equals(other._areas, _areas));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    body,
    priority,
    const DeepCollectionEquality().hash(_areas),
  );

  /// Create a copy of PageAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PageAlertImplCopyWith<_$PageAlertImpl> get copyWith =>
      __$$PageAlertImplCopyWithImpl<_$PageAlertImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PageAlertImplToJson(this);
  }
}

abstract class _PageAlert implements PageAlert {
  const factory _PageAlert({
    required final String id,
    required final String title,
    required final String body,
    final String priority,
    final List<String> areas,
  }) = _$PageAlertImpl;

  factory _PageAlert.fromJson(Map<String, dynamic> json) =
      _$PageAlertImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get body;
  @override
  String get priority;
  @override
  List<String> get areas;

  /// Create a copy of PageAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PageAlertImplCopyWith<_$PageAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceLink _$ServiceLinkFromJson(Map<String, dynamic> json) {
  return _ServiceLink.fromJson(json);
}

/// @nodoc
mixin _$ServiceLink {
  String get label => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;

  /// Serializes this ServiceLink to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceLink
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceLinkCopyWith<ServiceLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceLinkCopyWith<$Res> {
  factory $ServiceLinkCopyWith(
    ServiceLink value,
    $Res Function(ServiceLink) then,
  ) = _$ServiceLinkCopyWithImpl<$Res, ServiceLink>;
  @useResult
  $Res call({String label, String url, String? type});
}

/// @nodoc
class _$ServiceLinkCopyWithImpl<$Res, $Val extends ServiceLink>
    implements $ServiceLinkCopyWith<$Res> {
  _$ServiceLinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceLink
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? url = null,
    Object? type = freezed,
  }) {
    return _then(
      _value.copyWith(
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            type: freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ServiceLinkImplCopyWith<$Res>
    implements $ServiceLinkCopyWith<$Res> {
  factory _$$ServiceLinkImplCopyWith(
    _$ServiceLinkImpl value,
    $Res Function(_$ServiceLinkImpl) then,
  ) = __$$ServiceLinkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, String url, String? type});
}

/// @nodoc
class __$$ServiceLinkImplCopyWithImpl<$Res>
    extends _$ServiceLinkCopyWithImpl<$Res, _$ServiceLinkImpl>
    implements _$$ServiceLinkImplCopyWith<$Res> {
  __$$ServiceLinkImplCopyWithImpl(
    _$ServiceLinkImpl _value,
    $Res Function(_$ServiceLinkImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServiceLink
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? url = null,
    Object? type = freezed,
  }) {
    return _then(
      _$ServiceLinkImpl(
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceLinkImpl implements _ServiceLink {
  const _$ServiceLinkImpl({required this.label, required this.url, this.type});

  factory _$ServiceLinkImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceLinkImplFromJson(json);

  @override
  final String label;
  @override
  final String url;
  @override
  final String? type;

  @override
  String toString() {
    return 'ServiceLink(label: $label, url: $url, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceLinkImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, url, type);

  /// Create a copy of ServiceLink
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceLinkImplCopyWith<_$ServiceLinkImpl> get copyWith =>
      __$$ServiceLinkImplCopyWithImpl<_$ServiceLinkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceLinkImplToJson(this);
  }
}

abstract class _ServiceLink implements ServiceLink {
  const factory _ServiceLink({
    required final String label,
    required final String url,
    final String? type,
  }) = _$ServiceLinkImpl;

  factory _ServiceLink.fromJson(Map<String, dynamic> json) =
      _$ServiceLinkImpl.fromJson;

  @override
  String get label;
  @override
  String get url;
  @override
  String? get type;

  /// Create a copy of ServiceLink
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceLinkImplCopyWith<_$ServiceLinkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PageStory _$PageStoryFromJson(Map<String, dynamic> json) {
  return _PageStory.fromJson(json);
}

/// @nodoc
mixin _$PageStory {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  int? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PageStory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PageStory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PageStoryCopyWith<PageStory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageStoryCopyWith<$Res> {
  factory $PageStoryCopyWith(PageStory value, $Res Function(PageStory) then) =
      _$PageStoryCopyWithImpl<$Res, PageStory>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'image_url') String imageUrl,
    int duration,
    @JsonKey(name: 'created_at') int? createdAt,
  });
}

/// @nodoc
class _$PageStoryCopyWithImpl<$Res, $Val extends PageStory>
    implements $PageStoryCopyWith<$Res> {
  _$PageStoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PageStory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageUrl = null,
    Object? duration = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PageStoryImplCopyWith<$Res>
    implements $PageStoryCopyWith<$Res> {
  factory _$$PageStoryImplCopyWith(
    _$PageStoryImpl value,
    $Res Function(_$PageStoryImpl) then,
  ) = __$$PageStoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'image_url') String imageUrl,
    int duration,
    @JsonKey(name: 'created_at') int? createdAt,
  });
}

/// @nodoc
class __$$PageStoryImplCopyWithImpl<$Res>
    extends _$PageStoryCopyWithImpl<$Res, _$PageStoryImpl>
    implements _$$PageStoryImplCopyWith<$Res> {
  __$$PageStoryImplCopyWithImpl(
    _$PageStoryImpl _value,
    $Res Function(_$PageStoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PageStory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageUrl = null,
    Object? duration = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$PageStoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PageStoryImpl implements _PageStory {
  const _$PageStoryImpl({
    required this.id,
    @JsonKey(name: 'image_url') required this.imageUrl,
    this.duration = 5,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$PageStoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PageStoryImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @JsonKey()
  final int duration;
  @override
  @JsonKey(name: 'created_at')
  final int? createdAt;

  @override
  String toString() {
    return 'PageStory(id: $id, imageUrl: $imageUrl, duration: $duration, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PageStoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, imageUrl, duration, createdAt);

  /// Create a copy of PageStory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PageStoryImplCopyWith<_$PageStoryImpl> get copyWith =>
      __$$PageStoryImplCopyWithImpl<_$PageStoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PageStoryImplToJson(this);
  }
}

abstract class _PageStory implements PageStory {
  const factory _PageStory({
    required final String id,
    @JsonKey(name: 'image_url') required final String imageUrl,
    final int duration,
    @JsonKey(name: 'created_at') final int? createdAt,
  }) = _$PageStoryImpl;

  factory _PageStory.fromJson(Map<String, dynamic> json) =
      _$PageStoryImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  int get duration;
  @override
  @JsonKey(name: 'created_at')
  int? get createdAt;

  /// Create a copy of PageStory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PageStoryImplCopyWith<_$PageStoryImpl> get copyWith =>
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

MallAnnouncement _$MallAnnouncementFromJson(Map<String, dynamic> json) {
  return _MallAnnouncement.fromJson(json);
}

/// @nodoc
mixin _$MallAnnouncement {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String? get badge => throw _privateConstructorUsedError;
  @JsonKey(name: 'valid_until')
  String? get validUntil => throw _privateConstructorUsedError;

  /// Serializes this MallAnnouncement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MallAnnouncement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MallAnnouncementCopyWith<MallAnnouncement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MallAnnouncementCopyWith<$Res> {
  factory $MallAnnouncementCopyWith(
    MallAnnouncement value,
    $Res Function(MallAnnouncement) then,
  ) = _$MallAnnouncementCopyWithImpl<$Res, MallAnnouncement>;
  @useResult
  $Res call({
    String id,
    String type,
    String title,
    String body,
    String? badge,
    @JsonKey(name: 'valid_until') String? validUntil,
  });
}

/// @nodoc
class _$MallAnnouncementCopyWithImpl<$Res, $Val extends MallAnnouncement>
    implements $MallAnnouncementCopyWith<$Res> {
  _$MallAnnouncementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MallAnnouncement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? body = null,
    Object? badge = freezed,
    Object? validUntil = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            body: null == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                      as String,
            badge: freezed == badge
                ? _value.badge
                : badge // ignore: cast_nullable_to_non_nullable
                      as String?,
            validUntil: freezed == validUntil
                ? _value.validUntil
                : validUntil // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MallAnnouncementImplCopyWith<$Res>
    implements $MallAnnouncementCopyWith<$Res> {
  factory _$$MallAnnouncementImplCopyWith(
    _$MallAnnouncementImpl value,
    $Res Function(_$MallAnnouncementImpl) then,
  ) = __$$MallAnnouncementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    String title,
    String body,
    String? badge,
    @JsonKey(name: 'valid_until') String? validUntil,
  });
}

/// @nodoc
class __$$MallAnnouncementImplCopyWithImpl<$Res>
    extends _$MallAnnouncementCopyWithImpl<$Res, _$MallAnnouncementImpl>
    implements _$$MallAnnouncementImplCopyWith<$Res> {
  __$$MallAnnouncementImplCopyWithImpl(
    _$MallAnnouncementImpl _value,
    $Res Function(_$MallAnnouncementImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MallAnnouncement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? body = null,
    Object? badge = freezed,
    Object? validUntil = freezed,
  }) {
    return _then(
      _$MallAnnouncementImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        body: null == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String,
        badge: freezed == badge
            ? _value.badge
            : badge // ignore: cast_nullable_to_non_nullable
                  as String?,
        validUntil: freezed == validUntil
            ? _value.validUntil
            : validUntil // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MallAnnouncementImpl implements _MallAnnouncement {
  const _$MallAnnouncementImpl({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    this.badge,
    @JsonKey(name: 'valid_until') this.validUntil,
  });

  factory _$MallAnnouncementImpl.fromJson(Map<String, dynamic> json) =>
      _$$MallAnnouncementImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String title;
  @override
  final String body;
  @override
  final String? badge;
  @override
  @JsonKey(name: 'valid_until')
  final String? validUntil;

  @override
  String toString() {
    return 'MallAnnouncement(id: $id, type: $type, title: $title, body: $body, badge: $badge, validUntil: $validUntil)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MallAnnouncementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.badge, badge) || other.badge == badge) &&
            (identical(other.validUntil, validUntil) ||
                other.validUntil == validUntil));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, title, body, badge, validUntil);

  /// Create a copy of MallAnnouncement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MallAnnouncementImplCopyWith<_$MallAnnouncementImpl> get copyWith =>
      __$$MallAnnouncementImplCopyWithImpl<_$MallAnnouncementImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MallAnnouncementImplToJson(this);
  }
}

abstract class _MallAnnouncement implements MallAnnouncement {
  const factory _MallAnnouncement({
    required final String id,
    required final String type,
    required final String title,
    required final String body,
    final String? badge,
    @JsonKey(name: 'valid_until') final String? validUntil,
  }) = _$MallAnnouncementImpl;

  factory _MallAnnouncement.fromJson(Map<String, dynamic> json) =
      _$MallAnnouncementImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get title;
  @override
  String get body;
  @override
  String? get badge;
  @override
  @JsonKey(name: 'valid_until')
  String? get validUntil;

  /// Create a copy of MallAnnouncement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MallAnnouncementImplCopyWith<_$MallAnnouncementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DirectoryStats _$DirectoryStatsFromJson(Map<String, dynamic> json) {
  return _DirectoryStats.fromJson(json);
}

/// @nodoc
mixin _$DirectoryStats {
  @JsonKey(name: 'total_tenants')
  int get totalTenants => throw _privateConstructorUsedError;
  @JsonKey(name: 'on_honak')
  int get onHonak => throw _privateConstructorUsedError;
  @JsonKey(name: 'open_now')
  int get openNow => throw _privateConstructorUsedError;
  int get floors => throw _privateConstructorUsedError;

  /// Serializes this DirectoryStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DirectoryStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DirectoryStatsCopyWith<DirectoryStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectoryStatsCopyWith<$Res> {
  factory $DirectoryStatsCopyWith(
    DirectoryStats value,
    $Res Function(DirectoryStats) then,
  ) = _$DirectoryStatsCopyWithImpl<$Res, DirectoryStats>;
  @useResult
  $Res call({
    @JsonKey(name: 'total_tenants') int totalTenants,
    @JsonKey(name: 'on_honak') int onHonak,
    @JsonKey(name: 'open_now') int openNow,
    int floors,
  });
}

/// @nodoc
class _$DirectoryStatsCopyWithImpl<$Res, $Val extends DirectoryStats>
    implements $DirectoryStatsCopyWith<$Res> {
  _$DirectoryStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DirectoryStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalTenants = null,
    Object? onHonak = null,
    Object? openNow = null,
    Object? floors = null,
  }) {
    return _then(
      _value.copyWith(
            totalTenants: null == totalTenants
                ? _value.totalTenants
                : totalTenants // ignore: cast_nullable_to_non_nullable
                      as int,
            onHonak: null == onHonak
                ? _value.onHonak
                : onHonak // ignore: cast_nullable_to_non_nullable
                      as int,
            openNow: null == openNow
                ? _value.openNow
                : openNow // ignore: cast_nullable_to_non_nullable
                      as int,
            floors: null == floors
                ? _value.floors
                : floors // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DirectoryStatsImplCopyWith<$Res>
    implements $DirectoryStatsCopyWith<$Res> {
  factory _$$DirectoryStatsImplCopyWith(
    _$DirectoryStatsImpl value,
    $Res Function(_$DirectoryStatsImpl) then,
  ) = __$$DirectoryStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'total_tenants') int totalTenants,
    @JsonKey(name: 'on_honak') int onHonak,
    @JsonKey(name: 'open_now') int openNow,
    int floors,
  });
}

/// @nodoc
class __$$DirectoryStatsImplCopyWithImpl<$Res>
    extends _$DirectoryStatsCopyWithImpl<$Res, _$DirectoryStatsImpl>
    implements _$$DirectoryStatsImplCopyWith<$Res> {
  __$$DirectoryStatsImplCopyWithImpl(
    _$DirectoryStatsImpl _value,
    $Res Function(_$DirectoryStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DirectoryStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalTenants = null,
    Object? onHonak = null,
    Object? openNow = null,
    Object? floors = null,
  }) {
    return _then(
      _$DirectoryStatsImpl(
        totalTenants: null == totalTenants
            ? _value.totalTenants
            : totalTenants // ignore: cast_nullable_to_non_nullable
                  as int,
        onHonak: null == onHonak
            ? _value.onHonak
            : onHonak // ignore: cast_nullable_to_non_nullable
                  as int,
        openNow: null == openNow
            ? _value.openNow
            : openNow // ignore: cast_nullable_to_non_nullable
                  as int,
        floors: null == floors
            ? _value.floors
            : floors // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DirectoryStatsImpl implements _DirectoryStats {
  const _$DirectoryStatsImpl({
    @JsonKey(name: 'total_tenants') this.totalTenants = 0,
    @JsonKey(name: 'on_honak') this.onHonak = 0,
    @JsonKey(name: 'open_now') this.openNow = 0,
    this.floors = 0,
  });

  factory _$DirectoryStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DirectoryStatsImplFromJson(json);

  @override
  @JsonKey(name: 'total_tenants')
  final int totalTenants;
  @override
  @JsonKey(name: 'on_honak')
  final int onHonak;
  @override
  @JsonKey(name: 'open_now')
  final int openNow;
  @override
  @JsonKey()
  final int floors;

  @override
  String toString() {
    return 'DirectoryStats(totalTenants: $totalTenants, onHonak: $onHonak, openNow: $openNow, floors: $floors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DirectoryStatsImpl &&
            (identical(other.totalTenants, totalTenants) ||
                other.totalTenants == totalTenants) &&
            (identical(other.onHonak, onHonak) || other.onHonak == onHonak) &&
            (identical(other.openNow, openNow) || other.openNow == openNow) &&
            (identical(other.floors, floors) || other.floors == floors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, totalTenants, onHonak, openNow, floors);

  /// Create a copy of DirectoryStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DirectoryStatsImplCopyWith<_$DirectoryStatsImpl> get copyWith =>
      __$$DirectoryStatsImplCopyWithImpl<_$DirectoryStatsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DirectoryStatsImplToJson(this);
  }
}

abstract class _DirectoryStats implements DirectoryStats {
  const factory _DirectoryStats({
    @JsonKey(name: 'total_tenants') final int totalTenants,
    @JsonKey(name: 'on_honak') final int onHonak,
    @JsonKey(name: 'open_now') final int openNow,
    final int floors,
  }) = _$DirectoryStatsImpl;

  factory _DirectoryStats.fromJson(Map<String, dynamic> json) =
      _$DirectoryStatsImpl.fromJson;

  @override
  @JsonKey(name: 'total_tenants')
  int get totalTenants;
  @override
  @JsonKey(name: 'on_honak')
  int get onHonak;
  @override
  @JsonKey(name: 'open_now')
  int get openNow;
  @override
  int get floors;

  /// Create a copy of DirectoryStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DirectoryStatsImplCopyWith<_$DirectoryStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
