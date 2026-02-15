// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CustomerSubscriptionInfo _$CustomerSubscriptionInfoFromJson(
  Map<String, dynamic> json,
) {
  return _CustomerSubscriptionInfo.fromJson(json);
}

/// @nodoc
mixin _$CustomerSubscriptionInfo {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'package_name')
  String get packageName => throw _privateConstructorUsedError;
  @JsonKey(name: 'remaining_credits')
  int? get remainingCredits => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_credits')
  int? get totalCredits => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  String? get expiresAt => throw _privateConstructorUsedError;
  String get model => throw _privateConstructorUsedError;
  @JsonKey(name: 'recurring_mode')
  String? get recurringMode => throw _privateConstructorUsedError;
  @JsonKey(name: 'recurring_frequency')
  String? get recurringFrequency => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this CustomerSubscriptionInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomerSubscriptionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerSubscriptionInfoCopyWith<CustomerSubscriptionInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerSubscriptionInfoCopyWith<$Res> {
  factory $CustomerSubscriptionInfoCopyWith(
    CustomerSubscriptionInfo value,
    $Res Function(CustomerSubscriptionInfo) then,
  ) = _$CustomerSubscriptionInfoCopyWithImpl<$Res, CustomerSubscriptionInfo>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'package_name') String packageName,
    @JsonKey(name: 'remaining_credits') int? remainingCredits,
    @JsonKey(name: 'total_credits') int? totalCredits,
    @JsonKey(name: 'expires_at') String? expiresAt,
    String model,
    @JsonKey(name: 'recurring_mode') String? recurringMode,
    @JsonKey(name: 'recurring_frequency') String? recurringFrequency,
    String status,
  });
}

/// @nodoc
class _$CustomerSubscriptionInfoCopyWithImpl<
  $Res,
  $Val extends CustomerSubscriptionInfo
>
    implements $CustomerSubscriptionInfoCopyWith<$Res> {
  _$CustomerSubscriptionInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerSubscriptionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? packageName = null,
    Object? remainingCredits = freezed,
    Object? totalCredits = freezed,
    Object? expiresAt = freezed,
    Object? model = null,
    Object? recurringMode = freezed,
    Object? recurringFrequency = freezed,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            packageName: null == packageName
                ? _value.packageName
                : packageName // ignore: cast_nullable_to_non_nullable
                      as String,
            remainingCredits: freezed == remainingCredits
                ? _value.remainingCredits
                : remainingCredits // ignore: cast_nullable_to_non_nullable
                      as int?,
            totalCredits: freezed == totalCredits
                ? _value.totalCredits
                : totalCredits // ignore: cast_nullable_to_non_nullable
                      as int?,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            model: null == model
                ? _value.model
                : model // ignore: cast_nullable_to_non_nullable
                      as String,
            recurringMode: freezed == recurringMode
                ? _value.recurringMode
                : recurringMode // ignore: cast_nullable_to_non_nullable
                      as String?,
            recurringFrequency: freezed == recurringFrequency
                ? _value.recurringFrequency
                : recurringFrequency // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CustomerSubscriptionInfoImplCopyWith<$Res>
    implements $CustomerSubscriptionInfoCopyWith<$Res> {
  factory _$$CustomerSubscriptionInfoImplCopyWith(
    _$CustomerSubscriptionInfoImpl value,
    $Res Function(_$CustomerSubscriptionInfoImpl) then,
  ) = __$$CustomerSubscriptionInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'package_name') String packageName,
    @JsonKey(name: 'remaining_credits') int? remainingCredits,
    @JsonKey(name: 'total_credits') int? totalCredits,
    @JsonKey(name: 'expires_at') String? expiresAt,
    String model,
    @JsonKey(name: 'recurring_mode') String? recurringMode,
    @JsonKey(name: 'recurring_frequency') String? recurringFrequency,
    String status,
  });
}

