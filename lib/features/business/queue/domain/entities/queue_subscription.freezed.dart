// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_subscription.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QueueSubscription _$QueueSubscriptionFromJson(Map<String, dynamic> json) {
  return _QueueSubscription.fromJson(json);
}

/// @nodoc
mixin _$QueueSubscription {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_ar')
  String get nameAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'washes_per_month')
  int get washesPerMonth => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_per_month_cents')
  int get pricePerMonth => throw _privateConstructorUsedError;
  @JsonKey(name: 'package_id')
  String get packageId => throw _privateConstructorUsedError;
  List<String> get features => throw _privateConstructorUsedError;
  bool get popular => throw _privateConstructorUsedError;

  /// Serializes this QueueSubscription to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueueSubscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueueSubscriptionCopyWith<QueueSubscription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueSubscriptionCopyWith<$Res> {
  factory $QueueSubscriptionCopyWith(
    QueueSubscription value,
    $Res Function(QueueSubscription) then,
  ) = _$QueueSubscriptionCopyWithImpl<$Res, QueueSubscription>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'name_ar') String nameAr,
    @JsonKey(name: 'washes_per_month') int washesPerMonth,
    @JsonKey(name: 'price_per_month_cents') int pricePerMonth,
    @JsonKey(name: 'package_id') String packageId,
    List<String> features,
    bool popular,
  });
}

/// @nodoc
class _$QueueSubscriptionCopyWithImpl<$Res, $Val extends QueueSubscription>
    implements $QueueSubscriptionCopyWith<$Res> {
  _$QueueSubscriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueueSubscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameAr = null,
    Object? washesPerMonth = null,
    Object? pricePerMonth = null,
    Object? packageId = null,
    Object? features = null,
    Object? popular = null,
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
            washesPerMonth: null == washesPerMonth
                ? _value.washesPerMonth
                : washesPerMonth // ignore: cast_nullable_to_non_nullable
                      as int,
            pricePerMonth: null == pricePerMonth
                ? _value.pricePerMonth
                : pricePerMonth // ignore: cast_nullable_to_non_nullable
                      as int,
            packageId: null == packageId
                ? _value.packageId
                : packageId // ignore: cast_nullable_to_non_nullable
                      as String,
            features: null == features
                ? _value.features
                : features // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            popular: null == popular
                ? _value.popular
                : popular // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QueueSubscriptionImplCopyWith<$Res>
    implements $QueueSubscriptionCopyWith<$Res> {
  factory _$$QueueSubscriptionImplCopyWith(
    _$QueueSubscriptionImpl value,
    $Res Function(_$QueueSubscriptionImpl) then,
  ) = __$$QueueSubscriptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'name_ar') String nameAr,
    @JsonKey(name: 'washes_per_month') int washesPerMonth,
    @JsonKey(name: 'price_per_month_cents') int pricePerMonth,
    @JsonKey(name: 'package_id') String packageId,
    List<String> features,
    bool popular,
  });
}

/// @nodoc
class __$$QueueSubscriptionImplCopyWithImpl<$Res>
    extends _$QueueSubscriptionCopyWithImpl<$Res, _$QueueSubscriptionImpl>
    implements _$$QueueSubscriptionImplCopyWith<$Res> {
  __$$QueueSubscriptionImplCopyWithImpl(
    _$QueueSubscriptionImpl _value,
    $Res Function(_$QueueSubscriptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueueSubscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameAr = null,
    Object? washesPerMonth = null,
    Object? pricePerMonth = null,
    Object? packageId = null,
    Object? features = null,
    Object? popular = null,
  }) {
    return _then(
      _$QueueSubscriptionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        nameAr: null == nameAr
            ? _value.nameAr
            : nameAr // ignore: cast_nullable_to_non_nullable
                  as String,
        washesPerMonth: null == washesPerMonth
            ? _value.washesPerMonth
            : washesPerMonth // ignore: cast_nullable_to_non_nullable
                  as int,
        pricePerMonth: null == pricePerMonth
            ? _value.pricePerMonth
            : pricePerMonth // ignore: cast_nullable_to_non_nullable
                  as int,
        packageId: null == packageId
            ? _value.packageId
            : packageId // ignore: cast_nullable_to_non_nullable
                  as String,
        features: null == features
            ? _value._features
            : features // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        popular: null == popular
            ? _value.popular
            : popular // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueSubscriptionImpl implements _QueueSubscription {
  const _$QueueSubscriptionImpl({
    required this.id,
    @JsonKey(name: 'name_ar') required this.nameAr,
    @JsonKey(name: 'washes_per_month') required this.washesPerMonth,
    @JsonKey(name: 'price_per_month_cents') required this.pricePerMonth,
    @JsonKey(name: 'package_id') required this.packageId,
    final List<String> features = const [],
    this.popular = false,
  }) : _features = features;

  factory _$QueueSubscriptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueSubscriptionImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'name_ar')
  final String nameAr;
  @override
  @JsonKey(name: 'washes_per_month')
  final int washesPerMonth;
  @override
  @JsonKey(name: 'price_per_month_cents')
  final int pricePerMonth;
  @override
  @JsonKey(name: 'package_id')
  final String packageId;
  final List<String> _features;
  @override
  @JsonKey()
  List<String> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  @override
  @JsonKey()
  final bool popular;

  @override
  String toString() {
    return 'QueueSubscription(id: $id, nameAr: $nameAr, washesPerMonth: $washesPerMonth, pricePerMonth: $pricePerMonth, packageId: $packageId, features: $features, popular: $popular)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueSubscriptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.washesPerMonth, washesPerMonth) ||
                other.washesPerMonth == washesPerMonth) &&
            (identical(other.pricePerMonth, pricePerMonth) ||
                other.pricePerMonth == pricePerMonth) &&
            (identical(other.packageId, packageId) ||
                other.packageId == packageId) &&
            const DeepCollectionEquality().equals(other._features, _features) &&
            (identical(other.popular, popular) || other.popular == popular));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    nameAr,
    washesPerMonth,
    pricePerMonth,
    packageId,
    const DeepCollectionEquality().hash(_features),
    popular,
  );

  /// Create a copy of QueueSubscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueSubscriptionImplCopyWith<_$QueueSubscriptionImpl> get copyWith =>
      __$$QueueSubscriptionImplCopyWithImpl<_$QueueSubscriptionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueSubscriptionImplToJson(this);
  }
}

abstract class _QueueSubscription implements QueueSubscription {
  const factory _QueueSubscription({
    required final String id,
    @JsonKey(name: 'name_ar') required final String nameAr,
    @JsonKey(name: 'washes_per_month') required final int washesPerMonth,
    @JsonKey(name: 'price_per_month_cents') required final int pricePerMonth,
    @JsonKey(name: 'package_id') required final String packageId,
    final List<String> features,
    final bool popular,
  }) = _$QueueSubscriptionImpl;

  factory _QueueSubscription.fromJson(Map<String, dynamic> json) =
      _$QueueSubscriptionImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'name_ar')
  String get nameAr;
  @override
  @JsonKey(name: 'washes_per_month')
  int get washesPerMonth;
  @override
  @JsonKey(name: 'price_per_month_cents')
  int get pricePerMonth;
  @override
  @JsonKey(name: 'package_id')
  String get packageId;
  @override
  List<String> get features;
  @override
  bool get popular;

  /// Create a copy of QueueSubscription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueSubscriptionImplCopyWith<_$QueueSubscriptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
