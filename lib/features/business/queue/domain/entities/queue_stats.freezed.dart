// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QueueDayStats _$QueueDayStatsFromJson(Map<String, dynamic> json) {
  return _QueueDayStats.fromJson(json);
}

/// @nodoc
mixin _$QueueDayStats {
  @JsonKey(name: 'total_today')
  int get totalToday => throw _privateConstructorUsedError;
  int get completed => throw _privateConstructorUsedError;
  @JsonKey(name: 'in_progress')
  int get inProgress => throw _privateConstructorUsedError;
  int get waiting => throw _privateConstructorUsedError;
  @JsonKey(name: 'no_shows')
  int get noShows => throw _privateConstructorUsedError;
  @JsonKey(name: 'avg_wait_min')
  int get avgWaitMin => throw _privateConstructorUsedError;
  @JsonKey(name: 'avg_service_min')
  int get avgServiceMin => throw _privateConstructorUsedError;
  @JsonKey(name: 'revenue_today_cents')
  int get revenueToday => throw _privateConstructorUsedError;
  @JsonKey(name: 'subscribers_today')
  int get subscribersToday => throw _privateConstructorUsedError;

  /// Serializes this QueueDayStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueueDayStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueueDayStatsCopyWith<QueueDayStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueDayStatsCopyWith<$Res> {
  factory $QueueDayStatsCopyWith(
    QueueDayStats value,
    $Res Function(QueueDayStats) then,
  ) = _$QueueDayStatsCopyWithImpl<$Res, QueueDayStats>;
  @useResult
  $Res call({
    @JsonKey(name: 'total_today') int totalToday,
    int completed,
    @JsonKey(name: 'in_progress') int inProgress,
    int waiting,
    @JsonKey(name: 'no_shows') int noShows,
    @JsonKey(name: 'avg_wait_min') int avgWaitMin,
    @JsonKey(name: 'avg_service_min') int avgServiceMin,
    @JsonKey(name: 'revenue_today_cents') int revenueToday,
    @JsonKey(name: 'subscribers_today') int subscribersToday,
  });
}

/// @nodoc
class _$QueueDayStatsCopyWithImpl<$Res, $Val extends QueueDayStats>
    implements $QueueDayStatsCopyWith<$Res> {
  _$QueueDayStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueueDayStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalToday = null,
    Object? completed = null,
    Object? inProgress = null,
    Object? waiting = null,
    Object? noShows = null,
    Object? avgWaitMin = null,
    Object? avgServiceMin = null,
    Object? revenueToday = null,
    Object? subscribersToday = null,
  }) {
    return _then(
      _value.copyWith(
            totalToday: null == totalToday
                ? _value.totalToday
                : totalToday // ignore: cast_nullable_to_non_nullable
                      as int,
            completed: null == completed
                ? _value.completed
                : completed // ignore: cast_nullable_to_non_nullable
                      as int,
            inProgress: null == inProgress
                ? _value.inProgress
                : inProgress // ignore: cast_nullable_to_non_nullable
                      as int,
            waiting: null == waiting
                ? _value.waiting
                : waiting // ignore: cast_nullable_to_non_nullable
                      as int,
            noShows: null == noShows
                ? _value.noShows
                : noShows // ignore: cast_nullable_to_non_nullable
                      as int,
            avgWaitMin: null == avgWaitMin
                ? _value.avgWaitMin
                : avgWaitMin // ignore: cast_nullable_to_non_nullable
                      as int,
            avgServiceMin: null == avgServiceMin
                ? _value.avgServiceMin
                : avgServiceMin // ignore: cast_nullable_to_non_nullable
                      as int,
            revenueToday: null == revenueToday
                ? _value.revenueToday
                : revenueToday // ignore: cast_nullable_to_non_nullable
                      as int,
            subscribersToday: null == subscribersToday
                ? _value.subscribersToday
                : subscribersToday // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QueueDayStatsImplCopyWith<$Res>
    implements $QueueDayStatsCopyWith<$Res> {
  factory _$$QueueDayStatsImplCopyWith(
    _$QueueDayStatsImpl value,
    $Res Function(_$QueueDayStatsImpl) then,
  ) = __$$QueueDayStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'total_today') int totalToday,
    int completed,
    @JsonKey(name: 'in_progress') int inProgress,
    int waiting,
    @JsonKey(name: 'no_shows') int noShows,
    @JsonKey(name: 'avg_wait_min') int avgWaitMin,
    @JsonKey(name: 'avg_service_min') int avgServiceMin,
    @JsonKey(name: 'revenue_today_cents') int revenueToday,
    @JsonKey(name: 'subscribers_today') int subscribersToday,
  });
}

