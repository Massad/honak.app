// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CustomerRequest _$CustomerRequestFromJson(Map<String, dynamic> json) {
  return _CustomerRequest.fromJson(json);
}

/// @nodoc
mixin _$CustomerRequest {
  String get id => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // order | booking | quote | inquiry | reservation
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_page_id')
  String get businessPageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_name')
  String get businessName => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_avatar_url')
  String? get businessAvatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_slug')
  String? get businessSlug => throw _privateConstructorUsedError;
  List<OrderLineItem> get items => throw _privateConstructorUsedError;
  @JsonKey(name: 'items_count')
  int get itemsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_cents')
  @MoneyNullableConverter()
  Money? get total => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  String? get summary => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  int get createdAt => throw _privateConstructorUsedError; // Status timeline
  List<TimelineEvent> get timeline =>
      throw _privateConstructorUsedError; // Delivery tracking (for in-progress orders)
  @JsonKey(name: 'delivery_tracking')
  DeliveryTracking? get deliveryTracking => throw _privateConstructorUsedError; // Subscription payment info
  @JsonKey(name: 'paid_by_subscription')
  SubscriptionPayment? get paidBySubscription =>
      throw _privateConstructorUsedError; // Action flags
  @JsonKey(name: 'can_edit')
  bool get canEdit => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_cancel')
  bool get canCancel => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_reschedule')
  bool get canReschedule => throw _privateConstructorUsedError; // Archetype-specific optionals
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
  String? get urgency =>
      throw _privateConstructorUsedError; // not_urgent | soon | asap
  @JsonKey(name: 'team_member')
  String? get teamMember => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivery_method')
  String? get deliveryMethod => throw _privateConstructorUsedError; // delivery | pickup
  @JsonKey(name: 'delivery_address')
  String? get deliveryAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method')
  String? get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'decline_reason')
  String? get declineReason => throw _privateConstructorUsedError;

  /// Serializes this CustomerRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomerRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerRequestCopyWith<CustomerRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerRequestCopyWith<$Res> {
  factory $CustomerRequestCopyWith(
    CustomerRequest value,
    $Res Function(CustomerRequest) then,
  ) = _$CustomerRequestCopyWithImpl<$Res, CustomerRequest>;
  @useResult
  $Res call({
    String id,
    String type,
    String status,
    @JsonKey(name: 'business_page_id') String businessPageId,
    @JsonKey(name: 'business_name') String businessName,
    @JsonKey(name: 'business_avatar_url') String? businessAvatarUrl,
    @JsonKey(name: 'business_slug') String? businessSlug,
    List<OrderLineItem> items,
    @JsonKey(name: 'items_count') int itemsCount,
    @JsonKey(name: 'total_cents') @MoneyNullableConverter() Money? total,
    String? note,
    String? summary,
    @JsonKey(name: 'created_at') int createdAt,
    List<TimelineEvent> timeline,
    @JsonKey(name: 'delivery_tracking') DeliveryTracking? deliveryTracking,
    @JsonKey(name: 'paid_by_subscription')
    SubscriptionPayment? paidBySubscription,
    @JsonKey(name: 'can_edit') bool canEdit,
    @JsonKey(name: 'can_cancel') bool canCancel,
    @JsonKey(name: 'can_reschedule') bool canReschedule,
    @JsonKey(name: 'preferred_date') String? preferredDate,
    @JsonKey(name: 'time_slot') String? timeSlot,
    String? description,
    @JsonKey(name: 'date_range') String? dateRange,
    @JsonKey(name: 'guest_count') int? guestCount,
    @JsonKey(name: 'service_location') String? serviceLocation,
    String? urgency,
    @JsonKey(name: 'team_member') String? teamMember,
    @JsonKey(name: 'delivery_method') String? deliveryMethod,
    @JsonKey(name: 'delivery_address') String? deliveryAddress,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'decline_reason') String? declineReason,
  });

  $DeliveryTrackingCopyWith<$Res>? get deliveryTracking;
  $SubscriptionPaymentCopyWith<$Res>? get paidBySubscription;
}

