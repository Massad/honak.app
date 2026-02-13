// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CatalogItem _$CatalogItemFromJson(Map<String, dynamic> json) {
  return _CatalogItem.fromJson(json);
}

/// @nodoc
mixin _$CatalogItem {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_en')
  String? get nameEn => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @MoneyConverter()
  @JsonKey(name: 'price_cents')
  Money get price => throw _privateConstructorUsedError;
  @MoneyNullableConverter()
  @JsonKey(name: 'compare_at_price_cents')
  Money? get compareAtPrice => throw _privateConstructorUsedError;
  List<Media> get images => throw _privateConstructorUsedError;
  List<CatalogVariant> get variants => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_ar')
  String? get categoryAr => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  @JsonKey(name: 'in_stock')
  bool get inStock => throw _privateConstructorUsedError;
  @JsonKey(name: 'stock_count')
  int? get stockCount => throw _privateConstructorUsedError;
  String? get sku => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_id')
  String? get pageId => throw _privateConstructorUsedError;

  /// Serializes this CatalogItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CatalogItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CatalogItemCopyWith<CatalogItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatalogItemCopyWith<$Res> {
  factory $CatalogItemCopyWith(
    CatalogItem value,
    $Res Function(CatalogItem) then,
  ) = _$CatalogItemCopyWithImpl<$Res, CatalogItem>;
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'name_en') String? nameEn,
    String? description,
    @MoneyConverter() @JsonKey(name: 'price_cents') Money price,
    @MoneyNullableConverter()
    @JsonKey(name: 'compare_at_price_cents')
    Money? compareAtPrice,
    List<Media> images,
    List<CatalogVariant> variants,
    String category,
    @JsonKey(name: 'category_ar') String? categoryAr,
    String? brand,
    @JsonKey(name: 'in_stock') bool inStock,
    @JsonKey(name: 'stock_count') int? stockCount,
    String? sku,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'page_id') String? pageId,
  });
}

/// @nodoc
class _$CatalogItemCopyWithImpl<$Res, $Val extends CatalogItem>
    implements $CatalogItemCopyWith<$Res> {
  _$CatalogItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CatalogItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = freezed,
    Object? description = freezed,
    Object? price = null,
    Object? compareAtPrice = freezed,
    Object? images = null,
    Object? variants = null,
    Object? category = null,
    Object? categoryAr = freezed,
    Object? brand = freezed,
    Object? inStock = null,
    Object? stockCount = freezed,
    Object? sku = freezed,
    Object? sortOrder = null,
    Object? pageId = freezed,
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
            nameEn: freezed == nameEn
                ? _value.nameEn
                : nameEn // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as Money,
            compareAtPrice: freezed == compareAtPrice
                ? _value.compareAtPrice
                : compareAtPrice // ignore: cast_nullable_to_non_nullable
                      as Money?,
            images: null == images
                ? _value.images
                : images // ignore: cast_nullable_to_non_nullable
                      as List<Media>,
            variants: null == variants
                ? _value.variants
                : variants // ignore: cast_nullable_to_non_nullable
                      as List<CatalogVariant>,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryAr: freezed == categoryAr
                ? _value.categoryAr
                : categoryAr // ignore: cast_nullable_to_non_nullable
                      as String?,
            brand: freezed == brand
                ? _value.brand
                : brand // ignore: cast_nullable_to_non_nullable
                      as String?,
            inStock: null == inStock
                ? _value.inStock
                : inStock // ignore: cast_nullable_to_non_nullable
                      as bool,
            stockCount: freezed == stockCount
                ? _value.stockCount
                : stockCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            sku: freezed == sku
                ? _value.sku
                : sku // ignore: cast_nullable_to_non_nullable
                      as String?,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            pageId: freezed == pageId
                ? _value.pageId
                : pageId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CatalogItemImplCopyWith<$Res>
    implements $CatalogItemCopyWith<$Res> {
  factory _$$CatalogItemImplCopyWith(
    _$CatalogItemImpl value,
    $Res Function(_$CatalogItemImpl) then,
  ) = __$$CatalogItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'name_en') String? nameEn,
    String? description,
    @MoneyConverter() @JsonKey(name: 'price_cents') Money price,
    @MoneyNullableConverter()
    @JsonKey(name: 'compare_at_price_cents')
    Money? compareAtPrice,
    List<Media> images,
    List<CatalogVariant> variants,
    String category,
    @JsonKey(name: 'category_ar') String? categoryAr,
    String? brand,
    @JsonKey(name: 'in_stock') bool inStock,
    @JsonKey(name: 'stock_count') int? stockCount,
    String? sku,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'page_id') String? pageId,
  });
}

