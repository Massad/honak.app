// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Item _$ItemFromJson(Map<String, dynamic> json) {
  return _Item.fromJson(json);
}

/// @nodoc
mixin _$Item {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_ar')
  String get nameAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_en')
  String? get nameEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'description_ar')
  String? get descriptionAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'description_en')
  String? get descriptionEn => throw _privateConstructorUsedError;
  @_MoneyConverter()
  @JsonKey(name: 'price_cents')
  Money get price => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  @JsonKey(name: 'option_groups')
  List<OptionGroup> get optionGroups => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  String? get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'in_stock')
  bool get inStock => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_id')
  String? get pageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this Item to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItemCopyWith<Item> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCopyWith<$Res> {
  factory $ItemCopyWith(Item value, $Res Function(Item) then) =
      _$ItemCopyWithImpl<$Res, Item>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'name_ar') String nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    @JsonKey(name: 'description_ar') String? descriptionAr,
    @JsonKey(name: 'description_en') String? descriptionEn,
    @_MoneyConverter() @JsonKey(name: 'price_cents') Money price,
    List<String> images,
    @JsonKey(name: 'option_groups') List<OptionGroup> optionGroups,
    @JsonKey(name: 'category_id') String? categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'in_stock') bool inStock,
    @JsonKey(name: 'page_id') String? pageId,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class _$ItemCopyWithImpl<$Res, $Val extends Item>
    implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameAr = null,
    Object? nameEn = freezed,
    Object? descriptionAr = freezed,
    Object? descriptionEn = freezed,
    Object? price = null,
    Object? images = null,
    Object? optionGroups = null,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? inStock = null,
    Object? pageId = freezed,
    Object? sortOrder = null,
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
            descriptionEn: freezed == descriptionEn
                ? _value.descriptionEn
                : descriptionEn // ignore: cast_nullable_to_non_nullable
                      as String?,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as Money,
            images: null == images
                ? _value.images
                : images // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            optionGroups: null == optionGroups
                ? _value.optionGroups
                : optionGroups // ignore: cast_nullable_to_non_nullable
                      as List<OptionGroup>,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryName: freezed == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String?,
            inStock: null == inStock
                ? _value.inStock
                : inStock // ignore: cast_nullable_to_non_nullable
                      as bool,
            pageId: freezed == pageId
                ? _value.pageId
                : pageId // ignore: cast_nullable_to_non_nullable
                      as String?,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ItemImplCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$$ItemImplCopyWith(
    _$ItemImpl value,
    $Res Function(_$ItemImpl) then,
  ) = __$$ItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'name_ar') String nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    @JsonKey(name: 'description_ar') String? descriptionAr,
    @JsonKey(name: 'description_en') String? descriptionEn,
    @_MoneyConverter() @JsonKey(name: 'price_cents') Money price,
    List<String> images,
    @JsonKey(name: 'option_groups') List<OptionGroup> optionGroups,
    @JsonKey(name: 'category_id') String? categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'in_stock') bool inStock,
    @JsonKey(name: 'page_id') String? pageId,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class __$$ItemImplCopyWithImpl<$Res>
    extends _$ItemCopyWithImpl<$Res, _$ItemImpl>
    implements _$$ItemImplCopyWith<$Res> {
  __$$ItemImplCopyWithImpl(_$ItemImpl _value, $Res Function(_$ItemImpl) _then)
    : super(_value, _then);

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameAr = null,
    Object? nameEn = freezed,
    Object? descriptionAr = freezed,
    Object? descriptionEn = freezed,
    Object? price = null,
    Object? images = null,
    Object? optionGroups = null,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? inStock = null,
    Object? pageId = freezed,
    Object? sortOrder = null,
  }) {
    return _then(
      _$ItemImpl(
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
        descriptionEn: freezed == descriptionEn
            ? _value.descriptionEn
            : descriptionEn // ignore: cast_nullable_to_non_nullable
                  as String?,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as Money,
        images: null == images
            ? _value._images
            : images // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        optionGroups: null == optionGroups
            ? _value._optionGroups
            : optionGroups // ignore: cast_nullable_to_non_nullable
                  as List<OptionGroup>,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryName: freezed == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String?,
        inStock: null == inStock
            ? _value.inStock
            : inStock // ignore: cast_nullable_to_non_nullable
                  as bool,
        pageId: freezed == pageId
            ? _value.pageId
            : pageId // ignore: cast_nullable_to_non_nullable
                  as String?,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemImpl implements _Item {
  const _$ItemImpl({
    required this.id,
    @JsonKey(name: 'name_ar') required this.nameAr,
    @JsonKey(name: 'name_en') this.nameEn,
    @JsonKey(name: 'description_ar') this.descriptionAr,
    @JsonKey(name: 'description_en') this.descriptionEn,
    @_MoneyConverter() @JsonKey(name: 'price_cents') required this.price,
    final List<String> images = const [],
    @JsonKey(name: 'option_groups')
    final List<OptionGroup> optionGroups = const [],
    @JsonKey(name: 'category_id') this.categoryId,
    @JsonKey(name: 'category_name') this.categoryName,
    @JsonKey(name: 'in_stock') this.inStock = true,
    @JsonKey(name: 'page_id') this.pageId,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
  }) : _images = images,
       _optionGroups = optionGroups;

  factory _$ItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemImplFromJson(json);

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
  @JsonKey(name: 'description_en')
  final String? descriptionEn;
  @override
  @_MoneyConverter()
  @JsonKey(name: 'price_cents')
  final Money price;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  final List<OptionGroup> _optionGroups;
  @override
  @JsonKey(name: 'option_groups')
  List<OptionGroup> get optionGroups {
    if (_optionGroups is EqualUnmodifiableListView) return _optionGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_optionGroups);
  }

  @override
  @JsonKey(name: 'category_id')
  final String? categoryId;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @override
  @JsonKey(name: 'in_stock')
  final bool inStock;
  @override
  @JsonKey(name: 'page_id')
  final String? pageId;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;

  @override
  String toString() {
    return 'Item(id: $id, nameAr: $nameAr, nameEn: $nameEn, descriptionAr: $descriptionAr, descriptionEn: $descriptionEn, price: $price, images: $images, optionGroups: $optionGroups, categoryId: $categoryId, categoryName: $categoryName, inStock: $inStock, pageId: $pageId, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.descriptionAr, descriptionAr) ||
                other.descriptionAr == descriptionAr) &&
            (identical(other.descriptionEn, descriptionEn) ||
                other.descriptionEn == descriptionEn) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality().equals(
              other._optionGroups,
              _optionGroups,
            ) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.inStock, inStock) || other.inStock == inStock) &&
            (identical(other.pageId, pageId) || other.pageId == pageId) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    nameAr,
    nameEn,
    descriptionAr,
    descriptionEn,
    price,
    const DeepCollectionEquality().hash(_images),
    const DeepCollectionEquality().hash(_optionGroups),
    categoryId,
    categoryName,
    inStock,
    pageId,
    sortOrder,
  );

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      __$$ItemImplCopyWithImpl<_$ItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemImplToJson(this);
  }
}

