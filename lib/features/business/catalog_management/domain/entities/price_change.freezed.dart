// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_change.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PriceChange _$PriceChangeFromJson(Map<String, dynamic> json) {
  return _PriceChange.fromJson(json);
}

/// @nodoc
mixin _$PriceChange {
  String get id => throw _privateConstructorUsedError;
  String get direction => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  String get scope => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_names')
  List<String> get categoryNames => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_ids')
  List<String> get itemIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'starts_at')
  String get startsAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'ends_at')
  String? get endsAt => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_public')
  bool get isPublic => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'affected_count')
  int get affectedCount => throw _privateConstructorUsedError;

  /// Serializes this PriceChange to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PriceChange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PriceChangeCopyWith<PriceChange> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceChangeCopyWith<$Res> {
  factory $PriceChangeCopyWith(
    PriceChange value,
    $Res Function(PriceChange) then,
  ) = _$PriceChangeCopyWithImpl<$Res, PriceChange>;
  @useResult
  $Res call({
    String id,
    String direction,
    String method,
    double value,
    String scope,
    @JsonKey(name: 'category_names') List<String> categoryNames,
    @JsonKey(name: 'item_ids') List<String> itemIds,
    @JsonKey(name: 'starts_at') String startsAt,
    @JsonKey(name: 'ends_at') String? endsAt,
    String reason,
    @JsonKey(name: 'is_public') bool isPublic,
    String status,
    @JsonKey(name: 'affected_count') int affectedCount,
  });
}

/// @nodoc
class _$PriceChangeCopyWithImpl<$Res, $Val extends PriceChange>
    implements $PriceChangeCopyWith<$Res> {
  _$PriceChangeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PriceChange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? direction = null,
    Object? method = null,
    Object? value = null,
    Object? scope = null,
    Object? categoryNames = null,
    Object? itemIds = null,
    Object? startsAt = null,
    Object? endsAt = freezed,
    Object? reason = null,
    Object? isPublic = null,
    Object? status = null,
    Object? affectedCount = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            direction: null == direction
                ? _value.direction
                : direction // ignore: cast_nullable_to_non_nullable
                      as String,
            method: null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                      as String,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as double,
            scope: null == scope
                ? _value.scope
                : scope // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryNames: null == categoryNames
                ? _value.categoryNames
                : categoryNames // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            itemIds: null == itemIds
                ? _value.itemIds
                : itemIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            startsAt: null == startsAt
                ? _value.startsAt
                : startsAt // ignore: cast_nullable_to_non_nullable
                      as String,
            endsAt: freezed == endsAt
                ? _value.endsAt
                : endsAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
            isPublic: null == isPublic
                ? _value.isPublic
                : isPublic // ignore: cast_nullable_to_non_nullable
                      as bool,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            affectedCount: null == affectedCount
                ? _value.affectedCount
                : affectedCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PriceChangeImplCopyWith<$Res>
    implements $PriceChangeCopyWith<$Res> {
  factory _$$PriceChangeImplCopyWith(
    _$PriceChangeImpl value,
    $Res Function(_$PriceChangeImpl) then,
  ) = __$$PriceChangeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String direction,
    String method,
    double value,
    String scope,
    @JsonKey(name: 'category_names') List<String> categoryNames,
    @JsonKey(name: 'item_ids') List<String> itemIds,
    @JsonKey(name: 'starts_at') String startsAt,
    @JsonKey(name: 'ends_at') String? endsAt,
    String reason,
    @JsonKey(name: 'is_public') bool isPublic,
    String status,
    @JsonKey(name: 'affected_count') int affectedCount,
  });
}

