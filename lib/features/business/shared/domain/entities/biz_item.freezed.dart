// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biz_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BizItem _$BizItemFromJson(Map<String, dynamic> json) {
  return _BizItem.fromJson(json);
}

/// @nodoc
mixin _$BizItem {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_en')
  String? get nameEn => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_cents')
  @MoneyNullableConverter()
  Money? get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_text')
  String? get priceText => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_price_cents')
  @MoneyNullableConverter()
  Money? get originalPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_percent')
  int? get discountPercent => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_ends')
  String? get discountEnds => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  String? get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int? get stock => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_id')
  String? get pageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'branch_ids')
  List<String> get branchIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'assigned_team_ids')
  List<String> get assignedTeamIds => throw _privateConstructorUsedError;
  Map<String, dynamic> get properties => throw _privateConstructorUsedError;

  /// Serializes this BizItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BizItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BizItemCopyWith<BizItem> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BizItemCopyWith<$Res> {
  factory $BizItemCopyWith(BizItem value, $Res Function(BizItem) then) =
      _$BizItemCopyWithImpl<$Res, BizItem>;
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'name_en') String? nameEn,
    String? description,
    @JsonKey(name: 'price_cents') @MoneyNullableConverter() Money? price,
    @JsonKey(name: 'price_text') String? priceText,
    @JsonKey(name: 'original_price_cents')
    @MoneyNullableConverter()
    Money? originalPrice,
    @JsonKey(name: 'discount_percent') int? discountPercent,
    @JsonKey(name: 'discount_ends') String? discountEnds,
    List<String> images,
    @JsonKey(name: 'category_id') String? categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    String status,
    int? stock,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'page_id') String? pageId,
    @JsonKey(name: 'branch_ids') List<String> branchIds,
    @JsonKey(name: 'assigned_team_ids') List<String> assignedTeamIds,
    Map<String, dynamic> properties,
  });
}

/// @nodoc
class _$BizItemCopyWithImpl<$Res, $Val extends BizItem>
    implements $BizItemCopyWith<$Res> {
  _$BizItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BizItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = freezed,
    Object? description = freezed,
    Object? price = freezed,
    Object? priceText = freezed,
    Object? originalPrice = freezed,
    Object? discountPercent = freezed,
    Object? discountEnds = freezed,
    Object? images = null,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? status = null,
    Object? stock = freezed,
    Object? sortOrder = null,
    Object? pageId = freezed,
    Object? branchIds = null,
    Object? assignedTeamIds = null,
    Object? properties = null,
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
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as Money?,
            priceText: freezed == priceText
                ? _value.priceText
                : priceText // ignore: cast_nullable_to_non_nullable
                      as String?,
            originalPrice: freezed == originalPrice
                ? _value.originalPrice
                : originalPrice // ignore: cast_nullable_to_non_nullable
                      as Money?,
            discountPercent: freezed == discountPercent
                ? _value.discountPercent
                : discountPercent // ignore: cast_nullable_to_non_nullable
                      as int?,
            discountEnds: freezed == discountEnds
                ? _value.discountEnds
                : discountEnds // ignore: cast_nullable_to_non_nullable
                      as String?,
            images: null == images
                ? _value.images
                : images // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryName: freezed == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            stock: freezed == stock
                ? _value.stock
                : stock // ignore: cast_nullable_to_non_nullable
                      as int?,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            pageId: freezed == pageId
                ? _value.pageId
                : pageId // ignore: cast_nullable_to_non_nullable
                      as String?,
            branchIds: null == branchIds
                ? _value.branchIds
                : branchIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            assignedTeamIds: null == assignedTeamIds
                ? _value.assignedTeamIds
                : assignedTeamIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            properties: null == properties
                ? _value.properties
                : properties // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BizItemImplCopyWith<$Res> implements $BizItemCopyWith<$Res> {
  factory _$$BizItemImplCopyWith(
    _$BizItemImpl value,
    $Res Function(_$BizItemImpl) then,
  ) = __$$BizItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'name_en') String? nameEn,
    String? description,
    @JsonKey(name: 'price_cents') @MoneyNullableConverter() Money? price,
    @JsonKey(name: 'price_text') String? priceText,
    @JsonKey(name: 'original_price_cents')
    @MoneyNullableConverter()
    Money? originalPrice,
    @JsonKey(name: 'discount_percent') int? discountPercent,
    @JsonKey(name: 'discount_ends') String? discountEnds,
    List<String> images,
    @JsonKey(name: 'category_id') String? categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    String status,
    int? stock,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'page_id') String? pageId,
    @JsonKey(name: 'branch_ids') List<String> branchIds,
    @JsonKey(name: 'assigned_team_ids') List<String> assignedTeamIds,
    Map<String, dynamic> properties,
  });
}

