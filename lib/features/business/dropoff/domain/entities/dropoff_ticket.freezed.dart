// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dropoff_ticket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DropoffTicket _$DropoffTicketFromJson(Map<String, dynamic> json) {
  return _DropoffTicket.fromJson(json);
}

/// @nodoc
mixin _$DropoffTicket {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'ticket_number')
  String get ticketNumber => throw _privateConstructorUsedError;
  DropoffStatus get status => throw _privateConstructorUsedError;
  DropoffSource get source =>
      throw _privateConstructorUsedError; // Customer info
  @JsonKey(name: 'customer_name')
  String get customerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_phone')
  String? get customerPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_avatar')
  String? get customerAvatar => throw _privateConstructorUsedError; // Items
  List<DropoffItem> get items => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_price_cents')
  int get totalPrice => throw _privateConstructorUsedError; // Timing
  @JsonKey(name: 'dropped_off_at')
  String get droppedOffAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'estimated_ready_at')
  String get estimatedReadyAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'started_at')
  String? get startedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_at')
  String? get completedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'picked_up_at')
  String? get pickedUpAt => throw _privateConstructorUsedError; // Extras
  String? get notes => throw _privateConstructorUsedError;
  bool get urgent => throw _privateConstructorUsedError;
  bool get paid => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method')
  String? get paymentMethod => throw _privateConstructorUsedError;

  /// Serializes this DropoffTicket to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DropoffTicket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DropoffTicketCopyWith<DropoffTicket> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DropoffTicketCopyWith<$Res> {
  factory $DropoffTicketCopyWith(
    DropoffTicket value,
    $Res Function(DropoffTicket) then,
  ) = _$DropoffTicketCopyWithImpl<$Res, DropoffTicket>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'ticket_number') String ticketNumber,
    DropoffStatus status,
    DropoffSource source,
    @JsonKey(name: 'customer_name') String customerName,
    @JsonKey(name: 'customer_phone') String? customerPhone,
    @JsonKey(name: 'customer_avatar') String? customerAvatar,
    List<DropoffItem> items,
    @JsonKey(name: 'total_price_cents') int totalPrice,
    @JsonKey(name: 'dropped_off_at') String droppedOffAt,
    @JsonKey(name: 'estimated_ready_at') String estimatedReadyAt,
    @JsonKey(name: 'started_at') String? startedAt,
    @JsonKey(name: 'completed_at') String? completedAt,
    @JsonKey(name: 'picked_up_at') String? pickedUpAt,
    String? notes,
    bool urgent,
    bool paid,
    @JsonKey(name: 'payment_method') String? paymentMethod,
  });
}

/// @nodoc
class _$DropoffTicketCopyWithImpl<$Res, $Val extends DropoffTicket>
    implements $DropoffTicketCopyWith<$Res> {
  _$DropoffTicketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DropoffTicket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ticketNumber = null,
    Object? status = null,
    Object? source = null,
    Object? customerName = null,
    Object? customerPhone = freezed,
    Object? customerAvatar = freezed,
    Object? items = null,
    Object? totalPrice = null,
    Object? droppedOffAt = null,
    Object? estimatedReadyAt = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? pickedUpAt = freezed,
    Object? notes = freezed,
    Object? urgent = null,
    Object? paid = null,
    Object? paymentMethod = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            ticketNumber: null == ticketNumber
                ? _value.ticketNumber
                : ticketNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as DropoffStatus,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as DropoffSource,
            customerName: null == customerName
                ? _value.customerName
                : customerName // ignore: cast_nullable_to_non_nullable
                      as String,
            customerPhone: freezed == customerPhone
                ? _value.customerPhone
                : customerPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            customerAvatar: freezed == customerAvatar
                ? _value.customerAvatar
                : customerAvatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<DropoffItem>,
            totalPrice: null == totalPrice
                ? _value.totalPrice
                : totalPrice // ignore: cast_nullable_to_non_nullable
                      as int,
            droppedOffAt: null == droppedOffAt
                ? _value.droppedOffAt
                : droppedOffAt // ignore: cast_nullable_to_non_nullable
                      as String,
            estimatedReadyAt: null == estimatedReadyAt
                ? _value.estimatedReadyAt
                : estimatedReadyAt // ignore: cast_nullable_to_non_nullable
                      as String,
            startedAt: freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            pickedUpAt: freezed == pickedUpAt
                ? _value.pickedUpAt
                : pickedUpAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            urgent: null == urgent
                ? _value.urgent
                : urgent // ignore: cast_nullable_to_non_nullable
                      as bool,
            paid: null == paid
                ? _value.paid
                : paid // ignore: cast_nullable_to_non_nullable
                      as bool,
            paymentMethod: freezed == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DropoffTicketImplCopyWith<$Res>
    implements $DropoffTicketCopyWith<$Res> {
  factory _$$DropoffTicketImplCopyWith(
    _$DropoffTicketImpl value,
    $Res Function(_$DropoffTicketImpl) then,
  ) = __$$DropoffTicketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'ticket_number') String ticketNumber,
    DropoffStatus status,
    DropoffSource source,
    @JsonKey(name: 'customer_name') String customerName,
    @JsonKey(name: 'customer_phone') String? customerPhone,
    @JsonKey(name: 'customer_avatar') String? customerAvatar,
    List<DropoffItem> items,
    @JsonKey(name: 'total_price_cents') int totalPrice,
    @JsonKey(name: 'dropped_off_at') String droppedOffAt,
    @JsonKey(name: 'estimated_ready_at') String estimatedReadyAt,
    @JsonKey(name: 'started_at') String? startedAt,
    @JsonKey(name: 'completed_at') String? completedAt,
    @JsonKey(name: 'picked_up_at') String? pickedUpAt,
    String? notes,
    bool urgent,
    bool paid,
    @JsonKey(name: 'payment_method') String? paymentMethod,
  });
}

