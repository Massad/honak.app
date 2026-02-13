// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'package_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BusinessPackage _$BusinessPackageFromJson(Map<String, dynamic> json) {
  return _BusinessPackage.fromJson(json);
}

/// @nodoc
mixin _$BusinessPackage {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  int get credits => throw _privateConstructorUsedError;
  @JsonKey(name: 'credit_label')
  String get creditLabel => throw _privateConstructorUsedError;
  @JsonKey(name: 'validity_model')
  String get validityModel => throw _privateConstructorUsedError;
  @JsonKey(name: 'validity_months')
  int? get validityMonths => throw _privateConstructorUsedError;
  @JsonKey(name: 'compare_price')
  int? get comparePrice => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;

  /// Serializes this BusinessPackage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusinessPackage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessPackageCopyWith<BusinessPackage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessPackageCopyWith<$Res> {
  factory $BusinessPackageCopyWith(
    BusinessPackage value,
    $Res Function(BusinessPackage) then,
  ) = _$BusinessPackageCopyWithImpl<$Res, BusinessPackage>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    int price,
    int credits,
    @JsonKey(name: 'credit_label') String creditLabel,
    @JsonKey(name: 'validity_model') String validityModel,
    @JsonKey(name: 'validity_months') int? validityMonths,
    @JsonKey(name: 'compare_price') int? comparePrice,
    bool active,
    String icon,
  });
}

/// @nodoc
class _$BusinessPackageCopyWithImpl<$Res, $Val extends BusinessPackage>
    implements $BusinessPackageCopyWith<$Res> {
  _$BusinessPackageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessPackage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? credits = null,
    Object? creditLabel = null,
    Object? validityModel = null,
    Object? validityMonths = freezed,
    Object? comparePrice = freezed,
    Object? active = null,
    Object? icon = null,
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
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            credits: null == credits
                ? _value.credits
                : credits // ignore: cast_nullable_to_non_nullable
                      as int,
            creditLabel: null == creditLabel
                ? _value.creditLabel
                : creditLabel // ignore: cast_nullable_to_non_nullable
                      as String,
            validityModel: null == validityModel
                ? _value.validityModel
                : validityModel // ignore: cast_nullable_to_non_nullable
                      as String,
            validityMonths: freezed == validityMonths
                ? _value.validityMonths
                : validityMonths // ignore: cast_nullable_to_non_nullable
                      as int?,
            comparePrice: freezed == comparePrice
                ? _value.comparePrice
                : comparePrice // ignore: cast_nullable_to_non_nullable
                      as int?,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
            icon: null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BusinessPackageImplCopyWith<$Res>
    implements $BusinessPackageCopyWith<$Res> {
  factory _$$BusinessPackageImplCopyWith(
    _$BusinessPackageImpl value,
    $Res Function(_$BusinessPackageImpl) then,
  ) = __$$BusinessPackageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    int price,
    int credits,
    @JsonKey(name: 'credit_label') String creditLabel,
    @JsonKey(name: 'validity_model') String validityModel,
    @JsonKey(name: 'validity_months') int? validityMonths,
    @JsonKey(name: 'compare_price') int? comparePrice,
    bool active,
    String icon,
  });
}

