// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) {
  return _MenuItem.fromJson(json);
}

/// @nodoc
mixin _$MenuItem {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_en')
  String? get nameEn => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @MoneyConverter()
  @JsonKey(name: 'price_cents')
  Money get price => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_ar')
  String? get categoryAr => throw _privateConstructorUsedError;
  List<MenuItemSize> get sizes => throw _privateConstructorUsedError;
  List<MenuItemModifier> get modifiers => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_available')
  bool get isAvailable => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_popular')
  bool get isPopular => throw _privateConstructorUsedError;
  @JsonKey(name: 'preparation_time_minutes')
  int? get preparationTimeMinutes => throw _privateConstructorUsedError;
  int? get calories => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_id')
  String? get pageId => throw _privateConstructorUsedError;

  /// Serializes this MenuItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MenuItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenuItemCopyWith<MenuItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuItemCopyWith<$Res> {
  factory $MenuItemCopyWith(MenuItem value, $Res Function(MenuItem) then) =
      _$MenuItemCopyWithImpl<$Res, MenuItem>;
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'name_en') String? nameEn,
    String? description,
    @MoneyConverter() @JsonKey(name: 'price_cents') Money price,
    String? image,
    String category,
    @JsonKey(name: 'category_ar') String? categoryAr,
    List<MenuItemSize> sizes,
    List<MenuItemModifier> modifiers,
    @JsonKey(name: 'is_available') bool isAvailable,
    @JsonKey(name: 'is_popular') bool isPopular,
    @JsonKey(name: 'preparation_time_minutes') int? preparationTimeMinutes,
    int? calories,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'page_id') String? pageId,
  });
}

/// @nodoc
class _$MenuItemCopyWithImpl<$Res, $Val extends MenuItem>
    implements $MenuItemCopyWith<$Res> {
  _$MenuItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MenuItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = freezed,
    Object? description = freezed,
    Object? price = null,
    Object? image = freezed,
    Object? category = null,
    Object? categoryAr = freezed,
    Object? sizes = null,
    Object? modifiers = null,
    Object? isAvailable = null,
    Object? isPopular = null,
    Object? preparationTimeMinutes = freezed,
    Object? calories = freezed,
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
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryAr: freezed == categoryAr
                ? _value.categoryAr
                : categoryAr // ignore: cast_nullable_to_non_nullable
                      as String?,
            sizes: null == sizes
                ? _value.sizes
                : sizes // ignore: cast_nullable_to_non_nullable
                      as List<MenuItemSize>,
            modifiers: null == modifiers
                ? _value.modifiers
                : modifiers // ignore: cast_nullable_to_non_nullable
                      as List<MenuItemModifier>,
            isAvailable: null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPopular: null == isPopular
                ? _value.isPopular
                : isPopular // ignore: cast_nullable_to_non_nullable
                      as bool,
            preparationTimeMinutes: freezed == preparationTimeMinutes
                ? _value.preparationTimeMinutes
                : preparationTimeMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            calories: freezed == calories
                ? _value.calories
                : calories // ignore: cast_nullable_to_non_nullable
                      as int?,
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
abstract class _$$MenuItemImplCopyWith<$Res>
    implements $MenuItemCopyWith<$Res> {
  factory _$$MenuItemImplCopyWith(
    _$MenuItemImpl value,
    $Res Function(_$MenuItemImpl) then,
  ) = __$$MenuItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'name_en') String? nameEn,
    String? description,
    @MoneyConverter() @JsonKey(name: 'price_cents') Money price,
    String? image,
    String category,
    @JsonKey(name: 'category_ar') String? categoryAr,
    List<MenuItemSize> sizes,
    List<MenuItemModifier> modifiers,
    @JsonKey(name: 'is_available') bool isAvailable,
    @JsonKey(name: 'is_popular') bool isPopular,
    @JsonKey(name: 'preparation_time_minutes') int? preparationTimeMinutes,
    int? calories,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'page_id') String? pageId,
  });
}

