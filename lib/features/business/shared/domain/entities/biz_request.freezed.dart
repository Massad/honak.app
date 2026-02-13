// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biz_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BizRequest _$BizRequestFromJson(Map<String, dynamic> json) {
  return _BizRequest.fromJson(json);
}

/// @nodoc
mixin _$BizRequest {
  String get id => throw _privateConstructorUsedError;
  RequestCustomer get customer => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'items_count')
  int get itemsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_cents')
  @MoneyNullableConverter()
  Money? get total => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  @JsonKey(name: 'decline_reason')
  String? get declineReason => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  int get createdAt => throw _privateConstructorUsedError;
  List<RequestItem> get items => throw _privateConstructorUsedError;
  @JsonKey(name: 'conversation_id')
  String? get conversationId => throw _privateConstructorUsedError; // Archetype-specific optional fields
  @JsonKey(name: 'preferred_date')
  String? get preferredDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_slot')
  String? get timeSlot => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_range')
  String? get dateRange => throw _privateConstructorUsedError;
  @JsonKey(name: 'guest_count')
  int? get guestCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_location')
  String? get serviceLocation => throw _privateConstructorUsedError;

  /// Serializes this BizRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BizRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BizRequestCopyWith<BizRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BizRequestCopyWith<$Res> {
  factory $BizRequestCopyWith(
    BizRequest value,
    $Res Function(BizRequest) then,
  ) = _$BizRequestCopyWithImpl<$Res, BizRequest>;
  @useResult
  $Res call({
    String id,
    RequestCustomer customer,
    String status,
    String type,
    @JsonKey(name: 'items_count') int itemsCount,
    @JsonKey(name: 'total_cents') @MoneyNullableConverter() Money? total,
    String? note,
    @JsonKey(name: 'decline_reason') String? declineReason,
    @JsonKey(name: 'created_at') int createdAt,
    List<RequestItem> items,
    @JsonKey(name: 'conversation_id') String? conversationId,
    @JsonKey(name: 'preferred_date') String? preferredDate,
    @JsonKey(name: 'time_slot') String? timeSlot,
    String? description,
    @JsonKey(name: 'date_range') String? dateRange,
    @JsonKey(name: 'guest_count') int? guestCount,
    @JsonKey(name: 'service_location') String? serviceLocation,
  });

  $RequestCustomerCopyWith<$Res> get customer;
}

/// @nodoc
class _$BizRequestCopyWithImpl<$Res, $Val extends BizRequest>
    implements $BizRequestCopyWith<$Res> {
  _$BizRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BizRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customer = null,
    Object? status = null,
    Object? type = null,
    Object? itemsCount = null,
    Object? total = freezed,
    Object? note = freezed,
    Object? declineReason = freezed,
    Object? createdAt = null,
    Object? items = null,
    Object? conversationId = freezed,
    Object? preferredDate = freezed,
    Object? timeSlot = freezed,
    Object? description = freezed,
    Object? dateRange = freezed,
    Object? guestCount = freezed,
    Object? serviceLocation = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            customer: null == customer
                ? _value.customer
                : customer // ignore: cast_nullable_to_non_nullable
                      as RequestCustomer,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            itemsCount: null == itemsCount
                ? _value.itemsCount
                : itemsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            total: freezed == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as Money?,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
            declineReason: freezed == declineReason
                ? _value.declineReason
                : declineReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as int,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<RequestItem>,
            conversationId: freezed == conversationId
                ? _value.conversationId
                : conversationId // ignore: cast_nullable_to_non_nullable
                      as String?,
            preferredDate: freezed == preferredDate
                ? _value.preferredDate
                : preferredDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            timeSlot: freezed == timeSlot
                ? _value.timeSlot
                : timeSlot // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateRange: freezed == dateRange
                ? _value.dateRange
                : dateRange // ignore: cast_nullable_to_non_nullable
                      as String?,
            guestCount: freezed == guestCount
                ? _value.guestCount
                : guestCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            serviceLocation: freezed == serviceLocation
                ? _value.serviceLocation
                : serviceLocation // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of BizRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestCustomerCopyWith<$Res> get customer {
    return $RequestCustomerCopyWith<$Res>(_value.customer, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BizRequestImplCopyWith<$Res>
    implements $BizRequestCopyWith<$Res> {
  factory _$$BizRequestImplCopyWith(
    _$BizRequestImpl value,
    $Res Function(_$BizRequestImpl) then,
  ) = __$$BizRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    RequestCustomer customer,
    String status,
    String type,
    @JsonKey(name: 'items_count') int itemsCount,
    @JsonKey(name: 'total_cents') @MoneyNullableConverter() Money? total,
    String? note,
    @JsonKey(name: 'decline_reason') String? declineReason,
    @JsonKey(name: 'created_at') int createdAt,
    List<RequestItem> items,
    @JsonKey(name: 'conversation_id') String? conversationId,
    @JsonKey(name: 'preferred_date') String? preferredDate,
    @JsonKey(name: 'time_slot') String? timeSlot,
    String? description,
    @JsonKey(name: 'date_range') String? dateRange,
    @JsonKey(name: 'guest_count') int? guestCount,
    @JsonKey(name: 'service_location') String? serviceLocation,
  });

  @override
  $RequestCustomerCopyWith<$Res> get customer;
}

