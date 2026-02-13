// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alert_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BusinessAlert _$BusinessAlertFromJson(Map<String, dynamic> json) {
  return _BusinessAlert.fromJson(json);
}

/// @nodoc
mixin _$BusinessAlert {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  int? get expiresAt => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  int get createdAt => throw _privateConstructorUsedError;
  int get views => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_areas')
  List<String> get targetAreas => throw _privateConstructorUsedError;

  /// Serializes this BusinessAlert to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusinessAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessAlertCopyWith<BusinessAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessAlertCopyWith<$Res> {
  factory $BusinessAlertCopyWith(
    BusinessAlert value,
    $Res Function(BusinessAlert) then,
  ) = _$BusinessAlertCopyWithImpl<$Res, BusinessAlert>;
  @useResult
  $Res call({
    String id,
    String title,
    String body,
    String severity,
    @JsonKey(name: 'expires_at') int? expiresAt,
    bool active,
    @JsonKey(name: 'created_at') int createdAt,
    int views,
    @JsonKey(name: 'target_areas') List<String> targetAreas,
  });
}

/// @nodoc
class _$BusinessAlertCopyWithImpl<$Res, $Val extends BusinessAlert>
    implements $BusinessAlertCopyWith<$Res> {
  _$BusinessAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? severity = null,
    Object? expiresAt = freezed,
    Object? active = null,
    Object? createdAt = null,
    Object? views = null,
    Object? targetAreas = null,
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
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as String,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as int?,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as int,
            views: null == views
                ? _value.views
                : views // ignore: cast_nullable_to_non_nullable
                      as int,
            targetAreas: null == targetAreas
                ? _value.targetAreas
                : targetAreas // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BusinessAlertImplCopyWith<$Res>
    implements $BusinessAlertCopyWith<$Res> {
  factory _$$BusinessAlertImplCopyWith(
    _$BusinessAlertImpl value,
    $Res Function(_$BusinessAlertImpl) then,
  ) = __$$BusinessAlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String body,
    String severity,
    @JsonKey(name: 'expires_at') int? expiresAt,
    bool active,
    @JsonKey(name: 'created_at') int createdAt,
    int views,
    @JsonKey(name: 'target_areas') List<String> targetAreas,
  });
}

/// @nodoc
class __$$BusinessAlertImplCopyWithImpl<$Res>
    extends _$BusinessAlertCopyWithImpl<$Res, _$BusinessAlertImpl>
    implements _$$BusinessAlertImplCopyWith<$Res> {
  __$$BusinessAlertImplCopyWithImpl(
    _$BusinessAlertImpl _value,
    $Res Function(_$BusinessAlertImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusinessAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? severity = null,
    Object? expiresAt = freezed,
    Object? active = null,
    Object? createdAt = null,
    Object? views = null,
    Object? targetAreas = null,
  }) {
    return _then(
      _$BusinessAlertImpl(
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
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as String,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as int?,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as int,
        views: null == views
            ? _value.views
            : views // ignore: cast_nullable_to_non_nullable
                  as int,
        targetAreas: null == targetAreas
            ? _value._targetAreas
            : targetAreas // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessAlertImpl implements _BusinessAlert {
  const _$BusinessAlertImpl({
    required this.id,
    required this.title,
    required this.body,
    this.severity = 'info',
    @JsonKey(name: 'expires_at') this.expiresAt,
    this.active = true,
    @JsonKey(name: 'created_at') required this.createdAt,
    this.views = 0,
    @JsonKey(name: 'target_areas') final List<String> targetAreas = const [],
  }) : _targetAreas = targetAreas;

  factory _$BusinessAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessAlertImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String body;
  @override
  @JsonKey()
  final String severity;
  @override
  @JsonKey(name: 'expires_at')
  final int? expiresAt;
  @override
  @JsonKey()
  final bool active;
  @override
  @JsonKey(name: 'created_at')
  final int createdAt;
  @override
  @JsonKey()
  final int views;
  final List<String> _targetAreas;
  @override
  @JsonKey(name: 'target_areas')
  List<String> get targetAreas {
    if (_targetAreas is EqualUnmodifiableListView) return _targetAreas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_targetAreas);
  }

  @override
  String toString() {
    return 'BusinessAlert(id: $id, title: $title, body: $body, severity: $severity, expiresAt: $expiresAt, active: $active, createdAt: $createdAt, views: $views, targetAreas: $targetAreas)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessAlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.views, views) || other.views == views) &&
            const DeepCollectionEquality().equals(
              other._targetAreas,
              _targetAreas,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    body,
    severity,
    expiresAt,
    active,
    createdAt,
    views,
    const DeepCollectionEquality().hash(_targetAreas),
  );

  /// Create a copy of BusinessAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessAlertImplCopyWith<_$BusinessAlertImpl> get copyWith =>
      __$$BusinessAlertImplCopyWithImpl<_$BusinessAlertImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessAlertImplToJson(this);
  }
}

abstract class _BusinessAlert implements BusinessAlert {
  const factory _BusinessAlert({
    required final String id,
    required final String title,
    required final String body,
    final String severity,
    @JsonKey(name: 'expires_at') final int? expiresAt,
    final bool active,
    @JsonKey(name: 'created_at') required final int createdAt,
    final int views,
    @JsonKey(name: 'target_areas') final List<String> targetAreas,
  }) = _$BusinessAlertImpl;

  factory _BusinessAlert.fromJson(Map<String, dynamic> json) =
      _$BusinessAlertImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get body;
  @override
  String get severity;
  @override
  @JsonKey(name: 'expires_at')
  int? get expiresAt;
  @override
  bool get active;
  @override
  @JsonKey(name: 'created_at')
  int get createdAt;
  @override
  int get views;
  @override
  @JsonKey(name: 'target_areas')
  List<String> get targetAreas;

  /// Create a copy of BusinessAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessAlertImplCopyWith<_$BusinessAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