/// @nodoc
class __$$MenuItemImplCopyWithImpl<$Res>
    extends _$MenuItemCopyWithImpl<$Res, _$MenuItemImpl>
    implements _$$MenuItemImplCopyWith<$Res> {
  __$$MenuItemImplCopyWithImpl(
    _$MenuItemImpl _value,
    $Res Function(_$MenuItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MenuItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = freezed,
    Object? description = freezed,
    Object? price = null,
    Object? image = freezed,
    Object? category = null,
    Object? categoryAr = freezed,
    Object? sizes = null,
    Object? modifiers = null,
    Object? isAvailable = null,
    Object? isPopular = null,
    Object? preparationTimeMinutes = freezed,
    Object? calories = freezed,
    Object? sortOrder = null,
    Object? pageId = freezed,
  }) {
    return _then(
      _$MenuItemImpl(
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
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryAr: freezed == categoryAr
            ? _value.categoryAr
            : categoryAr // ignore: cast_nullable_to_non_nullable
                  as String?,
        sizes: null == sizes
            ? _value._sizes
            : sizes // ignore: cast_nullable_to_non_nullable
                  as List<MenuItemSize>,
        modifiers: null == modifiers
            ? _value._modifiers
            : modifiers // ignore: cast_nullable_to_non_nullable
                  as List<MenuItemModifier>,
        isAvailable: null == isAvailable
            ? _value.isAvailable
            : isAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPopular: null == isPopular
            ? _value.isPopular
            : isPopular // ignore: cast_nullable_to_non_nullable
                  as bool,
        preparationTimeMinutes: freezed == preparationTimeMinutes
            ? _value.preparationTimeMinutes
            : preparationTimeMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        calories: freezed == calories
            ? _value.calories
            : calories // ignore: cast_nullable_to_non_nullable
                  as int?,
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
class _$MenuItemImpl implements _MenuItem {
  const _$MenuItemImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'name_en') this.nameEn,
    this.description,
    @MoneyConverter() @JsonKey(name: 'price_cents') required this.price,
    this.image,
    required this.category,
    @JsonKey(name: 'category_ar') this.categoryAr,
    final List<MenuItemSize> sizes = const [],
    final List<MenuItemModifier> modifiers = const [],
    @JsonKey(name: 'is_available') this.isAvailable = true,
    @JsonKey(name: 'is_popular') this.isPopular = false,
    @JsonKey(name: 'preparation_time_minutes') this.preparationTimeMinutes,
    this.calories,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'page_id') this.pageId,
  }) : _sizes = sizes,
       _modifiers = modifiers;

  factory _$MenuItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenuItemImplFromJson(json);

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
  final String? image;
  @override
  final String category;
  @override
  @JsonKey(name: 'category_ar')
  final String? categoryAr;
  final List<MenuItemSize> _sizes;
  @override
  @JsonKey()
  List<MenuItemSize> get sizes {
    if (_sizes is EqualUnmodifiableListView) return _sizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sizes);
  }

  final List<MenuItemModifier> _modifiers;
  @override
  @JsonKey()
  List<MenuItemModifier> get modifiers {
    if (_modifiers is EqualUnmodifiableListView) return _modifiers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modifiers);
  }

  @override
  @JsonKey(name: 'is_available')
  final bool isAvailable;
  @override
  @JsonKey(name: 'is_popular')
  final bool isPopular;
  @override
  @JsonKey(name: 'preparation_time_minutes')
  final int? preparationTimeMinutes;
  @override
  final int? calories;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'page_id')
  final String? pageId;

  @override
  String toString() {
    return 'MenuItem(id: $id, name: $name, nameEn: $nameEn, description: $description, price: $price, image: $image, category: $category, categoryAr: $categoryAr, sizes: $sizes, modifiers: $modifiers, isAvailable: $isAvailable, isPopular: $isPopular, preparationTimeMinutes: $preparationTimeMinutes, calories: $calories, sortOrder: $sortOrder, pageId: $pageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.categoryAr, categoryAr) ||
                other.categoryAr == categoryAr) &&
            const DeepCollectionEquality().equals(other._sizes, _sizes) &&
            const DeepCollectionEquality().equals(
              other._modifiers,
              _modifiers,
            ) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.isPopular, isPopular) ||
                other.isPopular == isPopular) &&
            (identical(other.preparationTimeMinutes, preparationTimeMinutes) ||
                other.preparationTimeMinutes == preparationTimeMinutes) &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
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
    image,
    category,
    categoryAr,
    const DeepCollectionEquality().hash(_sizes),
    const DeepCollectionEquality().hash(_modifiers),
    isAvailable,
    isPopular,
    preparationTimeMinutes,
    calories,
    sortOrder,
    pageId,
  );

  /// Create a copy of MenuItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuItemImplCopyWith<_$MenuItemImpl> get copyWith =>
      __$$MenuItemImplCopyWithImpl<_$MenuItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MenuItemImplToJson(this);
  }
}