/// @nodoc
class __$$BizRequestImplCopyWithImpl<$Res>
    extends _$BizRequestCopyWithImpl<$Res, _$BizRequestImpl>
    implements _$$BizRequestImplCopyWith<$Res> {
  __$$BizRequestImplCopyWithImpl(
    _$BizRequestImpl _value,
    $Res Function(_$BizRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BizRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customer = null,
    Object? status = null,
    Object? type = null,
    Object? itemsCount = null,
    Object? total = freezed,
    Object? note = freezed,
    Object? declineReason = freezed,
    Object? createdAt = null,
    Object? items = null,
    Object? conversationId = freezed,
    Object? preferredDate = freezed,
    Object? timeSlot = freezed,
    Object? description = freezed,
    Object? dateRange = freezed,
    Object? guestCount = freezed,
    Object? serviceLocation = freezed,
  }) {
    return _then(
      _$BizRequestImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        customer: null == customer
            ? _value.customer
            : customer // ignore: cast_nullable_to_non_nullable
                  as RequestCustomer,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        itemsCount: null == itemsCount
            ? _value.itemsCount
            : itemsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        total: freezed == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as Money?,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        declineReason: freezed == declineReason
            ? _value.declineReason
            : declineReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as int,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<RequestItem>,
        conversationId: freezed == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String?,
        preferredDate: freezed == preferredDate
            ? _value.preferredDate
            : preferredDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        timeSlot: freezed == timeSlot
            ? _value.timeSlot
            : timeSlot // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateRange: freezed == dateRange
            ? _value.dateRange
            : dateRange // ignore: cast_nullable_to_non_nullable
                  as String?,
        guestCount: freezed == guestCount
            ? _value.guestCount
            : guestCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        serviceLocation: freezed == serviceLocation
            ? _value.serviceLocation
            : serviceLocation // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BizRequestImpl implements _BizRequest {
  const _$BizRequestImpl({
    required this.id,
    required this.customer,
    required this.status,
    this.type = 'order',
    @JsonKey(name: 'items_count') this.itemsCount = 0,
    @JsonKey(name: 'total_cents') @MoneyNullableConverter() this.total,
    this.note,
    @JsonKey(name: 'decline_reason') this.declineReason,
    @JsonKey(name: 'created_at') required this.createdAt,
    final List<RequestItem> items = const [],
    @JsonKey(name: 'conversation_id') this.conversationId,
    @JsonKey(name: 'preferred_date') this.preferredDate,
    @JsonKey(name: 'time_slot') this.timeSlot,
    this.description,
    @JsonKey(name: 'date_range') this.dateRange,
    @JsonKey(name: 'guest_count') this.guestCount,
    @JsonKey(name: 'service_location') this.serviceLocation,
  }) : _items = items;

  factory _$BizRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$BizRequestImplFromJson(json);

  @override
  final String id;
  @override
  final RequestCustomer customer;
  @override
  final String status;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey(name: 'items_count')
  final int itemsCount;
  @override
  @JsonKey(name: 'total_cents')
  @MoneyNullableConverter()
  final Money? total;
  @override
  final String? note;
  @override
  @JsonKey(name: 'decline_reason')
  final String? declineReason;
  @override
  @JsonKey(name: 'created_at')
  final int createdAt;
  final List<RequestItem> _items;
  @override
  @JsonKey()
  List<RequestItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey(name: 'conversation_id')
  final String? conversationId;
  // Archetype-specific optional fields
  @override
  @JsonKey(name: 'preferred_date')
  final String? preferredDate;
  @override
  @JsonKey(name: 'time_slot')
  final String? timeSlot;
  @override
  final String? description;
  @override
  @JsonKey(name: 'date_range')
  final String? dateRange;
  @override
  @JsonKey(name: 'guest_count')
  final int? guestCount;
  @override
  @JsonKey(name: 'service_location')
  final String? serviceLocation;

  @override
  String toString() {
    return 'BizRequest(id: $id, customer: $customer, status: $status, type: $type, itemsCount: $itemsCount, total: $total, note: $note, declineReason: $declineReason, createdAt: $createdAt, items: $items, conversationId: $conversationId, preferredDate: $preferredDate, timeSlot: $timeSlot, description: $description, dateRange: $dateRange, guestCount: $guestCount, serviceLocation: $serviceLocation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BizRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.itemsCount, itemsCount) ||
                other.itemsCount == itemsCount) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.declineReason, declineReason) ||
                other.declineReason == declineReason) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.preferredDate, preferredDate) ||
                other.preferredDate == preferredDate) &&
            (identical(other.timeSlot, timeSlot) ||
                other.timeSlot == timeSlot) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.dateRange, dateRange) ||
                other.dateRange == dateRange) &&
            (identical(other.guestCount, guestCount) ||
                other.guestCount == guestCount) &&
            (identical(other.serviceLocation, serviceLocation) ||
                other.serviceLocation == serviceLocation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    customer,
    status,
    type,
    itemsCount,
    total,
    note,
    declineReason,
    createdAt,
    const DeepCollectionEquality().hash(_items),
    conversationId,
    preferredDate,
    timeSlot,
    description,
    dateRange,
    guestCount,
    serviceLocation,
  );

  /// Create a copy of BizRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BizRequestImplCopyWith<_$BizRequestImpl> get copyWith =>
      __$$BizRequestImplCopyWithImpl<_$BizRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BizRequestImplToJson(this);
  }
}