/// @nodoc
class __$$DropoffTicketImplCopyWithImpl<$Res>
    extends _$DropoffTicketCopyWithImpl<$Res, _$DropoffTicketImpl>
    implements _$$DropoffTicketImplCopyWith<$Res> {
  __$$DropoffTicketImplCopyWithImpl(
    _$DropoffTicketImpl _value,
    $Res Function(_$DropoffTicketImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DropoffTicket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ticketNumber = null,
    Object? status = null,
    Object? source = null,
    Object? customerName = null,
    Object? customerPhone = freezed,
    Object? customerAvatar = freezed,
    Object? items = null,
    Object? totalPrice = null,
    Object? droppedOffAt = null,
    Object? estimatedReadyAt = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? pickedUpAt = freezed,
    Object? notes = freezed,
    Object? urgent = null,
    Object? paid = null,
    Object? paymentMethod = freezed,
  }) {
    return _then(
      _$DropoffTicketImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        ticketNumber: null == ticketNumber
            ? _value.ticketNumber
            : ticketNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as DropoffStatus,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as DropoffSource,
        customerName: null == customerName
            ? _value.customerName
            : customerName // ignore: cast_nullable_to_non_nullable
                  as String,
        customerPhone: freezed == customerPhone
            ? _value.customerPhone
            : customerPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        customerAvatar: freezed == customerAvatar
            ? _value.customerAvatar
            : customerAvatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<DropoffItem>,
        totalPrice: null == totalPrice
            ? _value.totalPrice
            : totalPrice // ignore: cast_nullable_to_non_nullable
                  as int,
        droppedOffAt: null == droppedOffAt
            ? _value.droppedOffAt
            : droppedOffAt // ignore: cast_nullable_to_non_nullable
                  as String,
        estimatedReadyAt: null == estimatedReadyAt
            ? _value.estimatedReadyAt
            : estimatedReadyAt // ignore: cast_nullable_to_non_nullable
                  as String,
        startedAt: freezed == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        pickedUpAt: freezed == pickedUpAt
            ? _value.pickedUpAt
            : pickedUpAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        urgent: null == urgent
            ? _value.urgent
            : urgent // ignore: cast_nullable_to_non_nullable
                  as bool,
        paid: null == paid
            ? _value.paid
            : paid // ignore: cast_nullable_to_non_nullable
                  as bool,
        paymentMethod: freezed == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DropoffTicketImpl implements _DropoffTicket {
  const _$DropoffTicketImpl({
    required this.id,
    @JsonKey(name: 'ticket_number') required this.ticketNumber,
    required this.status,
    required this.source,
    @JsonKey(name: 'customer_name') required this.customerName,
    @JsonKey(name: 'customer_phone') this.customerPhone,
    @JsonKey(name: 'customer_avatar') this.customerAvatar,
    required final List<DropoffItem> items,
    @JsonKey(name: 'total_price_cents') required this.totalPrice,
    @JsonKey(name: 'dropped_off_at') required this.droppedOffAt,
    @JsonKey(name: 'estimated_ready_at') required this.estimatedReadyAt,
    @JsonKey(name: 'started_at') this.startedAt,
    @JsonKey(name: 'completed_at') this.completedAt,
    @JsonKey(name: 'picked_up_at') this.pickedUpAt,
    this.notes,
    this.urgent = false,
    this.paid = false,
    @JsonKey(name: 'payment_method') this.paymentMethod,
  }) : _items = items;

  factory _$DropoffTicketImpl.fromJson(Map<String, dynamic> json) =>
      _$$DropoffTicketImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'ticket_number')
  final String ticketNumber;
  @override
  final DropoffStatus status;
  @override
  final DropoffSource source;
  // Customer info
  @override
  @JsonKey(name: 'customer_name')
  final String customerName;
  @override
  @JsonKey(name: 'customer_phone')
  final String? customerPhone;
  @override
  @JsonKey(name: 'customer_avatar')
  final String? customerAvatar;
  // Items
  final List<DropoffItem> _items;
  // Items
  @override
  List<DropoffItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey(name: 'total_price_cents')
  final int totalPrice;
  // Timing
  @override
  @JsonKey(name: 'dropped_off_at')
  final String droppedOffAt;
  @override
  @JsonKey(name: 'estimated_ready_at')
  final String estimatedReadyAt;
  @override
  @JsonKey(name: 'started_at')
  final String? startedAt;
  @override
  @JsonKey(name: 'completed_at')
  final String? completedAt;
  @override
  @JsonKey(name: 'picked_up_at')
  final String? pickedUpAt;
  // Extras
  @override
  final String? notes;
  @override
  @JsonKey()
  final bool urgent;
  @override
  @JsonKey()
  final bool paid;
  @override
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;

  @override
  String toString() {
    return 'DropoffTicket(id: $id, ticketNumber: $ticketNumber, status: $status, source: $source, customerName: $customerName, customerPhone: $customerPhone, customerAvatar: $customerAvatar, items: $items, totalPrice: $totalPrice, droppedOffAt: $droppedOffAt, estimatedReadyAt: $estimatedReadyAt, startedAt: $startedAt, completedAt: $completedAt, pickedUpAt: $pickedUpAt, notes: $notes, urgent: $urgent, paid: $paid, paymentMethod: $paymentMethod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DropoffTicketImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ticketNumber, ticketNumber) ||
                other.ticketNumber == ticketNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerPhone, customerPhone) ||
                other.customerPhone == customerPhone) &&
            (identical(other.customerAvatar, customerAvatar) ||
                other.customerAvatar == customerAvatar) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.droppedOffAt, droppedOffAt) ||
                other.droppedOffAt == droppedOffAt) &&
            (identical(other.estimatedReadyAt, estimatedReadyAt) ||
                other.estimatedReadyAt == estimatedReadyAt) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.pickedUpAt, pickedUpAt) ||
                other.pickedUpAt == pickedUpAt) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.urgent, urgent) || other.urgent == urgent) &&
            (identical(other.paid, paid) || other.paid == paid) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    ticketNumber,
    status,
    source,
    customerName,
    customerPhone,
    customerAvatar,
    const DeepCollectionEquality().hash(_items),
    totalPrice,
    droppedOffAt,
    estimatedReadyAt,
    startedAt,
    completedAt,
    pickedUpAt,
    notes,
    urgent,
    paid,
    paymentMethod,
  );

  /// Create a copy of DropoffTicket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DropoffTicketImplCopyWith<_$DropoffTicketImpl> get copyWith =>
      __$$DropoffTicketImplCopyWithImpl<_$DropoffTicketImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DropoffTicketImplToJson(this);
  }
}