abstract class _MenuItem implements MenuItem {
  const factory _MenuItem({
    required final String id,
    required final String name,
    @JsonKey(name: 'name_en') final String? nameEn,
    final String? description,
    @MoneyConverter() @JsonKey(name: 'price_cents') required final Money price,
    final String? image,
    required final String category,
    @JsonKey(name: 'category_ar') final String? categoryAr,
    final List<MenuItemSize> sizes,
    final List<MenuItemModifier> modifiers,
    @JsonKey(name: 'is_available') final bool isAvailable,
    @JsonKey(name: 'is_popular') final bool isPopular,
    @JsonKey(name: 'preparation_time_minutes')
    final int? preparationTimeMinutes,
    final int? calories,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'page_id') final String? pageId,
  }) = _$MenuItemImpl;

  factory _MenuItem.fromJson(Map<String, dynamic> json) =
      _$MenuItemImpl.fromJson;

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
  String? get image;
  @override
  String get category;
  @override
  @JsonKey(name: 'category_ar')
  String? get categoryAr;
  @override
  List<MenuItemSize> get sizes;
  @override
  List<MenuItemModifier> get modifiers;
  @override
  @JsonKey(name: 'is_available')
  bool get isAvailable;
  @override
  @JsonKey(name: 'is_popular')
  bool get isPopular;
  @override
  @JsonKey(name: 'preparation_time_minutes')
  int? get preparationTimeMinutes;
  @override
  int? get calories;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'page_id')
  String? get pageId;

  /// Create a copy of MenuItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenuItemImplCopyWith<_$MenuItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MenuItemSize _$MenuItemSizeFromJson(Map<String, dynamic> json) {
  return _MenuItemSize.fromJson(json);
}

/// @nodoc
mixin _$MenuItemSize {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_ar')
  String? get nameAr => throw _privateConstructorUsedError;
  @MoneyConverter()
  @JsonKey(name: 'price_cents')
  Money get price => throw _privateConstructorUsedError;

  /// Serializes this MenuItemSize to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MenuItemSize
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenuItemSizeCopyWith<MenuItemSize> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuItemSizeCopyWith<$Res> {
  factory $MenuItemSizeCopyWith(
    MenuItemSize value,
    $Res Function(MenuItemSize) then,
  ) = _$MenuItemSizeCopyWithImpl<$Res, MenuItemSize>;
  @useResult
  $Res call({
    String name,
    @JsonKey(name: 'name_ar') String? nameAr,
    @MoneyConverter() @JsonKey(name: 'price_cents') Money price,
  });
}

/// @nodoc
class _$MenuItemSizeCopyWithImpl<$Res, $Val extends MenuItemSize>
    implements $MenuItemSizeCopyWith<$Res> {
  _$MenuItemSizeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MenuItemSize
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? nameAr = freezed,
    Object? price = null,
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
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as Money,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MenuItemSizeImplCopyWith<$Res>
    implements $MenuItemSizeCopyWith<$Res> {
  factory _$$MenuItemSizeImplCopyWith(
    _$MenuItemSizeImpl value,
    $Res Function(_$MenuItemSizeImpl) then,
  ) = __$$MenuItemSizeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    @JsonKey(name: 'name_ar') String? nameAr,
    @MoneyConverter() @JsonKey(name: 'price_cents') Money price,
  });
}

