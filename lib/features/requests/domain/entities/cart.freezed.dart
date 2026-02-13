// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CartItem _$CartItemFromJson(Map<String, dynamic> json) {
  return _CartItem.fromJson(json);
}

/// @nodoc
mixin _$CartItem {
  String get itemId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Unit price in piasters (item base + selected option modifiers).
  @JsonKey(name: 'unit_price_cents')
  int get unitPriceCents => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  /// Display text for selected options (e.g. "كبير، إضافي جبنة").
  String? get variation => throw _privateConstructorUsedError;

  /// Raw selected option IDs keyed by group ID.
  Map<String, List<String>> get selectedOptions =>
      throw _privateConstructorUsedError;

  /// Serializes this CartItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CartItemCopyWith<CartItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartItemCopyWith<$Res> {
  factory $CartItemCopyWith(CartItem value, $Res Function(CartItem) then) =
      _$CartItemCopyWithImpl<$Res, CartItem>;
  @useResult
  $Res call({
    String itemId,
    String name,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'unit_price_cents') int unitPriceCents,
    int quantity,
    String? variation,
    Map<String, List<String>> selectedOptions,
  });
}

/// @nodoc
class _$CartItemCopyWithImpl<$Res, $Val extends CartItem>
    implements $CartItemCopyWith<$Res> {
  _$CartItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? name = null,
    Object? imageUrl = freezed,
    Object? unitPriceCents = null,
    Object? quantity = null,
    Object? variation = freezed,
    Object? selectedOptions = null,
  }) {
    return _then(
      _value.copyWith(
            itemId: null == itemId
                ? _value.itemId
                : itemId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            unitPriceCents: null == unitPriceCents
                ? _value.unitPriceCents
                : unitPriceCents // ignore: cast_nullable_to_non_nullable
                      as int,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            variation: freezed == variation
                ? _value.variation
                : variation // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedOptions: null == selectedOptions
                ? _value.selectedOptions
                : selectedOptions // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<String>>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CartItemImplCopyWith<$Res>
    implements $CartItemCopyWith<$Res> {
  factory _$$CartItemImplCopyWith(
    _$CartItemImpl value,
    $Res Function(_$CartItemImpl) then,
  ) = __$$CartItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String itemId,
    String name,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'unit_price_cents') int unitPriceCents,
    int quantity,
    String? variation,
    Map<String, List<String>> selectedOptions,
  });
}