abstract class _DropoffTicket implements DropoffTicket {
  const factory _DropoffTicket({
    required final String id,
    @JsonKey(name: 'ticket_number') required final String ticketNumber,
    required final DropoffStatus status,
    required final DropoffSource source,
    @JsonKey(name: 'customer_name') required final String customerName,
    @JsonKey(name: 'customer_phone') final String? customerPhone,
    @JsonKey(name: 'customer_avatar') final String? customerAvatar,
    required final List<DropoffItem> items,
    @JsonKey(name: 'total_price_cents') required final int totalPrice,
    @JsonKey(name: 'dropped_off_at') required final String droppedOffAt,
    @JsonKey(name: 'estimated_ready_at') required final String estimatedReadyAt,
    @JsonKey(name: 'started_at') final String? startedAt,
    @JsonKey(name: 'completed_at') final String? completedAt,
    @JsonKey(name: 'picked_up_at') final String? pickedUpAt,
    final String? notes,
    final bool urgent,
    final bool paid,
    @JsonKey(name: 'payment_method') final String? paymentMethod,
  }) = _$DropoffTicketImpl;

  factory _DropoffTicket.fromJson(Map<String, dynamic> json) =
      _$DropoffTicketImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'ticket_number')
  String get ticketNumber;
  @override
  DropoffStatus get status;
  @override
  DropoffSource get source; // Customer info
  @override
  @JsonKey(name: 'customer_name')
  String get customerName;
  @override
  @JsonKey(name: 'customer_phone')
  String? get customerPhone;
  @override
  @JsonKey(name: 'customer_avatar')
  String? get customerAvatar; // Items
  @override
  List<DropoffItem> get items;
  @override
  @JsonKey(name: 'total_price_cents')
  int get totalPrice; // Timing
  @override
  @JsonKey(name: 'dropped_off_at')
  String get droppedOffAt;
  @override
  @JsonKey(name: 'estimated_ready_at')
  String get estimatedReadyAt;
  @override
  @JsonKey(name: 'started_at')
  String? get startedAt;
  @override
  @JsonKey(name: 'completed_at')
  String? get completedAt;
  @override
  @JsonKey(name: 'picked_up_at')
  String? get pickedUpAt; // Extras
  @override
  String? get notes;
  @override
  bool get urgent;
  @override
  bool get paid;
  @override
  @JsonKey(name: 'payment_method')
  String? get paymentMethod;

  /// Create a copy of DropoffTicket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DropoffTicketImplCopyWith<_$DropoffTicketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