/// @nodoc
class __$$BizItemImplCopyWithImpl<$Res>
    extends _$BizItemCopyWithImpl<$Res, _$BizItemImpl>
    implements _$$BizItemImplCopyWith<$Res> {
  __$$BizItemImplCopyWithImpl(
    _$BizItemImpl _value,
    $Res Function(_$BizItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BizItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = freezed,
    Object? description = freezed,
    Object? price = freezed,
    Object? priceText = freezed,
    Object? originalPrice = freezed,
    Object? discountPercent = freezed,
    Object? discountEnds = freezed,
    Object? images = null,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? status = null,
    Object? stock = freezed,
    Object? sortOrder = null,
    Object? pageId = freezed,
    Object? branchIds = null,
    Object? assignedTeamIds = null,
    Object? properties = null,
  }) {
    return _then(
      _$BizItemImpl(
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
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as Money?,
        priceText: freezed == priceText
            ? _value.priceText
            : priceText // ignore: cast_nullable_to_non_nullable
                  as String?,
        originalPrice: freezed == originalPrice
            ? _value.originalPrice
            : originalPrice // ignore: cast_nullable_to_non_nullable
                  as Money?,
        discountPercent: freezed == discountPercent
            ? _value.discountPercent
            : discountPercent // ignore: cast_nullable_to_non_nullable
                  as int?,
        discountEnds: freezed == discountEnds
            ? _value.discountEnds
            : discountEnds // ignore: cast_nullable_to_non_nullable
                  as String?,
        images: null == images
            ? _value._images
            : images // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryName: freezed == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        stock: freezed == stock
            ? _value.stock
            : stock // ignore: cast_nullable_to_non_nullable
                  as int?,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        pageId: freezed == pageId
            ? _value.pageId
            : pageId // ignore: cast_nullable_to_non_nullable
                  as String?,
        branchIds: null == branchIds
            ? _value._branchIds
            : branchIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        assignedTeamIds: null == assignedTeamIds
            ? _value._assignedTeamIds
            : assignedTeamIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        properties: null == properties
            ? _value._properties
            : properties // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BizItemImpl implements _BizItem {
  const _$BizItemImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'name_en') this.nameEn,
    this.description,
    @JsonKey(name: 'price_cents') @MoneyNullableConverter() this.price,
    @JsonKey(name: 'price_text') this.priceText,
    @JsonKey(name: 'original_price_cents')
    @MoneyNullableConverter()
    this.originalPrice,
    @JsonKey(name: 'discount_percent') this.discountPercent,
    @JsonKey(name: 'discount_ends') this.discountEnds,
    final List<String> images = const [],
    @JsonKey(name: 'category_id') this.categoryId,
    @JsonKey(name: 'category_name') this.categoryName,
    this.status = 'active',
    this.stock,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'page_id') this.pageId,
    @JsonKey(name: 'branch_ids') final List<String> branchIds = const [],
    @JsonKey(name: 'assigned_team_ids')
    final List<String> assignedTeamIds = const [],
    final Map<String, dynamic> properties = const {},
  }) : _images = images,
       _branchIds = branchIds,
       _assignedTeamIds = assignedTeamIds,
       _properties = properties;

  factory _$BizItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$BizItemImplFromJson(json);

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
  @JsonKey(name: 'price_cents')
  @MoneyNullableConverter()
  final Money? price;
  @override
  @JsonKey(name: 'price_text')
  final String? priceText;
  @override
  @JsonKey(name: 'original_price_cents')
  @MoneyNullableConverter()
  final Money? originalPrice;
  @override
  @JsonKey(name: 'discount_percent')
  final int? discountPercent;
  @override
  @JsonKey(name: 'discount_ends')
  final String? discountEnds;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  @JsonKey(name: 'category_id')
  final String? categoryId;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @override
  @JsonKey()
  final String status;
  @override
  final int? stock;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'page_id')
  final String? pageId;
  final List<String> _branchIds;
  @override
  @JsonKey(name: 'branch_ids')
  List<String> get branchIds {
    if (_branchIds is EqualUnmodifiableListView) return _branchIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_branchIds);
  }

  final List<String> _assignedTeamIds;
  @override
  @JsonKey(name: 'assigned_team_ids')
  List<String> get assignedTeamIds {
    if (_assignedTeamIds is EqualUnmodifiableListView) return _assignedTeamIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assignedTeamIds);
  }

  final Map<String, dynamic> _properties;
  @override
  @JsonKey()
  Map<String, dynamic> get properties {
    if (_properties is EqualUnmodifiableMapView) return _properties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_properties);
  }

  @override
  String toString() {
    return 'BizItem(id: $id, name: $name, nameEn: $nameEn, description: $description, price: $price, priceText: $priceText, originalPrice: $originalPrice, discountPercent: $discountPercent, discountEnds: $discountEnds, images: $images, categoryId: $categoryId, categoryName: $categoryName, status: $status, stock: $stock, sortOrder: $sortOrder, pageId: $pageId, branchIds: $branchIds, assignedTeamIds: $assignedTeamIds, properties: $properties)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BizItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.priceText, priceText) ||
                other.priceText == priceText) &&
            (identical(other.originalPrice, originalPrice) ||
                other.originalPrice == originalPrice) &&
            (identical(other.discountPercent, discountPercent) ||
                other.discountPercent == discountPercent) &&
            (identical(other.discountEnds, discountEnds) ||
                other.discountEnds == discountEnds) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.pageId, pageId) || other.pageId == pageId) &&
            const DeepCollectionEquality().equals(
              other._branchIds,
              _branchIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._assignedTeamIds,
              _assignedTeamIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._properties,
              _properties,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    name,
    nameEn,
    description,
    price,
    priceText,
    originalPrice,
    discountPercent,
    discountEnds,
    const DeepCollectionEquality().hash(_images),
    categoryId,
    categoryName,
    status,
    stock,
    sortOrder,
    pageId,
    const DeepCollectionEquality().hash(_branchIds),
    const DeepCollectionEquality().hash(_assignedTeamIds),
    const DeepCollectionEquality().hash(_properties),
  ]);

  /// Create a copy of BizItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BizItemImplCopyWith<_$BizItemImpl> get copyWith =>
      __$$BizItemImplCopyWithImpl<_$BizItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BizItemImplToJson(this);
  }
}