abstract class _BizRequest implements BizRequest {
  const factory _BizRequest({
    required final String id,
    required final RequestCustomer customer,
    required final String status,
    final String type,
    @JsonKey(name: 'items_count') final int itemsCount,
    @JsonKey(name: 'total_cents') @MoneyNullableConverter() final Money? total,
    final String? note,
    @JsonKey(name: 'decline_reason') final String? declineReason,
    @JsonKey(name: 'created_at') required final int createdAt,
    final List<RequestItem> items,
    @JsonKey(name: 'conversation_id') final String? conversationId,
    @JsonKey(name: 'preferred_date') final String? preferredDate,
    @JsonKey(name: 'time_slot') final String? timeSlot,
    final String? description,
    @JsonKey(name: 'date_range') final String? dateRange,
    @JsonKey(name: 'guest_count') final int? guestCount,
    @JsonKey(name: 'service_location') final String? serviceLocation,
  }) = _$BizRequestImpl;

  factory _BizRequest.fromJson(Map<String, dynamic> json) =
      _$BizRequestImpl.fromJson;

  @override
  String get id;
  @override
  RequestCustomer get customer;
  @override
  String get status;
  @override
  String get type;
  @override
  @JsonKey(name: 'items_count')
  int get itemsCount;
  @override
  @JsonKey(name: 'total_cents')
  @MoneyNullableConverter()
  Money? get total;
  @override
  String? get note;
  @override
  @JsonKey(name: 'decline_reason')
  String? get declineReason;
  @override
  @JsonKey(name: 'created_at')
  int get createdAt;
  @override
  List<RequestItem> get items;
  @override
  @JsonKey(name: 'conversation_id')
  String? get conversationId; // Archetype-specific optional fields
  @override
  @JsonKey(name: 'preferred_date')
  String? get preferredDate;
  @override
  @JsonKey(name: 'time_slot')
  String? get timeSlot;
  @override
  String? get description;
  @override
  @JsonKey(name: 'date_range')
  String? get dateRange;
  @override
  @JsonKey(name: 'guest_count')
  int? get guestCount;
  @override
  @JsonKey(name: 'service_location')
  String? get serviceLocation;