/// @nodoc
class _$CustomerRequestCopyWithImpl<$Res, $Val extends CustomerRequest>
    implements $CustomerRequestCopyWith<$Res> {
  _$CustomerRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? businessPageId = null,
    Object? businessName = null,
    Object? businessAvatarUrl = freezed,
    Object? businessSlug = freezed,
    Object? items = null,
    Object? itemsCount = null,
    Object? total = freezed,
    Object? note = freezed,
    Object? summary = freezed,
    Object? createdAt = null,
    Object? timeline = null,
    Object? deliveryTracking = freezed,
    Object? paidBySubscription = freezed,
    Object? canEdit = null,
    Object? canCancel = null,
    Object? canReschedule = null,
    Object? preferredDate = freezed,
    Object? timeSlot = freezed,
    Object? description = freezed,
    Object? dateRange = freezed,
    Object? guestCount = freezed,
    Object? serviceLocation = freezed,
    Object? urgency = freezed,
    Object? teamMember = freezed,
    Object? deliveryMethod = freezed,
    Object? deliveryAddress = freezed,
    Object? paymentMethod = freezed,
    Object? declineReason = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            businessPageId: null == businessPageId
                ? _value.businessPageId
                : businessPageId // ignore: cast_nullable_to_non_nullable
                      as String,
            businessName: null == businessName
                ? _value.businessName
                : businessName // ignore: cast_nullable_to_non_nullable
                      as String,
            businessAvatarUrl: freezed == businessAvatarUrl
                ? _value.businessAvatarUrl
                : businessAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            businessSlug: freezed == businessSlug
                ? _value.businessSlug
                : businessSlug // ignore: cast_nullable_to_non_nullable
                      as String?,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<OrderLineItem>,
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
            summary: freezed == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as int,
            timeline: null == timeline
                ? _value.timeline
                : timeline // ignore: cast_nullable_to_non_nullable
                      as List<TimelineEvent>,
            deliveryTracking: freezed == deliveryTracking
                ? _value.deliveryTracking
                : deliveryTracking // ignore: cast_nullable_to_non_nullable
                      as DeliveryTracking?,
            paidBySubscription: freezed == paidBySubscription
                ? _value.paidBySubscription
                : paidBySubscription // ignore: cast_nullable_to_non_nullable
                      as SubscriptionPayment?,
            canEdit: null == canEdit
                ? _value.canEdit
                : canEdit // ignore: cast_nullable_to_non_nullable
                      as bool,
            canCancel: null == canCancel
                ? _value.canCancel
                : canCancel // ignore: cast_nullable_to_non_nullable
                      as bool,
            canReschedule: null == canReschedule
                ? _value.canReschedule
                : canReschedule // ignore: cast_nullable_to_non_nullable
                      as bool,
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
            urgency: freezed == urgency
                ? _value.urgency
                : urgency // ignore: cast_nullable_to_non_nullable
                      as String?,
            teamMember: freezed == teamMember
                ? _value.teamMember
                : teamMember // ignore: cast_nullable_to_non_nullable
                      as String?,
            deliveryMethod: freezed == deliveryMethod
                ? _value.deliveryMethod
                : deliveryMethod // ignore: cast_nullable_to_non_nullable
                      as String?,
            deliveryAddress: freezed == deliveryAddress
                ? _value.deliveryAddress
                : deliveryAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            paymentMethod: freezed == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as String?,
            declineReason: freezed == declineReason
                ? _value.declineReason
                : declineReason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of CustomerRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeliveryTrackingCopyWith<$Res>? get deliveryTracking {
    if (_value.deliveryTracking == null) {
      return null;
    }

    return $DeliveryTrackingCopyWith<$Res>(_value.deliveryTracking!, (value) {
      return _then(_value.copyWith(deliveryTracking: value) as $Val);
    });
  }

  /// Create a copy of CustomerRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionPaymentCopyWith<$Res>? get paidBySubscription {
    if (_value.paidBySubscription == null) {
      return null;
    }

    return $SubscriptionPaymentCopyWith<$Res>(_value.paidBySubscription!, (
      value,
    ) {
      return _then(_value.copyWith(paidBySubscription: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CustomerRequestImplCopyWith<$Res>
    implements $CustomerRequestCopyWith<$Res> {
  factory _$$CustomerRequestImplCopyWith(
    _$CustomerRequestImpl value,
    $Res Function(_$CustomerRequestImpl) then,
  ) = __$$CustomerRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    String status,
    @JsonKey(name: 'business_page_id') String businessPageId,
    @JsonKey(name: 'business_name') String businessName,
    @JsonKey(name: 'business_avatar_url') String? businessAvatarUrl,
    @JsonKey(name: 'business_slug') String? businessSlug,
    List<OrderLineItem> items,
    @JsonKey(name: 'items_count') int itemsCount,
    @JsonKey(name: 'total_cents') @MoneyNullableConverter() Money? total,
    String? note,
    String? summary,
    @JsonKey(name: 'created_at') int createdAt,
    List<TimelineEvent> timeline,
    @JsonKey(name: 'delivery_tracking') DeliveryTracking? deliveryTracking,
    @JsonKey(name: 'paid_by_subscription')
    SubscriptionPayment? paidBySubscription,
    @JsonKey(name: 'can_edit') bool canEdit,
    @JsonKey(name: 'can_cancel') bool canCancel,
    @JsonKey(name: 'can_reschedule') bool canReschedule,
    @JsonKey(name: 'preferred_date') String? preferredDate,
    @JsonKey(name: 'time_slot') String? timeSlot,
    String? description,
    @JsonKey(name: 'date_range') String? dateRange,
    @JsonKey(name: 'guest_count') int? guestCount,
    @JsonKey(name: 'service_location') String? serviceLocation,
    String? urgency,
    @JsonKey(name: 'team_member') String? teamMember,
    @JsonKey(name: 'delivery_method') String? deliveryMethod,
    @JsonKey(name: 'delivery_address') String? deliveryAddress,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'decline_reason') String? declineReason,
  });

  @override
  $DeliveryTrackingCopyWith<$Res>? get deliveryTracking;
  @override
  $SubscriptionPaymentCopyWith<$Res>? get paidBySubscription;
}

/// @nodoc
class __$$CustomerRequestImplCopyWithImpl<$Res>
    extends _$CustomerRequestCopyWithImpl<$Res, _$CustomerRequestImpl>
    implements _$$CustomerRequestImplCopyWith<$Res> {
  __$$CustomerRequestImplCopyWithImpl(
    _$CustomerRequestImpl _value,
    $Res Function(_$CustomerRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CustomerRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? businessPageId = null,
    Object? businessName = null,
    Object? businessAvatarUrl = freezed,
    Object? businessSlug = freezed,
    Object? items = null,
    Object? itemsCount = null,
    Object? total = freezed,
    Object? note = freezed,
    Object? summary = freezed,
    Object? createdAt = null,
    Object? timeline = null,
    Object? deliveryTracking = freezed,
    Object? paidBySubscription = freezed,
    Object? canEdit = null,
    Object? canCancel = null,
    Object? canReschedule = null,
    Object? preferredDate = freezed,
    Object? timeSlot = freezed,
    Object? description = freezed,
    Object? dateRange = freezed,
    Object? guestCount = freezed,
    Object? serviceLocation = freezed,
    Object? urgency = freezed,
    Object? teamMember = freezed,
    Object? deliveryMethod = freezed,
    Object? deliveryAddress = freezed,
    Object? paymentMethod = freezed,
    Object? declineReason = freezed,
  }) {
    return _then(
      _$CustomerRequestImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        businessPageId: null == businessPageId
            ? _value.businessPageId
            : businessPageId // ignore: cast_nullable_to_non_nullable
                  as String,
        businessName: null == businessName
            ? _value.businessName
            : businessName // ignore: cast_nullable_to_non_nullable
                  as String,
        businessAvatarUrl: freezed == businessAvatarUrl
            ? _value.businessAvatarUrl
            : businessAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        businessSlug: freezed == businessSlug
            ? _value.businessSlug
            : businessSlug // ignore: cast_nullable_to_non_nullable
                  as String?,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<OrderLineItem>,
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
        summary: freezed == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as int,
        timeline: null == timeline
            ? _value._timeline
            : timeline // ignore: cast_nullable_to_non_nullable
                  as List<TimelineEvent>,
        deliveryTracking: freezed == deliveryTracking
            ? _value.deliveryTracking
            : deliveryTracking // ignore: cast_nullable_to_non_nullable
                  as DeliveryTracking?,
        paidBySubscription: freezed == paidBySubscription
            ? _value.paidBySubscription
            : paidBySubscription // ignore: cast_nullable_to_non_nullable
                  as SubscriptionPayment?,
        canEdit: null == canEdit
            ? _value.canEdit
            : canEdit // ignore: cast_nullable_to_non_nullable
                  as bool,
        canCancel: null == canCancel
            ? _value.canCancel
            : canCancel // ignore: cast_nullable_to_non_nullable
                  as bool,
        canReschedule: null == canReschedule
            ? _value.canReschedule
            : canReschedule // ignore: cast_nullable_to_non_nullable
                  as bool,
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
        urgency: freezed == urgency
            ? _value.urgency
            : urgency // ignore: cast_nullable_to_non_nullable
                  as String?,
        teamMember: freezed == teamMember
            ? _value.teamMember
            : teamMember // ignore: cast_nullable_to_non_nullable
                  as String?,
        deliveryMethod: freezed == deliveryMethod
            ? _value.deliveryMethod
            : deliveryMethod // ignore: cast_nullable_to_non_nullable
                  as String?,
        deliveryAddress: freezed == deliveryAddress
            ? _value.deliveryAddress
            : deliveryAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        paymentMethod: freezed == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as String?,
        declineReason: freezed == declineReason
            ? _value.declineReason
            : declineReason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerRequestImpl extends _CustomerRequest {
  const _$CustomerRequestImpl({
    required this.id,
    required this.type,
    required this.status,
    @JsonKey(name: 'business_page_id') required this.businessPageId,
    @JsonKey(name: 'business_name') required this.businessName,
    @JsonKey(name: 'business_avatar_url') this.businessAvatarUrl,
    @JsonKey(name: 'business_slug') this.businessSlug,
    final List<OrderLineItem> items = const [],
    @JsonKey(name: 'items_count') this.itemsCount = 0,
    @JsonKey(name: 'total_cents') @MoneyNullableConverter() this.total,
    this.note,
    this.summary,
    @JsonKey(name: 'created_at') required this.createdAt,
    final List<TimelineEvent> timeline = const [],
    @JsonKey(name: 'delivery_tracking') this.deliveryTracking,
    @JsonKey(name: 'paid_by_subscription') this.paidBySubscription,
    @JsonKey(name: 'can_edit') this.canEdit = false,
    @JsonKey(name: 'can_cancel') this.canCancel = false,
    @JsonKey(name: 'can_reschedule') this.canReschedule = false,
    @JsonKey(name: 'preferred_date') this.preferredDate,
    @JsonKey(name: 'time_slot') this.timeSlot,
    this.description,
    @JsonKey(name: 'date_range') this.dateRange,
    @JsonKey(name: 'guest_count') this.guestCount,
    @JsonKey(name: 'service_location') this.serviceLocation,
    this.urgency,
    @JsonKey(name: 'team_member') this.teamMember,
    @JsonKey(name: 'delivery_method') this.deliveryMethod,
    @JsonKey(name: 'delivery_address') this.deliveryAddress,
    @JsonKey(name: 'payment_method') this.paymentMethod,
    @JsonKey(name: 'decline_reason') this.declineReason,
  }) : _items = items,
       _timeline = timeline,
       super._();

  factory _$CustomerRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerRequestImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  // order | booking | quote | inquiry | reservation
  @override
  final String status;
  @override
  @JsonKey(name: 'business_page_id')
  final String businessPageId;
  @override
  @JsonKey(name: 'business_name')
  final String businessName;
  @override
  @JsonKey(name: 'business_avatar_url')
  final String? businessAvatarUrl;
  @override
  @JsonKey(name: 'business_slug')
  final String? businessSlug;
  final List<OrderLineItem> _items;
  @override
  @JsonKey()
  List<OrderLineItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

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
  final String? summary;
  @override
  @JsonKey(name: 'created_at')
  final int createdAt;
  // Status timeline
  final List<TimelineEvent> _timeline;
  // Status timeline
  @override
  @JsonKey()
  List<TimelineEvent> get timeline {
    if (_timeline is EqualUnmodifiableListView) return _timeline;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeline);
  }

  // Delivery tracking (for in-progress orders)
  @override
  @JsonKey(name: 'delivery_tracking')
  final DeliveryTracking? deliveryTracking;
  // Subscription payment info
  @override
  @JsonKey(name: 'paid_by_subscription')
  final SubscriptionPayment? paidBySubscription;
  // Action flags
  @override
  @JsonKey(name: 'can_edit')
  final bool canEdit;
  @override
  @JsonKey(name: 'can_cancel')
  final bool canCancel;
  @override
  @JsonKey(name: 'can_reschedule')
  final bool canReschedule;
  // Archetype-specific optionals
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
  final String? urgency;
  // not_urgent | soon | asap
  @override
  @JsonKey(name: 'team_member')
  final String? teamMember;
  @override
  @JsonKey(name: 'delivery_method')
  final String? deliveryMethod;
  // delivery | pickup
  @override
  @JsonKey(name: 'delivery_address')
  final String? deliveryAddress;
  @override
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @override
  @JsonKey(name: 'decline_reason')
  final String? declineReason;

  @override
  String toString() {
    return 'CustomerRequest(id: $id, type: $type, status: $status, businessPageId: $businessPageId, businessName: $businessName, businessAvatarUrl: $businessAvatarUrl, businessSlug: $businessSlug, items: $items, itemsCount: $itemsCount, total: $total, note: $note, summary: $summary, createdAt: $createdAt, timeline: $timeline, deliveryTracking: $deliveryTracking, paidBySubscription: $paidBySubscription, canEdit: $canEdit, canCancel: $canCancel, canReschedule: $canReschedule, preferredDate: $preferredDate, timeSlot: $timeSlot, description: $description, dateRange: $dateRange, guestCount: $guestCount, serviceLocation: $serviceLocation, urgency: $urgency, teamMember: $teamMember, deliveryMethod: $deliveryMethod, deliveryAddress: $deliveryAddress, paymentMethod: $paymentMethod, declineReason: $declineReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.businessPageId, businessPageId) ||
                other.businessPageId == businessPageId) &&
            (identical(other.businessName, businessName) ||
                other.businessName == businessName) &&
            (identical(other.businessAvatarUrl, businessAvatarUrl) ||
                other.businessAvatarUrl == businessAvatarUrl) &&
            (identical(other.businessSlug, businessSlug) ||
                other.businessSlug == businessSlug) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.itemsCount, itemsCount) ||
                other.itemsCount == itemsCount) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._timeline, _timeline) &&
            (identical(other.deliveryTracking, deliveryTracking) ||
                other.deliveryTracking == deliveryTracking) &&
            (identical(other.paidBySubscription, paidBySubscription) ||
                other.paidBySubscription == paidBySubscription) &&
            (identical(other.canEdit, canEdit) || other.canEdit == canEdit) &&
            (identical(other.canCancel, canCancel) ||
                other.canCancel == canCancel) &&
            (identical(other.canReschedule, canReschedule) ||
                other.canReschedule == canReschedule) &&
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
                other.serviceLocation == serviceLocation) &&
            (identical(other.urgency, urgency) || other.urgency == urgency) &&
            (identical(other.teamMember, teamMember) ||
                other.teamMember == teamMember) &&
            (identical(other.deliveryMethod, deliveryMethod) ||
                other.deliveryMethod == deliveryMethod) &&
            (identical(other.deliveryAddress, deliveryAddress) ||
                other.deliveryAddress == deliveryAddress) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.declineReason, declineReason) ||
                other.declineReason == declineReason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    type,
    status,
    businessPageId,
    businessName,
    businessAvatarUrl,
    businessSlug,
    const DeepCollectionEquality().hash(_items),
    itemsCount,
    total,
    note,
    summary,
    createdAt,
    const DeepCollectionEquality().hash(_timeline),
    deliveryTracking,
    paidBySubscription,
    canEdit,
    canCancel,
    canReschedule,
    preferredDate,
    timeSlot,
    description,
    dateRange,
    guestCount,
    serviceLocation,
    urgency,
    teamMember,
    deliveryMethod,
    deliveryAddress,
    paymentMethod,
    declineReason,
  ]);

  /// Create a copy of CustomerRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerRequestImplCopyWith<_$CustomerRequestImpl> get copyWith =>
      __$$CustomerRequestImplCopyWithImpl<_$CustomerRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerRequestImplToJson(this);
  }
}

