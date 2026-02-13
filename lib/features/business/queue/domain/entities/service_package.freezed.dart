// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_package.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ServicePackage _$ServicePackageFromJson(Map<String, dynamic> json) {
  return _ServicePackage.fromJson(json);
}

/// @nodoc
mixin _$ServicePackage {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_ar')
  String get nameAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_en')
  String? get nameEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'description_ar')
  String? get descriptionAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_cents')
  int get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_min')
  int get durationMin => throw _privateConstructorUsedError;
  List<String> get features => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  bool get popular => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;

  /// Serializes this ServicePackage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServicePackage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServicePackageCopyWith<ServicePackage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServicePackageCopyWith<$Res> {
  factory $ServicePackageCopyWith(
    ServicePackage value,
    $Res Function(ServicePackage) then,
  ) = _$ServicePackageCopyWithImpl<$Res, ServicePackage>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'name_ar') String nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    @JsonKey(name: 'description_ar') String? descriptionAr,
    @JsonKey(name: 'price_cents') int price,
    @JsonKey(name: 'duration_min') int durationMin,
    List<String> features,
    String? icon,
    bool popular,
    String? color,
  });
}

/// @nodoc
class _$ServicePackageCopyWithImpl<$Res, $Val extends ServicePackage>
    implements $ServicePackageCopyWith<$Res> {
  _$ServicePackageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServicePackage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameAr = null,
    Object? nameEn = freezed,
    Object? descriptionAr = freezed,
    Object? price = null,
    Object? durationMin = null,
    Object? features = null,
    Object? icon = freezed,
    Object? popular = null,
    Object? color = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            nameAr: null == nameAr
                ? _value.nameAr
                : nameAr // ignore: cast_nullable_to_non_nullable
                      as String,
            nameEn: freezed == nameEn
                ? _value.nameEn
                : nameEn // ignore: cast_nullable_to_non_nullable
                      as String?,
            descriptionAr: freezed == descriptionAr
                ? _value.descriptionAr
                : descriptionAr // ignore: cast_nullable_to_non_nullable
                      as String?,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            durationMin: null == durationMin
                ? _value.durationMin
                : durationMin // ignore: cast_nullable_to_non_nullable
                      as int,
            features: null == features
                ? _value.features
                : features // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            icon: freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String?,
            popular: null == popular
                ? _value.popular
                : popular // ignore: cast_nullable_to_non_nullable
                      as bool,
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ServicePackageImplCopyWith<$Res>
    implements $ServicePackageCopyWith<$Res> {
  factory _$$ServicePackageImplCopyWith(
    _$ServicePackageImpl value,
    $Res Function(_$ServicePackageImpl) then,
  ) = __$$ServicePackageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'name_ar') String nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    @JsonKey(name: 'description_ar') String? descriptionAr,
    @JsonKey(name: 'price_cents') int price,
    @JsonKey(name: 'duration_min') int durationMin,
    List<String> features,
    String? icon,
    bool popular,
    String? color,
  });
}