  /// Create a copy of BizRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BizRequestImplCopyWith<_$BizRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RequestCustomer _$RequestCustomerFromJson(Map<String, dynamic> json) {
  return _RequestCustomer.fromJson(json);
}

/// @nodoc
mixin _$RequestCustomer {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;

  /// Serializes this RequestCustomer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RequestCustomer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RequestCustomerCopyWith<RequestCustomer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestCustomerCopyWith<$Res> {
  factory $RequestCustomerCopyWith(
    RequestCustomer value,
    $Res Function(RequestCustomer) then,
  ) = _$RequestCustomerCopyWithImpl<$Res, RequestCustomer>;
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    String? phone,
  });
}

/// @nodoc
class _$RequestCustomerCopyWithImpl<$Res, $Val extends RequestCustomer>
    implements $RequestCustomerCopyWith<$Res> {
  _$RequestCustomerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequestCustomer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatarUrl = freezed,
    Object? phone = freezed,
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
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RequestCustomerImplCopyWith<$Res>
    implements $RequestCustomerCopyWith<$Res> {
  factory _$$RequestCustomerImplCopyWith(
    _$RequestCustomerImpl value,
    $Res Function(_$RequestCustomerImpl) then,
  ) = __$$RequestCustomerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    String? phone,
  });
}