abstract class _Item implements Item {
  const factory _Item({
    required final String id,
    @JsonKey(name: 'name_ar') required final String nameAr,
    @JsonKey(name: 'name_en') final String? nameEn,
    @JsonKey(name: 'description_ar') final String? descriptionAr,
    @JsonKey(name: 'description_en') final String? descriptionEn,
    @_MoneyConverter() @JsonKey(name: 'price_cents') required final Money price,
    final List<String> images,
    @JsonKey(name: 'option_groups') final List<OptionGroup> optionGroups,
    @JsonKey(name: 'category_id') final String? categoryId,
    @JsonKey(name: 'category_name') final String? categoryName,
    @JsonKey(name: 'in_stock') final bool inStock,
    @JsonKey(name: 'page_id') final String? pageId,
    @JsonKey(name: 'sort_order') final int sortOrder,
  }) = _$ItemImpl;

  factory _Item.fromJson(Map<String, dynamic> json) = _$ItemImpl.fromJson;

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
  @JsonKey(name: 'description_en')
  String? get descriptionEn;
  @override
  @_MoneyConverter()
  @JsonKey(name: 'price_cents')
  Money get price;
  @override
  List<String> get images;
  @override
  @JsonKey(name: 'option_groups')
  List<OptionGroup> get optionGroups;
  @override
  @JsonKey(name: 'category_id')
  String? get categoryId;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  @JsonKey(name: 'in_stock')
  bool get inStock;
  @override
  @JsonKey(name: 'page_id')
  String? get pageId;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OptionGroup _$OptionGroupFromJson(Map<String, dynamic> json) {
  return _OptionGroup.fromJson(json);
}

/// @nodoc
mixin _$OptionGroup {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'label_ar')
  String get labelAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'label_en')
  String? get labelEn => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'required')
  bool get isRequired => throw _privateConstructorUsedError;
  List<ItemOption> get options => throw _privateConstructorUsedError;

  /// Serializes this OptionGroup to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OptionGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OptionGroupCopyWith<OptionGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptionGroupCopyWith<$Res> {
  factory $OptionGroupCopyWith(
    OptionGroup value,
    $Res Function(OptionGroup) then,
  ) = _$OptionGroupCopyWithImpl<$Res, OptionGroup>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'label_ar') String labelAr,
    @JsonKey(name: 'label_en') String? labelEn,
    String type,
    @JsonKey(name: 'required') bool isRequired,
    List<ItemOption> options,
  });
}

