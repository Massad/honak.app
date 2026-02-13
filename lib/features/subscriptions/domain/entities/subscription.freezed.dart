// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) {
  return _Subscription.fromJson(json);
}

/// @nodoc
mixin _$Subscription {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_id')
  String get pageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_name')
  String get pageName => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_logo')
  String? get pageLogo => throw _privateConstructorUsedError;
  @JsonKey(name: 'package_id')
  String get packageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'package_name')
  String get packageName => throw _privateConstructorUsedError;
  SubscriptionModel get model => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_credits')
  int? get totalCredits => throw _privateConstructorUsedError;
  @JsonKey(name: 'remaining_credits')
  int? get remainingCredits => throw _privateConstructorUsedError;
  @JsonKey(name: 'credit_label')
  String? get creditLabel => throw _privateConstructorUsedError;
  @JsonKey(name: 'starts_at')
  String get startsAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  String? get expiresAt => throw _privateConstructorUsedError;
  SubscriptionStatus get status => throw _privateConstructorUsedError;
  List<CreditHistoryEntry> get history => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_ids')
  List<String> get itemIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'paused_at')
  String? get pausedAt => throw _privateConstructorUsedError;
  SubscriptionPolicy? get policy => throw _privateConstructorUsedError;

  /// Serializes this Subscription to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionCopyWith<Subscription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionCopyWith<$Res> {
  factory $SubscriptionCopyWith(
    Subscription value,
    $Res Function(Subscription) then,
  ) = _$SubscriptionCopyWithImpl<$Res, Subscription>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'page_id') String pageId,
    @JsonKey(name: 'page_name') String pageName,
    @JsonKey(name: 'page_logo') String? pageLogo,
    @JsonKey(name: 'package_id') String packageId,
    @JsonKey(name: 'package_name') String packageName,
    SubscriptionModel model,
    @JsonKey(name: 'total_credits') int? totalCredits,
    @JsonKey(name: 'remaining_credits') int? remainingCredits,
    @JsonKey(name: 'credit_label') String? creditLabel,
    @JsonKey(name: 'starts_at') String startsAt,
    @JsonKey(name: 'expires_at') String? expiresAt,
    SubscriptionStatus status,
    List<CreditHistoryEntry> history,
    @JsonKey(name: 'item_ids') List<String> itemIds,
    @JsonKey(name: 'paused_at') String? pausedAt,
    SubscriptionPolicy? policy,
  });

  $SubscriptionPolicyCopyWith<$Res>? get policy;
}