/// @nodoc
class __$$CartItemImplCopyWithImpl<$Res>
    extends _$CartItemCopyWithImpl<$Res, _$CartItemImpl>
    implements _$$CartItemImplCopyWith<$Res> {
  __$$CartItemImplCopyWithImpl(
    _$CartItemImpl _value,
    $Res Function(_$CartItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? name = null,
    Object? imageUrl = freezed,
    Object? unitPriceCents = null,
    Object? quantity = null,
    Object? variation = freezed,
    Object? selectedOptions = null,
  }) {
    return _then(
      _$CartItemImpl(
        itemId: null == itemId
            ? _value.itemId
            : itemId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        unitPriceCents: null == unitPriceCents
            ? _value.unitPriceCents
            : unitPriceCents // ignore: cast_nullable_to_non_nullable
                  as int,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        variation: freezed == variation
            ? _value.variation
            : variation // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedOptions: null == selectedOptions
            ? _value._selectedOptions
            : selectedOptions // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<String>>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CartItemImpl extends _CartItem {
  const _$CartItemImpl({
    required this.itemId,
    required this.name,
    @JsonKey(name: 'image_url') this.imageUrl,
    @JsonKey(name: 'unit_price_cents') required this.unitPriceCents,
    this.quantity = 1,
    this.variation,
    final Map<String, List<String>> selectedOptions = const {},
  }) : _selectedOptions = selectedOptions,
       super._();

  factory _$CartItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartItemImplFromJson(json);

  @override
  final String itemId;
  @override
  final String name;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  /// Unit price in piasters (item base + selected option modifiers).
  @override
  @JsonKey(name: 'unit_price_cents')
  final int unitPriceCents;
  @override
  @JsonKey()
  final int quantity;

  /// Display text for selected options (e.g. "كبير، إضافي جبنة").
  @override
  final String? variation;

  /// Raw selected option IDs keyed by group ID.
  final Map<String, List<String>> _selectedOptions;

  /// Raw selected option IDs keyed by group ID.
  @override
  @JsonKey()
  Map<String, List<String>> get selectedOptions {
    if (_selectedOptions is EqualUnmodifiableMapView) return _selectedOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_selectedOptions);
  }

  @override
  String toString() {
    return 'CartItem(itemId: $itemId, name: $name, imageUrl: $imageUrl, unitPriceCents: $unitPriceCents, quantity: $quantity, variation: $variation, selectedOptions: $selectedOptions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartItemImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.unitPriceCents, unitPriceCents) ||
                other.unitPriceCents == unitPriceCents) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.variation, variation) ||
                other.variation == variation) &&
            const DeepCollectionEquality().equals(
              other._selectedOptions,
              _selectedOptions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    itemId,
    name,
    imageUrl,
    unitPriceCents,
    quantity,
    variation,
    const DeepCollectionEquality().hash(_selectedOptions),
  );

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartItemImplCopyWith<_$CartItemImpl> get copyWith =>
      __$$CartItemImplCopyWithImpl<_$CartItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartItemImplToJson(this);
  }
}

abstract class _CartItem extends CartItem {
  const factory _CartItem({
    required final String itemId,
    required final String name,
    @JsonKey(name: 'image_url') final String? imageUrl,
    @JsonKey(name: 'unit_price_cents') required final int unitPriceCents,
    final int quantity,
    final String? variation,
    final Map<String, List<String>> selectedOptions,
  }) = _$CartItemImpl;
  const _CartItem._() : super._();

  factory _CartItem.fromJson(Map<String, dynamic> json) =
      _$CartItemImpl.fromJson;

  @override
  String get itemId;
  @override
  String get name;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;

  /// Unit price in piasters (item base + selected option modifiers).
  @override
  @JsonKey(name: 'unit_price_cents')
  int get unitPriceCents;
  @override
  int get quantity;

  /// Display text for selected options (e.g. "كبير، إضافي جبنة").
  @override
  String? get variation;