abstract class _CustomerRequest extends CustomerRequest {
  const factory _CustomerRequest({
    required final String id,
    required final String type,
    required final String status,
    @JsonKey(name: 'business_page_id') required final String businessPageId,
    @JsonKey(name: 'business_name') required final String businessName,
    @JsonKey(name: 'business_avatar_url') final String? businessAvatarUrl,
    @JsonKey(name: 'business_slug') final String? businessSlug,
    final List<OrderLineItem> items,
    @JsonKey(name: 'items_count') final int itemsCount,
    @JsonKey(name: 'total_cents') @MoneyNullableConverter() final Money? total,
    final String? note,
    final String? summary,
    @JsonKey(name: 'created_at') required final int createdAt,
    final List<TimelineEvent> timeline,
    @JsonKey(name: 'delivery_tracking')
    final DeliveryTracking? deliveryTracking,
    @JsonKey(name: 'paid_by_subscription')
    final SubscriptionPayment? paidBySubscription,
    @JsonKey(name: 'can_edit') final bool canEdit,
    @JsonKey(name: 'can_cancel') final bool canCancel,
    @JsonKey(name: 'can_reschedule') final bool canReschedule,
    @JsonKey(name: 'preferred_date') final String? preferredDate,
    @JsonKey(name: 'time_slot') final String? timeSlot,
    final String? description,
    @JsonKey(name: 'date_range') final String? dateRange,
    @JsonKey(name: 'guest_count') final int? guestCount,
    @JsonKey(name: 'service_location') final String? serviceLocation,
    final String? urgency,
    @JsonKey(name: 'team_member') final String? teamMember,
    @JsonKey(name: 'delivery_method') final String? deliveryMethod,
    @JsonKey(name: 'delivery_address') final String? deliveryAddress,
    @JsonKey(name: 'payment_method') final String? paymentMethod,
    @JsonKey(name: 'decline_reason') final String? declineReason,
  }) = _$CustomerRequestImpl;
  const _CustomerRequest._() : super._();