/// @nodoc
class _$SubscriptionCopyWithImpl<$Res, $Val extends Subscription>
    implements $SubscriptionCopyWith<$Res> {
  _$SubscriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pageId = null,
    Object? pageName = null,
    Object? pageLogo = freezed,
    Object? packageId = null,
    Object? packageName = null,
    Object? model = null,
    Object? totalCredits = freezed,
    Object? remainingCredits = freezed,
    Object? creditLabel = freezed,
    Object? startsAt = null,
    Object? expiresAt = freezed,
    Object? status = null,
    Object? history = null,
    Object? itemIds = null,
    Object? pausedAt = freezed,
    Object? policy = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            pageId: null == pageId
                ? _value.pageId
                : pageId // ignore: cast_nullable_to_non_nullable
                      as String,
            pageName: null == pageName
                ? _value.pageName
                : pageName // ignore: cast_nullable_to_non_nullable
                      as String,
            pageLogo: freezed == pageLogo
                ? _value.pageLogo
                : pageLogo // ignore: cast_nullable_to_non_nullable
                      as String?,
            packageId: null == packageId
                ? _value.packageId
                : packageId // ignore: cast_nullable_to_non_nullable
                      as String,
            packageName: null == packageName
                ? _value.packageName
                : packageName // ignore: cast_nullable_to_non_nullable
                      as String,
            model: null == model
                ? _value.model
                : model // ignore: cast_nullable_to_non_nullable
                      as SubscriptionModel,
            totalCredits: freezed == totalCredits
                ? _value.totalCredits
                : totalCredits // ignore: cast_nullable_to_non_nullable
                      as int?,
            remainingCredits: freezed == remainingCredits
                ? _value.remainingCredits
                : remainingCredits // ignore: cast_nullable_to_non_nullable
                      as int?,
            creditLabel: freezed == creditLabel
                ? _value.creditLabel
                : creditLabel // ignore: cast_nullable_to_non_nullable
                      as String?,
            startsAt: null == startsAt
                ? _value.startsAt
                : startsAt // ignore: cast_nullable_to_non_nullable
                      as String,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as SubscriptionStatus,
            history: null == history
                ? _value.history
                : history // ignore: cast_nullable_to_non_nullable
                      as List<CreditHistoryEntry>,
            itemIds: null == itemIds
                ? _value.itemIds
                : itemIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            pausedAt: freezed == pausedAt
                ? _value.pausedAt
                : pausedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            policy: freezed == policy
                ? _value.policy
                : policy // ignore: cast_nullable_to_non_nullable
                      as SubscriptionPolicy?,
          )
          as $Val,
    );
  }

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionPolicyCopyWith<$Res>? get policy {
    if (_value.policy == null) {
      return null;
    }

    return $SubscriptionPolicyCopyWith<$Res>(_value.policy!, (value) {
      return _then(_value.copyWith(policy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SubscriptionImplCopyWith<$Res>
    implements $SubscriptionCopyWith<$Res> {
  factory _$$SubscriptionImplCopyWith(
    _$SubscriptionImpl value,
    $Res Function(_$SubscriptionImpl) then,
  ) = __$$SubscriptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'page_id') String pageId,
    @JsonKey(name: 'page_name') String pageName,
    @JsonKey(name: 'page_logo') String? pageLogo,
    @JsonKey(name: 'package_id') String packageId,
    @JsonKey(name: 'package_name') String packageName,
    SubscriptionModel model,
    @JsonKey(name: 'total_credits') int? totalCredits,
    @JsonKey(name: 'remaining_credits') int? remainingCredits,
    @JsonKey(name: 'credit_label') String? creditLabel,
    @JsonKey(name: 'starts_at') String startsAt,
    @JsonKey(name: 'expires_at') String? expiresAt,
    SubscriptionStatus status,
    List<CreditHistoryEntry> history,
    @JsonKey(name: 'item_ids') List<String> itemIds,
    @JsonKey(name: 'paused_at') String? pausedAt,
    SubscriptionPolicy? policy,
  });

  @override
  $SubscriptionPolicyCopyWith<$Res>? get policy;
}

/// @nodoc
class __$$SubscriptionImplCopyWithImpl<$Res>
    extends _$SubscriptionCopyWithImpl<$Res, _$SubscriptionImpl>
    implements _$$SubscriptionImplCopyWith<$Res> {
  __$$SubscriptionImplCopyWithImpl(
    _$SubscriptionImpl _value,
    $Res Function(_$SubscriptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pageId = null,
    Object? pageName = null,
    Object? pageLogo = freezed,
    Object? packageId = null,
    Object? packageName = null,
    Object? model = null,
    Object? totalCredits = freezed,
    Object? remainingCredits = freezed,
    Object? creditLabel = freezed,
    Object? startsAt = null,
    Object? expiresAt = freezed,
    Object? status = null,
    Object? history = null,
    Object? itemIds = null,
    Object? pausedAt = freezed,
    Object? policy = freezed,
  }) {
    return _then(
      _$SubscriptionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        pageId: null == pageId
            ? _value.pageId
            : pageId // ignore: cast_nullable_to_non_nullable
                  as String,
        pageName: null == pageName
            ? _value.pageName
            : pageName // ignore: cast_nullable_to_non_nullable
                  as String,
        pageLogo: freezed == pageLogo
            ? _value.pageLogo
            : pageLogo // ignore: cast_nullable_to_non_nullable
                  as String?,
        packageId: null == packageId
            ? _value.packageId
            : packageId // ignore: cast_nullable_to_non_nullable
                  as String,
        packageName: null == packageName
            ? _value.packageName
            : packageName // ignore: cast_nullable_to_non_nullable
                  as String,
        model: null == model
            ? _value.model
            : model // ignore: cast_nullable_to_non_nullable
                  as SubscriptionModel,
        totalCredits: freezed == totalCredits
            ? _value.totalCredits
            : totalCredits // ignore: cast_nullable_to_non_nullable
                  as int?,
        remainingCredits: freezed == remainingCredits
            ? _value.remainingCredits
            : remainingCredits // ignore: cast_nullable_to_non_nullable
                  as int?,
        creditLabel: freezed == creditLabel
            ? _value.creditLabel
            : creditLabel // ignore: cast_nullable_to_non_nullable
                  as String?,
        startsAt: null == startsAt
            ? _value.startsAt
            : startsAt // ignore: cast_nullable_to_non_nullable
                  as String,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as SubscriptionStatus,
        history: null == history
            ? _value._history
            : history // ignore: cast_nullable_to_non_nullable
                  as List<CreditHistoryEntry>,
        itemIds: null == itemIds
            ? _value._itemIds
            : itemIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        pausedAt: freezed == pausedAt
            ? _value.pausedAt
            : pausedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        policy: freezed == policy
            ? _value.policy
            : policy // ignore: cast_nullable_to_non_nullable
                  as SubscriptionPolicy?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionImpl extends _Subscription {
  const _$SubscriptionImpl({
    required this.id,
    @JsonKey(name: 'page_id') required this.pageId,
    @JsonKey(name: 'page_name') required this.pageName,
    @JsonKey(name: 'page_logo') this.pageLogo,
    @JsonKey(name: 'package_id') required this.packageId,
    @JsonKey(name: 'package_name') required this.packageName,
    required this.model,
    @JsonKey(name: 'total_credits') this.totalCredits,
    @JsonKey(name: 'remaining_credits') this.remainingCredits,
    @JsonKey(name: 'credit_label') this.creditLabel,
    @JsonKey(name: 'starts_at') required this.startsAt,
    @JsonKey(name: 'expires_at') this.expiresAt,
    required this.status,
    final List<CreditHistoryEntry> history = const [],
    @JsonKey(name: 'item_ids') final List<String> itemIds = const [],
    @JsonKey(name: 'paused_at') this.pausedAt,
    this.policy,
  }) : _history = history,
       _itemIds = itemIds,
       super._();

  factory _$SubscriptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'page_id')
  final String pageId;
  @override
  @JsonKey(name: 'page_name')
  final String pageName;
  @override
  @JsonKey(name: 'page_logo')
  final String? pageLogo;
  @override
  @JsonKey(name: 'package_id')
  final String packageId;
  @override
  @JsonKey(name: 'package_name')
  final String packageName;
  @override
  final SubscriptionModel model;
  @override
  @JsonKey(name: 'total_credits')
  final int? totalCredits;
  @override
  @JsonKey(name: 'remaining_credits')
  final int? remainingCredits;
  @override
  @JsonKey(name: 'credit_label')
  final String? creditLabel;
  @override
  @JsonKey(name: 'starts_at')
  final String startsAt;
  @override
  @JsonKey(name: 'expires_at')
  final String? expiresAt;
  @override
  final SubscriptionStatus status;
  final List<CreditHistoryEntry> _history;
  @override
  @JsonKey()
  List<CreditHistoryEntry> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
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
  @JsonKey(name: 'paused_at')
  final String? pausedAt;
  @override
  final SubscriptionPolicy? policy;

  @override
  String toString() {
    return 'Subscription(id: $id, pageId: $pageId, pageName: $pageName, pageLogo: $pageLogo, packageId: $packageId, packageName: $packageName, model: $model, totalCredits: $totalCredits, remainingCredits: $remainingCredits, creditLabel: $creditLabel, startsAt: $startsAt, expiresAt: $expiresAt, status: $status, history: $history, itemIds: $itemIds, pausedAt: $pausedAt, policy: $policy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pageId, pageId) || other.pageId == pageId) &&
            (identical(other.pageName, pageName) ||
                other.pageName == pageName) &&
            (identical(other.pageLogo, pageLogo) ||
                other.pageLogo == pageLogo) &&
            (identical(other.packageId, packageId) ||
                other.packageId == packageId) &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.totalCredits, totalCredits) ||
                other.totalCredits == totalCredits) &&
            (identical(other.remainingCredits, remainingCredits) ||
                other.remainingCredits == remainingCredits) &&
            (identical(other.creditLabel, creditLabel) ||
                other.creditLabel == creditLabel) &&
            (identical(other.startsAt, startsAt) ||
                other.startsAt == startsAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            const DeepCollectionEquality().equals(other._itemIds, _itemIds) &&
            (identical(other.pausedAt, pausedAt) ||
                other.pausedAt == pausedAt) &&
            (identical(other.policy, policy) || other.policy == policy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    pageId,
    pageName,
    pageLogo,
    packageId,
    packageName,
    model,
    totalCredits,
    remainingCredits,
    creditLabel,
    startsAt,
    expiresAt,
    status,
    const DeepCollectionEquality().hash(_history),
    const DeepCollectionEquality().hash(_itemIds),
    pausedAt,
    policy,
  );

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionImplCopyWith<_$SubscriptionImpl> get copyWith =>
      __$$SubscriptionImplCopyWithImpl<_$SubscriptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionImplToJson(this);
  }
}

abstract class _Subscription extends Subscription {
  const factory _Subscription({
    required final String id,
    @JsonKey(name: 'page_id') required final String pageId,
    @JsonKey(name: 'page_name') required final String pageName,
    @JsonKey(name: 'page_logo') final String? pageLogo,
    @JsonKey(name: 'package_id') required final String packageId,
    @JsonKey(name: 'package_name') required final String packageName,
    required final SubscriptionModel model,
    @JsonKey(name: 'total_credits') final int? totalCredits,
    @JsonKey(name: 'remaining_credits') final int? remainingCredits,
    @JsonKey(name: 'credit_label') final String? creditLabel,
    @JsonKey(name: 'starts_at') required final String startsAt,
    @JsonKey(name: 'expires_at') final String? expiresAt,
    required final SubscriptionStatus status,
    final List<CreditHistoryEntry> history,
    @JsonKey(name: 'item_ids') final List<String> itemIds,
    @JsonKey(name: 'paused_at') final String? pausedAt,
    final SubscriptionPolicy? policy,
  }) = _$SubscriptionImpl;
  const _Subscription._() : super._();

  factory _Subscription.fromJson(Map<String, dynamic> json) =
      _$SubscriptionImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'page_id')
  String get pageId;
  @override
  @JsonKey(name: 'page_name')
  String get pageName;
  @override
  @JsonKey(name: 'page_logo')
  String? get pageLogo;
  @override
  @JsonKey(name: 'package_id')
  String get packageId;
  @override
  @JsonKey(name: 'package_name')
  String get packageName;
  @override
  SubscriptionModel get model;
  @override
  @JsonKey(name: 'total_credits')
  int? get totalCredits;
  @override
  @JsonKey(name: 'remaining_credits')
  int? get remainingCredits;
  @override
  @JsonKey(name: 'credit_label')
  String? get creditLabel;
  @override
  @JsonKey(name: 'starts_at')
  String get startsAt;
  @override
  @JsonKey(name: 'expires_at')
  String? get expiresAt;
  @override
  SubscriptionStatus get status;
  @override
  List<CreditHistoryEntry> get history;
  @override
  @JsonKey(name: 'item_ids')
  List<String> get itemIds;
  @override
  @JsonKey(name: 'paused_at')
  String? get pausedAt;
  @override
  SubscriptionPolicy? get policy;

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionImplCopyWith<_$SubscriptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