/// @nodoc
class __$$CustomerSubscriptionInfoImplCopyWithImpl<$Res>
    extends
        _$CustomerSubscriptionInfoCopyWithImpl<
          $Res,
          _$CustomerSubscriptionInfoImpl
        >
    implements _$$CustomerSubscriptionInfoImplCopyWith<$Res> {
  __$$CustomerSubscriptionInfoImplCopyWithImpl(
    _$CustomerSubscriptionInfoImpl _value,
    $Res Function(_$CustomerSubscriptionInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CustomerSubscriptionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? packageName = null,
    Object? remainingCredits = freezed,
    Object? totalCredits = freezed,
    Object? expiresAt = freezed,
    Object? model = null,
    Object? recurringMode = freezed,
    Object? recurringFrequency = freezed,
    Object? status = null,
  }) {
    return _then(
      _$CustomerSubscriptionInfoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        packageName: null == packageName
            ? _value.packageName
            : packageName // ignore: cast_nullable_to_non_nullable
                  as String,
        remainingCredits: freezed == remainingCredits
            ? _value.remainingCredits
            : remainingCredits // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalCredits: freezed == totalCredits
            ? _value.totalCredits
            : totalCredits // ignore: cast_nullable_to_non_nullable
                  as int?,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        model: null == model
            ? _value.model
            : model // ignore: cast_nullable_to_non_nullable
                  as String,
        recurringMode: freezed == recurringMode
            ? _value.recurringMode
            : recurringMode // ignore: cast_nullable_to_non_nullable
                  as String?,
        recurringFrequency: freezed == recurringFrequency
            ? _value.recurringFrequency
            : recurringFrequency // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerSubscriptionInfoImpl implements _CustomerSubscriptionInfo {
  const _$CustomerSubscriptionInfoImpl({
    required this.id,
    @JsonKey(name: 'package_name') required this.packageName,
    @JsonKey(name: 'remaining_credits') this.remainingCredits,
    @JsonKey(name: 'total_credits') this.totalCredits,
    @JsonKey(name: 'expires_at') this.expiresAt,
    required this.model,
    @JsonKey(name: 'recurring_mode') this.recurringMode,
    @JsonKey(name: 'recurring_frequency') this.recurringFrequency,
    required this.status,
  });

  factory _$CustomerSubscriptionInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerSubscriptionInfoImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'package_name')
  final String packageName;
  @override
  @JsonKey(name: 'remaining_credits')
  final int? remainingCredits;
  @override
  @JsonKey(name: 'total_credits')
  final int? totalCredits;
  @override
  @JsonKey(name: 'expires_at')
  final String? expiresAt;
  @override
  final String model;
  @override
  @JsonKey(name: 'recurring_mode')
  final String? recurringMode;
  @override
  @JsonKey(name: 'recurring_frequency')
  final String? recurringFrequency;
  @override
  final String status;

  @override
  String toString() {
    return 'CustomerSubscriptionInfo(id: $id, packageName: $packageName, remainingCredits: $remainingCredits, totalCredits: $totalCredits, expiresAt: $expiresAt, model: $model, recurringMode: $recurringMode, recurringFrequency: $recurringFrequency, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerSubscriptionInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.remainingCredits, remainingCredits) ||
                other.remainingCredits == remainingCredits) &&
            (identical(other.totalCredits, totalCredits) ||
                other.totalCredits == totalCredits) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.recurringMode, recurringMode) ||
                other.recurringMode == recurringMode) &&
            (identical(other.recurringFrequency, recurringFrequency) ||
                other.recurringFrequency == recurringFrequency) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    packageName,
    remainingCredits,
    totalCredits,
    expiresAt,
    model,
    recurringMode,
    recurringFrequency,
    status,
  );

  /// Create a copy of CustomerSubscriptionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerSubscriptionInfoImplCopyWith<_$CustomerSubscriptionInfoImpl>
  get copyWith =>
      __$$CustomerSubscriptionInfoImplCopyWithImpl<
        _$CustomerSubscriptionInfoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerSubscriptionInfoImplToJson(this);
  }
}

abstract class _CustomerSubscriptionInfo implements CustomerSubscriptionInfo {
  const factory _CustomerSubscriptionInfo({
    required final String id,
    @JsonKey(name: 'package_name') required final String packageName,
    @JsonKey(name: 'remaining_credits') final int? remainingCredits,
    @JsonKey(name: 'total_credits') final int? totalCredits,
    @JsonKey(name: 'expires_at') final String? expiresAt,
    required final String model,
    @JsonKey(name: 'recurring_mode') final String? recurringMode,
    @JsonKey(name: 'recurring_frequency') final String? recurringFrequency,
    required final String status,
  }) = _$CustomerSubscriptionInfoImpl;