/// @nodoc
class __$$CatalogItemImplCopyWithImpl<$Res>
    extends _$CatalogItemCopyWithImpl<$Res, _$CatalogItemImpl>
    implements _$$CatalogItemImplCopyWith<$Res> {
  __$$CatalogItemImplCopyWithImpl(
    _$CatalogItemImpl _value,
    $Res Function(_$CatalogItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CatalogItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = freezed,
    Object? description = freezed,
    Object? price = null,
    Object? compareAtPrice = freezed,
    Object? images = null,
    Object? variants = null,
    Object? category = null,
    Object? categoryAr = freezed,
    Object? brand = freezed,
    Object? inStock = null,
    Object? stockCount = freezed,
    Object? sku = freezed,
    Object? sortOrder = null,
    Object? pageId = freezed,
  }) {
    return _then(
      _$CatalogItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        nameEn: freezed == nameEn
            ? _value.nameEn
            : nameEn // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as Money,
        compareAtPrice: freezed == compareAtPrice
            ? _value.compareAtPrice
            : compareAtPrice // ignore: cast_nullable_to_non_nullable
                  as Money?,
        images: null == images
            ? _value._images
            : images // ignore: cast_nullable_to_non_nullable
                  as List<Media>,
        variants: null == variants
            ? _value._variants
            : variants // ignore: cast_nullable_to_non_nullable
                  as List<CatalogVariant>,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryAr: freezed == categoryAr
            ? _value.categoryAr
            : categoryAr // ignore: cast_nullable_to_non_nullable
                  as String?,
        brand: freezed == brand
            ? _value.brand
            : brand // ignore: cast_nullable_to_non_nullable
                  as String?,
        inStock: null == inStock
            ? _value.inStock
            : inStock // ignore: cast_nullable_to_non_nullable
                  as bool,
        stockCount: freezed == stockCount
            ? _value.stockCount
            : stockCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        sku: freezed == sku
            ? _value.sku
            : sku // ignore: cast_nullable_to_non_nullable
                  as String?,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        pageId: freezed == pageId
            ? _value.pageId
            : pageId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CatalogItemImpl implements _CatalogItem {
  const _$CatalogItemImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'name_en') this.nameEn,
    this.description,
    @MoneyConverter() @JsonKey(name: 'price_cents') required this.price,
    @MoneyNullableConverter()
    @JsonKey(name: 'compare_at_price_cents')
    this.compareAtPrice = null,
    final List<Media> images = const [],
    final List<CatalogVariant> variants = const [],
    required this.category,
    @JsonKey(name: 'category_ar') this.categoryAr,
    this.brand,
    @JsonKey(name: 'in_stock') this.inStock = true,
    @JsonKey(name: 'stock_count') this.stockCount,
    this.sku,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'page_id') this.pageId,
  }) : _images = images,
       _variants = variants;

  factory _$CatalogItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CatalogItemImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'name_en')
  final String? nameEn;
  @override
  final String? description;
  @override
  @MoneyConverter()
  @JsonKey(name: 'price_cents')
  final Money price;
  @override
  @MoneyNullableConverter()
  @JsonKey(name: 'compare_at_price_cents')
  final Money? compareAtPrice;
  final List<Media> _images;
  @override
  @JsonKey()
  List<Media> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  final List<CatalogVariant> _variants;
  @override
  @JsonKey()
  List<CatalogVariant> get variants {
    if (_variants is EqualUnmodifiableListView) return _variants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variants);
  }

  @override
  final String category;
  @override
  @JsonKey(name: 'category_ar')
  final String? categoryAr;
  @override
  final String? brand;
  @override
  @JsonKey(name: 'in_stock')
  final bool inStock;
  @override
  @JsonKey(name: 'stock_count')
  final int? stockCount;
  @override
  final String? sku;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'page_id')
  final String? pageId;

  @override
  String toString() {
    return 'CatalogItem(id: $id, name: $name, nameEn: $nameEn, description: $description, price: $price, compareAtPrice: $compareAtPrice, images: $images, variants: $variants, category: $category, categoryAr: $categoryAr, brand: $brand, inStock: $inStock, stockCount: $stockCount, sku: $sku, sortOrder: $sortOrder, pageId: $pageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatalogItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.compareAtPrice, compareAtPrice) ||
                other.compareAtPrice == compareAtPrice) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality().equals(other._variants, _variants) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.categoryAr, categoryAr) ||
                other.categoryAr == categoryAr) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.inStock, inStock) || other.inStock == inStock) &&
            (identical(other.stockCount, stockCount) ||
                other.stockCount == stockCount) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.pageId, pageId) || other.pageId == pageId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    nameEn,
    description,
    price,
    compareAtPrice,
    const DeepCollectionEquality().hash(_images),
    const DeepCollectionEquality().hash(_variants),
    category,
    categoryAr,
    brand,
    inStock,
    stockCount,
    sku,
    sortOrder,
    pageId,
  );

  /// Create a copy of CatalogItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CatalogItemImplCopyWith<_$CatalogItemImpl> get copyWith =>
      __$$CatalogItemImplCopyWithImpl<_$CatalogItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CatalogItemImplToJson(this);
  }
}