abstract class _BizItem implements BizItem {
  const factory _BizItem({
    required final String id,
    required final String name,
    @JsonKey(name: 'name_en') final String? nameEn,
    final String? description,
    @JsonKey(name: 'price_cents') @MoneyNullableConverter() final Money? price,
    @JsonKey(name: 'price_text') final String? priceText,
    @JsonKey(name: 'original_price_cents')
    @MoneyNullableConverter()
    final Money? originalPrice,
    @JsonKey(name: 'discount_percent') final int? discountPercent,
    @JsonKey(name: 'discount_ends') final String? discountEnds,
    final List<String> images,
    @JsonKey(name: 'category_id') final String? categoryId,
    @JsonKey(name: 'category_name') final String? categoryName,
    final String status,
    final int? stock,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'page_id') final String? pageId,
    @JsonKey(name: 'branch_ids') final List<String> branchIds,
    @JsonKey(name: 'assigned_team_ids') final List<String> assignedTeamIds,
    final Map<String, dynamic> properties,
  }) = _$BizItemImpl;

  factory _BizItem.fromJson(Map<String, dynamic> json) = _$BizItemImpl.fromJson;

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
  @JsonKey(name: 'price_cents')
  @MoneyNullableConverter()
  Money? get price;
  @override
  @JsonKey(name: 'price_text')
  String? get priceText;
  @override
  @JsonKey(name: 'original_price_cents')
  @MoneyNullableConverter()
  Money? get originalPrice;
  @override
  @JsonKey(name: 'discount_percent')
  int? get discountPercent;
  @override
  @JsonKey(name: 'discount_ends')
  String? get discountEnds;
  @override
  List<String> get images;
  @override
  @JsonKey(name: 'category_id')
  String? get categoryId;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  String get status;
  @override
  int? get stock;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'page_id')
  String? get pageId;
  @override
  @JsonKey(name: 'branch_ids')
  List<String> get branchIds;
  @override
  @JsonKey(name: 'assigned_team_ids')
  List<String> get assignedTeamIds;
  @override
  Map<String, dynamic> get properties;

  /// Create a copy of BizItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BizItemImplCopyWith<_$BizItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
