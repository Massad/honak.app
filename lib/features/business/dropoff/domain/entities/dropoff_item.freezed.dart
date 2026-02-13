// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dropoff_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DropoffItem _$DropoffItemFromJson(Map<String, dynamic> json) {
  return _DropoffItem.fromJson(json);
}

/// @nodoc
mixin _$DropoffItem {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String get service => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_cents')
  int get price => throw _privateConstructorUsedError;
  Map<String, String> get attributes => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'photo_before')
  String? get photoBefore => throw _privateConstructorUsedError;
  @JsonKey(name: 'photo_after')
  String? get photoAfter => throw _privateConstructorUsedError;

  /// Serializes this DropoffItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DropoffItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DropoffItemCopyWith<DropoffItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DropoffItemCopyWith<$Res> {
  factory $DropoffItemCopyWith(
    DropoffItem value,
    $Res Function(DropoffItem) then,
  ) = _$DropoffItemCopyWithImpl<$Res, DropoffItem>;
  @useResult
  $Res call({
    String id,
    String name,
    int quantity,
    String service,
    @JsonKey(name: 'price_cents') int price,
    Map<String, String> attributes,
    String? notes,
    @JsonKey(name: 'photo_before') String? photoBefore,
    @JsonKey(name: 'photo_after') String? photoAfter,
  });
}

/// @nodoc
class _$DropoffItemCopyWithImpl<$Res, $Val extends DropoffItem>
    implements $DropoffItemCopyWith<$Res> {
  _$DropoffItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DropoffItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? quantity = null,
    Object? service = null,
    Object? price = null,
    Object? attributes = null,
    Object? notes = freezed,
    Object? photoBefore = freezed,
    Object? photoAfter = freezed,
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
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            service: null == service
                ? _value.service
                : service // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            attributes: null == attributes
                ? _value.attributes
                : attributes // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            photoBefore: freezed == photoBefore
                ? _value.photoBefore
                : photoBefore // ignore: cast_nullable_to_non_nullable
                      as String?,
            photoAfter: freezed == photoAfter
                ? _value.photoAfter
                : photoAfter // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DropoffItemImplCopyWith<$Res>
    implements $DropoffItemCopyWith<$Res> {
  factory _$$DropoffItemImplCopyWith(
    _$DropoffItemImpl value,
    $Res Function(_$DropoffItemImpl) then,
  ) = __$$DropoffItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    int quantity,
    String service,
    @JsonKey(name: 'price_cents') int price,
    Map<String, String> attributes,
    String? notes,
    @JsonKey(name: 'photo_before') String? photoBefore,
    @JsonKey(name: 'photo_after') String? photoAfter,
  });
}

/// @nodoc
class __$$DropoffItemImplCopyWithImpl<$Res>
    extends _$DropoffItemCopyWithImpl<$Res, _$DropoffItemImpl>
    implements _$$DropoffItemImplCopyWith<$Res> {
  __$$DropoffItemImplCopyWithImpl(
    _$DropoffItemImpl _value,
    $Res Function(_$DropoffItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DropoffItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? quantity = null,
    Object? service = null,
    Object? price = null,
    Object? attributes = null,
    Object? notes = freezed,
    Object? photoBefore = freezed,
    Object? photoAfter = freezed,
  }) {
    return _then(
      _$DropoffItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        service: null == service
            ? _value.service
            : service // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        attributes: null == attributes
            ? _value._attributes
            : attributes // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        photoBefore: freezed == photoBefore
            ? _value.photoBefore
            : photoBefore // ignore: cast_nullable_to_non_nullable
                  as String?,
        photoAfter: freezed == photoAfter
            ? _value.photoAfter
            : photoAfter // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DropoffItemImpl implements _DropoffItem {
  const _$DropoffItemImpl({
    required this.id,
    required this.name,
    required this.quantity,
    required this.service,
    @JsonKey(name: 'price_cents') required this.price,
    final Map<String, String> attributes = const {},
    this.notes,
    @JsonKey(name: 'photo_before') this.photoBefore,
    @JsonKey(name: 'photo_after') this.photoAfter,
  }) : _attributes = attributes;

  factory _$DropoffItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DropoffItemImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int quantity;
  @override
  final String service;
  @override
  @JsonKey(name: 'price_cents')
  final int price;
  final Map<String, String> _attributes;
  @override
  @JsonKey()
  Map<String, String> get attributes {
    if (_attributes is EqualUnmodifiableMapView) return _attributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_attributes);
  }

  @override
  final String? notes;
  @override
  @JsonKey(name: 'photo_before')
  final String? photoBefore;
  @override
  @JsonKey(name: 'photo_after')
  final String? photoAfter;

  @override
  String toString() {
    return 'DropoffItem(id: $id, name: $name, quantity: $quantity, service: $service, price: $price, attributes: $attributes, notes: $notes, photoBefore: $photoBefore, photoAfter: $photoAfter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DropoffItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality().equals(
              other._attributes,
              _attributes,
            ) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.photoBefore, photoBefore) ||
                other.photoBefore == photoBefore) &&
            (identical(other.photoAfter, photoAfter) ||
                other.photoAfter == photoAfter));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    quantity,
    service,
    price,
    const DeepCollectionEquality().hash(_attributes),
    notes,
    photoBefore,
    photoAfter,
  );

  /// Create a copy of DropoffItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DropoffItemImplCopyWith<_$DropoffItemImpl> get copyWith =>
      __$$DropoffItemImplCopyWithImpl<_$DropoffItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DropoffItemImplToJson(this);
  }
}

abstract class _DropoffItem implements DropoffItem {
  const factory _DropoffItem({
    required final String id,
    required final String name,
    required final int quantity,
    required final String service,
    @JsonKey(name: 'price_cents') required final int price,
    final Map<String, String> attributes,
    final String? notes,
    @JsonKey(name: 'photo_before') final String? photoBefore,
    @JsonKey(name: 'photo_after') final String? photoAfter,
  }) = _$DropoffItemImpl;

  factory _DropoffItem.fromJson(Map<String, dynamic> json) =
      _$DropoffItemImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get quantity;
  @override
  String get service;
  @override
  @JsonKey(name: 'price_cents')
  int get price;
  @override
  Map<String, String> get attributes;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'photo_before')
  String? get photoBefore;
  @override
  @JsonKey(name: 'photo_after')
  String? get photoAfter;

  /// Create a copy of DropoffItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DropoffItemImplCopyWith<_$DropoffItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
