// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'directory_floor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DirectoryFloor _$DirectoryFloorFromJson(Map<String, dynamic> json) {
  return _DirectoryFloor.fromJson(json);
}

/// @nodoc
mixin _$DirectoryFloor {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  @JsonKey(name: 'tenant_count')
  int get tenantCount => throw _privateConstructorUsedError;

  /// Serializes this DirectoryFloor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DirectoryFloor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DirectoryFloorCopyWith<DirectoryFloor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectoryFloorCopyWith<$Res> {
  factory $DirectoryFloorCopyWith(
    DirectoryFloor value,
    $Res Function(DirectoryFloor) then,
  ) = _$DirectoryFloorCopyWithImpl<$Res, DirectoryFloor>;
  @useResult
  $Res call({
    String id,
    String name,
    String? label,
    @JsonKey(name: 'tenant_count') int tenantCount,
  });
}

/// @nodoc
class _$DirectoryFloorCopyWithImpl<$Res, $Val extends DirectoryFloor>
    implements $DirectoryFloorCopyWith<$Res> {
  _$DirectoryFloorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DirectoryFloor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? label = freezed,
    Object? tenantCount = null,
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
            label: freezed == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String?,
            tenantCount: null == tenantCount
                ? _value.tenantCount
                : tenantCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DirectoryFloorImplCopyWith<$Res>
    implements $DirectoryFloorCopyWith<$Res> {
  factory _$$DirectoryFloorImplCopyWith(
    _$DirectoryFloorImpl value,
    $Res Function(_$DirectoryFloorImpl) then,
  ) = __$$DirectoryFloorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? label,
    @JsonKey(name: 'tenant_count') int tenantCount,
  });
}

/// @nodoc
class __$$DirectoryFloorImplCopyWithImpl<$Res>
    extends _$DirectoryFloorCopyWithImpl<$Res, _$DirectoryFloorImpl>
    implements _$$DirectoryFloorImplCopyWith<$Res> {
  __$$DirectoryFloorImplCopyWithImpl(
    _$DirectoryFloorImpl _value,
    $Res Function(_$DirectoryFloorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DirectoryFloor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? label = freezed,
    Object? tenantCount = null,
  }) {
    return _then(
      _$DirectoryFloorImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        label: freezed == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String?,
        tenantCount: null == tenantCount
            ? _value.tenantCount
            : tenantCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DirectoryFloorImpl implements _DirectoryFloor {
  const _$DirectoryFloorImpl({
    required this.id,
    required this.name,
    this.label,
    @JsonKey(name: 'tenant_count') this.tenantCount = 0,
  });

  factory _$DirectoryFloorImpl.fromJson(Map<String, dynamic> json) =>
      _$$DirectoryFloorImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? label;
  @override
  @JsonKey(name: 'tenant_count')
  final int tenantCount;

  @override
  String toString() {
    return 'DirectoryFloor(id: $id, name: $name, label: $label, tenantCount: $tenantCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DirectoryFloorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.tenantCount, tenantCount) ||
                other.tenantCount == tenantCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, label, tenantCount);

  /// Create a copy of DirectoryFloor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DirectoryFloorImplCopyWith<_$DirectoryFloorImpl> get copyWith =>
      __$$DirectoryFloorImplCopyWithImpl<_$DirectoryFloorImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DirectoryFloorImplToJson(this);
  }
}

abstract class _DirectoryFloor implements DirectoryFloor {
  const factory _DirectoryFloor({
    required final String id,
    required final String name,
    final String? label,
    @JsonKey(name: 'tenant_count') final int tenantCount,
  }) = _$DirectoryFloorImpl;

  factory _DirectoryFloor.fromJson(Map<String, dynamic> json) =
      _$DirectoryFloorImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get label;
  @override
  @JsonKey(name: 'tenant_count')
  int get tenantCount;

  /// Create a copy of DirectoryFloor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DirectoryFloorImplCopyWith<_$DirectoryFloorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
