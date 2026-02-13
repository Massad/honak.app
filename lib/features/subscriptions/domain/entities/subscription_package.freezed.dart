// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_package.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SubscriptionPackage _$SubscriptionPackageFromJson(Map<String, dynamic> json) {
  return _SubscriptionPackage.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionPackage {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  int? get credits => throw _privateConstructorUsedError;
  @JsonKey(name: 'credit_label')
  String? get creditLabel => throw _privateConstructorUsedError;
  @JsonKey(name: 'validity_months')
  int get validityMonths => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  @JsonKey(name: 'compare_single_price')
  int? get compareSinglePrice => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  SubscriptionModel get model => throw _privateConstructorUsedError;
  List<String> get items => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_ids')
  List<String> get itemIds => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionPackage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionPackage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionPackageCopyWith<SubscriptionPackage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionPackageCopyWith<$Res> {
  factory $SubscriptionPackageCopyWith(
    SubscriptionPackage value,
    $Res Function(SubscriptionPackage) then,
  ) = _$SubscriptionPackageCopyWithImpl<$Res, SubscriptionPackage>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    int price,
    int? credits,
    @JsonKey(name: 'credit_label') String? creditLabel,
    @JsonKey(name: 'validity_months') int validityMonths,
    String? icon,
    @JsonKey(name: 'compare_single_price') int? compareSinglePrice,
    bool active,
    SubscriptionModel model,
    List<String> items,
    @JsonKey(name: 'item_ids') List<String> itemIds,
    String? category,
  });
}

/// @nodoc
class _$SubscriptionPackageCopyWithImpl<$Res, $Val extends SubscriptionPackage>
    implements $SubscriptionPackageCopyWith<$Res> {
  _$SubscriptionPackageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionPackage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? price = null,
    Object? credits = freezed,
    Object? creditLabel = freezed,
    Object? validityMonths = null,
    Object? icon = freezed,
    Object? compareSinglePrice = freezed,
    Object? active = null,
    Object? model = null,
    Object? items = null,
    Object? itemIds = null,
    Object? category = freezed,
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
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            credits: freezed == credits
                ? _value.credits
                : credits // ignore: cast_nullable_to_non_nullable
                      as int?,
            creditLabel: freezed == creditLabel
                ? _value.creditLabel
                : creditLabel // ignore: cast_nullable_to_non_nullable
                      as String?,
            validityMonths: null == validityMonths
                ? _value.validityMonths
                : validityMonths // ignore: cast_nullable_to_non_nullable
                      as int,
            icon: freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String?,
            compareSinglePrice: freezed == compareSinglePrice
                ? _value.compareSinglePrice
                : compareSinglePrice // ignore: cast_nullable_to_non_nullable
                      as int?,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
            model: null == model
                ? _value.model
                : model // ignore: cast_nullable_to_non_nullable
                      as SubscriptionModel,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            itemIds: null == itemIds
                ? _value.itemIds
                : itemIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubscriptionPackageImplCopyWith<$Res>
    implements $SubscriptionPackageCopyWith<$Res> {
  factory _$$SubscriptionPackageImplCopyWith(
    _$SubscriptionPackageImpl value,
    $Res Function(_$SubscriptionPackageImpl) then,
  ) = __$$SubscriptionPackageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    int price,
    int? credits,
    @JsonKey(name: 'credit_label') String? creditLabel,
    @JsonKey(name: 'validity_months') int validityMonths,
    String? icon,
    @JsonKey(name: 'compare_single_price') int? compareSinglePrice,
    bool active,
    SubscriptionModel model,
    List<String> items,
    @JsonKey(name: 'item_ids') List<String> itemIds,
    String? category,
  });
}