/// @nodoc
class _$OptionGroupCopyWithImpl<$Res, $Val extends OptionGroup>
    implements $OptionGroupCopyWith<$Res> {
  _$OptionGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OptionGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? labelAr = null,
    Object? labelEn = freezed,
    Object? type = null,
    Object? isRequired = null,
    Object? options = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            labelAr: null == labelAr
                ? _value.labelAr
                : labelAr // ignore: cast_nullable_to_non_nullable
                      as String,
            labelEn: freezed == labelEn
                ? _value.labelEn
                : labelEn // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            isRequired: null == isRequired
                ? _value.isRequired
                : isRequired // ignore: cast_nullable_to_non_nullable
                      as bool,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<ItemOption>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OptionGroupImplCopyWith<$Res>
    implements $OptionGroupCopyWith<$Res> {
  factory _$$OptionGroupImplCopyWith(
    _$OptionGroupImpl value,
    $Res Function(_$OptionGroupImpl) then,
  ) = __$$OptionGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'label_ar') String labelAr,
    @JsonKey(name: 'label_en') String? labelEn,
    String type,
    @JsonKey(name: 'required') bool isRequired,
    List<ItemOption> options,
  });
}

/// @nodoc
class __$$OptionGroupImplCopyWithImpl<$Res>
    extends _$OptionGroupCopyWithImpl<$Res, _$OptionGroupImpl>
    implements _$$OptionGroupImplCopyWith<$Res> {
  __$$OptionGroupImplCopyWithImpl(
    _$OptionGroupImpl _value,
    $Res Function(_$OptionGroupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OptionGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? labelAr = null,
    Object? labelEn = freezed,
    Object? type = null,
    Object? isRequired = null,
    Object? options = null,
  }) {
    return _then(
      _$OptionGroupImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        labelAr: null == labelAr
            ? _value.labelAr
            : labelAr // ignore: cast_nullable_to_non_nullable
                  as String,
        labelEn: freezed == labelEn
            ? _value.labelEn
            : labelEn // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        isRequired: null == isRequired
            ? _value.isRequired
            : isRequired // ignore: cast_nullable_to_non_nullable
                  as bool,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<ItemOption>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OptionGroupImpl implements _OptionGroup {
  const _$OptionGroupImpl({
    required this.id,
    @JsonKey(name: 'label_ar') required this.labelAr,
    @JsonKey(name: 'label_en') this.labelEn,
    required this.type,
    @JsonKey(name: 'required') this.isRequired = false,
    final List<ItemOption> options = const [],
  }) : _options = options;

  factory _$OptionGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$OptionGroupImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'label_ar')
  final String labelAr;
  @override
  @JsonKey(name: 'label_en')
  final String? labelEn;
  @override
  final String type;
  @override
  @JsonKey(name: 'required')
  final bool isRequired;
  final List<ItemOption> _options;
  @override
  @JsonKey()
  List<ItemOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  String toString() {
    return 'OptionGroup(id: $id, labelAr: $labelAr, labelEn: $labelEn, type: $type, isRequired: $isRequired, options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OptionGroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.labelAr, labelAr) || other.labelAr == labelAr) &&
            (identical(other.labelEn, labelEn) || other.labelEn == labelEn) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    labelAr,
    labelEn,
    type,
    isRequired,
    const DeepCollectionEquality().hash(_options),
  );

  /// Create a copy of OptionGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OptionGroupImplCopyWith<_$OptionGroupImpl> get copyWith =>
      __$$OptionGroupImplCopyWithImpl<_$OptionGroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OptionGroupImplToJson(this);
  }
}

abstract class _OptionGroup implements OptionGroup {
  const factory _OptionGroup({
    required final String id,
    @JsonKey(name: 'label_ar') required final String labelAr,
    @JsonKey(name: 'label_en') final String? labelEn,
    required final String type,
    @JsonKey(name: 'required') final bool isRequired,
    final List<ItemOption> options,
  }) = _$OptionGroupImpl;

  factory _OptionGroup.fromJson(Map<String, dynamic> json) =
      _$OptionGroupImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'label_ar')
  String get labelAr;
  @override
  @JsonKey(name: 'label_en')
  String? get labelEn;
  @override
  String get type;
  @override
  @JsonKey(name: 'required')
  bool get isRequired;
  @override
  List<ItemOption> get options;

  /// Create a copy of OptionGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OptionGroupImplCopyWith<_$OptionGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ItemOption _$ItemOptionFromJson(Map<String, dynamic> json) {
  return _ItemOption.fromJson(json);
}