/// @nodoc
class __$$QueueDayStatsImplCopyWithImpl<$Res>
    extends _$QueueDayStatsCopyWithImpl<$Res, _$QueueDayStatsImpl>
    implements _$$QueueDayStatsImplCopyWith<$Res> {
  __$$QueueDayStatsImplCopyWithImpl(
    _$QueueDayStatsImpl _value,
    $Res Function(_$QueueDayStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueueDayStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalToday = null,
    Object? completed = null,
    Object? inProgress = null,
    Object? waiting = null,
    Object? noShows = null,
    Object? avgWaitMin = null,
    Object? avgServiceMin = null,
    Object? revenueToday = null,
    Object? subscribersToday = null,
  }) {
    return _then(
      _$QueueDayStatsImpl(
        totalToday: null == totalToday
            ? _value.totalToday
            : totalToday // ignore: cast_nullable_to_non_nullable
                  as int,
        completed: null == completed
            ? _value.completed
            : completed // ignore: cast_nullable_to_non_nullable
                  as int,
        inProgress: null == inProgress
            ? _value.inProgress
            : inProgress // ignore: cast_nullable_to_non_nullable
                  as int,
        waiting: null == waiting
            ? _value.waiting
            : waiting // ignore: cast_nullable_to_non_nullable
                  as int,
        noShows: null == noShows
            ? _value.noShows
            : noShows // ignore: cast_nullable_to_non_nullable
                  as int,
        avgWaitMin: null == avgWaitMin
            ? _value.avgWaitMin
            : avgWaitMin // ignore: cast_nullable_to_non_nullable
                  as int,
        avgServiceMin: null == avgServiceMin
            ? _value.avgServiceMin
            : avgServiceMin // ignore: cast_nullable_to_non_nullable
                  as int,
        revenueToday: null == revenueToday
            ? _value.revenueToday
            : revenueToday // ignore: cast_nullable_to_non_nullable
                  as int,
        subscribersToday: null == subscribersToday
            ? _value.subscribersToday
            : subscribersToday // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueDayStatsImpl implements _QueueDayStats {
  const _$QueueDayStatsImpl({
    @JsonKey(name: 'total_today') this.totalToday = 0,
    this.completed = 0,
    @JsonKey(name: 'in_progress') this.inProgress = 0,
    this.waiting = 0,
    @JsonKey(name: 'no_shows') this.noShows = 0,
    @JsonKey(name: 'avg_wait_min') this.avgWaitMin = 0,
    @JsonKey(name: 'avg_service_min') this.avgServiceMin = 0,
    @JsonKey(name: 'revenue_today_cents') this.revenueToday = 0,
    @JsonKey(name: 'subscribers_today') this.subscribersToday = 0,
  });

  factory _$QueueDayStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueDayStatsImplFromJson(json);

  @override
  @JsonKey(name: 'total_today')
  final int totalToday;
  @override
  @JsonKey()
  final int completed;
  @override
  @JsonKey(name: 'in_progress')
  final int inProgress;
  @override
  @JsonKey()
  final int waiting;
  @override
  @JsonKey(name: 'no_shows')
  final int noShows;
  @override
  @JsonKey(name: 'avg_wait_min')
  final int avgWaitMin;
  @override
  @JsonKey(name: 'avg_service_min')
  final int avgServiceMin;
  @override
  @JsonKey(name: 'revenue_today_cents')
  final int revenueToday;
  @override
  @JsonKey(name: 'subscribers_today')
  final int subscribersToday;

  @override
  String toString() {
    return 'QueueDayStats(totalToday: $totalToday, completed: $completed, inProgress: $inProgress, waiting: $waiting, noShows: $noShows, avgWaitMin: $avgWaitMin, avgServiceMin: $avgServiceMin, revenueToday: $revenueToday, subscribersToday: $subscribersToday)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueDayStatsImpl &&
            (identical(other.totalToday, totalToday) ||
                other.totalToday == totalToday) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.inProgress, inProgress) ||
                other.inProgress == inProgress) &&
            (identical(other.waiting, waiting) || other.waiting == waiting) &&
            (identical(other.noShows, noShows) || other.noShows == noShows) &&
            (identical(other.avgWaitMin, avgWaitMin) ||
                other.avgWaitMin == avgWaitMin) &&
            (identical(other.avgServiceMin, avgServiceMin) ||
                other.avgServiceMin == avgServiceMin) &&
            (identical(other.revenueToday, revenueToday) ||
                other.revenueToday == revenueToday) &&
            (identical(other.subscribersToday, subscribersToday) ||
                other.subscribersToday == subscribersToday));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalToday,
    completed,
    inProgress,
    waiting,
    noShows,
    avgWaitMin,
    avgServiceMin,
    revenueToday,
    subscribersToday,
  );

  /// Create a copy of QueueDayStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueDayStatsImplCopyWith<_$QueueDayStatsImpl> get copyWith =>
      __$$QueueDayStatsImplCopyWithImpl<_$QueueDayStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueDayStatsImplToJson(this);
  }
}

abstract class _QueueDayStats implements QueueDayStats {
  const factory _QueueDayStats({
    @JsonKey(name: 'total_today') final int totalToday,
    final int completed,
    @JsonKey(name: 'in_progress') final int inProgress,
    final int waiting,
    @JsonKey(name: 'no_shows') final int noShows,
    @JsonKey(name: 'avg_wait_min') final int avgWaitMin,
    @JsonKey(name: 'avg_service_min') final int avgServiceMin,
    @JsonKey(name: 'revenue_today_cents') final int revenueToday,
    @JsonKey(name: 'subscribers_today') final int subscribersToday,
  }) = _$QueueDayStatsImpl;

  factory _QueueDayStats.fromJson(Map<String, dynamic> json) =
      _$QueueDayStatsImpl.fromJson;

  @override
  @JsonKey(name: 'total_today')
  int get totalToday;
  @override
  int get completed;
  @override
  @JsonKey(name: 'in_progress')
  int get inProgress;
  @override
  int get waiting;
  @override
  @JsonKey(name: 'no_shows')
  int get noShows;
  @override
  @JsonKey(name: 'avg_wait_min')
  int get avgWaitMin;
  @override
  @JsonKey(name: 'avg_service_min')
  int get avgServiceMin;
  @override
  @JsonKey(name: 'revenue_today_cents')
  int get revenueToday;
  @override
  @JsonKey(name: 'subscribers_today')
  int get subscribersToday;

  /// Create a copy of QueueDayStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueDayStatsImplCopyWith<_$QueueDayStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