/// @nodoc
class __$$RequestCustomerImplCopyWithImpl<$Res>
    extends _$RequestCustomerCopyWithImpl<$Res, _$RequestCustomerImpl>
    implements _$$RequestCustomerImplCopyWith<$Res> {
  __$$RequestCustomerImplCopyWithImpl(
    _$RequestCustomerImpl _value,
    $Res Function(_$RequestCustomerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestCustomer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatarUrl = freezed,
    Object? phone = freezed,
  }) {
    return _then(
      _$RequestCustomerImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestCustomerImpl implements _RequestCustomer {
  const _$RequestCustomerImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    this.phone,
  });

  factory _$RequestCustomerImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestCustomerImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  final String? phone;

  @override
  String toString() {
    return 'RequestCustomer(id: $id, name: $name, avatarUrl: $avatarUrl, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestCustomerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, avatarUrl, phone);

  /// Create a copy of RequestCustomer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestCustomerImplCopyWith<_$RequestCustomerImpl> get copyWith =>
      __$$RequestCustomerImplCopyWithImpl<_$RequestCustomerImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestCustomerImplToJson(this);
  }
}

abstract class _RequestCustomer implements RequestCustomer {
  const factory _RequestCustomer({
    required final String id,
    required final String name,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    final String? phone,
  }) = _$RequestCustomerImpl;

  factory _RequestCustomer.fromJson(Map<String, dynamic> json) =
      _$RequestCustomerImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  String? get phone;

  /// Create a copy of RequestCustomer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestCustomerImplCopyWith<_$RequestCustomerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RequestItem _$RequestItemFromJson(Map<String, dynamic> json) {
  return _RequestItem.fromJson(json);
}

/// @nodoc
mixin _$RequestItem {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_cents')
  @MoneyNullableConverter()
  Money? get price => throw _privateConstructorUsedError;
  String? get variation => throw _privateConstructorUsedError;

  /// Serializes this RequestItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RequestItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RequestItemCopyWith<RequestItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestItemCopyWith<$Res> {
  factory $RequestItemCopyWith(
    RequestItem value,
    $Res Function(RequestItem) then,
  ) = _$RequestItemCopyWithImpl<$Res, RequestItem>;
  @useResult
  $Res call({
    String id,
    String name,
    int quantity,
    @JsonKey(name: 'price_cents') @MoneyNullableConverter() Money? price,
    String? variation,
  });
}

/// @nodoc
class _$RequestItemCopyWithImpl<$Res, $Val extends RequestItem>
    implements $RequestItemCopyWith<$Res> {
  _$RequestItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequestItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? quantity = null,
    Object? price = freezed,
    Object? variation = freezed,
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
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as Money?,
            variation: freezed == variation
                ? _value.variation
                : variation // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RequestItemImplCopyWith<$Res>
    implements $RequestItemCopyWith<$Res> {
  factory _$$RequestItemImplCopyWith(
    _$RequestItemImpl value,
    $Res Function(_$RequestItemImpl) then,
  ) = __$$RequestItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    int quantity,
    @JsonKey(name: 'price_cents') @MoneyNullableConverter() Money? price,
    String? variation,
  });
}

/// @nodoc
class __$$RequestItemImplCopyWithImpl<$Res>
    extends _$RequestItemCopyWithImpl<$Res, _$RequestItemImpl>
    implements _$$RequestItemImplCopyWith<$Res> {
  __$$RequestItemImplCopyWithImpl(
    _$RequestItemImpl _value,
    $Res Function(_$RequestItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? quantity = null,
    Object? price = freezed,
    Object? variation = freezed,
  }) {
    return _then(
      _$RequestItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as Money?,
        variation: freezed == variation
            ? _value.variation
            : variation // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestItemImpl implements _RequestItem {
  const _$RequestItemImpl({
    required this.id,
    required this.name,
    this.quantity = 1,
    @JsonKey(name: 'price_cents') @MoneyNullableConverter() this.price,
    this.variation,
  });

  factory _$RequestItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestItemImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey(name: 'price_cents')
  @MoneyNullableConverter()
  final Money? price;
  @override
  final String? variation;

  @override
  String toString() {
    return 'RequestItem(id: $id, name: $name, quantity: $quantity, price: $price, variation: $variation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.variation, variation) ||
                other.variation == variation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, quantity, price, variation);

  /// Create a copy of RequestItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestItemImplCopyWith<_$RequestItemImpl> get copyWith =>
      __$$RequestItemImplCopyWithImpl<_$RequestItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestItemImplToJson(this);
  }
}

abstract class _RequestItem implements RequestItem {
  const factory _RequestItem({
    required final String id,
    required final String name,
    final int quantity,
    @JsonKey(name: 'price_cents') @MoneyNullableConverter() final Money? price,
    final String? variation,
  }) = _$RequestItemImpl;

  factory _RequestItem.fromJson(Map<String, dynamic> json) =
      _$RequestItemImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get quantity;
  @override
  @JsonKey(name: 'price_cents')
  @MoneyNullableConverter()
  Money? get price;
  @override
  String? get variation;

  /// Create a copy of RequestItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestItemImplCopyWith<_$RequestItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