/// @nodoc
class __$$PriceChangeImplCopyWithImpl<$Res>
    extends _$PriceChangeCopyWithImpl<$Res, _$PriceChangeImpl>
    implements _$$PriceChangeImplCopyWith<$Res> {
  __$$PriceChangeImplCopyWithImpl(
    _$PriceChangeImpl _value,
    $Res Function(_$PriceChangeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PriceChange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? direction = null,
    Object? method = null,
    Object? value = null,
    Object? scope = null,
    Object? categoryNames = null,
    Object? itemIds = null,
    Object? startsAt = null,
    Object? endsAt = freezed,
    Object? reason = null,
    Object? isPublic = null,
    Object? status = null,
    Object? affectedCount = null,
  }) {
    return _then(
      _$PriceChangeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        direction: null == direction
            ? _value.direction
            : direction // ignore: cast_nullable_to_non_nullable
                  as String,
        method: null == method
            ? _value.method
            : method // ignore: cast_nullable_to_non_nullable
                  as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as double,
        scope: null == scope
            ? _value.scope
            : scope // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryNames: null == categoryNames
            ? _value._categoryNames
            : categoryNames // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        itemIds: null == itemIds
            ? _value._itemIds
            : itemIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        startsAt: null == startsAt
            ? _value.startsAt
            : startsAt // ignore: cast_nullable_to_non_nullable
                  as String,
        endsAt: freezed == endsAt
            ? _value.endsAt
            : endsAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        isPublic: null == isPublic
            ? _value.isPublic
            : isPublic // ignore: cast_nullable_to_non_nullable
                  as bool,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        affectedCount: null == affectedCount
            ? _value.affectedCount
            : affectedCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceChangeImpl implements _PriceChange {
  const _$PriceChangeImpl({
    required this.id,
    required this.direction,
    required this.method,
    required this.value,
    this.scope = 'all',
    @JsonKey(name: 'category_names')
    final List<String> categoryNames = const [],
    @JsonKey(name: 'item_ids') final List<String> itemIds = const [],
    @JsonKey(name: 'starts_at') required this.startsAt,
    @JsonKey(name: 'ends_at') this.endsAt,
    this.reason = '',
    @JsonKey(name: 'is_public') this.isPublic = true,
    this.status = 'active',
    @JsonKey(name: 'affected_count') this.affectedCount = 0,
  }) : _categoryNames = categoryNames,
       _itemIds = itemIds;

  factory _$PriceChangeImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceChangeImplFromJson(json);

  @override
  final String id;
  @override
  final String direction;
  @override
  final String method;
  @override
  final double value;
  @override
  @JsonKey()
  final String scope;
  final List<String> _categoryNames;
  @override
  @JsonKey(name: 'category_names')
  List<String> get categoryNames {
    if (_categoryNames is EqualUnmodifiableListView) return _categoryNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoryNames);
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
  @JsonKey(name: 'starts_at')
  final String startsAt;
  @override
  @JsonKey(name: 'ends_at')
  final String? endsAt;
  @override
  @JsonKey()
  final String reason;
  @override
  @JsonKey(name: 'is_public')
  final bool isPublic;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'affected_count')
  final int affectedCount;

  @override
  String toString() {
    return 'PriceChange(id: $id, direction: $direction, method: $method, value: $value, scope: $scope, categoryNames: $categoryNames, itemIds: $itemIds, startsAt: $startsAt, endsAt: $endsAt, reason: $reason, isPublic: $isPublic, status: $status, affectedCount: $affectedCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceChangeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.scope, scope) || other.scope == scope) &&
            const DeepCollectionEquality().equals(
              other._categoryNames,
              _categoryNames,
            ) &&
            const DeepCollectionEquality().equals(other._itemIds, _itemIds) &&
            (identical(other.startsAt, startsAt) ||
                other.startsAt == startsAt) &&
            (identical(other.endsAt, endsAt) || other.endsAt == endsAt) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.affectedCount, affectedCount) ||
                other.affectedCount == affectedCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    direction,
    method,
    value,
    scope,
    const DeepCollectionEquality().hash(_categoryNames),
    const DeepCollectionEquality().hash(_itemIds),
    startsAt,
    endsAt,
    reason,
    isPublic,
    status,
    affectedCount,
  );

  /// Create a copy of PriceChange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceChangeImplCopyWith<_$PriceChangeImpl> get copyWith =>
      __$$PriceChangeImplCopyWithImpl<_$PriceChangeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceChangeImplToJson(this);
  }
}

abstract class _PriceChange implements PriceChange {
  const factory _PriceChange({
    required final String id,
    required final String direction,
    required final String method,
    required final double value,
    final String scope,
    @JsonKey(name: 'category_names') final List<String> categoryNames,
    @JsonKey(name: 'item_ids') final List<String> itemIds,
    @JsonKey(name: 'starts_at') required final String startsAt,
    @JsonKey(name: 'ends_at') final String? endsAt,
    final String reason,
    @JsonKey(name: 'is_public') final bool isPublic,
    final String status,
    @JsonKey(name: 'affected_count') final int affectedCount,
  }) = _$PriceChangeImpl;

  factory _PriceChange.fromJson(Map<String, dynamic> json) =
      _$PriceChangeImpl.fromJson;

  @override
  String get id;
  @override
  String get direction;
  @override
  String get method;
  @override
  double get value;
  @override
  String get scope;
  @override
  @JsonKey(name: 'category_names')
  List<String> get categoryNames;
  @override
  @JsonKey(name: 'item_ids')
  List<String> get itemIds;
  @override
  @JsonKey(name: 'starts_at')
  String get startsAt;
  @override
  @JsonKey(name: 'ends_at')
  String? get endsAt;
  @override
  String get reason;
  @override
  @JsonKey(name: 'is_public')
  bool get isPublic;
  @override
  String get status;
  @override
  @JsonKey(name: 'affected_count')
  int get affectedCount;

  /// Create a copy of PriceChange
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PriceChangeImplCopyWith<_$PriceChangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
