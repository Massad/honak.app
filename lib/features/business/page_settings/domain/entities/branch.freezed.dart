// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'branch.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Branch _$BranchFromJson(Map<String, dynamic> json) {
  return _Branch.fromJson(json);
}

/// @nodoc
mixin _$Branch {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get neighborhood => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_main')
  bool get isMain => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_type')
  String get locationType => throw _privateConstructorUsedError;
  @JsonKey(name: 'venue_id')
  String? get venueId => throw _privateConstructorUsedError;
  @JsonKey(name: 'venue_name')
  String? get venueName => throw _privateConstructorUsedError;
  @JsonKey(name: 'venue_floor')
  String? get venueFloor => throw _privateConstructorUsedError;
  @JsonKey(name: 'venue_unit')
  String? get venueUnit => throw _privateConstructorUsedError;

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
    String? city,
    String? neighborhood,
    String status,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'is_main') bool isMain,
    bool active,
    @JsonKey(name: 'location_type') String locationType,
    @JsonKey(name: 'venue_id') String? venueId,
    @JsonKey(name: 'venue_name') String? venueName,
    @JsonKey(name: 'venue_floor') String? venueFloor,
    @JsonKey(name: 'venue_unit') String? venueUnit,
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
    Object? city = freezed,
    Object? neighborhood = freezed,
    Object? status = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? isMain = null,
    Object? active = null,
    Object? locationType = null,
    Object? venueId = freezed,
    Object? venueName = freezed,
    Object? venueFloor = freezed,
    Object? venueUnit = freezed,
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
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            neighborhood: freezed == neighborhood
                ? _value.neighborhood
                : neighborhood // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            isMain: null == isMain
                ? _value.isMain
                : isMain // ignore: cast_nullable_to_non_nullable
                      as bool,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
            locationType: null == locationType
                ? _value.locationType
                : locationType // ignore: cast_nullable_to_non_nullable
                      as String,
            venueId: freezed == venueId
                ? _value.venueId
                : venueId // ignore: cast_nullable_to_non_nullable
                      as String?,
            venueName: freezed == venueName
                ? _value.venueName
                : venueName // ignore: cast_nullable_to_non_nullable
                      as String?,
            venueFloor: freezed == venueFloor
                ? _value.venueFloor
                : venueFloor // ignore: cast_nullable_to_non_nullable
                      as String?,
            venueUnit: freezed == venueUnit
                ? _value.venueUnit
                : venueUnit // ignore: cast_nullable_to_non_nullable
                      as String?,
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
    String? city,
    String? neighborhood,
    String status,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'is_main') bool isMain,
    bool active,
    @JsonKey(name: 'location_type') String locationType,
    @JsonKey(name: 'venue_id') String? venueId,
    @JsonKey(name: 'venue_name') String? venueName,
    @JsonKey(name: 'venue_floor') String? venueFloor,
    @JsonKey(name: 'venue_unit') String? venueUnit,
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
    Object? city = freezed,
    Object? neighborhood = freezed,
    Object? status = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? isMain = null,
    Object? active = null,
    Object? locationType = null,
    Object? venueId = freezed,
    Object? venueName = freezed,
    Object? venueFloor = freezed,
    Object? venueUnit = freezed,
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
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        neighborhood: freezed == neighborhood
            ? _value.neighborhood
            : neighborhood // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        isMain: null == isMain
            ? _value.isMain
            : isMain // ignore: cast_nullable_to_non_nullable
                  as bool,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
        locationType: null == locationType
            ? _value.locationType
            : locationType // ignore: cast_nullable_to_non_nullable
                  as String,
        venueId: freezed == venueId
            ? _value.venueId
            : venueId // ignore: cast_nullable_to_non_nullable
                  as String?,
        venueName: freezed == venueName
            ? _value.venueName
            : venueName // ignore: cast_nullable_to_non_nullable
                  as String?,
        venueFloor: freezed == venueFloor
            ? _value.venueFloor
            : venueFloor // ignore: cast_nullable_to_non_nullable
                  as String?,
        venueUnit: freezed == venueUnit
            ? _value.venueUnit
            : venueUnit // ignore: cast_nullable_to_non_nullable
                  as String?,
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
    this.city,
    this.neighborhood,
    this.status = 'active',
    this.latitude,
    this.longitude,
    @JsonKey(name: 'is_main') this.isMain = false,
    this.active = true,
    @JsonKey(name: 'location_type') this.locationType = 'standalone',
    @JsonKey(name: 'venue_id') this.venueId,
    @JsonKey(name: 'venue_name') this.venueName,
    @JsonKey(name: 'venue_floor') this.venueFloor,
    @JsonKey(name: 'venue_unit') this.venueUnit,
  });

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
  final String? city;
  @override
  final String? neighborhood;
  @override
  @JsonKey()
  final String status;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey(name: 'is_main')
  final bool isMain;
  @override
  @JsonKey()
  final bool active;
  @override
  @JsonKey(name: 'location_type')
  final String locationType;
  @override
  @JsonKey(name: 'venue_id')
  final String? venueId;
  @override
  @JsonKey(name: 'venue_name')
  final String? venueName;
  @override
  @JsonKey(name: 'venue_floor')
  final String? venueFloor;
  @override
  @JsonKey(name: 'venue_unit')
  final String? venueUnit;

  @override
  String toString() {
    return 'Branch(id: $id, name: $name, address: $address, phone: $phone, city: $city, neighborhood: $neighborhood, status: $status, latitude: $latitude, longitude: $longitude, isMain: $isMain, active: $active, locationType: $locationType, venueId: $venueId, venueName: $venueName, venueFloor: $venueFloor, venueUnit: $venueUnit)';
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
            (identical(other.city, city) || other.city == city) &&
            (identical(other.neighborhood, neighborhood) ||
                other.neighborhood == neighborhood) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.isMain, isMain) || other.isMain == isMain) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.locationType, locationType) ||
                other.locationType == locationType) &&
            (identical(other.venueId, venueId) || other.venueId == venueId) &&
            (identical(other.venueName, venueName) ||
                other.venueName == venueName) &&
            (identical(other.venueFloor, venueFloor) ||
                other.venueFloor == venueFloor) &&
            (identical(other.venueUnit, venueUnit) ||
                other.venueUnit == venueUnit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    address,
    phone,
    city,
    neighborhood,
    status,
    latitude,
    longitude,
    isMain,
    active,
    locationType,
    venueId,
    venueName,
    venueFloor,
    venueUnit,
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
    final String? city,
    final String? neighborhood,
    final String status,
    final double? latitude,
    final double? longitude,
    @JsonKey(name: 'is_main') final bool isMain,
    final bool active,
    @JsonKey(name: 'location_type') final String locationType,
    @JsonKey(name: 'venue_id') final String? venueId,
    @JsonKey(name: 'venue_name') final String? venueName,
    @JsonKey(name: 'venue_floor') final String? venueFloor,
    @JsonKey(name: 'venue_unit') final String? venueUnit,
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
  String? get city;
  @override
  String? get neighborhood;
  @override
  String get status;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  @JsonKey(name: 'is_main')
  bool get isMain;
  @override
  bool get active;
  @override
  @JsonKey(name: 'location_type')
  String get locationType;
  @override
  @JsonKey(name: 'venue_id')
  String? get venueId;
  @override
  @JsonKey(name: 'venue_name')
  String? get venueName;
  @override
  @JsonKey(name: 'venue_floor')
  String? get venueFloor;
  @override
  @JsonKey(name: 'venue_unit')
  String? get venueUnit;

  /// Create a copy of Branch
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BranchImplCopyWith<_$BranchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