/// @nodoc
class __$$MenuItemSizeImplCopyWithImpl<$Res>
    extends _$MenuItemSizeCopyWithImpl<$Res, _$MenuItemSizeImpl>
    implements _$$MenuItemSizeImplCopyWith<$Res> {
  __$$MenuItemSizeImplCopyWithImpl(
    _$MenuItemSizeImpl _value,
    $Res Function(_$MenuItemSizeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MenuItemSize
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? nameAr = freezed,
    Object? price = null,
  }) {
    return _then(
      _$MenuItemSizeImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        nameAr: freezed == nameAr
            ? _value.nameAr
            : nameAr // ignore: cast_nullable_to_non_nullable
                  as String?,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as Money,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MenuItemSizeImpl implements _MenuItemSize {
  const _$MenuItemSizeImpl({
    required this.name,
    @JsonKey(name: 'name_ar') this.nameAr,
    @MoneyConverter() @JsonKey(name: 'price_cents') required this.price,
  });

  factory _$MenuItemSizeImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenuItemSizeImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: 'name_ar')
  final String? nameAr;
  @override
  @MoneyConverter()
  @JsonKey(name: 'price_cents')
  final Money price;

  @override
  String toString() {
    return 'MenuItemSize(name: $name, nameAr: $nameAr, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuItemSizeImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, nameAr, price);

  /// Create a copy of MenuItemSize
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuItemSizeImplCopyWith<_$MenuItemSizeImpl> get copyWith =>
      __$$MenuItemSizeImplCopyWithImpl<_$MenuItemSizeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MenuItemSizeImplToJson(this);
  }
}

abstract class _MenuItemSize implements MenuItemSize {
  const factory _MenuItemSize({
    required final String name,
    @JsonKey(name: 'name_ar') final String? nameAr,
    @MoneyConverter() @JsonKey(name: 'price_cents') required final Money price,
  }) = _$MenuItemSizeImpl;

  factory _MenuItemSize.fromJson(Map<String, dynamic> json) =
      _$MenuItemSizeImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'name_ar')
  String? get nameAr;
  @override
  @MoneyConverter()
  @JsonKey(name: 'price_cents')
  Money get price;

  /// Create a copy of MenuItemSize
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenuItemSizeImplCopyWith<_$MenuItemSizeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MenuItemModifier _$MenuItemModifierFromJson(Map<String, dynamic> json) {
  return _MenuItemModifier.fromJson(json);
}

/// @nodoc
mixin _$MenuItemModifier {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_ar')
  String? get nameAr => throw _privateConstructorUsedError;
  @MoneyNullableConverter()
  @JsonKey(name: 'price_cents')
  Money? get price => throw _privateConstructorUsedError;

  /// Serializes this MenuItemModifier to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MenuItemModifier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenuItemModifierCopyWith<MenuItemModifier> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuItemModifierCopyWith<$Res> {
  factory $MenuItemModifierCopyWith(
    MenuItemModifier value,
    $Res Function(MenuItemModifier) then,
  ) = _$MenuItemModifierCopyWithImpl<$Res, MenuItemModifier>;
  @useResult
  $Res call({
    String name,
    @JsonKey(name: 'name_ar') String? nameAr,
    @MoneyNullableConverter() @JsonKey(name: 'price_cents') Money? price,
  });
}

/// @nodoc
class _$MenuItemModifierCopyWithImpl<$Res, $Val extends MenuItemModifier>
    implements $MenuItemModifierCopyWith<$Res> {
  _$MenuItemModifierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MenuItemModifier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? nameAr = freezed,
    Object? price = freezed,
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
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as Money?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MenuItemModifierImplCopyWith<$Res>
    implements $MenuItemModifierCopyWith<$Res> {
  factory _$$MenuItemModifierImplCopyWith(
    _$MenuItemModifierImpl value,
    $Res Function(_$MenuItemModifierImpl) then,
  ) = __$$MenuItemModifierImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    @JsonKey(name: 'name_ar') String? nameAr,
    @MoneyNullableConverter() @JsonKey(name: 'price_cents') Money? price,
  });
}

/// @nodoc
class __$$MenuItemModifierImplCopyWithImpl<$Res>
    extends _$MenuItemModifierCopyWithImpl<$Res, _$MenuItemModifierImpl>
    implements _$$MenuItemModifierImplCopyWith<$Res> {
  __$$MenuItemModifierImplCopyWithImpl(
    _$MenuItemModifierImpl _value,
    $Res Function(_$MenuItemModifierImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MenuItemModifier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? nameAr = freezed,
    Object? price = freezed,
  }) {
    return _then(
      _$MenuItemModifierImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        nameAr: freezed == nameAr
            ? _value.nameAr
            : nameAr // ignore: cast_nullable_to_non_nullable
                  as String?,
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as Money?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MenuItemModifierImpl implements _MenuItemModifier {
  const _$MenuItemModifierImpl({
    required this.name,
    @JsonKey(name: 'name_ar') this.nameAr,
    @MoneyNullableConverter() @JsonKey(name: 'price_cents') this.price = null,
  });

  factory _$MenuItemModifierImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenuItemModifierImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: 'name_ar')
  final String? nameAr;
  @override
  @MoneyNullableConverter()
  @JsonKey(name: 'price_cents')
  final Money? price;

  @override
  String toString() {
    return 'MenuItemModifier(name: $name, nameAr: $nameAr, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuItemModifierImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, nameAr, price);

  /// Create a copy of MenuItemModifier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuItemModifierImplCopyWith<_$MenuItemModifierImpl> get copyWith =>
      __$$MenuItemModifierImplCopyWithImpl<_$MenuItemModifierImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MenuItemModifierImplToJson(this);
  }
}

abstract class _MenuItemModifier implements MenuItemModifier {
  const factory _MenuItemModifier({
    required final String name,
    @JsonKey(name: 'name_ar') final String? nameAr,
    @MoneyNullableConverter() @JsonKey(name: 'price_cents') final Money? price,
  }) = _$MenuItemModifierImpl;

  factory _MenuItemModifier.fromJson(Map<String, dynamic> json) =
      _$MenuItemModifierImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'name_ar')
  String? get nameAr;
  @override
  @MoneyNullableConverter()
  @JsonKey(name: 'price_cents')
  Money? get price;

  /// Create a copy of MenuItemModifier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenuItemModifierImplCopyWith<_$MenuItemModifierImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
