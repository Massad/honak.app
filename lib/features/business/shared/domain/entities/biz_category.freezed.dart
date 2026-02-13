// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biz_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BizCategory _$BizCategoryFromJson(Map<String, dynamic> json) {
  return _BizCategory.fromJson(json);
}

/// @nodoc
mixin _$BizCategory {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_en')
  String? get nameEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_count')
  int get itemCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this BizCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BizCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BizCategoryCopyWith<BizCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BizCategoryCopyWith<$Res> {
  factory $BizCategoryCopyWith(
    BizCategory value,
    $Res Function(BizCategory) then,
  ) = _$BizCategoryCopyWithImpl<$Res, BizCategory>;
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'name_en') String? nameEn,
    @JsonKey(name: 'item_count') int itemCount,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class _$BizCategoryCopyWithImpl<$Res, $Val extends BizCategory>
    implements $BizCategoryCopyWith<$Res> {
  _$BizCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BizCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = freezed,
    Object? itemCount = null,
    Object? sortOrder = null,
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
            itemCount: null == itemCount
                ? _value.itemCount
                : itemCount // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$BizCategoryImplCopyWith<$Res>
    implements $BizCategoryCopyWith<$Res> {
  factory _$$BizCategoryImplCopyWith(
    _$BizCategoryImpl value,
    $Res Function(_$BizCategoryImpl) then,
  ) = __$$BizCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'name_en') String? nameEn,
    @JsonKey(name: 'item_count') int itemCount,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class __$$BizCategoryImplCopyWithImpl<$Res>
    extends _$BizCategoryCopyWithImpl<$Res, _$BizCategoryImpl>
    implements _$$BizCategoryImplCopyWith<$Res> {
  __$$BizCategoryImplCopyWithImpl(
    _$BizCategoryImpl _value,
    $Res Function(_$BizCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BizCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = freezed,
    Object? itemCount = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _$BizCategoryImpl(
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
        itemCount: null == itemCount
            ? _value.itemCount
            : itemCount // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$BizCategoryImpl implements _BizCategory {
  const _$BizCategoryImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'name_en') this.nameEn,
    @JsonKey(name: 'item_count') this.itemCount = 0,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
  });

  factory _$BizCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$BizCategoryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'name_en')
  final String? nameEn;
  @override
  @JsonKey(name: 'item_count')
  final int itemCount;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;

  @override
  String toString() {
    return 'BizCategory(id: $id, name: $name, nameEn: $nameEn, itemCount: $itemCount, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BizCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, nameEn, itemCount, sortOrder);

  /// Create a copy of BizCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BizCategoryImplCopyWith<_$BizCategoryImpl> get copyWith =>
      __$$BizCategoryImplCopyWithImpl<_$BizCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BizCategoryImplToJson(this);
  }
}

abstract class _BizCategory implements BizCategory {
  const factory _BizCategory({
    required final String id,
    required final String name,
    @JsonKey(name: 'name_en') final String? nameEn,
    @JsonKey(name: 'item_count') final int itemCount,
    @JsonKey(name: 'sort_order') final int sortOrder,
  }) = _$BizCategoryImpl;

  factory _BizCategory.fromJson(Map<String, dynamic> json) =
      _$BizCategoryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'name_en')
  String? get nameEn;
  @override
  @JsonKey(name: 'item_count')
  int get itemCount;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;

  /// Create a copy of BizCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BizCategoryImplCopyWith<_$BizCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
