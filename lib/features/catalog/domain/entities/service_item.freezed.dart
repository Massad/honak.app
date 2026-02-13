// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ServiceItem _$ServiceItemFromJson(Map<String, dynamic> json) {
  return _ServiceItem.fromJson(json);
}

/// @nodoc
mixin _$ServiceItem {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_en')
  String? get nameEn => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @MoneyConverter()
  @JsonKey(name: 'price_cents')
  Money get price => throw _privateConstructorUsedError;
  @MoneyNullableConverter()
  @JsonKey(name: 'price_from_cents')
  Money? get priceFrom => throw _privateConstructorUsedError;
  @MoneyNullableConverter()
  @JsonKey(name: 'price_to_cents')
  Money? get priceTo => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_minutes')
  int? get durationMinutes => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_ar')
  String? get categoryAr => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'requires_team_member')
  bool get requiresTeamMember => throw _privateConstructorUsedError;
  @JsonKey(name: 'available_team_member_ids')
  List<String> get availableTeamMemberIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_available')
  bool get isAvailable => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_popular')
  bool get isPopular => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_id')
  String? get pageId => throw _privateConstructorUsedError;

  /// Serializes this ServiceItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceItemCopyWith<ServiceItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceItemCopyWith<$Res> {
  factory $ServiceItemCopyWith(
    ServiceItem value,
    $Res Function(ServiceItem) then,
  ) = _$ServiceItemCopyWithImpl<$Res, ServiceItem>;
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'name_en') String? nameEn,
    String? description,
    @MoneyConverter() @JsonKey(name: 'price_cents') Money price,
    @MoneyNullableConverter()
    @JsonKey(name: 'price_from_cents')
    Money? priceFrom,
    @MoneyNullableConverter() @JsonKey(name: 'price_to_cents') Money? priceTo,
    @JsonKey(name: 'duration_minutes') int? durationMinutes,
    String category,
    @JsonKey(name: 'category_ar') String? categoryAr,
    String? image,
    @JsonKey(name: 'requires_team_member') bool requiresTeamMember,
    @JsonKey(name: 'available_team_member_ids')
    List<String> availableTeamMemberIds,
    @JsonKey(name: 'is_available') bool isAvailable,
    @JsonKey(name: 'is_popular') bool isPopular,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'page_id') String? pageId,
  });
}

/// @nodoc
class _$ServiceItemCopyWithImpl<$Res, $Val extends ServiceItem>
    implements $ServiceItemCopyWith<$Res> {
  _$ServiceItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = freezed,
    Object? description = freezed,
    Object? price = null,
    Object? priceFrom = freezed,
    Object? priceTo = freezed,
    Object? durationMinutes = freezed,
    Object? category = null,
    Object? categoryAr = freezed,
    Object? image = freezed,
    Object? requiresTeamMember = null,
    Object? availableTeamMemberIds = null,
    Object? isAvailable = null,
    Object? isPopular = null,
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
            priceFrom: freezed == priceFrom
                ? _value.priceFrom
                : priceFrom // ignore: cast_nullable_to_non_nullable
                      as Money?,
            priceTo: freezed == priceTo
                ? _value.priceTo
                : priceTo // ignore: cast_nullable_to_non_nullable
                      as Money?,
            durationMinutes: freezed == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryAr: freezed == categoryAr
                ? _value.categoryAr
                : categoryAr // ignore: cast_nullable_to_non_nullable
                      as String?,
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String?,
            requiresTeamMember: null == requiresTeamMember
                ? _value.requiresTeamMember
                : requiresTeamMember // ignore: cast_nullable_to_non_nullable
                      as bool,
            availableTeamMemberIds: null == availableTeamMemberIds
                ? _value.availableTeamMemberIds
                : availableTeamMemberIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isAvailable: null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPopular: null == isPopular
                ? _value.isPopular
                : isPopular // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$ServiceItemImplCopyWith<$Res>
    implements $ServiceItemCopyWith<$Res> {
  factory _$$ServiceItemImplCopyWith(
    _$ServiceItemImpl value,
    $Res Function(_$ServiceItemImpl) then,
  ) = __$$ServiceItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'name_en') String? nameEn,
    String? description,
    @MoneyConverter() @JsonKey(name: 'price_cents') Money price,
    @MoneyNullableConverter()
    @JsonKey(name: 'price_from_cents')
    Money? priceFrom,
    @MoneyNullableConverter() @JsonKey(name: 'price_to_cents') Money? priceTo,
    @JsonKey(name: 'duration_minutes') int? durationMinutes,
    String category,
    @JsonKey(name: 'category_ar') String? categoryAr,
    String? image,
    @JsonKey(name: 'requires_team_member') bool requiresTeamMember,
    @JsonKey(name: 'available_team_member_ids')
    List<String> availableTeamMemberIds,
    @JsonKey(name: 'is_available') bool isAvailable,
    @JsonKey(name: 'is_popular') bool isPopular,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'page_id') String? pageId,
  });
}

