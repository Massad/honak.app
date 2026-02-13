// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'space.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Space _$SpaceFromJson(Map<String, dynamic> json) {
  return _Space.fromJson(json);
}

/// @nodoc
mixin _$Space {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_en')
  String? get nameEn => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<Media> get images => throw _privateConstructorUsedError;
  @_MoneyConverter()
  @JsonKey(name: 'price_per_unit_cents')
  Money get pricePerUnit => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_unit')
  String get priceUnit => throw _privateConstructorUsedError;
  int? get capacity => throw _privateConstructorUsedError;
  @JsonKey(name: 'min_capacity')
  int? get minCapacity => throw _privateConstructorUsedError;
  List<String> get amenities => throw _privateConstructorUsedError;
  @JsonKey(name: 'amenities_ar')
  List<String> get amenitiesAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_available')
  bool get isAvailable => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_id')
  String? get pageId => throw _privateConstructorUsedError;

  /// Serializes this Space to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Space
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpaceCopyWith<Space> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpaceCopyWith<$Res> {
  factory $SpaceCopyWith(Space value, $Res Function(Space) then) =
      _$SpaceCopyWithImpl<$Res, Space>;
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'name_en') String? nameEn,
    String? description,
    List<Media> images,
    @_MoneyConverter()
    @JsonKey(name: 'price_per_unit_cents')
    Money pricePerUnit,
    @JsonKey(name: 'price_unit') String priceUnit,
    int? capacity,
    @JsonKey(name: 'min_capacity') int? minCapacity,
    List<String> amenities,
    @JsonKey(name: 'amenities_ar') List<String> amenitiesAr,
    @JsonKey(name: 'is_available') bool isAvailable,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'page_id') String? pageId,
  });
}

/// @nodoc
class _$SpaceCopyWithImpl<$Res, $Val extends Space>
    implements $SpaceCopyWith<$Res> {
  _$SpaceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Space
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = freezed,
    Object? description = freezed,
    Object? images = null,
    Object? pricePerUnit = null,
    Object? priceUnit = null,
    Object? capacity = freezed,
    Object? minCapacity = freezed,
    Object? amenities = null,
    Object? amenitiesAr = null,
    Object? isAvailable = null,
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
            images: null == images
                ? _value.images
                : images // ignore: cast_nullable_to_non_nullable
                      as List<Media>,
            pricePerUnit: null == pricePerUnit
                ? _value.pricePerUnit
                : pricePerUnit // ignore: cast_nullable_to_non_nullable
                      as Money,
            priceUnit: null == priceUnit
                ? _value.priceUnit
                : priceUnit // ignore: cast_nullable_to_non_nullable
                      as String,
            capacity: freezed == capacity
                ? _value.capacity
                : capacity // ignore: cast_nullable_to_non_nullable
                      as int?,
            minCapacity: freezed == minCapacity
                ? _value.minCapacity
                : minCapacity // ignore: cast_nullable_to_non_nullable
                      as int?,
            amenities: null == amenities
                ? _value.amenities
                : amenities // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            amenitiesAr: null == amenitiesAr
                ? _value.amenitiesAr
                : amenitiesAr // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isAvailable: null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
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
abstract class _$$SpaceImplCopyWith<$Res> implements $SpaceCopyWith<$Res> {
  factory _$$SpaceImplCopyWith(
    _$SpaceImpl value,
    $Res Function(_$SpaceImpl) then,
  ) = __$$SpaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'name_en') String? nameEn,
    String? description,
    List<Media> images,
    @_MoneyConverter()
    @JsonKey(name: 'price_per_unit_cents')
    Money pricePerUnit,
    @JsonKey(name: 'price_unit') String priceUnit,
    int? capacity,
    @JsonKey(name: 'min_capacity') int? minCapacity,
    List<String> amenities,
    @JsonKey(name: 'amenities_ar') List<String> amenitiesAr,
    @JsonKey(name: 'is_available') bool isAvailable,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'page_id') String? pageId,
  });
}