  factory _CustomerSubscriptionInfo.fromJson(Map<String, dynamic> json) =
      _$CustomerSubscriptionInfoImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'package_name')
  String get packageName;
  @override
  @JsonKey(name: 'remaining_credits')
  int? get remainingCredits;
  @override
  @JsonKey(name: 'total_credits')
  int? get totalCredits;
  @override
  @JsonKey(name: 'expires_at')
  String? get expiresAt;
  @override
  String get model;
  @override
  @JsonKey(name: 'recurring_mode')
  String? get recurringMode;
  @override
  @JsonKey(name: 'recurring_frequency')
  String? get recurringFrequency;
  @override
  String get status;

  /// Create a copy of CustomerSubscriptionInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerSubscriptionInfoImplCopyWith<_$CustomerSubscriptionInfoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

RecentOrder _$RecentOrderFromJson(Map<String, dynamic> json) {
  return _RecentOrder.fromJson(json);
}

/// @nodoc
mixin _$RecentOrder {
  String get date => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this RecentOrder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecentOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecentOrderCopyWith<RecentOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentOrderCopyWith<$Res> {
  factory $RecentOrderCopyWith(
    RecentOrder value,
    $Res Function(RecentOrder) then,
  ) = _$RecentOrderCopyWithImpl<$Res, RecentOrder>;
  @useResult
  $Res call({String date, String summary, int amount, String status});
}

/// @nodoc
class _$RecentOrderCopyWithImpl<$Res, $Val extends RecentOrder>
    implements $RecentOrderCopyWith<$Res> {
  _$RecentOrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecentOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? summary = null,
    Object? amount = null,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecentOrderImplCopyWith<$Res>
    implements $RecentOrderCopyWith<$Res> {
  factory _$$RecentOrderImplCopyWith(
    _$RecentOrderImpl value,
    $Res Function(_$RecentOrderImpl) then,
  ) = __$$RecentOrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, String summary, int amount, String status});
}