/// @nodoc
mixin _$ItemOption {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'label_ar')
  String get labelAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'label_en')
  String? get labelEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_modifier')
  int get priceModifier => throw _privateConstructorUsedError;
  @JsonKey(name: 'color_hex')
  String? get colorHex => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this ItemOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ItemOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItemOptionCopyWith<ItemOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemOptionCopyWith<$Res> {
  factory $ItemOptionCopyWith(
    ItemOption value,
    $Res Function(ItemOption) then,
  ) = _$ItemOptionCopyWithImpl<$Res, ItemOption>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'label_ar') String labelAr,
    @JsonKey(name: 'label_en') String? labelEn,
    @JsonKey(name: 'price_modifier') int priceModifier,
    @JsonKey(name: 'color_hex') String? colorHex,
    @JsonKey(name: 'image_url') String? imageUrl,
  });
}

/// @nodoc
class _$ItemOptionCopyWithImpl<$Res, $Val extends ItemOption>
    implements $ItemOptionCopyWith<$Res> {
  _$ItemOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ItemOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? labelAr = null,
    Object? labelEn = freezed,
    Object? priceModifier = null,
    Object? colorHex = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            labelAr: null == labelAr
                ? _value.labelAr
                : labelAr // ignore: cast_nullable_to_non_nullable
                      as String,
            labelEn: freezed == labelEn
                ? _value.labelEn
                : labelEn // ignore: cast_nullable_to_non_nullable
                      as String?,
            priceModifier: null == priceModifier
                ? _value.priceModifier
                : priceModifier // ignore: cast_nullable_to_non_nullable
                      as int,
            colorHex: freezed == colorHex
                ? _value.colorHex
                : colorHex // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ItemOptionImplCopyWith<$Res>
    implements $ItemOptionCopyWith<$Res> {
  factory _$$ItemOptionImplCopyWith(
    _$ItemOptionImpl value,
    $Res Function(_$ItemOptionImpl) then,
  ) = __$$ItemOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'label_ar') String labelAr,
    @JsonKey(name: 'label_en') String? labelEn,
    @JsonKey(name: 'price_modifier') int priceModifier,
    @JsonKey(name: 'color_hex') String? colorHex,
    @JsonKey(name: 'image_url') String? imageUrl,
  });
}