  factory _CustomerRequest.fromJson(Map<String, dynamic> json) =
      _$CustomerRequestImpl.fromJson;

  @override
  String get id;
  @override
  String get type; // order | booking | quote | inquiry | reservation
  @override
  String get status;
  @override
  @JsonKey(name: 'business_page_id')
  String get businessPageId;
  @override
  @JsonKey(name: 'business_name')
  String get businessName;
  @override
  @JsonKey(name: 'business_avatar_url')
  String? get businessAvatarUrl;
  @override
  @JsonKey(name: 'business_slug')
  String? get businessSlug;
  @override
  List<OrderLineItem> get items;
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
  String? get summary;
  @override
  @JsonKey(name: 'created_at')
  int get createdAt; // Status timeline
  @override
  List<TimelineEvent> get timeline; // Delivery tracking (for in-progress orders)
  @override
  @JsonKey(name: 'delivery_tracking')
  DeliveryTracking? get deliveryTracking; // Subscription payment info
  @override
  @JsonKey(name: 'paid_by_subscription')
  SubscriptionPayment? get paidBySubscription; // Action flags
  @override
  @JsonKey(name: 'can_edit')
  bool get canEdit;
  @override
  @JsonKey(name: 'can_cancel')
  bool get canCancel;
  @override
  @JsonKey(name: 'can_reschedule')
  bool get canReschedule; // Archetype-specific optionals
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
  @override
  String? get urgency; // not_urgent | soon | asap
  @override
  @JsonKey(name: 'team_member')
  String? get teamMember;
  @override
  @JsonKey(name: 'delivery_method')
  String? get deliveryMethod; // delivery | pickup
  @override
  @JsonKey(name: 'delivery_address')
  String? get deliveryAddress;
  @override
  @JsonKey(name: 'payment_method')
  String? get paymentMethod;
  @override
  @JsonKey(name: 'decline_reason')
  String? get declineReason;