/// @nodoc
class __$$SubscriptionPackageImplCopyWithImpl<$Res>
    extends _$SubscriptionPackageCopyWithImpl<$Res, _$SubscriptionPackageImpl>
    implements _$$SubscriptionPackageImplCopyWith<$Res> {
  __$$SubscriptionPackageImplCopyWithImpl(
    _$SubscriptionPackageImpl _value,
    $Res Function(_$SubscriptionPackageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionPackage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? price = null,
    Object? credits = freezed,
    Object? creditLabel = freezed,
    Object? validityMonths = null,
    Object? icon = freezed,
    Object? compareSinglePrice = freezed,
    Object? active = null,
    Object? model = null,
    Object? items = null,
    Object? itemIds = null,
    Object? category = freezed,
  }) {
    return _then(
      _$SubscriptionPackageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        credits: freezed == credits
            ? _value.credits
            : credits // ignore: cast_nullable_to_non_nullable
                  as int?,
        creditLabel: freezed == creditLabel
            ? _value.creditLabel
            : creditLabel // ignore: cast_nullable_to_non_nullable
                  as String?,
        validityMonths: null == validityMonths
            ? _value.validityMonths
            : validityMonths // ignore: cast_nullable_to_non_nullable
                  as int,
        icon: freezed == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String?,
        compareSinglePrice: freezed == compareSinglePrice
            ? _value.compareSinglePrice
            : compareSinglePrice // ignore: cast_nullable_to_non_nullable
                  as int?,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
        model: null == model
            ? _value.model
            : model // ignore: cast_nullable_to_non_nullable
                  as SubscriptionModel,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        itemIds: null == itemIds
            ? _value._itemIds
            : itemIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionPackageImpl implements _SubscriptionPackage {
  const _$SubscriptionPackageImpl({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.credits,
    @JsonKey(name: 'credit_label') this.creditLabel,
    @JsonKey(name: 'validity_months') this.validityMonths = 1,
    this.icon,
    @JsonKey(name: 'compare_single_price') this.compareSinglePrice,
    this.active = true,
    required this.model,
    final List<String> items = const [],
    @JsonKey(name: 'item_ids') final List<String> itemIds = const [],
    this.category,
  }) : _items = items,
       _itemIds = itemIds;

  factory _$SubscriptionPackageImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionPackageImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final int price;
  @override
  final int? credits;
  @override
  @JsonKey(name: 'credit_label')
  final String? creditLabel;
  @override
  @JsonKey(name: 'validity_months')
  final int validityMonths;
  @override
  final String? icon;
  @override
  @JsonKey(name: 'compare_single_price')
  final int? compareSinglePrice;
  @override
  @JsonKey()
  final bool active;
  @override
  final SubscriptionModel model;
  final List<String> _items;
  @override
  @JsonKey()
  List<String> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final List<String> _itemIds;
  @override
  @JsonKey(name: 'item_ids')
  List<String> get itemIds {
    if (_itemIds is EqualUnmodifiableListView) return _itemIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemIds);
  }

  @override
  final String? category;

  @override
  String toString() {
    return 'SubscriptionPackage(id: $id, name: $name, description: $description, price: $price, credits: $credits, creditLabel: $creditLabel, validityMonths: $validityMonths, icon: $icon, compareSinglePrice: $compareSinglePrice, active: $active, model: $model, items: $items, itemIds: $itemIds, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionPackageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.credits, credits) || other.credits == credits) &&
            (identical(other.creditLabel, creditLabel) ||
                other.creditLabel == creditLabel) &&
            (identical(other.validityMonths, validityMonths) ||
                other.validityMonths == validityMonths) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.compareSinglePrice, compareSinglePrice) ||
                other.compareSinglePrice == compareSinglePrice) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.model, model) || other.model == model) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality().equals(other._itemIds, _itemIds) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    price,
    credits,
    creditLabel,
    validityMonths,
    icon,
    compareSinglePrice,
    active,
    model,
    const DeepCollectionEquality().hash(_items),
    const DeepCollectionEquality().hash(_itemIds),
    category,
  );

  /// Create a copy of SubscriptionPackage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionPackageImplCopyWith<_$SubscriptionPackageImpl> get copyWith =>
      __$$SubscriptionPackageImplCopyWithImpl<_$SubscriptionPackageImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionPackageImplToJson(this);
  }
}

abstract class _SubscriptionPackage implements SubscriptionPackage {
  const factory _SubscriptionPackage({
    required final String id,
    required final String name,
    final String? description,
    required final int price,
    final int? credits,
    @JsonKey(name: 'credit_label') final String? creditLabel,
    @JsonKey(name: 'validity_months') final int validityMonths,
    final String? icon,
    @JsonKey(name: 'compare_single_price') final int? compareSinglePrice,
    final bool active,
    required final SubscriptionModel model,
    final List<String> items,
    @JsonKey(name: 'item_ids') final List<String> itemIds,
    final String? category,
  }) = _$SubscriptionPackageImpl;

  factory _SubscriptionPackage.fromJson(Map<String, dynamic> json) =
      _$SubscriptionPackageImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  int get price;
  @override
  int? get credits;
  @override
  @JsonKey(name: 'credit_label')
  String? get creditLabel;
  @override
  @JsonKey(name: 'validity_months')
  int get validityMonths;
  @override
  String? get icon;
  @override
  @JsonKey(name: 'compare_single_price')
  int? get compareSinglePrice;
  @override
  bool get active;
  @override
  SubscriptionModel get model;
  @override
  List<String> get items;
  @override
  @JsonKey(name: 'item_ids')
  List<String> get itemIds;
  @override
  String? get category;

  /// Create a copy of SubscriptionPackage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionPackageImplCopyWith<_$SubscriptionPackageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