  /// Raw selected option IDs keyed by group ID.
  @override
  Map<String, List<String>> get selectedOptions;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartItemImplCopyWith<_$CartItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Cart _$CartFromJson(Map<String, dynamic> json) {
  return _Cart.fromJson(json);
}

/// @nodoc
mixin _$Cart {
  @JsonKey(name: 'page_id')
  String get pageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_name')
  String get pageName => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_avatar_url')
  String? get pageAvatarUrl => throw _privateConstructorUsedError;
  List<CartItem> get items => throw _privateConstructorUsedError;

  /// Serializes this Cart to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Cart
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CartCopyWith<Cart> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartCopyWith<$Res> {
  factory $CartCopyWith(Cart value, $Res Function(Cart) then) =
      _$CartCopyWithImpl<$Res, Cart>;
  @useResult
  $Res call({
    @JsonKey(name: 'page_id') String pageId,
    @JsonKey(name: 'page_name') String pageName,
    @JsonKey(name: 'page_avatar_url') String? pageAvatarUrl,
    List<CartItem> items,
  });
}

/// @nodoc
class _$CartCopyWithImpl<$Res, $Val extends Cart>
    implements $CartCopyWith<$Res> {
  _$CartCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Cart
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageId = null,
    Object? pageName = null,
    Object? pageAvatarUrl = freezed,
    Object? items = null,
  }) {
    return _then(
      _value.copyWith(
            pageId: null == pageId
                ? _value.pageId
                : pageId // ignore: cast_nullable_to_non_nullable
                      as String,
            pageName: null == pageName
                ? _value.pageName
                : pageName // ignore: cast_nullable_to_non_nullable
                      as String,
            pageAvatarUrl: freezed == pageAvatarUrl
                ? _value.pageAvatarUrl
                : pageAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<CartItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CartImplCopyWith<$Res> implements $CartCopyWith<$Res> {
  factory _$$CartImplCopyWith(
    _$CartImpl value,
    $Res Function(_$CartImpl) then,
  ) = __$$CartImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'page_id') String pageId,
    @JsonKey(name: 'page_name') String pageName,
    @JsonKey(name: 'page_avatar_url') String? pageAvatarUrl,
    List<CartItem> items,
  });
}

/// @nodoc
class __$$CartImplCopyWithImpl<$Res>
    extends _$CartCopyWithImpl<$Res, _$CartImpl>
    implements _$$CartImplCopyWith<$Res> {
  __$$CartImplCopyWithImpl(_$CartImpl _value, $Res Function(_$CartImpl) _then)
    : super(_value, _then);

  /// Create a copy of Cart
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageId = null,
    Object? pageName = null,
    Object? pageAvatarUrl = freezed,
    Object? items = null,
  }) {
    return _then(
      _$CartImpl(
        pageId: null == pageId
            ? _value.pageId
            : pageId // ignore: cast_nullable_to_non_nullable
                  as String,
        pageName: null == pageName
            ? _value.pageName
            : pageName // ignore: cast_nullable_to_non_nullable
                  as String,
        pageAvatarUrl: freezed == pageAvatarUrl
            ? _value.pageAvatarUrl
            : pageAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<CartItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CartImpl extends _Cart {
  const _$CartImpl({
    @JsonKey(name: 'page_id') required this.pageId,
    @JsonKey(name: 'page_name') required this.pageName,
    @JsonKey(name: 'page_avatar_url') this.pageAvatarUrl,
    final List<CartItem> items = const [],
  }) : _items = items,
       super._();

  factory _$CartImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartImplFromJson(json);

  @override
  @JsonKey(name: 'page_id')
  final String pageId;
  @override
  @JsonKey(name: 'page_name')
  final String pageName;
  @override
  @JsonKey(name: 'page_avatar_url')
  final String? pageAvatarUrl;
  final List<CartItem> _items;
  @override
  @JsonKey()
  List<CartItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'Cart(pageId: $pageId, pageName: $pageName, pageAvatarUrl: $pageAvatarUrl, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartImpl &&
            (identical(other.pageId, pageId) || other.pageId == pageId) &&
            (identical(other.pageName, pageName) ||
                other.pageName == pageName) &&
            (identical(other.pageAvatarUrl, pageAvatarUrl) ||
                other.pageAvatarUrl == pageAvatarUrl) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    pageId,
    pageName,
    pageAvatarUrl,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of Cart
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartImplCopyWith<_$CartImpl> get copyWith =>
      __$$CartImplCopyWithImpl<_$CartImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartImplToJson(this);
  }
}

abstract class _Cart extends Cart {
  const factory _Cart({
    @JsonKey(name: 'page_id') required final String pageId,
    @JsonKey(name: 'page_name') required final String pageName,
    @JsonKey(name: 'page_avatar_url') final String? pageAvatarUrl,
    final List<CartItem> items,
  }) = _$CartImpl;
  const _Cart._() : super._();

  factory _Cart.fromJson(Map<String, dynamic> json) = _$CartImpl.fromJson;

  @override
  @JsonKey(name: 'page_id')
  String get pageId;
  @override
  @JsonKey(name: 'page_name')
  String get pageName;
  @override
  @JsonKey(name: 'page_avatar_url')
  String? get pageAvatarUrl;
  @override
  List<CartItem> get items;

  /// Create a copy of Cart
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartImplCopyWith<_$CartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