/// @nodoc
class __$$ItemOptionImplCopyWithImpl<$Res>
    extends _$ItemOptionCopyWithImpl<$Res, _$ItemOptionImpl>
    implements _$$ItemOptionImplCopyWith<$Res> {
  __$$ItemOptionImplCopyWithImpl(
    _$ItemOptionImpl _value,
    $Res Function(_$ItemOptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ItemOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? labelAr = null,
    Object? labelEn = freezed,
    Object? priceModifier = null,
    Object? colorHex = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$ItemOptionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        labelAr: null == labelAr
            ? _value.labelAr
            : labelAr // ignore: cast_nullable_to_non_nullable
                  as String,
        labelEn: freezed == labelEn
            ? _value.labelEn
            : labelEn // ignore: cast_nullable_to_non_nullable
                  as String?,
        priceModifier: null == priceModifier
            ? _value.priceModifier
            : priceModifier // ignore: cast_nullable_to_non_nullable
                  as int,
        colorHex: freezed == colorHex
            ? _value.colorHex
            : colorHex // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemOptionImpl implements _ItemOption {
  const _$ItemOptionImpl({
    required this.id,
    @JsonKey(name: 'label_ar') required this.labelAr,
    @JsonKey(name: 'label_en') this.labelEn,
    @JsonKey(name: 'price_modifier') this.priceModifier = 0,
    @JsonKey(name: 'color_hex') this.colorHex,
    @JsonKey(name: 'image_url') this.imageUrl,
  });

  factory _$ItemOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemOptionImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'label_ar')
  final String labelAr;
  @override
  @JsonKey(name: 'label_en')
  final String? labelEn;
  @override
  @JsonKey(name: 'price_modifier')
  final int priceModifier;
  @override
  @JsonKey(name: 'color_hex')
  final String? colorHex;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @override
  String toString() {
    return 'ItemOption(id: $id, labelAr: $labelAr, labelEn: $labelEn, priceModifier: $priceModifier, colorHex: $colorHex, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.labelAr, labelAr) || other.labelAr == labelAr) &&
            (identical(other.labelEn, labelEn) || other.labelEn == labelEn) &&
            (identical(other.priceModifier, priceModifier) ||
                other.priceModifier == priceModifier) &&
            (identical(other.colorHex, colorHex) ||
                other.colorHex == colorHex) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    labelAr,
    labelEn,
    priceModifier,
    colorHex,
    imageUrl,
  );

  /// Create a copy of ItemOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemOptionImplCopyWith<_$ItemOptionImpl> get copyWith =>
      __$$ItemOptionImplCopyWithImpl<_$ItemOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemOptionImplToJson(this);
  }
}

abstract class _ItemOption implements ItemOption {
  const factory _ItemOption({
    required final String id,
    @JsonKey(name: 'label_ar') required final String labelAr,
    @JsonKey(name: 'label_en') final String? labelEn,
    @JsonKey(name: 'price_modifier') final int priceModifier,
    @JsonKey(name: 'color_hex') final String? colorHex,
    @JsonKey(name: 'image_url') final String? imageUrl,
  }) = _$ItemOptionImpl;

  factory _ItemOption.fromJson(Map<String, dynamic> json) =
      _$ItemOptionImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'label_ar')
  String get labelAr;
  @override
  @JsonKey(name: 'label_en')
  String? get labelEn;
  @override
  @JsonKey(name: 'price_modifier')
  int get priceModifier;
  @override
  @JsonKey(name: 'color_hex')
  String? get colorHex;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;

  /// Create a copy of ItemOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItemOptionImplCopyWith<_$ItemOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
