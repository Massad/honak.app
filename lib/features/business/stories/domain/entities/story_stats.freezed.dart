// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StoryStats _$StoryStatsFromJson(Map<String, dynamic> json) {
  return _StoryStats.fromJson(json);
}

/// @nodoc
mixin _$StoryStats {
  int get views => throw _privateConstructorUsedError;
  @JsonKey(name: 'unique_reach')
  int get uniqueReach => throw _privateConstructorUsedError;
  int get shares => throw _privateConstructorUsedError;
  int get messages => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_visits')
  int get profileVisits => throw _privateConstructorUsedError;
  @JsonKey(name: 'link_clicks')
  int get linkClicks => throw _privateConstructorUsedError;

  /// Serializes this StoryStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryStatsCopyWith<StoryStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryStatsCopyWith<$Res> {
  factory $StoryStatsCopyWith(
    StoryStats value,
    $Res Function(StoryStats) then,
  ) = _$StoryStatsCopyWithImpl<$Res, StoryStats>;
  @useResult
  $Res call({
    int views,
    @JsonKey(name: 'unique_reach') int uniqueReach,
    int shares,
    int messages,
    @JsonKey(name: 'profile_visits') int profileVisits,
    @JsonKey(name: 'link_clicks') int linkClicks,
  });
}

/// @nodoc
class _$StoryStatsCopyWithImpl<$Res, $Val extends StoryStats>
    implements $StoryStatsCopyWith<$Res> {
  _$StoryStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? views = null,
    Object? uniqueReach = null,
    Object? shares = null,
    Object? messages = null,
    Object? profileVisits = null,
    Object? linkClicks = null,
  }) {
    return _then(
      _value.copyWith(
            views: null == views
                ? _value.views
                : views // ignore: cast_nullable_to_non_nullable
                      as int,
            uniqueReach: null == uniqueReach
                ? _value.uniqueReach
                : uniqueReach // ignore: cast_nullable_to_non_nullable
                      as int,
            shares: null == shares
                ? _value.shares
                : shares // ignore: cast_nullable_to_non_nullable
                      as int,
            messages: null == messages
                ? _value.messages
                : messages // ignore: cast_nullable_to_non_nullable
                      as int,
            profileVisits: null == profileVisits
                ? _value.profileVisits
                : profileVisits // ignore: cast_nullable_to_non_nullable
                      as int,
            linkClicks: null == linkClicks
                ? _value.linkClicks
                : linkClicks // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoryStatsImplCopyWith<$Res>
    implements $StoryStatsCopyWith<$Res> {
  factory _$$StoryStatsImplCopyWith(
    _$StoryStatsImpl value,
    $Res Function(_$StoryStatsImpl) then,
  ) = __$$StoryStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int views,
    @JsonKey(name: 'unique_reach') int uniqueReach,
    int shares,
    int messages,
    @JsonKey(name: 'profile_visits') int profileVisits,
    @JsonKey(name: 'link_clicks') int linkClicks,
  });
}

/// @nodoc
class __$$StoryStatsImplCopyWithImpl<$Res>
    extends _$StoryStatsCopyWithImpl<$Res, _$StoryStatsImpl>
    implements _$$StoryStatsImplCopyWith<$Res> {
  __$$StoryStatsImplCopyWithImpl(
    _$StoryStatsImpl _value,
    $Res Function(_$StoryStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? views = null,
    Object? uniqueReach = null,
    Object? shares = null,
    Object? messages = null,
    Object? profileVisits = null,
    Object? linkClicks = null,
  }) {
    return _then(
      _$StoryStatsImpl(
        views: null == views
            ? _value.views
            : views // ignore: cast_nullable_to_non_nullable
                  as int,
        uniqueReach: null == uniqueReach
            ? _value.uniqueReach
            : uniqueReach // ignore: cast_nullable_to_non_nullable
                  as int,
        shares: null == shares
            ? _value.shares
            : shares // ignore: cast_nullable_to_non_nullable
                  as int,
        messages: null == messages
            ? _value.messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as int,
        profileVisits: null == profileVisits
            ? _value.profileVisits
            : profileVisits // ignore: cast_nullable_to_non_nullable
                  as int,
        linkClicks: null == linkClicks
            ? _value.linkClicks
            : linkClicks // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryStatsImpl implements _StoryStats {
  const _$StoryStatsImpl({
    this.views = 0,
    @JsonKey(name: 'unique_reach') this.uniqueReach = 0,
    this.shares = 0,
    this.messages = 0,
    @JsonKey(name: 'profile_visits') this.profileVisits = 0,
    @JsonKey(name: 'link_clicks') this.linkClicks = 0,
  });

  factory _$StoryStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryStatsImplFromJson(json);

  @override
  @JsonKey()
  final int views;
  @override
  @JsonKey(name: 'unique_reach')
  final int uniqueReach;
  @override
  @JsonKey()
  final int shares;
  @override
  @JsonKey()
  final int messages;
  @override
  @JsonKey(name: 'profile_visits')
  final int profileVisits;
  @override
  @JsonKey(name: 'link_clicks')
  final int linkClicks;

  @override
  String toString() {
    return 'StoryStats(views: $views, uniqueReach: $uniqueReach, shares: $shares, messages: $messages, profileVisits: $profileVisits, linkClicks: $linkClicks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryStatsImpl &&
            (identical(other.views, views) || other.views == views) &&
            (identical(other.uniqueReach, uniqueReach) ||
                other.uniqueReach == uniqueReach) &&
            (identical(other.shares, shares) || other.shares == shares) &&
            (identical(other.messages, messages) ||
                other.messages == messages) &&
            (identical(other.profileVisits, profileVisits) ||
                other.profileVisits == profileVisits) &&
            (identical(other.linkClicks, linkClicks) ||
                other.linkClicks == linkClicks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    views,
    uniqueReach,
    shares,
    messages,
    profileVisits,
    linkClicks,
  );

  /// Create a copy of StoryStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryStatsImplCopyWith<_$StoryStatsImpl> get copyWith =>
      __$$StoryStatsImplCopyWithImpl<_$StoryStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryStatsImplToJson(this);
  }
}

abstract class _StoryStats implements StoryStats {
  const factory _StoryStats({
    final int views,
    @JsonKey(name: 'unique_reach') final int uniqueReach,
    final int shares,
    final int messages,
    @JsonKey(name: 'profile_visits') final int profileVisits,
    @JsonKey(name: 'link_clicks') final int linkClicks,
  }) = _$StoryStatsImpl;

  factory _StoryStats.fromJson(Map<String, dynamic> json) =
      _$StoryStatsImpl.fromJson;

  @override
  int get views;
  @override
  @JsonKey(name: 'unique_reach')
  int get uniqueReach;
  @override
  int get shares;
  @override
  int get messages;
  @override
  @JsonKey(name: 'profile_visits')
  int get profileVisits;
  @override
  @JsonKey(name: 'link_clicks')
  int get linkClicks;

  /// Create a copy of StoryStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryStatsImplCopyWith<_$StoryStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