/// @nodoc
class __$$RecentOrderImplCopyWithImpl<$Res>
    extends _$RecentOrderCopyWithImpl<$Res, _$RecentOrderImpl>
    implements _$$RecentOrderImplCopyWith<$Res> {
  __$$RecentOrderImplCopyWithImpl(
    _$RecentOrderImpl _value,
    $Res Function(_$RecentOrderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecentOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? summary = null,
    Object? amount = null,
    Object? status = null,
  }) {
    return _then(
      _$RecentOrderImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecentOrderImpl implements _RecentOrder {
  const _$RecentOrderImpl({
    required this.date,
    required this.summary,
    this.amount = 0,
    this.status = 'pending',
  });

  factory _$RecentOrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecentOrderImplFromJson(json);

  @override
  final String date;
  @override
  final String summary;
  @override
  @JsonKey()
  final int amount;
  @override
  @JsonKey()
  final String status;

  @override
  String toString() {
    return 'RecentOrder(date: $date, summary: $summary, amount: $amount, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecentOrderImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, summary, amount, status);

  /// Create a copy of RecentOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecentOrderImplCopyWith<_$RecentOrderImpl> get copyWith =>
      __$$RecentOrderImplCopyWithImpl<_$RecentOrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecentOrderImplToJson(this);
  }
}

abstract class _RecentOrder implements RecentOrder {
  const factory _RecentOrder({
    required final String date,
    required final String summary,
    final int amount,
    final String status,
  }) = _$RecentOrderImpl;

  factory _RecentOrder.fromJson(Map<String, dynamic> json) =
      _$RecentOrderImpl.fromJson;

  @override
  String get date;
  @override
  String get summary;
  @override
  int get amount;
  @override
  String get status;

  /// Create a copy of RecentOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecentOrderImplCopyWith<_$RecentOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BusinessCustomer _$BusinessCustomerFromJson(Map<String, dynamic> json) {
  return _BusinessCustomer.fromJson(json);
}

/// @nodoc
mixin _$BusinessCustomer {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String? get area => throw _privateConstructorUsedError;
  CustomerBadge get badge => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_orders')
  int get totalOrders => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_spent')
  int get totalSpent => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_order_date')
  String? get lastOrderDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_activity_date')
  String? get lastActivityDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'usual_payment')
  String? get usualPayment => throw _privateConstructorUsedError;
  CustomerSubscriptionInfo? get subscription =>
      throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'recent_orders')
  List<RecentOrder> get recentOrders => throw _privateConstructorUsedError;

  /// Serializes this BusinessCustomer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusinessCustomer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessCustomerCopyWith<BusinessCustomer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessCustomerCopyWith<$Res> {
  factory $BusinessCustomerCopyWith(
    BusinessCustomer value,
    $Res Function(BusinessCustomer) then,
  ) = _$BusinessCustomerCopyWithImpl<$Res, BusinessCustomer>;
  @useResult
  $Res call({
    String id,
    String name,
    String? phone,
    String? avatar,
    String? area,
    CustomerBadge badge,
    @JsonKey(name: 'total_orders') int totalOrders,
    @JsonKey(name: 'total_spent') int totalSpent,
    @JsonKey(name: 'last_order_date') String? lastOrderDate,
    @JsonKey(name: 'last_activity_date') String? lastActivityDate,
    @JsonKey(name: 'usual_payment') String? usualPayment,
    CustomerSubscriptionInfo? subscription,
    String? source,
    @JsonKey(name: 'created_at') String? createdAt,
    String? notes,
    @JsonKey(name: 'recent_orders') List<RecentOrder> recentOrders,
  });

  $CustomerSubscriptionInfoCopyWith<$Res>? get subscription;
}

/// @nodoc
class _$BusinessCustomerCopyWithImpl<$Res, $Val extends BusinessCustomer>
    implements $BusinessCustomerCopyWith<$Res> {
  _$BusinessCustomerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessCustomer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = freezed,
    Object? avatar = freezed,
    Object? area = freezed,
    Object? badge = null,
    Object? totalOrders = null,
    Object? totalSpent = null,
    Object? lastOrderDate = freezed,
    Object? lastActivityDate = freezed,
    Object? usualPayment = freezed,
    Object? subscription = freezed,
    Object? source = freezed,
    Object? createdAt = freezed,
    Object? notes = freezed,
    Object? recentOrders = null,
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
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatar: freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            area: freezed == area
                ? _value.area
                : area // ignore: cast_nullable_to_non_nullable
                      as String?,
            badge: null == badge
                ? _value.badge
                : badge // ignore: cast_nullable_to_non_nullable
                      as CustomerBadge,
            totalOrders: null == totalOrders
                ? _value.totalOrders
                : totalOrders // ignore: cast_nullable_to_non_nullable
                      as int,
            totalSpent: null == totalSpent
                ? _value.totalSpent
                : totalSpent // ignore: cast_nullable_to_non_nullable
                      as int,
            lastOrderDate: freezed == lastOrderDate
                ? _value.lastOrderDate
                : lastOrderDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastActivityDate: freezed == lastActivityDate
                ? _value.lastActivityDate
                : lastActivityDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            usualPayment: freezed == usualPayment
                ? _value.usualPayment
                : usualPayment // ignore: cast_nullable_to_non_nullable
                      as String?,
            subscription: freezed == subscription
                ? _value.subscription
                : subscription // ignore: cast_nullable_to_non_nullable
                      as CustomerSubscriptionInfo?,
            source: freezed == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            recentOrders: null == recentOrders
                ? _value.recentOrders
                : recentOrders // ignore: cast_nullable_to_non_nullable
                      as List<RecentOrder>,
          )
          as $Val,
    );
  }

  /// Create a copy of BusinessCustomer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomerSubscriptionInfoCopyWith<$Res>? get subscription {
    if (_value.subscription == null) {
      return null;
    }

    return $CustomerSubscriptionInfoCopyWith<$Res>(_value.subscription!, (
      value,
    ) {
      return _then(_value.copyWith(subscription: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BusinessCustomerImplCopyWith<$Res>
    implements $BusinessCustomerCopyWith<$Res> {
  factory _$$BusinessCustomerImplCopyWith(
    _$BusinessCustomerImpl value,
    $Res Function(_$BusinessCustomerImpl) then,
  ) = __$$BusinessCustomerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? phone,
    String? avatar,
    String? area,
    CustomerBadge badge,
    @JsonKey(name: 'total_orders') int totalOrders,
    @JsonKey(name: 'total_spent') int totalSpent,
    @JsonKey(name: 'last_order_date') String? lastOrderDate,
    @JsonKey(name: 'last_activity_date') String? lastActivityDate,
    @JsonKey(name: 'usual_payment') String? usualPayment,
    CustomerSubscriptionInfo? subscription,
    String? source,
    @JsonKey(name: 'created_at') String? createdAt,
    String? notes,
    @JsonKey(name: 'recent_orders') List<RecentOrder> recentOrders,
  });

  @override
  $CustomerSubscriptionInfoCopyWith<$Res>? get subscription;
}

/// @nodoc
class __$$BusinessCustomerImplCopyWithImpl<$Res>
    extends _$BusinessCustomerCopyWithImpl<$Res, _$BusinessCustomerImpl>
    implements _$$BusinessCustomerImplCopyWith<$Res> {
  __$$BusinessCustomerImplCopyWithImpl(
    _$BusinessCustomerImpl _value,
    $Res Function(_$BusinessCustomerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusinessCustomer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = freezed,
    Object? avatar = freezed,
    Object? area = freezed,
    Object? badge = null,
    Object? totalOrders = null,
    Object? totalSpent = null,
    Object? lastOrderDate = freezed,
    Object? lastActivityDate = freezed,
    Object? usualPayment = freezed,
    Object? subscription = freezed,
    Object? source = freezed,
    Object? createdAt = freezed,
    Object? notes = freezed,
    Object? recentOrders = null,
  }) {
    return _then(
      _$BusinessCustomerImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatar: freezed == avatar
            ? _value.avatar
            : avatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        area: freezed == area
            ? _value.area
            : area // ignore: cast_nullable_to_non_nullable
                  as String?,
        badge: null == badge
            ? _value.badge
            : badge // ignore: cast_nullable_to_non_nullable
                  as CustomerBadge,
        totalOrders: null == totalOrders
            ? _value.totalOrders
            : totalOrders // ignore: cast_nullable_to_non_nullable
                  as int,
        totalSpent: null == totalSpent
            ? _value.totalSpent
            : totalSpent // ignore: cast_nullable_to_non_nullable
                  as int,
        lastOrderDate: freezed == lastOrderDate
            ? _value.lastOrderDate
            : lastOrderDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastActivityDate: freezed == lastActivityDate
            ? _value.lastActivityDate
            : lastActivityDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        usualPayment: freezed == usualPayment
            ? _value.usualPayment
            : usualPayment // ignore: cast_nullable_to_non_nullable
                  as String?,
        subscription: freezed == subscription
            ? _value.subscription
            : subscription // ignore: cast_nullable_to_non_nullable
                  as CustomerSubscriptionInfo?,
        source: freezed == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        recentOrders: null == recentOrders
            ? _value._recentOrders
            : recentOrders // ignore: cast_nullable_to_non_nullable
                  as List<RecentOrder>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessCustomerImpl extends _BusinessCustomer {
  const _$BusinessCustomerImpl({
    required this.id,
    required this.name,
    this.phone,
    this.avatar,
    this.area,
    this.badge = CustomerBadge.newCustomer,
    @JsonKey(name: 'total_orders') this.totalOrders = 0,
    @JsonKey(name: 'total_spent') this.totalSpent = 0,
    @JsonKey(name: 'last_order_date') this.lastOrderDate,
    @JsonKey(name: 'last_activity_date') this.lastActivityDate,
    @JsonKey(name: 'usual_payment') this.usualPayment,
    this.subscription,
    this.source,
    @JsonKey(name: 'created_at') this.createdAt,
    this.notes,
    @JsonKey(name: 'recent_orders')
    final List<RecentOrder> recentOrders = const [],
  }) : _recentOrders = recentOrders,
       super._();

  factory _$BusinessCustomerImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessCustomerImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? phone;
  @override
  final String? avatar;
  @override
  final String? area;
  @override
  @JsonKey()
  final CustomerBadge badge;
  @override
  @JsonKey(name: 'total_orders')
  final int totalOrders;
  @override
  @JsonKey(name: 'total_spent')
  final int totalSpent;
  @override
  @JsonKey(name: 'last_order_date')
  final String? lastOrderDate;
  @override
  @JsonKey(name: 'last_activity_date')
  final String? lastActivityDate;
  @override
  @JsonKey(name: 'usual_payment')
  final String? usualPayment;
  @override
  final CustomerSubscriptionInfo? subscription;
  @override
  final String? source;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  final String? notes;
  final List<RecentOrder> _recentOrders;
  @override
  @JsonKey(name: 'recent_orders')
  List<RecentOrder> get recentOrders {
    if (_recentOrders is EqualUnmodifiableListView) return _recentOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentOrders);
  }

  @override
  String toString() {
    return 'BusinessCustomer(id: $id, name: $name, phone: $phone, avatar: $avatar, area: $area, badge: $badge, totalOrders: $totalOrders, totalSpent: $totalSpent, lastOrderDate: $lastOrderDate, lastActivityDate: $lastActivityDate, usualPayment: $usualPayment, subscription: $subscription, source: $source, createdAt: $createdAt, notes: $notes, recentOrders: $recentOrders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessCustomerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.badge, badge) || other.badge == badge) &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            (identical(other.totalSpent, totalSpent) ||
                other.totalSpent == totalSpent) &&
            (identical(other.lastOrderDate, lastOrderDate) ||
                other.lastOrderDate == lastOrderDate) &&
            (identical(other.lastActivityDate, lastActivityDate) ||
                other.lastActivityDate == lastActivityDate) &&
            (identical(other.usualPayment, usualPayment) ||
                other.usualPayment == usualPayment) &&
            (identical(other.subscription, subscription) ||
                other.subscription == subscription) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(
              other._recentOrders,
              _recentOrders,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    phone,
    avatar,
    area,
    badge,
    totalOrders,
    totalSpent,
    lastOrderDate,
    lastActivityDate,
    usualPayment,
    subscription,
    source,
    createdAt,
    notes,
    const DeepCollectionEquality().hash(_recentOrders),
  );

  /// Create a copy of BusinessCustomer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessCustomerImplCopyWith<_$BusinessCustomerImpl> get copyWith =>
      __$$BusinessCustomerImplCopyWithImpl<_$BusinessCustomerImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessCustomerImplToJson(this);
  }
}

abstract class _BusinessCustomer extends BusinessCustomer {
  const factory _BusinessCustomer({
    required final String id,
    required final String name,
    final String? phone,
    final String? avatar,
    final String? area,
    final CustomerBadge badge,
    @JsonKey(name: 'total_orders') final int totalOrders,
    @JsonKey(name: 'total_spent') final int totalSpent,
    @JsonKey(name: 'last_order_date') final String? lastOrderDate,
    @JsonKey(name: 'last_activity_date') final String? lastActivityDate,
    @JsonKey(name: 'usual_payment') final String? usualPayment,
    final CustomerSubscriptionInfo? subscription,
    final String? source,
    @JsonKey(name: 'created_at') final String? createdAt,
    final String? notes,
    @JsonKey(name: 'recent_orders') final List<RecentOrder> recentOrders,
  }) = _$BusinessCustomerImpl;
  const _BusinessCustomer._() : super._();

  factory _BusinessCustomer.fromJson(Map<String, dynamic> json) =
      _$BusinessCustomerImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get phone;
  @override
  String? get avatar;
  @override
  String? get area;
  @override
  CustomerBadge get badge;
  @override
  @JsonKey(name: 'total_orders')
  int get totalOrders;
  @override
  @JsonKey(name: 'total_spent')
  int get totalSpent;
  @override
  @JsonKey(name: 'last_order_date')
  String? get lastOrderDate;
  @override
  @JsonKey(name: 'last_activity_date')
  String? get lastActivityDate;
  @override
  @JsonKey(name: 'usual_payment')
  String? get usualPayment;
  @override
  CustomerSubscriptionInfo? get subscription;
  @override
  String? get source;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'recent_orders')
  List<RecentOrder> get recentOrders;

  /// Create a copy of BusinessCustomer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessCustomerImplCopyWith<_$BusinessCustomerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