  /// Create a copy of CustomerRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerRequestImplCopyWith<_$CustomerRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderLineItem _$OrderLineItemFromJson(Map<String, dynamic> json) {
  return _OrderLineItem.fromJson(json);
}

/// @nodoc
mixin _$OrderLineItem {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_cents')
  @MoneyNullableConverter()
  Money? get price => throw _privateConstructorUsedError;
  String? get variation => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this OrderLineItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderLineItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderLineItemCopyWith<OrderLineItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderLineItemCopyWith<$Res> {
  factory $OrderLineItemCopyWith(
    OrderLineItem value,
    $Res Function(OrderLineItem) then,
  ) = _$OrderLineItemCopyWithImpl<$Res, OrderLineItem>;
  @useResult
  $Res call({
    String id,
    String name,
    int quantity,
    @JsonKey(name: 'price_cents') @MoneyNullableConverter() Money? price,
    String? variation,
    @JsonKey(name: 'image_url') String? imageUrl,
  });
}

/// @nodoc
class _$OrderLineItemCopyWithImpl<$Res, $Val extends OrderLineItem>
    implements $OrderLineItemCopyWith<$Res> {
  _$OrderLineItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderLineItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? quantity = null,
    Object? price = freezed,
    Object? variation = freezed,
    Object? imageUrl = freezed,
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
abstract class _$$OrderLineItemImplCopyWith<$Res>
    implements $OrderLineItemCopyWith<$Res> {
  factory _$$OrderLineItemImplCopyWith(
    _$OrderLineItemImpl value,
    $Res Function(_$OrderLineItemImpl) then,
  ) = __$$OrderLineItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    int quantity,
    @JsonKey(name: 'price_cents') @MoneyNullableConverter() Money? price,
    String? variation,
    @JsonKey(name: 'image_url') String? imageUrl,
  });
}