/// @nodoc
class __$$ServicePackageImplCopyWithImpl<$Res>
    extends _$ServicePackageCopyWithImpl<$Res, _$ServicePackageImpl>
    implements _$$ServicePackageImplCopyWith<$Res> {
  __$$ServicePackageImplCopyWithImpl(
    _$ServicePackageImpl _value,
    $Res Function(_$ServicePackageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServicePackage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameAr = null,
    Object? nameEn = freezed,
    Object? descriptionAr = freezed,
    Object? price = null,
    Object? durationMin = null,
    Object? features = null,
    Object? icon = freezed,
    Object? popular = null,
    Object? color = freezed,
  }) {
    return _then(
      _$ServicePackageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        nameAr: null == nameAr
            ? _value.nameAr
            : nameAr // ignore: cast_nullable_to_non_nullable
                  as String,
        nameEn: freezed == nameEn
            ? _value.nameEn
            : nameEn // ignore: cast_nullable_to_non_nullable
                  as String?,
        descriptionAr: freezed == descriptionAr
            ? _value.descriptionAr
            : descriptionAr // ignore: cast_nullable_to_non_nullable
                  as String?,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        durationMin: null == durationMin
            ? _value.durationMin
            : durationMin // ignore: cast_nullable_to_non_nullable
                  as int,
        features: null == features
            ? _value._features
            : features // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        icon: freezed == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String?,
        popular: null == popular
            ? _value.popular
            : popular // ignore: cast_nullable_to_non_nullable
                  as bool,
        color: freezed == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ServicePackageImpl implements _ServicePackage {
  const _$ServicePackageImpl({
    required this.id,
    @JsonKey(name: 'name_ar') required this.nameAr,
    @JsonKey(name: 'name_en') this.nameEn,
    @JsonKey(name: 'description_ar') this.descriptionAr,
    @JsonKey(name: 'price_cents') required this.price,
    @JsonKey(name: 'duration_min') required this.durationMin,
    final List<String> features = const [],
    this.icon,
    this.popular = false,
    this.color,
  }) : _features = features;

  factory _$ServicePackageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServicePackageImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'name_ar')
  final String nameAr;
  @override
  @JsonKey(name: 'name_en')
  final String? nameEn;
  @override
  @JsonKey(name: 'description_ar')
  final String? descriptionAr;
  @override
  @JsonKey(name: 'price_cents')
  final int price;
  @override
  @JsonKey(name: 'duration_min')
  final int durationMin;
  final List<String> _features;
  @override
  @JsonKey()
  List<String> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  @override
  final String? icon;
  @override
  @JsonKey()
  final bool popular;
  @override
  final String? color;

  @override
  String toString() {
    return 'ServicePackage(id: $id, nameAr: $nameAr, nameEn: $nameEn, descriptionAr: $descriptionAr, price: $price, durationMin: $durationMin, features: $features, icon: $icon, popular: $popular, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServicePackageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.descriptionAr, descriptionAr) ||
                other.descriptionAr == descriptionAr) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.durationMin, durationMin) ||
                other.durationMin == durationMin) &&
            const DeepCollectionEquality().equals(other._features, _features) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.popular, popular) || other.popular == popular) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    nameAr,
    nameEn,
    descriptionAr,
    price,
    durationMin,
    const DeepCollectionEquality().hash(_features),
    icon,
    popular,
    color,
  );

  /// Create a copy of ServicePackage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServicePackageImplCopyWith<_$ServicePackageImpl> get copyWith =>
      __$$ServicePackageImplCopyWithImpl<_$ServicePackageImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ServicePackageImplToJson(this);
  }
}

abstract class _ServicePackage implements ServicePackage {
  const factory _ServicePackage({
    required final String id,
    @JsonKey(name: 'name_ar') required final String nameAr,
    @JsonKey(name: 'name_en') final String? nameEn,
    @JsonKey(name: 'description_ar') final String? descriptionAr,
    @JsonKey(name: 'price_cents') required final int price,
    @JsonKey(name: 'duration_min') required final int durationMin,
    final List<String> features,
    final String? icon,
    final bool popular,
    final String? color,
  }) = _$ServicePackageImpl;

  factory _ServicePackage.fromJson(Map<String, dynamic> json) =
      _$ServicePackageImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'name_ar')
  String get nameAr;
  @override
  @JsonKey(name: 'name_en')
  String? get nameEn;
  @override
  @JsonKey(name: 'description_ar')
  String? get descriptionAr;
  @override
  @JsonKey(name: 'price_cents')
  int get price;
  @override
  @JsonKey(name: 'duration_min')
  int get durationMin;
  @override
  List<String> get features;
  @override
  String? get icon;
  @override
  bool get popular;
  @override
  String? get color;

  /// Create a copy of ServicePackage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServicePackageImplCopyWith<_$ServicePackageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