abstract class _CatalogItem implements CatalogItem {
  const factory _CatalogItem({
    required final String id,
    required final String name,
    @JsonKey(name: 'name_en') final String? nameEn,
    final String? description,
    @MoneyConverter() @JsonKey(name: 'price_cents') required final Money price,
    @MoneyNullableConverter()
    @JsonKey(name: 'compare_at_price_cents')
    final Money? compareAtPrice,
    final List<Media> images,
    final List<CatalogVariant> variants,
    required final String category,
    @JsonKey(name: 'category_ar') final String? categoryAr,
    final String? brand,
    @JsonKey(name: 'in_stock') final bool inStock,
    @JsonKey(name: 'stock_count') final int? stockCount,
    final String? sku,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'page_id') final String? pageId,
  }) = _$CatalogItemImpl;

  factory _CatalogItem.fromJson(Map<String, dynamic> json) =
      _$CatalogItemImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'name_en')
  String? get nameEn;
  @override
  String? get description;
  @override
  @MoneyConverter()
  @JsonKey(name: 'price_cents')
  Money get price;
  @override
  @MoneyNullableConverter()
  @JsonKey(name: 'compare_at_price_cents')
  Money? get compareAtPrice;
  @override
  List<Media> get images;
  @override
  List<CatalogVariant> get variants;
  @override
  String get category;
  @override
  @JsonKey(name: 'category_ar')
  String? get categoryAr;
  @override
  String? get brand;
  @override
  @JsonKey(name: 'in_stock')
  bool get inStock;
  @override
  @JsonKey(name: 'stock_count')
  int? get stockCount;
  @override
  String? get sku;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'page_id')
  String? get pageId;

  /// Create a copy of CatalogItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CatalogItemImplCopyWith<_$CatalogItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CatalogVariant _$CatalogVariantFromJson(Map<String, dynamic> json) {
  return _CatalogVariant.fromJson(json);
}

/// @nodoc
mixin _$CatalogVariant {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_ar')
  String? get nameAr => throw _privateConstructorUsedError;
  List<String> get values => throw _privateConstructorUsedError;
  List<int> get priceAdjustments => throw _privateConstructorUsedError;

  /// Serializes this CatalogVariant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CatalogVariant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CatalogVariantCopyWith<CatalogVariant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatalogVariantCopyWith<$Res> {
  factory $CatalogVariantCopyWith(
    CatalogVariant value,
    $Res Function(CatalogVariant) then,
  ) = _$CatalogVariantCopyWithImpl<$Res, CatalogVariant>;
  @useResult
  $Res call({
    String name,
    @JsonKey(name: 'name_ar') String? nameAr,
    List<String> values,
    List<int> priceAdjustments,
  });
}

