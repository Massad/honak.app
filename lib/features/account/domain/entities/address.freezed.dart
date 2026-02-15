// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Address _$AddressFromJson(Map<String, dynamic> json) {
  return _Address.fromJson(json);
}

/// @nodoc
mixin _$Address {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  @JsonKey(name: 'label_icon')
  String get labelIcon => throw _privateConstructorUsedError;
  String get area => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get street => throw _privateConstructorUsedError;
  String get building => throw _privateConstructorUsedError;
  String get floor => throw _privateConstructorUsedError;
  String get apartment => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_default')
  bool get isDefault => throw _privateConstructorUsedError;

  /// Serializes this Address to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressCopyWith<Address> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) then) =
      _$AddressCopyWithImpl<$Res, Address>;
  @useResult
  $Res call({
    String id,
    String label,
    @JsonKey(name: 'label_icon') String labelIcon,
    String area,
    String city,
    String street,
    String building,
    String floor,
    String apartment,
    String notes,
    @JsonKey(name: 'is_default') bool isDefault,
  });
}

/// @nodoc
class _$AddressCopyWithImpl<$Res, $Val extends Address>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? labelIcon = null,
    Object? area = null,
    Object? city = null,
    Object? street = null,
    Object? building = null,
    Object? floor = null,
    Object? apartment = null,
    Object? notes = null,
    Object? isDefault = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            labelIcon: null == labelIcon
                ? _value.labelIcon
                : labelIcon // ignore: cast_nullable_to_non_nullable
                      as String,
            area: null == area
                ? _value.area
                : area // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            street: null == street
                ? _value.street
                : street // ignore: cast_nullable_to_non_nullable
                      as String,
            building: null == building
                ? _value.building
                : building // ignore: cast_nullable_to_non_nullable
                      as String,
            floor: null == floor
                ? _value.floor
                : floor // ignore: cast_nullable_to_non_nullable
                      as String,
            apartment: null == apartment
                ? _value.apartment
                : apartment // ignore: cast_nullable_to_non_nullable
                      as String,
            notes: null == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String,
            isDefault: null == isDefault
                ? _value.isDefault
                : isDefault // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddressImplCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$$AddressImplCopyWith(
    _$AddressImpl value,
    $Res Function(_$AddressImpl) then,
  ) = __$$AddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String label,
    @JsonKey(name: 'label_icon') String labelIcon,
    String area,
    String city,
    String street,
    String building,
    String floor,
    String apartment,
    String notes,
    @JsonKey(name: 'is_default') bool isDefault,
  });
}

/// @nodoc
class __$$AddressImplCopyWithImpl<$Res>
    extends _$AddressCopyWithImpl<$Res, _$AddressImpl>
    implements _$$AddressImplCopyWith<$Res> {
  __$$AddressImplCopyWithImpl(
    _$AddressImpl _value,
    $Res Function(_$AddressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? labelIcon = null,
    Object? area = null,
    Object? city = null,
    Object? street = null,
    Object? building = null,
    Object? floor = null,
    Object? apartment = null,
    Object? notes = null,
    Object? isDefault = null,
  }) {
    return _then(
      _$AddressImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        labelIcon: null == labelIcon
            ? _value.labelIcon
            : labelIcon // ignore: cast_nullable_to_non_nullable
                  as String,
        area: null == area
            ? _value.area
            : area // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        street: null == street
            ? _value.street
            : street // ignore: cast_nullable_to_non_nullable
                  as String,
        building: null == building
            ? _value.building
            : building // ignore: cast_nullable_to_non_nullable
                  as String,
        floor: null == floor
            ? _value.floor
            : floor // ignore: cast_nullable_to_non_nullable
                  as String,
        apartment: null == apartment
            ? _value.apartment
            : apartment // ignore: cast_nullable_to_non_nullable
                  as String,
        notes: null == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String,
        isDefault: null == isDefault
            ? _value.isDefault
            : isDefault // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressImpl implements _Address {
  const _$AddressImpl({
    required this.id,
    required this.label,
    @JsonKey(name: 'label_icon') this.labelIcon = 'home',
    required this.area,
    this.city = 'عمّان',
    this.street = '',
    this.building = '',
    this.floor = '',
    this.apartment = '',
    this.notes = '',
    @JsonKey(name: 'is_default') this.isDefault = false,
  });

  factory _$AddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressImplFromJson(json);

  @override
  final String id;
  @override
  final String label;
  @override
  @JsonKey(name: 'label_icon')
  final String labelIcon;
  @override
  final String area;
  @override
  @JsonKey()
  final String city;
  @override
  @JsonKey()
  final String street;
  @override
  @JsonKey()
  final String building;
  @override
  @JsonKey()
  final String floor;
  @override
  @JsonKey()
  final String apartment;
  @override
  @JsonKey()
  final String notes;
  @override
  @JsonKey(name: 'is_default')
  final bool isDefault;

  @override
  String toString() {
    return 'Address(id: $id, label: $label, labelIcon: $labelIcon, area: $area, city: $city, street: $street, building: $building, floor: $floor, apartment: $apartment, notes: $notes, isDefault: $isDefault)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.labelIcon, labelIcon) ||
                other.labelIcon == labelIcon) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.building, building) ||
                other.building == building) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.apartment, apartment) ||
                other.apartment == apartment) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    label,
    labelIcon,
    area,
    city,
    street,
    building,
    floor,
    apartment,
    notes,
    isDefault,
  );

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      __$$AddressImplCopyWithImpl<_$AddressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressImplToJson(this);
  }
}

abstract class _Address implements Address {
  const factory _Address({
    required final String id,
    required final String label,
    @JsonKey(name: 'label_icon') final String labelIcon,
    required final String area,
    final String city,
    final String street,
    final String building,
    final String floor,
    final String apartment,
    final String notes,
    @JsonKey(name: 'is_default') final bool isDefault,
  }) = _$AddressImpl;

  factory _Address.fromJson(Map<String, dynamic> json) = _$AddressImpl.fromJson;

  @override
  String get id;
  @override
  String get label;
  @override
  @JsonKey(name: 'label_icon')
  String get labelIcon;
  @override
  String get area;
  @override
  String get city;
  @override
  String get street;
  @override
  String get building;
  @override
  String get floor;
  @override
  String get apartment;
  @override
  String get notes;
  @override
  @JsonKey(name: 'is_default')
  bool get isDefault;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