/// @nodoc
class __$$SpaceImplCopyWithImpl<$Res>
    extends _$SpaceCopyWithImpl<$Res, _$SpaceImpl>
    implements _$$SpaceImplCopyWith<$Res> {
  __$$SpaceImplCopyWithImpl(
    _$SpaceImpl _value,
    $Res Function(_$SpaceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Space
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = freezed,
    Object? description = freezed,
    Object? images = null,
    Object? pricePerUnit = null,
    Object? priceUnit = null,
    Object? capacity = freezed,
    Object? minCapacity = freezed,
    Object? amenities = null,
    Object? amenitiesAr = null,
    Object? isAvailable = null,
    Object? sortOrder = null,
    Object? pageId = freezed,
  }) {
    return _then(
      _$SpaceImpl(
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
        images: null == images
            ? _value._images
            : images // ignore: cast_nullable_to_non_nullable
                  as List<Media>,
        pricePerUnit: null == pricePerUnit
            ? _value.pricePerUnit
            : pricePerUnit // ignore: cast_nullable_to_non_nullable
                  as Money,
        priceUnit: null == priceUnit
            ? _value.priceUnit
            : priceUnit // ignore: cast_nullable_to_non_nullable
                  as String,
        capacity: freezed == capacity
            ? _value.capacity
            : capacity // ignore: cast_nullable_to_non_nullable
                  as int?,
        minCapacity: freezed == minCapacity
            ? _value.minCapacity
            : minCapacity // ignore: cast_nullable_to_non_nullable
                  as int?,
        amenities: null == amenities
            ? _value._amenities
            : amenities // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        amenitiesAr: null == amenitiesAr
            ? _value._amenitiesAr
            : amenitiesAr // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isAvailable: null == isAvailable
            ? _value.isAvailable
            : isAvailable // ignore: cast_nullable_to_non_nullable
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
class _$SpaceImpl implements _Space {
  const _$SpaceImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'name_en') this.nameEn,
    this.description,
    final List<Media> images = const [],
    @_MoneyConverter()
    @JsonKey(name: 'price_per_unit_cents')
    required this.pricePerUnit,
    @JsonKey(name: 'price_unit') this.priceUnit = 'per_night',
    this.capacity,
    @JsonKey(name: 'min_capacity') this.minCapacity,
    final List<String> amenities = const [],
    @JsonKey(name: 'amenities_ar') final List<String> amenitiesAr = const [],
    @JsonKey(name: 'is_available') this.isAvailable = true,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'page_id') this.pageId,
  }) : _images = images,
       _amenities = amenities,
       _amenitiesAr = amenitiesAr;

  factory _$SpaceImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpaceImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'name_en')
  final String? nameEn;
  @override
  final String? description;
  final List<Media> _images;
  @override
  @JsonKey()
  List<Media> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  @_MoneyConverter()
  @JsonKey(name: 'price_per_unit_cents')
  final Money pricePerUnit;
  @override
  @JsonKey(name: 'price_unit')
  final String priceUnit;
  @override
  final int? capacity;
  @override
  @JsonKey(name: 'min_capacity')
  final int? minCapacity;
  final List<String> _amenities;
  @override
  @JsonKey()
  List<String> get amenities {
    if (_amenities is EqualUnmodifiableListView) return _amenities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_amenities);
  }

  final List<String> _amenitiesAr;
  @override
  @JsonKey(name: 'amenities_ar')
  List<String> get amenitiesAr {
    if (_amenitiesAr is EqualUnmodifiableListView) return _amenitiesAr;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_amenitiesAr);
  }

  @override
  @JsonKey(name: 'is_available')
  final bool isAvailable;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'page_id')
  final String? pageId;

  @override
  String toString() {
    return 'Space(id: $id, name: $name, nameEn: $nameEn, description: $description, images: $images, pricePerUnit: $pricePerUnit, priceUnit: $priceUnit, capacity: $capacity, minCapacity: $minCapacity, amenities: $amenities, amenitiesAr: $amenitiesAr, isAvailable: $isAvailable, sortOrder: $sortOrder, pageId: $pageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpaceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.pricePerUnit, pricePerUnit) ||
                other.pricePerUnit == pricePerUnit) &&
            (identical(other.priceUnit, priceUnit) ||
                other.priceUnit == priceUnit) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.minCapacity, minCapacity) ||
                other.minCapacity == minCapacity) &&
            const DeepCollectionEquality().equals(
              other._amenities,
              _amenities,
            ) &&
            const DeepCollectionEquality().equals(
              other._amenitiesAr,
              _amenitiesAr,
            ) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
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
    const DeepCollectionEquality().hash(_images),
    pricePerUnit,
    priceUnit,
    capacity,
    minCapacity,
    const DeepCollectionEquality().hash(_amenities),
    const DeepCollectionEquality().hash(_amenitiesAr),
    isAvailable,
    sortOrder,
    pageId,
  );

  /// Create a copy of Space
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpaceImplCopyWith<_$SpaceImpl> get copyWith =>
      __$$SpaceImplCopyWithImpl<_$SpaceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpaceImplToJson(this);
  }
}

abstract class _Space implements Space {
  const factory _Space({
    required final String id,
    required final String name,
    @JsonKey(name: 'name_en') final String? nameEn,
    final String? description,
    final List<Media> images,
    @_MoneyConverter()
    @JsonKey(name: 'price_per_unit_cents')
    required final Money pricePerUnit,
    @JsonKey(name: 'price_unit') final String priceUnit,
    final int? capacity,
    @JsonKey(name: 'min_capacity') final int? minCapacity,
    final List<String> amenities,
    @JsonKey(name: 'amenities_ar') final List<String> amenitiesAr,
    @JsonKey(name: 'is_available') final bool isAvailable,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'page_id') final String? pageId,
  }) = _$SpaceImpl;

  factory _Space.fromJson(Map<String, dynamic> json) = _$SpaceImpl.fromJson;

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
  List<Media> get images;
  @override
  @_MoneyConverter()
  @JsonKey(name: 'price_per_unit_cents')
  Money get pricePerUnit;
  @override
  @JsonKey(name: 'price_unit')
  String get priceUnit;
  @override
  int? get capacity;
  @override
  @JsonKey(name: 'min_capacity')
  int? get minCapacity;
  @override
  List<String> get amenities;
  @override
  @JsonKey(name: 'amenities_ar')
  List<String> get amenitiesAr;
  @override
  @JsonKey(name: 'is_available')
  bool get isAvailable;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'page_id')
  String? get pageId;

  /// Create a copy of Space
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpaceImplCopyWith<_$SpaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