/// @nodoc
class _$CatalogVariantCopyWithImpl<$Res, $Val extends CatalogVariant>
    implements $CatalogVariantCopyWith<$Res> {
  _$CatalogVariantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CatalogVariant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? nameAr = freezed,
    Object? values = null,
    Object? priceAdjustments = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            nameAr: freezed == nameAr
                ? _value.nameAr
                : nameAr // ignore: cast_nullable_to_non_nullable
                      as String?,
            values: null == values
                ? _value.values
                : values // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            priceAdjustments: null == priceAdjustments
                ? _value.priceAdjustments
                : priceAdjustments // ignore: cast_nullable_to_non_nullable
                      as List<int>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CatalogVariantImplCopyWith<$Res>
    implements $CatalogVariantCopyWith<$Res> {
  factory _$$CatalogVariantImplCopyWith(
    _$CatalogVariantImpl value,
    $Res Function(_$CatalogVariantImpl) then,
  ) = __$$CatalogVariantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    @JsonKey(name: 'name_ar') String? nameAr,
    List<String> values,
    List<int> priceAdjustments,
  });
}

/// @nodoc
class __$$CatalogVariantImplCopyWithImpl<$Res>
    extends _$CatalogVariantCopyWithImpl<$Res, _$CatalogVariantImpl>
    implements _$$CatalogVariantImplCopyWith<$Res> {
  __$$CatalogVariantImplCopyWithImpl(
    _$CatalogVariantImpl _value,
    $Res Function(_$CatalogVariantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CatalogVariant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? nameAr = freezed,
    Object? values = null,
    Object? priceAdjustments = null,
  }) {
    return _then(
      _$CatalogVariantImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        nameAr: freezed == nameAr
            ? _value.nameAr
            : nameAr // ignore: cast_nullable_to_non_nullable
                  as String?,
        values: null == values
            ? _value._values
            : values // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        priceAdjustments: null == priceAdjustments
            ? _value._priceAdjustments
            : priceAdjustments // ignore: cast_nullable_to_non_nullable
                  as List<int>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CatalogVariantImpl implements _CatalogVariant {
  const _$CatalogVariantImpl({
    required this.name,
    @JsonKey(name: 'name_ar') this.nameAr,
    final List<String> values = const [],
    final List<int> priceAdjustments = const [],
  }) : _values = values,
       _priceAdjustments = priceAdjustments;

  factory _$CatalogVariantImpl.fromJson(Map<String, dynamic> json) =>
      _$$CatalogVariantImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: 'name_ar')
  final String? nameAr;
  final List<String> _values;
  @override
  @JsonKey()
  List<String> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  final List<int> _priceAdjustments;
  @override
  @JsonKey()
  List<int> get priceAdjustments {
    if (_priceAdjustments is EqualUnmodifiableListView)
      return _priceAdjustments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_priceAdjustments);
  }

  @override
  String toString() {
    return 'CatalogVariant(name: $name, nameAr: $nameAr, values: $values, priceAdjustments: $priceAdjustments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatalogVariantImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            const DeepCollectionEquality().equals(other._values, _values) &&
            const DeepCollectionEquality().equals(
              other._priceAdjustments,
              _priceAdjustments,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    nameAr,
    const DeepCollectionEquality().hash(_values),
    const DeepCollectionEquality().hash(_priceAdjustments),
  );

  /// Create a copy of CatalogVariant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CatalogVariantImplCopyWith<_$CatalogVariantImpl> get copyWith =>
      __$$CatalogVariantImplCopyWithImpl<_$CatalogVariantImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CatalogVariantImplToJson(this);
  }
}

abstract class _CatalogVariant implements CatalogVariant {
  const factory _CatalogVariant({
    required final String name,
    @JsonKey(name: 'name_ar') final String? nameAr,
    final List<String> values,
    final List<int> priceAdjustments,
  }) = _$CatalogVariantImpl;

  factory _CatalogVariant.fromJson(Map<String, dynamic> json) =
      _$CatalogVariantImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'name_ar')
  String? get nameAr;
  @override
  List<String> get values;
  @override
  List<int> get priceAdjustments;

  /// Create a copy of CatalogVariant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CatalogVariantImplCopyWith<_$CatalogVariantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
