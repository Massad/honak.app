// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dropoff_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DropoffDayStats _$DropoffDayStatsFromJson(Map<String, dynamic> json) {
  return _DropoffDayStats.fromJson(json);
}

/// @nodoc
mixin _$DropoffDayStats {
  @JsonKey(name: 'total_today')
  int get totalToday => throw _privateConstructorUsedError;
  int get received => throw _privateConstructorUsedError;
  int get processing => throw _privateConstructorUsedError;
  int get ready => throw _privateConstructorUsedError;
  int get delivered => throw _privateConstructorUsedError;
  int get overdue => throw _privateConstructorUsedError;
  @JsonKey(name: 'revenue_today_cents')
  int get revenueToday => throw _privateConstructorUsedError;

  /// Serializes this DropoffDayStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DropoffDayStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DropoffDayStatsCopyWith<DropoffDayStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DropoffDayStatsCopyWith<$Res> {
  factory $DropoffDayStatsCopyWith(
    DropoffDayStats value,
    $Res Function(DropoffDayStats) then,
  ) = _$DropoffDayStatsCopyWithImpl<$Res, DropoffDayStats>;
  @useResult
  $Res call({
    @JsonKey(name: 'total_today') int totalToday,
    int received,
    int processing,
    int ready,
    int delivered,
    int overdue,
    @JsonKey(name: 'revenue_today_cents') int revenueToday,
  });
}

/// @nodoc
class _$DropoffDayStatsCopyWithImpl<$Res, $Val extends DropoffDayStats>
    implements $DropoffDayStatsCopyWith<$Res> {
  _$DropoffDayStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DropoffDayStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalToday = null,
    Object? received = null,
    Object? processing = null,
    Object? ready = null,
    Object? delivered = null,
    Object? overdue = null,
    Object? revenueToday = null,
  }) {
    return _then(
      _value.copyWith(
            totalToday: null == totalToday
                ? _value.totalToday
                : totalToday // ignore: cast_nullable_to_non_nullable
                      as int,
            received: null == received
                ? _value.received
                : received // ignore: cast_nullable_to_non_nullable
                      as int,
            processing: null == processing
                ? _value.processing
                : processing // ignore: cast_nullable_to_non_nullable
                      as int,
            ready: null == ready
                ? _value.ready
                : ready // ignore: cast_nullable_to_non_nullable
                      as int,
            delivered: null == delivered
                ? _value.delivered
                : delivered // ignore: cast_nullable_to_non_nullable
                      as int,
            overdue: null == overdue
                ? _value.overdue
                : overdue // ignore: cast_nullable_to_non_nullable
                      as int,
            revenueToday: null == revenueToday
                ? _value.revenueToday
                : revenueToday // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DropoffDayStatsImplCopyWith<$Res>
    implements $DropoffDayStatsCopyWith<$Res> {
  factory _$$DropoffDayStatsImplCopyWith(
    _$DropoffDayStatsImpl value,
    $Res Function(_$DropoffDayStatsImpl) then,
  ) = __$$DropoffDayStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'total_today') int totalToday,
    int received,
    int processing,
    int ready,
    int delivered,
    int overdue,
    @JsonKey(name: 'revenue_today_cents') int revenueToday,
  });
}

/// @nodoc
class __$$DropoffDayStatsImplCopyWithImpl<$Res>
    extends _$DropoffDayStatsCopyWithImpl<$Res, _$DropoffDayStatsImpl>
    implements _$$DropoffDayStatsImplCopyWith<$Res> {
  __$$DropoffDayStatsImplCopyWithImpl(
    _$DropoffDayStatsImpl _value,
    $Res Function(_$DropoffDayStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DropoffDayStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalToday = null,
    Object? received = null,
    Object? processing = null,
    Object? ready = null,
    Object? delivered = null,
    Object? overdue = null,
    Object? revenueToday = null,
  }) {
    return _then(
      _$DropoffDayStatsImpl(
        totalToday: null == totalToday
            ? _value.totalToday
            : totalToday // ignore: cast_nullable_to_non_nullable
                  as int,
        received: null == received
            ? _value.received
            : received // ignore: cast_nullable_to_non_nullable
                  as int,
        processing: null == processing
            ? _value.processing
            : processing // ignore: cast_nullable_to_non_nullable
                  as int,
        ready: null == ready
            ? _value.ready
            : ready // ignore: cast_nullable_to_non_nullable
                  as int,
        delivered: null == delivered
            ? _value.delivered
            : delivered // ignore: cast_nullable_to_non_nullable
                  as int,
        overdue: null == overdue
            ? _value.overdue
            : overdue // ignore: cast_nullable_to_non_nullable
                  as int,
        revenueToday: null == revenueToday
            ? _value.revenueToday
            : revenueToday // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DropoffDayStatsImpl implements _DropoffDayStats {
  const _$DropoffDayStatsImpl({
    @JsonKey(name: 'total_today') this.totalToday = 0,
    this.received = 0,
    this.processing = 0,
    this.ready = 0,
    this.delivered = 0,
    this.overdue = 0,
    @JsonKey(name: 'revenue_today_cents') this.revenueToday = 0,
  });

  factory _$DropoffDayStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DropoffDayStatsImplFromJson(json);

  @override
  @JsonKey(name: 'total_today')
  final int totalToday;
  @override
  @JsonKey()
  final int received;
  @override
  @JsonKey()
  final int processing;
  @override
  @JsonKey()
  final int ready;
  @override
  @JsonKey()
  final int delivered;
  @override
  @JsonKey()
  final int overdue;
  @override
  @JsonKey(name: 'revenue_today_cents')
  final int revenueToday;

  @override
  String toString() {
    return 'DropoffDayStats(totalToday: $totalToday, received: $received, processing: $processing, ready: $ready, delivered: $delivered, overdue: $overdue, revenueToday: $revenueToday)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DropoffDayStatsImpl &&
            (identical(other.totalToday, totalToday) ||
                other.totalToday == totalToday) &&
            (identical(other.received, received) ||
                other.received == received) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.ready, ready) || other.ready == ready) &&
            (identical(other.delivered, delivered) ||
                other.delivered == delivered) &&
            (identical(other.overdue, overdue) || other.overdue == overdue) &&
            (identical(other.revenueToday, revenueToday) ||
                other.revenueToday == revenueToday));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalToday,
    received,
    processing,
    ready,
    delivered,
    overdue,
    revenueToday,
  );

  /// Create a copy of DropoffDayStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DropoffDayStatsImplCopyWith<_$DropoffDayStatsImpl> get copyWith =>
      __$$DropoffDayStatsImplCopyWithImpl<_$DropoffDayStatsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DropoffDayStatsImplToJson(this);
  }
}

abstract class _DropoffDayStats implements DropoffDayStats {
  const factory _DropoffDayStats({
    @JsonKey(name: 'total_today') final int totalToday,
    final int received,
    final int processing,
    final int ready,
    final int delivered,
    final int overdue,
    @JsonKey(name: 'revenue_today_cents') final int revenueToday,
  }) = _$DropoffDayStatsImpl;

  factory _DropoffDayStats.fromJson(Map<String, dynamic> json) =
      _$DropoffDayStatsImpl.fromJson;

  @override
  @JsonKey(name: 'total_today')
  int get totalToday;
  @override
  int get received;
  @override
  int get processing;
  @override
  int get ready;
  @override
  int get delivered;
  @override
  int get overdue;
  @override
  @JsonKey(name: 'revenue_today_cents')
  int get revenueToday;

  /// Create a copy of DropoffDayStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DropoffDayStatsImplCopyWith<_$DropoffDayStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
