// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_story.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MyStory _$MyStoryFromJson(Map<String, dynamic> json) {
  return _MyStory.fromJson(json);
}

/// @nodoc
mixin _$MyStory {
  String get id => throw _privateConstructorUsedError;
  StorySlide get slide => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get audience => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  String? get expiresAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'scheduled_at')
  String? get scheduledAt => throw _privateConstructorUsedError;
  StoryStats get stats => throw _privateConstructorUsedError;

  /// Serializes this MyStory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MyStory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MyStoryCopyWith<MyStory> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyStoryCopyWith<$Res> {
  factory $MyStoryCopyWith(MyStory value, $Res Function(MyStory) then) =
      _$MyStoryCopyWithImpl<$Res, MyStory>;
  @useResult
  $Res call({
    String id,
    StorySlide slide,
    String status,
    String audience,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'expires_at') String? expiresAt,
    @JsonKey(name: 'scheduled_at') String? scheduledAt,
    StoryStats stats,
  });

  $StorySlideCopyWith<$Res> get slide;
  $StoryStatsCopyWith<$Res> get stats;
}

/// @nodoc
class _$MyStoryCopyWithImpl<$Res, $Val extends MyStory>
    implements $MyStoryCopyWith<$Res> {
  _$MyStoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyStory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? slide = null,
    Object? status = null,
    Object? audience = null,
    Object? createdAt = freezed,
    Object? expiresAt = freezed,
    Object? scheduledAt = freezed,
    Object? stats = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            slide: null == slide
                ? _value.slide
                : slide // ignore: cast_nullable_to_non_nullable
                      as StorySlide,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            audience: null == audience
                ? _value.audience
                : audience // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            scheduledAt: freezed == scheduledAt
                ? _value.scheduledAt
                : scheduledAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            stats: null == stats
                ? _value.stats
                : stats // ignore: cast_nullable_to_non_nullable
                      as StoryStats,
          )
          as $Val,
    );
  }

  /// Create a copy of MyStory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StorySlideCopyWith<$Res> get slide {
    return $StorySlideCopyWith<$Res>(_value.slide, (value) {
      return _then(_value.copyWith(slide: value) as $Val);
    });
  }

  /// Create a copy of MyStory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StoryStatsCopyWith<$Res> get stats {
    return $StoryStatsCopyWith<$Res>(_value.stats, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MyStoryImplCopyWith<$Res> implements $MyStoryCopyWith<$Res> {
  factory _$$MyStoryImplCopyWith(
    _$MyStoryImpl value,
    $Res Function(_$MyStoryImpl) then,
  ) = __$$MyStoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    StorySlide slide,
    String status,
    String audience,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'expires_at') String? expiresAt,
    @JsonKey(name: 'scheduled_at') String? scheduledAt,
    StoryStats stats,
  });

  @override
  $StorySlideCopyWith<$Res> get slide;
  @override
  $StoryStatsCopyWith<$Res> get stats;
}

/// @nodoc
class __$$MyStoryImplCopyWithImpl<$Res>
    extends _$MyStoryCopyWithImpl<$Res, _$MyStoryImpl>
    implements _$$MyStoryImplCopyWith<$Res> {
  __$$MyStoryImplCopyWithImpl(
    _$MyStoryImpl _value,
    $Res Function(_$MyStoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyStory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? slide = null,
    Object? status = null,
    Object? audience = null,
    Object? createdAt = freezed,
    Object? expiresAt = freezed,
    Object? scheduledAt = freezed,
    Object? stats = null,
  }) {
    return _then(
      _$MyStoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        slide: null == slide
            ? _value.slide
            : slide // ignore: cast_nullable_to_non_nullable
                  as StorySlide,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        audience: null == audience
            ? _value.audience
            : audience // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        scheduledAt: freezed == scheduledAt
            ? _value.scheduledAt
            : scheduledAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        stats: null == stats
            ? _value.stats
            : stats // ignore: cast_nullable_to_non_nullable
                  as StoryStats,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MyStoryImpl implements _MyStory {
  const _$MyStoryImpl({
    required this.id,
    required this.slide,
    this.status = 'live',
    this.audience = 'followers',
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'expires_at') this.expiresAt,
    @JsonKey(name: 'scheduled_at') this.scheduledAt,
    this.stats = const StoryStats(),
  });

  factory _$MyStoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$MyStoryImplFromJson(json);

  @override
  final String id;
  @override
  final StorySlide slide;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String audience;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'expires_at')
  final String? expiresAt;
  @override
  @JsonKey(name: 'scheduled_at')
  final String? scheduledAt;
  @override
  @JsonKey()
  final StoryStats stats;

  @override
  String toString() {
    return 'MyStory(id: $id, slide: $slide, status: $status, audience: $audience, createdAt: $createdAt, expiresAt: $expiresAt, scheduledAt: $scheduledAt, stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyStoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.slide, slide) || other.slide == slide) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.audience, audience) ||
                other.audience == audience) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.stats, stats) || other.stats == stats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    slide,
    status,
    audience,
    createdAt,
    expiresAt,
    scheduledAt,
    stats,
  );

  /// Create a copy of MyStory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyStoryImplCopyWith<_$MyStoryImpl> get copyWith =>
      __$$MyStoryImplCopyWithImpl<_$MyStoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MyStoryImplToJson(this);
  }
}

abstract class _MyStory implements MyStory {
  const factory _MyStory({
    required final String id,
    required final StorySlide slide,
    final String status,
    final String audience,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'expires_at') final String? expiresAt,
    @JsonKey(name: 'scheduled_at') final String? scheduledAt,
    final StoryStats stats,
  }) = _$MyStoryImpl;

  factory _MyStory.fromJson(Map<String, dynamic> json) = _$MyStoryImpl.fromJson;

  @override
  String get id;
  @override
  StorySlide get slide;
  @override
  String get status;
  @override
  String get audience;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'expires_at')
  String? get expiresAt;
  @override
  @JsonKey(name: 'scheduled_at')
  String? get scheduledAt;
  @override
  StoryStats get stats;

  /// Create a copy of MyStory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyStoryImplCopyWith<_$MyStoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
