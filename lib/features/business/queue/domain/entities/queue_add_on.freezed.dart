// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_add_on.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QueueAddOn _$QueueAddOnFromJson(Map<String, dynamic> json) {
  return _QueueAddOn.fromJson(json);
}

/// @nodoc
mixin _$QueueAddOn {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_cents')
  int get price => throw _privateConstructorUsedError;

  /// Serializes this QueueAddOn to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueueAddOn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueueAddOnCopyWith<QueueAddOn> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueAddOnCopyWith<$Res> {
  factory $QueueAddOnCopyWith(
    QueueAddOn value,
    $Res Function(QueueAddOn) then,
  ) = _$QueueAddOnCopyWithImpl<$Res, QueueAddOn>;
  @useResult
  $Res call({String name, @JsonKey(name: 'price_cents') int price});
}

/// @nodoc
class _$QueueAddOnCopyWithImpl<$Res, $Val extends QueueAddOn>
    implements $QueueAddOnCopyWith<$Res> {
  _$QueueAddOnCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueueAddOn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? price = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QueueAddOnImplCopyWith<$Res>
    implements $QueueAddOnCopyWith<$Res> {
  factory _$$QueueAddOnImplCopyWith(
    _$QueueAddOnImpl value,
    $Res Function(_$QueueAddOnImpl) then,
  ) = __$$QueueAddOnImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, @JsonKey(name: 'price_cents') int price});
}

/// @nodoc
class __$$QueueAddOnImplCopyWithImpl<$Res>
    extends _$QueueAddOnCopyWithImpl<$Res, _$QueueAddOnImpl>
    implements _$$QueueAddOnImplCopyWith<$Res> {
  __$$QueueAddOnImplCopyWithImpl(
    _$QueueAddOnImpl _value,
    $Res Function(_$QueueAddOnImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueueAddOn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? price = null}) {
    return _then(
      _$QueueAddOnImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueAddOnImpl implements _QueueAddOn {
  const _$QueueAddOnImpl({
    required this.name,
    @JsonKey(name: 'price_cents') required this.price,
  });

  factory _$QueueAddOnImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueAddOnImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: 'price_cents')
  final int price;

  @override
  String toString() {
    return 'QueueAddOn(name: $name, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueAddOnImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, price);

  /// Create a copy of QueueAddOn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueAddOnImplCopyWith<_$QueueAddOnImpl> get copyWith =>
      __$$QueueAddOnImplCopyWithImpl<_$QueueAddOnImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueAddOnImplToJson(this);
  }
}

abstract class _QueueAddOn implements QueueAddOn {
  const factory _QueueAddOn({
    required final String name,
    @JsonKey(name: 'price_cents') required final int price,
  }) = _$QueueAddOnImpl;

  factory _QueueAddOn.fromJson(Map<String, dynamic> json) =
      _$QueueAddOnImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'price_cents')
  int get price;

  /// Create a copy of QueueAddOn
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueAddOnImplCopyWith<_$QueueAddOnImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