/// @nodoc
class __$$ServiceItemImplCopyWithImpl<$Res>
    extends _$ServiceItemCopyWithImpl<$Res, _$ServiceItemImpl>
    implements _$$ServiceItemImplCopyWith<$Res> {
  __$$ServiceItemImplCopyWithImpl(
    _$ServiceItemImpl _value,
    $Res Function(_$ServiceItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServiceItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = freezed,
    Object? description = freezed,
    Object? price = null,
    Object? priceFrom = freezed,
    Object? priceTo = freezed,
    Object? durationMinutes = freezed,
    Object? category = null,
    Object? categoryAr = freezed,
    Object? image = freezed,
    Object? requiresTeamMember = null,
    Object? availableTeamMemberIds = null,
    Object? isAvailable = null,
    Object? isPopular = null,
    Object? sortOrder = null,
    Object? pageId = freezed,
  }) {
    return _then(
      _$ServiceItemImpl(
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
        priceFrom: freezed == priceFrom
            ? _value.priceFrom
            : priceFrom // ignore: cast_nullable_to_non_nullable
                  as Money?,
        priceTo: freezed == priceTo
            ? _value.priceTo
            : priceTo // ignore: cast_nullable_to_non_nullable
                  as Money?,
        durationMinutes: freezed == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryAr: freezed == categoryAr
            ? _value.categoryAr
            : categoryAr // ignore: cast_nullable_to_non_nullable
                  as String?,
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String?,
        requiresTeamMember: null == requiresTeamMember
            ? _value.requiresTeamMember
            : requiresTeamMember // ignore: cast_nullable_to_non_nullable
                  as bool,
        availableTeamMemberIds: null == availableTeamMemberIds
            ? _value._availableTeamMemberIds
            : availableTeamMemberIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isAvailable: null == isAvailable
            ? _value.isAvailable
            : isAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPopular: null == isPopular
            ? _value.isPopular
            : isPopular // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$ServiceItemImpl implements _ServiceItem {
  const _$ServiceItemImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'name_en') this.nameEn,
    this.description,
    @MoneyConverter() @JsonKey(name: 'price_cents') required this.price,
    @MoneyNullableConverter()
    @JsonKey(name: 'price_from_cents')
    this.priceFrom = null,
    @MoneyNullableConverter()
    @JsonKey(name: 'price_to_cents')
    this.priceTo = null,
    @JsonKey(name: 'duration_minutes') this.durationMinutes,
    required this.category,
    @JsonKey(name: 'category_ar') this.categoryAr,
    this.image,
    @JsonKey(name: 'requires_team_member') this.requiresTeamMember = false,
    @JsonKey(name: 'available_team_member_ids')
    final List<String> availableTeamMemberIds = const [],
    @JsonKey(name: 'is_available') this.isAvailable = true,
    @JsonKey(name: 'is_popular') this.isPopular = false,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'page_id') this.pageId,
  }) : _availableTeamMemberIds = availableTeamMemberIds;

  factory _$ServiceItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceItemImplFromJson(json);

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
  @JsonKey(name: 'price_from_cents')
  final Money? priceFrom;
  @override
  @MoneyNullableConverter()
  @JsonKey(name: 'price_to_cents')
  final Money? priceTo;
  @override
  @JsonKey(name: 'duration_minutes')
  final int? durationMinutes;
  @override
  final String category;
  @override
  @JsonKey(name: 'category_ar')
  final String? categoryAr;
  @override
  final String? image;
  @override
  @JsonKey(name: 'requires_team_member')
  final bool requiresTeamMember;
  final List<String> _availableTeamMemberIds;
  @override
  @JsonKey(name: 'available_team_member_ids')
  List<String> get availableTeamMemberIds {
    if (_availableTeamMemberIds is EqualUnmodifiableListView)
      return _availableTeamMemberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableTeamMemberIds);
  }

  @override
  @JsonKey(name: 'is_available')
  final bool isAvailable;
  @override
  @JsonKey(name: 'is_popular')
  final bool isPopular;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'page_id')
  final String? pageId;

  @override
  String toString() {
    return 'ServiceItem(id: $id, name: $name, nameEn: $nameEn, description: $description, price: $price, priceFrom: $priceFrom, priceTo: $priceTo, durationMinutes: $durationMinutes, category: $category, categoryAr: $categoryAr, image: $image, requiresTeamMember: $requiresTeamMember, availableTeamMemberIds: $availableTeamMemberIds, isAvailable: $isAvailable, isPopular: $isPopular, sortOrder: $sortOrder, pageId: $pageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.priceFrom, priceFrom) ||
                other.priceFrom == priceFrom) &&
            (identical(other.priceTo, priceTo) || other.priceTo == priceTo) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.categoryAr, categoryAr) ||
                other.categoryAr == categoryAr) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.requiresTeamMember, requiresTeamMember) ||
                other.requiresTeamMember == requiresTeamMember) &&
            const DeepCollectionEquality().equals(
              other._availableTeamMemberIds,
              _availableTeamMemberIds,
            ) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.isPopular, isPopular) ||
                other.isPopular == isPopular) &&
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
    priceFrom,
    priceTo,
    durationMinutes,
    category,
    categoryAr,
    image,
    requiresTeamMember,
    const DeepCollectionEquality().hash(_availableTeamMemberIds),
    isAvailable,
    isPopular,
    sortOrder,
    pageId,
  );

  /// Create a copy of ServiceItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceItemImplCopyWith<_$ServiceItemImpl> get copyWith =>
      __$$ServiceItemImplCopyWithImpl<_$ServiceItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceItemImplToJson(this);
  }
}

