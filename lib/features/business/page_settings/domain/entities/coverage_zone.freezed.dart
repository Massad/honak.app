// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coverage_zone.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CoverageZone _$CoverageZoneFromJson(Map<String, dynamic> json) {
  return _CoverageZone.fromJson(json);
}

/// @nodoc
mixin _$CoverageZone {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get zone => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivery_fee')
  int? get deliveryFee => throw _privateConstructorUsedError;

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
  $Res call({
    String id,
    String name,
    String zone,
    bool active,
    @JsonKey(name: 'delivery_fee') int? deliveryFee,
  });
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
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? zone = null,
    Object? active = null,
    Object? deliveryFee = freezed,
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
            zone: null == zone
                ? _value.zone
                : zone // ignore: cast_nullable_to_non_nullable
                      as String,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
            deliveryFee: freezed == deliveryFee
                ? _value.deliveryFee
                : deliveryFee // ignore: cast_nullable_to_non_nullable
                      as int?,
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
  $Res call({
    String id,
    String name,
    String zone,
    bool active,
    @JsonKey(name: 'delivery_fee') int? deliveryFee,
  });
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
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? zone = null,
    Object? active = null,
    Object? deliveryFee = freezed,
  }) {
    return _then(
      _$CoverageZoneImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        zone: null == zone
            ? _value.zone
            : zone // ignore: cast_nullable_to_non_nullable
                  as String,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
        deliveryFee: freezed == deliveryFee
            ? _value.deliveryFee
            : deliveryFee // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CoverageZoneImpl implements _CoverageZone {
  const _$CoverageZoneImpl({
    required this.id,
    required this.name,
    required this.zone,
    this.active = true,
    @JsonKey(name: 'delivery_fee') this.deliveryFee,
  });

  factory _$CoverageZoneImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoverageZoneImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String zone;
  @override
  @JsonKey()
  final bool active;
  @override
  @JsonKey(name: 'delivery_fee')
  final int? deliveryFee;

  @override
  String toString() {
    return 'CoverageZone(id: $id, name: $name, zone: $zone, active: $active, deliveryFee: $deliveryFee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoverageZoneImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.zone, zone) || other.zone == zone) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.deliveryFee, deliveryFee) ||
                other.deliveryFee == deliveryFee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, zone, active, deliveryFee);

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
    required final String id,
    required final String name,
    required final String zone,
    final bool active,
    @JsonKey(name: 'delivery_fee') final int? deliveryFee,
  }) = _$CoverageZoneImpl;

  factory _CoverageZone.fromJson(Map<String, dynamic> json) =
      _$CoverageZoneImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get zone;
  @override
  bool get active;
  @override
  @JsonKey(name: 'delivery_fee')
  int? get deliveryFee;

  /// Create a copy of CoverageZone
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoverageZoneImplCopyWith<_$CoverageZoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