/// @nodoc
class __$$BusinessPackageImplCopyWithImpl<$Res>
    extends _$BusinessPackageCopyWithImpl<$Res, _$BusinessPackageImpl>
    implements _$$BusinessPackageImplCopyWith<$Res> {
  __$$BusinessPackageImplCopyWithImpl(
    _$BusinessPackageImpl _value,
    $Res Function(_$BusinessPackageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusinessPackage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? credits = null,
    Object? creditLabel = null,
    Object? validityModel = null,
    Object? validityMonths = freezed,
    Object? comparePrice = freezed,
    Object? active = null,
    Object? icon = null,
  }) {
    return _then(
      _$BusinessPackageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        credits: null == credits
            ? _value.credits
            : credits // ignore: cast_nullable_to_non_nullable
                  as int,
        creditLabel: null == creditLabel
            ? _value.creditLabel
            : creditLabel // ignore: cast_nullable_to_non_nullable
                  as String,
        validityModel: null == validityModel
            ? _value.validityModel
            : validityModel // ignore: cast_nullable_to_non_nullable
                  as String,
        validityMonths: freezed == validityMonths
            ? _value.validityMonths
            : validityMonths // ignore: cast_nullable_to_non_nullable
                  as int?,
        comparePrice: freezed == comparePrice
            ? _value.comparePrice
            : comparePrice // ignore: cast_nullable_to_non_nullable
                  as int?,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
        icon: null == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessPackageImpl implements _BusinessPackage {
  const _$BusinessPackageImpl({
    required this.id,
    required this.name,
    this.description = '',
    required this.price,
    required this.credits,
    @JsonKey(name: 'credit_label') required this.creditLabel,
    @JsonKey(name: 'validity_model') this.validityModel = 'visits_date',
    @JsonKey(name: 'validity_months') this.validityMonths,
    @JsonKey(name: 'compare_price') this.comparePrice,
    this.active = true,
    this.icon = 'package',
  });

  factory _$BusinessPackageImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessPackageImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  final int price;
  @override
  final int credits;
  @override
  @JsonKey(name: 'credit_label')
  final String creditLabel;
  @override
  @JsonKey(name: 'validity_model')
  final String validityModel;
  @override
  @JsonKey(name: 'validity_months')
  final int? validityMonths;
  @override
  @JsonKey(name: 'compare_price')
  final int? comparePrice;
  @override
  @JsonKey()
  final bool active;
  @override
  @JsonKey()
  final String icon;

  @override
  String toString() {
    return 'BusinessPackage(id: $id, name: $name, description: $description, price: $price, credits: $credits, creditLabel: $creditLabel, validityModel: $validityModel, validityMonths: $validityMonths, comparePrice: $comparePrice, active: $active, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessPackageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.credits, credits) || other.credits == credits) &&
            (identical(other.creditLabel, creditLabel) ||
                other.creditLabel == creditLabel) &&
            (identical(other.validityModel, validityModel) ||
                other.validityModel == validityModel) &&
            (identical(other.validityMonths, validityMonths) ||
                other.validityMonths == validityMonths) &&
            (identical(other.comparePrice, comparePrice) ||
                other.comparePrice == comparePrice) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    price,
    credits,
    creditLabel,
    validityModel,
    validityMonths,
    comparePrice,
    active,
    icon,
  );

  /// Create a copy of BusinessPackage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessPackageImplCopyWith<_$BusinessPackageImpl> get copyWith =>
      __$$BusinessPackageImplCopyWithImpl<_$BusinessPackageImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessPackageImplToJson(this);
  }
}

abstract class _BusinessPackage implements BusinessPackage {
  const factory _BusinessPackage({
    required final String id,
    required final String name,
    final String description,
    required final int price,
    required final int credits,
    @JsonKey(name: 'credit_label') required final String creditLabel,
    @JsonKey(name: 'validity_model') final String validityModel,
    @JsonKey(name: 'validity_months') final int? validityMonths,
    @JsonKey(name: 'compare_price') final int? comparePrice,
    final bool active,
    final String icon,
  }) = _$BusinessPackageImpl;

  factory _BusinessPackage.fromJson(Map<String, dynamic> json) =
      _$BusinessPackageImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  int get price;
  @override
  int get credits;
  @override
  @JsonKey(name: 'credit_label')
  String get creditLabel;
  @override
  @JsonKey(name: 'validity_model')
  String get validityModel;
  @override
  @JsonKey(name: 'validity_months')
  int? get validityMonths;
  @override
  @JsonKey(name: 'compare_price')
  int? get comparePrice;
  @override
  bool get active;
  @override
  String get icon;

  /// Create a copy of BusinessPackage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessPackageImplCopyWith<_$BusinessPackageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