/// @nodoc
class __$$OrderLineItemImplCopyWithImpl<$Res>
    extends _$OrderLineItemCopyWithImpl<$Res, _$OrderLineItemImpl>
    implements _$$OrderLineItemImplCopyWith<$Res> {
  __$$OrderLineItemImplCopyWithImpl(
    _$OrderLineItemImpl _value,
    $Res Function(_$OrderLineItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderLineItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? quantity = null,
    Object? price = freezed,
    Object? variation = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$OrderLineItemImpl(
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
class _$OrderLineItemImpl implements _OrderLineItem {
  const _$OrderLineItemImpl({
    required this.id,
    required this.name,
    this.quantity = 1,
    @JsonKey(name: 'price_cents') @MoneyNullableConverter() this.price,
    this.variation,
    @JsonKey(name: 'image_url') this.imageUrl,
  });

  factory _$OrderLineItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderLineItemImplFromJson(json);

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
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @override
  String toString() {
    return 'OrderLineItem(id: $id, name: $name, quantity: $quantity, price: $price, variation: $variation, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderLineItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.variation, variation) ||
                other.variation == variation) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, quantity, price, variation, imageUrl);

  /// Create a copy of OrderLineItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderLineItemImplCopyWith<_$OrderLineItemImpl> get copyWith =>
      __$$OrderLineItemImplCopyWithImpl<_$OrderLineItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderLineItemImplToJson(this);
  }
}

abstract class _OrderLineItem implements OrderLineItem {
  const factory _OrderLineItem({
    required final String id,
    required final String name,
    final int quantity,
    @JsonKey(name: 'price_cents') @MoneyNullableConverter() final Money? price,
    final String? variation,
    @JsonKey(name: 'image_url') final String? imageUrl,
  }) = _$OrderLineItemImpl;

  factory _OrderLineItem.fromJson(Map<String, dynamic> json) =
      _$OrderLineItemImpl.fromJson;

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
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;

  /// Create a copy of OrderLineItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderLineItemImplCopyWith<_$OrderLineItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimelineEvent _$TimelineEventFromJson(Map<String, dynamic> json) {
  return _TimelineEvent.fromJson(json);
}

/// @nodoc
mixin _$TimelineEvent {
  String get status => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  String get actor =>
      throw _privateConstructorUsedError; // customer | business | system
  String? get detail => throw _privateConstructorUsedError;
  bool get done => throw _privateConstructorUsedError;

  /// Serializes this TimelineEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimelineEventCopyWith<TimelineEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelineEventCopyWith<$Res> {
  factory $TimelineEventCopyWith(
    TimelineEvent value,
    $Res Function(TimelineEvent) then,
  ) = _$TimelineEventCopyWithImpl<$Res, TimelineEvent>;
  @useResult
  $Res call({
    String status,
    String label,
    int timestamp,
    String actor,
    String? detail,
    bool done,
  });
}

/// @nodoc
class _$TimelineEventCopyWithImpl<$Res, $Val extends TimelineEvent>
    implements $TimelineEventCopyWith<$Res> {
  _$TimelineEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? label = null,
    Object? timestamp = null,
    Object? actor = null,
    Object? detail = freezed,
    Object? done = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as int,
            actor: null == actor
                ? _value.actor
                : actor // ignore: cast_nullable_to_non_nullable
                      as String,
            detail: freezed == detail
                ? _value.detail
                : detail // ignore: cast_nullable_to_non_nullable
                      as String?,
            done: null == done
                ? _value.done
                : done // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimelineEventImplCopyWith<$Res>
    implements $TimelineEventCopyWith<$Res> {
  factory _$$TimelineEventImplCopyWith(
    _$TimelineEventImpl value,
    $Res Function(_$TimelineEventImpl) then,
  ) = __$$TimelineEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String status,
    String label,
    int timestamp,
    String actor,
    String? detail,
    bool done,
  });
}

/// @nodoc
class __$$TimelineEventImplCopyWithImpl<$Res>
    extends _$TimelineEventCopyWithImpl<$Res, _$TimelineEventImpl>
    implements _$$TimelineEventImplCopyWith<$Res> {
  __$$TimelineEventImplCopyWithImpl(
    _$TimelineEventImpl _value,
    $Res Function(_$TimelineEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? label = null,
    Object? timestamp = null,
    Object? actor = null,
    Object? detail = freezed,
    Object? done = null,
  }) {
    return _then(
      _$TimelineEventImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as int,
        actor: null == actor
            ? _value.actor
            : actor // ignore: cast_nullable_to_non_nullable
                  as String,
        detail: freezed == detail
            ? _value.detail
            : detail // ignore: cast_nullable_to_non_nullable
                  as String?,
        done: null == done
            ? _value.done
            : done // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TimelineEventImpl implements _TimelineEvent {
  const _$TimelineEventImpl({
    required this.status,
    required this.label,
    required this.timestamp,
    this.actor = 'system',
    this.detail,
    this.done = false,
  });

  factory _$TimelineEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimelineEventImplFromJson(json);

  @override
  final String status;
  @override
  final String label;
  @override
  final int timestamp;
  @override
  @JsonKey()
  final String actor;
  // customer | business | system
  @override
  final String? detail;
  @override
  @JsonKey()
  final bool done;

  @override
  String toString() {
    return 'TimelineEvent(status: $status, label: $label, timestamp: $timestamp, actor: $actor, detail: $detail, done: $done)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimelineEventImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.actor, actor) || other.actor == actor) &&
            (identical(other.detail, detail) || other.detail == detail) &&
            (identical(other.done, done) || other.done == done));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, status, label, timestamp, actor, detail, done);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimelineEventImplCopyWith<_$TimelineEventImpl> get copyWith =>
      __$$TimelineEventImplCopyWithImpl<_$TimelineEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimelineEventImplToJson(this);
  }
}

abstract class _TimelineEvent implements TimelineEvent {
  const factory _TimelineEvent({
    required final String status,
    required final String label,
    required final int timestamp,
    final String actor,
    final String? detail,
    final bool done,
  }) = _$TimelineEventImpl;

  factory _TimelineEvent.fromJson(Map<String, dynamic> json) =
      _$TimelineEventImpl.fromJson;

  @override
  String get status;
  @override
  String get label;
  @override
  int get timestamp;
  @override
  String get actor; // customer | business | system
  @override
  String? get detail;
  @override
  bool get done;

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimelineEventImplCopyWith<_$TimelineEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeliveryTracking _$DeliveryTrackingFromJson(Map<String, dynamic> json) {
  return _DeliveryTracking.fromJson(json);
}

/// @nodoc
mixin _$DeliveryTracking {
  String get status =>
      throw _privateConstructorUsedError; // dispatched | en_route | arriving | delivered
  @JsonKey(name: 'estimated_minutes')
  int? get estimatedMinutes => throw _privateConstructorUsedError;
  @JsonKey(name: 'driver_name')
  String? get driverName => throw _privateConstructorUsedError;
  @JsonKey(name: 'driver_phone')
  String? get driverPhone => throw _privateConstructorUsedError;

  /// Serializes this DeliveryTracking to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeliveryTracking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeliveryTrackingCopyWith<DeliveryTracking> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeliveryTrackingCopyWith<$Res> {
  factory $DeliveryTrackingCopyWith(
    DeliveryTracking value,
    $Res Function(DeliveryTracking) then,
  ) = _$DeliveryTrackingCopyWithImpl<$Res, DeliveryTracking>;
  @useResult
  $Res call({
    String status,
    @JsonKey(name: 'estimated_minutes') int? estimatedMinutes,
    @JsonKey(name: 'driver_name') String? driverName,
    @JsonKey(name: 'driver_phone') String? driverPhone,
  });
}

/// @nodoc
class _$DeliveryTrackingCopyWithImpl<$Res, $Val extends DeliveryTracking>
    implements $DeliveryTrackingCopyWith<$Res> {
  _$DeliveryTrackingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeliveryTracking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? estimatedMinutes = freezed,
    Object? driverName = freezed,
    Object? driverPhone = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            estimatedMinutes: freezed == estimatedMinutes
                ? _value.estimatedMinutes
                : estimatedMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            driverName: freezed == driverName
                ? _value.driverName
                : driverName // ignore: cast_nullable_to_non_nullable
                      as String?,
            driverPhone: freezed == driverPhone
                ? _value.driverPhone
                : driverPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeliveryTrackingImplCopyWith<$Res>
    implements $DeliveryTrackingCopyWith<$Res> {
  factory _$$DeliveryTrackingImplCopyWith(
    _$DeliveryTrackingImpl value,
    $Res Function(_$DeliveryTrackingImpl) then,
  ) = __$$DeliveryTrackingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String status,
    @JsonKey(name: 'estimated_minutes') int? estimatedMinutes,
    @JsonKey(name: 'driver_name') String? driverName,
    @JsonKey(name: 'driver_phone') String? driverPhone,
  });
}

/// @nodoc
class __$$DeliveryTrackingImplCopyWithImpl<$Res>
    extends _$DeliveryTrackingCopyWithImpl<$Res, _$DeliveryTrackingImpl>
    implements _$$DeliveryTrackingImplCopyWith<$Res> {
  __$$DeliveryTrackingImplCopyWithImpl(
    _$DeliveryTrackingImpl _value,
    $Res Function(_$DeliveryTrackingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeliveryTracking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? estimatedMinutes = freezed,
    Object? driverName = freezed,
    Object? driverPhone = freezed,
  }) {
    return _then(
      _$DeliveryTrackingImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        estimatedMinutes: freezed == estimatedMinutes
            ? _value.estimatedMinutes
            : estimatedMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        driverName: freezed == driverName
            ? _value.driverName
            : driverName // ignore: cast_nullable_to_non_nullable
                  as String?,
        driverPhone: freezed == driverPhone
            ? _value.driverPhone
            : driverPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeliveryTrackingImpl implements _DeliveryTracking {
  const _$DeliveryTrackingImpl({
    required this.status,
    @JsonKey(name: 'estimated_minutes') this.estimatedMinutes,
    @JsonKey(name: 'driver_name') this.driverName,
    @JsonKey(name: 'driver_phone') this.driverPhone,
  });

  factory _$DeliveryTrackingImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeliveryTrackingImplFromJson(json);

  @override
  final String status;
  // dispatched | en_route | arriving | delivered
  @override
  @JsonKey(name: 'estimated_minutes')
  final int? estimatedMinutes;
  @override
  @JsonKey(name: 'driver_name')
  final String? driverName;
  @override
  @JsonKey(name: 'driver_phone')
  final String? driverPhone;

  @override
  String toString() {
    return 'DeliveryTracking(status: $status, estimatedMinutes: $estimatedMinutes, driverName: $driverName, driverPhone: $driverPhone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliveryTrackingImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.estimatedMinutes, estimatedMinutes) ||
                other.estimatedMinutes == estimatedMinutes) &&
            (identical(other.driverName, driverName) ||
                other.driverName == driverName) &&
            (identical(other.driverPhone, driverPhone) ||
                other.driverPhone == driverPhone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    estimatedMinutes,
    driverName,
    driverPhone,
  );

  /// Create a copy of DeliveryTracking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliveryTrackingImplCopyWith<_$DeliveryTrackingImpl> get copyWith =>
      __$$DeliveryTrackingImplCopyWithImpl<_$DeliveryTrackingImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DeliveryTrackingImplToJson(this);
  }
}

abstract class _DeliveryTracking implements DeliveryTracking {
  const factory _DeliveryTracking({
    required final String status,
    @JsonKey(name: 'estimated_minutes') final int? estimatedMinutes,
    @JsonKey(name: 'driver_name') final String? driverName,
    @JsonKey(name: 'driver_phone') final String? driverPhone,
  }) = _$DeliveryTrackingImpl;

  factory _DeliveryTracking.fromJson(Map<String, dynamic> json) =
      _$DeliveryTrackingImpl.fromJson;

  @override
  String get status; // dispatched | en_route | arriving | delivered
  @override
  @JsonKey(name: 'estimated_minutes')
  int? get estimatedMinutes;
  @override
  @JsonKey(name: 'driver_name')
  String? get driverName;
  @override
  @JsonKey(name: 'driver_phone')
  String? get driverPhone;

  /// Create a copy of DeliveryTracking
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliveryTrackingImplCopyWith<_$DeliveryTrackingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubscriptionPayment _$SubscriptionPaymentFromJson(Map<String, dynamic> json) {
  return _SubscriptionPayment.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionPayment {
  @JsonKey(name: 'subscription_id')
  String get subscriptionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'package_name')
  String get packageName => throw _privateConstructorUsedError;
  @JsonKey(name: 'credits_used')
  int get creditsUsed => throw _privateConstructorUsedError;
  @JsonKey(name: 'remaining_after')
  int? get remainingAfter => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionPayment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionPaymentCopyWith<SubscriptionPayment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionPaymentCopyWith<$Res> {
  factory $SubscriptionPaymentCopyWith(
    SubscriptionPayment value,
    $Res Function(SubscriptionPayment) then,
  ) = _$SubscriptionPaymentCopyWithImpl<$Res, SubscriptionPayment>;
  @useResult
  $Res call({
    @JsonKey(name: 'subscription_id') String subscriptionId,
    @JsonKey(name: 'package_name') String packageName,
    @JsonKey(name: 'credits_used') int creditsUsed,
    @JsonKey(name: 'remaining_after') int? remainingAfter,
  });
}

/// @nodoc
class _$SubscriptionPaymentCopyWithImpl<$Res, $Val extends SubscriptionPayment>
    implements $SubscriptionPaymentCopyWith<$Res> {
  _$SubscriptionPaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subscriptionId = null,
    Object? packageName = null,
    Object? creditsUsed = null,
    Object? remainingAfter = freezed,
  }) {
    return _then(
      _value.copyWith(
            subscriptionId: null == subscriptionId
                ? _value.subscriptionId
                : subscriptionId // ignore: cast_nullable_to_non_nullable
                      as String,
            packageName: null == packageName
                ? _value.packageName
                : packageName // ignore: cast_nullable_to_non_nullable
                      as String,
            creditsUsed: null == creditsUsed
                ? _value.creditsUsed
                : creditsUsed // ignore: cast_nullable_to_non_nullable
                      as int,
            remainingAfter: freezed == remainingAfter
                ? _value.remainingAfter
                : remainingAfter // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubscriptionPaymentImplCopyWith<$Res>
    implements $SubscriptionPaymentCopyWith<$Res> {
  factory _$$SubscriptionPaymentImplCopyWith(
    _$SubscriptionPaymentImpl value,
    $Res Function(_$SubscriptionPaymentImpl) then,
  ) = __$$SubscriptionPaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'subscription_id') String subscriptionId,
    @JsonKey(name: 'package_name') String packageName,
    @JsonKey(name: 'credits_used') int creditsUsed,
    @JsonKey(name: 'remaining_after') int? remainingAfter,
  });
}

/// @nodoc
class __$$SubscriptionPaymentImplCopyWithImpl<$Res>
    extends _$SubscriptionPaymentCopyWithImpl<$Res, _$SubscriptionPaymentImpl>
    implements _$$SubscriptionPaymentImplCopyWith<$Res> {
  __$$SubscriptionPaymentImplCopyWithImpl(
    _$SubscriptionPaymentImpl _value,
    $Res Function(_$SubscriptionPaymentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subscriptionId = null,
    Object? packageName = null,
    Object? creditsUsed = null,
    Object? remainingAfter = freezed,
  }) {
    return _then(
      _$SubscriptionPaymentImpl(
        subscriptionId: null == subscriptionId
            ? _value.subscriptionId
            : subscriptionId // ignore: cast_nullable_to_non_nullable
                  as String,
        packageName: null == packageName
            ? _value.packageName
            : packageName // ignore: cast_nullable_to_non_nullable
                  as String,
        creditsUsed: null == creditsUsed
            ? _value.creditsUsed
            : creditsUsed // ignore: cast_nullable_to_non_nullable
                  as int,
        remainingAfter: freezed == remainingAfter
            ? _value.remainingAfter
            : remainingAfter // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionPaymentImpl implements _SubscriptionPayment {
  const _$SubscriptionPaymentImpl({
    @JsonKey(name: 'subscription_id') required this.subscriptionId,
    @JsonKey(name: 'package_name') required this.packageName,
    @JsonKey(name: 'credits_used') this.creditsUsed = 1,
    @JsonKey(name: 'remaining_after') this.remainingAfter,
  });

  factory _$SubscriptionPaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionPaymentImplFromJson(json);

  @override
  @JsonKey(name: 'subscription_id')
  final String subscriptionId;
  @override
  @JsonKey(name: 'package_name')
  final String packageName;
  @override
  @JsonKey(name: 'credits_used')
  final int creditsUsed;
  @override
  @JsonKey(name: 'remaining_after')
  final int? remainingAfter;

  @override
  String toString() {
    return 'SubscriptionPayment(subscriptionId: $subscriptionId, packageName: $packageName, creditsUsed: $creditsUsed, remainingAfter: $remainingAfter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionPaymentImpl &&
            (identical(other.subscriptionId, subscriptionId) ||
                other.subscriptionId == subscriptionId) &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.creditsUsed, creditsUsed) ||
                other.creditsUsed == creditsUsed) &&
            (identical(other.remainingAfter, remainingAfter) ||
                other.remainingAfter == remainingAfter));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    subscriptionId,
    packageName,
    creditsUsed,
    remainingAfter,
  );

  /// Create a copy of SubscriptionPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionPaymentImplCopyWith<_$SubscriptionPaymentImpl> get copyWith =>
      __$$SubscriptionPaymentImplCopyWithImpl<_$SubscriptionPaymentImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionPaymentImplToJson(this);
  }
}

abstract class _SubscriptionPayment implements SubscriptionPayment {
  const factory _SubscriptionPayment({
    @JsonKey(name: 'subscription_id') required final String subscriptionId,
    @JsonKey(name: 'package_name') required final String packageName,
    @JsonKey(name: 'credits_used') final int creditsUsed,
    @JsonKey(name: 'remaining_after') final int? remainingAfter,
  }) = _$SubscriptionPaymentImpl;

  factory _SubscriptionPayment.fromJson(Map<String, dynamic> json) =
      _$SubscriptionPaymentImpl.fromJson;

  @override
  @JsonKey(name: 'subscription_id')
  String get subscriptionId;
  @override
  @JsonKey(name: 'package_name')
  String get packageName;
  @override
  @JsonKey(name: 'credits_used')
  int get creditsUsed;
  @override
  @JsonKey(name: 'remaining_after')
  int? get remainingAfter;

  /// Create a copy of SubscriptionPayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionPaymentImplCopyWith<_$SubscriptionPaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