abstract class _ServiceItem implements ServiceItem {
  const factory _ServiceItem({
    required final String id,
    required final String name,
    @JsonKey(name: 'name_en') final String? nameEn,
    final String? description,
    @MoneyConverter() @JsonKey(name: 'price_cents') required final Money price,
    @MoneyNullableConverter()
    @JsonKey(name: 'price_from_cents')
    final Money? priceFrom,
    @MoneyNullableConverter()
    @JsonKey(name: 'price_to_cents')
    final Money? priceTo,
    @JsonKey(name: 'duration_minutes') final int? durationMinutes,
    required final String category,
    @JsonKey(name: 'category_ar') final String? categoryAr,
    final String? image,
    @JsonKey(name: 'requires_team_member') final bool requiresTeamMember,
    @JsonKey(name: 'available_team_member_ids')
    final List<String> availableTeamMemberIds,
    @JsonKey(name: 'is_available') final bool isAvailable,
    @JsonKey(name: 'is_popular') final bool isPopular,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'page_id') final String? pageId,
  }) = _$ServiceItemImpl;

  factory _ServiceItem.fromJson(Map<String, dynamic> json) =
      _$ServiceItemImpl.fromJson;

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
  @JsonKey(name: 'price_from_cents')
  Money? get priceFrom;
  @override
  @MoneyNullableConverter()
  @JsonKey(name: 'price_to_cents')
  Money? get priceTo;
  @override
  @JsonKey(name: 'duration_minutes')
  int? get durationMinutes;
  @override
  String get category;
  @override
  @JsonKey(name: 'category_ar')
  String? get categoryAr;
  @override
  String? get image;
  @override
  @JsonKey(name: 'requires_team_member')
  bool get requiresTeamMember;
  @override
  @JsonKey(name: 'available_team_member_ids')
  List<String> get availableTeamMemberIds;
  @override
  @JsonKey(name: 'is_available')
  bool get isAvailable;
  @override
  @JsonKey(name: 'is_popular')
  bool get isPopular;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'page_id')
  String? get pageId;

  /// Create a copy of ServiceItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceItemImplCopyWith<_$ServiceItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
