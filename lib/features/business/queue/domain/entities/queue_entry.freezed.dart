// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QueueEntry _$QueueEntryFromJson(Map<String, dynamic> json) {
  return _QueueEntry.fromJson(json);
}

/// @nodoc
mixin _$QueueEntry {
  String get id => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;
  QueueStatus get status => throw _privateConstructorUsedError;
  QueueSource get source => throw _privateConstructorUsedError; // Customer info
  @JsonKey(name: 'customer_name')
  String get customerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_phone')
  String? get customerPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_avatar')
  String? get customerAvatar => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_subscriber')
  bool get isSubscriber => throw _privateConstructorUsedError; // Vehicle info (for car wash etc.)
  @JsonKey(name: 'vehicle_type')
  String? get vehicleType => throw _privateConstructorUsedError;
  @JsonKey(name: 'vehicle_color')
  String? get vehicleColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'plate_number')
  String? get plateNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'vehicle_label')
  String? get vehicleLabel => throw _privateConstructorUsedError; // Service info
  @JsonKey(name: 'package_id')
  String get packageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'package_name')
  String get packageName => throw _privateConstructorUsedError;
  @JsonKey(name: 'package_price_cents')
  int get packagePrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'add_ons')
  List<QueueAddOn> get addOns => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_price_cents')
  int get totalPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'estimated_duration_min')
  int get estimatedDurationMin => throw _privateConstructorUsedError; // Timestamps (unix epoch seconds)
  @JsonKey(name: 'checked_in_at')
  int get checkedInAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'started_at')
  int? get startedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_at')
  int? get completedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'estimated_ready_at')
  int? get estimatedReadyAt => throw _privateConstructorUsedError; // Discount (manual override by business)
  QueueDiscount? get discount => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_before_discount_cents')
  int? get priceBeforeDiscount => throw _privateConstructorUsedError; // Extras
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'photos_before')
  List<String> get photosBefore => throw _privateConstructorUsedError;
  @JsonKey(name: 'photos_after')
  List<String> get photosAfter => throw _privateConstructorUsedError;
  @JsonKey(name: 'subscription_plan')
  String? get subscriptionPlan => throw _privateConstructorUsedError;

  /// Serializes this QueueEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueueEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueueEntryCopyWith<QueueEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueEntryCopyWith<$Res> {
  factory $QueueEntryCopyWith(
    QueueEntry value,
    $Res Function(QueueEntry) then,
  ) = _$QueueEntryCopyWithImpl<$Res, QueueEntry>;
  @useResult
  $Res call({
    String id,
    int position,
    QueueStatus status,
    QueueSource source,
    @JsonKey(name: 'customer_name') String customerName,
    @JsonKey(name: 'customer_phone') String? customerPhone,
    @JsonKey(name: 'customer_avatar') String? customerAvatar,
    @JsonKey(name: 'is_subscriber') bool isSubscriber,
    @JsonKey(name: 'vehicle_type') String? vehicleType,
    @JsonKey(name: 'vehicle_color') String? vehicleColor,
    @JsonKey(name: 'plate_number') String? plateNumber,
    @JsonKey(name: 'vehicle_label') String? vehicleLabel,
    @JsonKey(name: 'package_id') String packageId,
    @JsonKey(name: 'package_name') String packageName,
    @JsonKey(name: 'package_price_cents') int packagePrice,
    @JsonKey(name: 'add_ons') List<QueueAddOn> addOns,
    @JsonKey(name: 'total_price_cents') int totalPrice,
    @JsonKey(name: 'estimated_duration_min') int estimatedDurationMin,
    @JsonKey(name: 'checked_in_at') int checkedInAt,
    @JsonKey(name: 'started_at') int? startedAt,
    @JsonKey(name: 'completed_at') int? completedAt,
    @JsonKey(name: 'estimated_ready_at') int? estimatedReadyAt,
    QueueDiscount? discount,
    @JsonKey(name: 'price_before_discount_cents') int? priceBeforeDiscount,
    String? notes,
    @JsonKey(name: 'photos_before') List<String> photosBefore,
    @JsonKey(name: 'photos_after') List<String> photosAfter,
    @JsonKey(name: 'subscription_plan') String? subscriptionPlan,
  });

  $QueueDiscountCopyWith<$Res>? get discount;
}

/// @nodoc
class _$QueueEntryCopyWithImpl<$Res, $Val extends QueueEntry>
    implements $QueueEntryCopyWith<$Res> {
  _$QueueEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueueEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? position = null,
    Object? status = null,
    Object? source = null,
    Object? customerName = null,
    Object? customerPhone = freezed,
    Object? customerAvatar = freezed,
    Object? isSubscriber = null,
    Object? vehicleType = freezed,
    Object? vehicleColor = freezed,
    Object? plateNumber = freezed,
    Object? vehicleLabel = freezed,
    Object? packageId = null,
    Object? packageName = null,
    Object? packagePrice = null,
    Object? addOns = null,
    Object? totalPrice = null,
    Object? estimatedDurationMin = null,
    Object? checkedInAt = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? estimatedReadyAt = freezed,
    Object? discount = freezed,
    Object? priceBeforeDiscount = freezed,
    Object? notes = freezed,
    Object? photosBefore = null,
    Object? photosAfter = null,
    Object? subscriptionPlan = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as QueueStatus,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as QueueSource,
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
            isSubscriber: null == isSubscriber
                ? _value.isSubscriber
                : isSubscriber // ignore: cast_nullable_to_non_nullable
                      as bool,
            vehicleType: freezed == vehicleType
                ? _value.vehicleType
                : vehicleType // ignore: cast_nullable_to_non_nullable
                      as String?,
            vehicleColor: freezed == vehicleColor
                ? _value.vehicleColor
                : vehicleColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            plateNumber: freezed == plateNumber
                ? _value.plateNumber
                : plateNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            vehicleLabel: freezed == vehicleLabel
                ? _value.vehicleLabel
                : vehicleLabel // ignore: cast_nullable_to_non_nullable
                      as String?,
            packageId: null == packageId
                ? _value.packageId
                : packageId // ignore: cast_nullable_to_non_nullable
                      as String,
            packageName: null == packageName
                ? _value.packageName
                : packageName // ignore: cast_nullable_to_non_nullable
                      as String,
            packagePrice: null == packagePrice
                ? _value.packagePrice
                : packagePrice // ignore: cast_nullable_to_non_nullable
                      as int,
            addOns: null == addOns
                ? _value.addOns
                : addOns // ignore: cast_nullable_to_non_nullable
                      as List<QueueAddOn>,
            totalPrice: null == totalPrice
                ? _value.totalPrice
                : totalPrice // ignore: cast_nullable_to_non_nullable
                      as int,
            estimatedDurationMin: null == estimatedDurationMin
                ? _value.estimatedDurationMin
                : estimatedDurationMin // ignore: cast_nullable_to_non_nullable
                      as int,
            checkedInAt: null == checkedInAt
                ? _value.checkedInAt
                : checkedInAt // ignore: cast_nullable_to_non_nullable
                      as int,
            startedAt: freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as int?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as int?,
            estimatedReadyAt: freezed == estimatedReadyAt
                ? _value.estimatedReadyAt
                : estimatedReadyAt // ignore: cast_nullable_to_non_nullable
                      as int?,
            discount: freezed == discount
                ? _value.discount
                : discount // ignore: cast_nullable_to_non_nullable
                      as QueueDiscount?,
            priceBeforeDiscount: freezed == priceBeforeDiscount
                ? _value.priceBeforeDiscount
                : priceBeforeDiscount // ignore: cast_nullable_to_non_nullable
                      as int?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            photosBefore: null == photosBefore
                ? _value.photosBefore
                : photosBefore // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            photosAfter: null == photosAfter
                ? _value.photosAfter
                : photosAfter // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            subscriptionPlan: freezed == subscriptionPlan
                ? _value.subscriptionPlan
                : subscriptionPlan // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of QueueEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QueueDiscountCopyWith<$Res>? get discount {
    if (_value.discount == null) {
      return null;
    }

    return $QueueDiscountCopyWith<$Res>(_value.discount!, (value) {
      return _then(_value.copyWith(discount: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QueueEntryImplCopyWith<$Res>
    implements $QueueEntryCopyWith<$Res> {
  factory _$$QueueEntryImplCopyWith(
    _$QueueEntryImpl value,
    $Res Function(_$QueueEntryImpl) then,
  ) = __$$QueueEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int position,
    QueueStatus status,
    QueueSource source,
    @JsonKey(name: 'customer_name') String customerName,
    @JsonKey(name: 'customer_phone') String? customerPhone,
    @JsonKey(name: 'customer_avatar') String? customerAvatar,
    @JsonKey(name: 'is_subscriber') bool isSubscriber,
    @JsonKey(name: 'vehicle_type') String? vehicleType,
    @JsonKey(name: 'vehicle_color') String? vehicleColor,
    @JsonKey(name: 'plate_number') String? plateNumber,
    @JsonKey(name: 'vehicle_label') String? vehicleLabel,
    @JsonKey(name: 'package_id') String packageId,
    @JsonKey(name: 'package_name') String packageName,
    @JsonKey(name: 'package_price_cents') int packagePrice,
    @JsonKey(name: 'add_ons') List<QueueAddOn> addOns,
    @JsonKey(name: 'total_price_cents') int totalPrice,
    @JsonKey(name: 'estimated_duration_min') int estimatedDurationMin,
    @JsonKey(name: 'checked_in_at') int checkedInAt,
    @JsonKey(name: 'started_at') int? startedAt,
    @JsonKey(name: 'completed_at') int? completedAt,
    @JsonKey(name: 'estimated_ready_at') int? estimatedReadyAt,
    QueueDiscount? discount,
    @JsonKey(name: 'price_before_discount_cents') int? priceBeforeDiscount,
    String? notes,
    @JsonKey(name: 'photos_before') List<String> photosBefore,
    @JsonKey(name: 'photos_after') List<String> photosAfter,
    @JsonKey(name: 'subscription_plan') String? subscriptionPlan,
  });

  @override
  $QueueDiscountCopyWith<$Res>? get discount;
}

/// @nodoc
class __$$QueueEntryImplCopyWithImpl<$Res>
    extends _$QueueEntryCopyWithImpl<$Res, _$QueueEntryImpl>
    implements _$$QueueEntryImplCopyWith<$Res> {
  __$$QueueEntryImplCopyWithImpl(
    _$QueueEntryImpl _value,
    $Res Function(_$QueueEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueueEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? position = null,
    Object? status = null,
    Object? source = null,
    Object? customerName = null,
    Object? customerPhone = freezed,
    Object? customerAvatar = freezed,
    Object? isSubscriber = null,
    Object? vehicleType = freezed,
    Object? vehicleColor = freezed,
    Object? plateNumber = freezed,
    Object? vehicleLabel = freezed,
    Object? packageId = null,
    Object? packageName = null,
    Object? packagePrice = null,
    Object? addOns = null,
    Object? totalPrice = null,
    Object? estimatedDurationMin = null,
    Object? checkedInAt = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? estimatedReadyAt = freezed,
    Object? discount = freezed,
    Object? priceBeforeDiscount = freezed,
    Object? notes = freezed,
    Object? photosBefore = null,
    Object? photosAfter = null,
    Object? subscriptionPlan = freezed,
  }) {
    return _then(
      _$QueueEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as QueueStatus,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as QueueSource,
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
        isSubscriber: null == isSubscriber
            ? _value.isSubscriber
            : isSubscriber // ignore: cast_nullable_to_non_nullable
                  as bool,
        vehicleType: freezed == vehicleType
            ? _value.vehicleType
            : vehicleType // ignore: cast_nullable_to_non_nullable
                  as String?,
        vehicleColor: freezed == vehicleColor
            ? _value.vehicleColor
            : vehicleColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        plateNumber: freezed == plateNumber
            ? _value.plateNumber
            : plateNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        vehicleLabel: freezed == vehicleLabel
            ? _value.vehicleLabel
            : vehicleLabel // ignore: cast_nullable_to_non_nullable
                  as String?,
        packageId: null == packageId
            ? _value.packageId
            : packageId // ignore: cast_nullable_to_non_nullable
                  as String,
        packageName: null == packageName
            ? _value.packageName
            : packageName // ignore: cast_nullable_to_non_nullable
                  as String,
        packagePrice: null == packagePrice
            ? _value.packagePrice
            : packagePrice // ignore: cast_nullable_to_non_nullable
                  as int,
        addOns: null == addOns
            ? _value._addOns
            : addOns // ignore: cast_nullable_to_non_nullable
                  as List<QueueAddOn>,
        totalPrice: null == totalPrice
            ? _value.totalPrice
            : totalPrice // ignore: cast_nullable_to_non_nullable
                  as int,
        estimatedDurationMin: null == estimatedDurationMin
            ? _value.estimatedDurationMin
            : estimatedDurationMin // ignore: cast_nullable_to_non_nullable
                  as int,
        checkedInAt: null == checkedInAt
            ? _value.checkedInAt
            : checkedInAt // ignore: cast_nullable_to_non_nullable
                  as int,
        startedAt: freezed == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as int?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as int?,
        estimatedReadyAt: freezed == estimatedReadyAt
            ? _value.estimatedReadyAt
            : estimatedReadyAt // ignore: cast_nullable_to_non_nullable
                  as int?,
        discount: freezed == discount
            ? _value.discount
            : discount // ignore: cast_nullable_to_non_nullable
                  as QueueDiscount?,
        priceBeforeDiscount: freezed == priceBeforeDiscount
            ? _value.priceBeforeDiscount
            : priceBeforeDiscount // ignore: cast_nullable_to_non_nullable
                  as int?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        photosBefore: null == photosBefore
            ? _value._photosBefore
            : photosBefore // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        photosAfter: null == photosAfter
            ? _value._photosAfter
            : photosAfter // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        subscriptionPlan: freezed == subscriptionPlan
            ? _value.subscriptionPlan
            : subscriptionPlan // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueEntryImpl implements _QueueEntry {
  const _$QueueEntryImpl({
    required this.id,
    required this.position,
    required this.status,
    required this.source,
    @JsonKey(name: 'customer_name') required this.customerName,
    @JsonKey(name: 'customer_phone') this.customerPhone,
    @JsonKey(name: 'customer_avatar') this.customerAvatar,
    @JsonKey(name: 'is_subscriber') this.isSubscriber = false,
    @JsonKey(name: 'vehicle_type') this.vehicleType,
    @JsonKey(name: 'vehicle_color') this.vehicleColor,
    @JsonKey(name: 'plate_number') this.plateNumber,
    @JsonKey(name: 'vehicle_label') this.vehicleLabel,
    @JsonKey(name: 'package_id') required this.packageId,
    @JsonKey(name: 'package_name') required this.packageName,
    @JsonKey(name: 'package_price_cents') required this.packagePrice,
    @JsonKey(name: 'add_ons') final List<QueueAddOn> addOns = const [],
    @JsonKey(name: 'total_price_cents') required this.totalPrice,
    @JsonKey(name: 'estimated_duration_min') required this.estimatedDurationMin,
    @JsonKey(name: 'checked_in_at') required this.checkedInAt,
    @JsonKey(name: 'started_at') this.startedAt,
    @JsonKey(name: 'completed_at') this.completedAt,
    @JsonKey(name: 'estimated_ready_at') this.estimatedReadyAt,
    this.discount,
    @JsonKey(name: 'price_before_discount_cents') this.priceBeforeDiscount,
    this.notes,
    @JsonKey(name: 'photos_before') final List<String> photosBefore = const [],
    @JsonKey(name: 'photos_after') final List<String> photosAfter = const [],
    @JsonKey(name: 'subscription_plan') this.subscriptionPlan,
  }) : _addOns = addOns,
       _photosBefore = photosBefore,
       _photosAfter = photosAfter;

  factory _$QueueEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueEntryImplFromJson(json);

  @override
  final String id;
  @override
  final int position;
  @override
  final QueueStatus status;
  @override
  final QueueSource source;
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
  @override
  @JsonKey(name: 'is_subscriber')
  final bool isSubscriber;
  // Vehicle info (for car wash etc.)
  @override
  @JsonKey(name: 'vehicle_type')
  final String? vehicleType;
  @override
  @JsonKey(name: 'vehicle_color')
  final String? vehicleColor;
  @override
  @JsonKey(name: 'plate_number')
  final String? plateNumber;
  @override
  @JsonKey(name: 'vehicle_label')
  final String? vehicleLabel;
  // Service info
  @override
  @JsonKey(name: 'package_id')
  final String packageId;
  @override
  @JsonKey(name: 'package_name')
  final String packageName;
  @override
  @JsonKey(name: 'package_price_cents')
  final int packagePrice;
  final List<QueueAddOn> _addOns;
  @override
  @JsonKey(name: 'add_ons')
  List<QueueAddOn> get addOns {
    if (_addOns is EqualUnmodifiableListView) return _addOns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addOns);
  }

  @override
  @JsonKey(name: 'total_price_cents')
  final int totalPrice;
  @override
  @JsonKey(name: 'estimated_duration_min')
  final int estimatedDurationMin;
  // Timestamps (unix epoch seconds)
  @override
  @JsonKey(name: 'checked_in_at')
  final int checkedInAt;
  @override
  @JsonKey(name: 'started_at')
  final int? startedAt;
  @override
  @JsonKey(name: 'completed_at')
  final int? completedAt;
  @override
  @JsonKey(name: 'estimated_ready_at')
  final int? estimatedReadyAt;
  // Discount (manual override by business)
  @override
  final QueueDiscount? discount;
  @override
  @JsonKey(name: 'price_before_discount_cents')
  final int? priceBeforeDiscount;
  // Extras
  @override
  final String? notes;
  final List<String> _photosBefore;
  @override
  @JsonKey(name: 'photos_before')
  List<String> get photosBefore {
    if (_photosBefore is EqualUnmodifiableListView) return _photosBefore;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photosBefore);
  }

  final List<String> _photosAfter;
  @override
  @JsonKey(name: 'photos_after')
  List<String> get photosAfter {
    if (_photosAfter is EqualUnmodifiableListView) return _photosAfter;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photosAfter);
  }

  @override
  @JsonKey(name: 'subscription_plan')
  final String? subscriptionPlan;

  @override
  String toString() {
    return 'QueueEntry(id: $id, position: $position, status: $status, source: $source, customerName: $customerName, customerPhone: $customerPhone, customerAvatar: $customerAvatar, isSubscriber: $isSubscriber, vehicleType: $vehicleType, vehicleColor: $vehicleColor, plateNumber: $plateNumber, vehicleLabel: $vehicleLabel, packageId: $packageId, packageName: $packageName, packagePrice: $packagePrice, addOns: $addOns, totalPrice: $totalPrice, estimatedDurationMin: $estimatedDurationMin, checkedInAt: $checkedInAt, startedAt: $startedAt, completedAt: $completedAt, estimatedReadyAt: $estimatedReadyAt, discount: $discount, priceBeforeDiscount: $priceBeforeDiscount, notes: $notes, photosBefore: $photosBefore, photosAfter: $photosAfter, subscriptionPlan: $subscriptionPlan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerPhone, customerPhone) ||
                other.customerPhone == customerPhone) &&
            (identical(other.customerAvatar, customerAvatar) ||
                other.customerAvatar == customerAvatar) &&
            (identical(other.isSubscriber, isSubscriber) ||
                other.isSubscriber == isSubscriber) &&
            (identical(other.vehicleType, vehicleType) ||
                other.vehicleType == vehicleType) &&
            (identical(other.vehicleColor, vehicleColor) ||
                other.vehicleColor == vehicleColor) &&
            (identical(other.plateNumber, plateNumber) ||
                other.plateNumber == plateNumber) &&
            (identical(other.vehicleLabel, vehicleLabel) ||
                other.vehicleLabel == vehicleLabel) &&
            (identical(other.packageId, packageId) ||
                other.packageId == packageId) &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.packagePrice, packagePrice) ||
                other.packagePrice == packagePrice) &&
            const DeepCollectionEquality().equals(other._addOns, _addOns) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.estimatedDurationMin, estimatedDurationMin) ||
                other.estimatedDurationMin == estimatedDurationMin) &&
            (identical(other.checkedInAt, checkedInAt) ||
                other.checkedInAt == checkedInAt) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.estimatedReadyAt, estimatedReadyAt) ||
                other.estimatedReadyAt == estimatedReadyAt) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.priceBeforeDiscount, priceBeforeDiscount) ||
                other.priceBeforeDiscount == priceBeforeDiscount) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(
              other._photosBefore,
              _photosBefore,
            ) &&
            const DeepCollectionEquality().equals(
              other._photosAfter,
              _photosAfter,
            ) &&
            (identical(other.subscriptionPlan, subscriptionPlan) ||
                other.subscriptionPlan == subscriptionPlan));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    position,
    status,
    source,
    customerName,
    customerPhone,
    customerAvatar,
    isSubscriber,
    vehicleType,
    vehicleColor,
    plateNumber,
    vehicleLabel,
    packageId,
    packageName,
    packagePrice,
    const DeepCollectionEquality().hash(_addOns),
    totalPrice,
    estimatedDurationMin,
    checkedInAt,
    startedAt,
    completedAt,
    estimatedReadyAt,
    discount,
    priceBeforeDiscount,
    notes,
    const DeepCollectionEquality().hash(_photosBefore),
    const DeepCollectionEquality().hash(_photosAfter),
    subscriptionPlan,
  ]);

  /// Create a copy of QueueEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueEntryImplCopyWith<_$QueueEntryImpl> get copyWith =>
      __$$QueueEntryImplCopyWithImpl<_$QueueEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueEntryImplToJson(this);
  }
}

abstract class _QueueEntry implements QueueEntry {
  const factory _QueueEntry({
    required final String id,
    required final int position,
    required final QueueStatus status,
    required final QueueSource source,
    @JsonKey(name: 'customer_name') required final String customerName,
    @JsonKey(name: 'customer_phone') final String? customerPhone,
    @JsonKey(name: 'customer_avatar') final String? customerAvatar,
    @JsonKey(name: 'is_subscriber') final bool isSubscriber,
    @JsonKey(name: 'vehicle_type') final String? vehicleType,
    @JsonKey(name: 'vehicle_color') final String? vehicleColor,
    @JsonKey(name: 'plate_number') final String? plateNumber,
    @JsonKey(name: 'vehicle_label') final String? vehicleLabel,
    @JsonKey(name: 'package_id') required final String packageId,
    @JsonKey(name: 'package_name') required final String packageName,
    @JsonKey(name: 'package_price_cents') required final int packagePrice,
    @JsonKey(name: 'add_ons') final List<QueueAddOn> addOns,
    @JsonKey(name: 'total_price_cents') required final int totalPrice,
    @JsonKey(name: 'estimated_duration_min')
    required final int estimatedDurationMin,
    @JsonKey(name: 'checked_in_at') required final int checkedInAt,
    @JsonKey(name: 'started_at') final int? startedAt,
    @JsonKey(name: 'completed_at') final int? completedAt,
    @JsonKey(name: 'estimated_ready_at') final int? estimatedReadyAt,
    final QueueDiscount? discount,
    @JsonKey(name: 'price_before_discount_cents')
    final int? priceBeforeDiscount,
    final String? notes,
    @JsonKey(name: 'photos_before') final List<String> photosBefore,
    @JsonKey(name: 'photos_after') final List<String> photosAfter,
    @JsonKey(name: 'subscription_plan') final String? subscriptionPlan,
  }) = _$QueueEntryImpl;

  factory _QueueEntry.fromJson(Map<String, dynamic> json) =
      _$QueueEntryImpl.fromJson;

  @override
  String get id;
  @override
  int get position;
  @override
  QueueStatus get status;
  @override
  QueueSource get source; // Customer info
  @override
  @JsonKey(name: 'customer_name')
  String get customerName;
  @override
  @JsonKey(name: 'customer_phone')
  String? get customerPhone;
  @override
  @JsonKey(name: 'customer_avatar')
  String? get customerAvatar;
  @override
  @JsonKey(name: 'is_subscriber')
  bool get isSubscriber; // Vehicle info (for car wash etc.)
  @override
  @JsonKey(name: 'vehicle_type')
  String? get vehicleType;
  @override
  @JsonKey(name: 'vehicle_color')
  String? get vehicleColor;
  @override
  @JsonKey(name: 'plate_number')
  String? get plateNumber;
  @override
  @JsonKey(name: 'vehicle_label')
  String? get vehicleLabel; // Service info
  @override
  @JsonKey(name: 'package_id')
  String get packageId;
  @override
  @JsonKey(name: 'package_name')
  String get packageName;
  @override
  @JsonKey(name: 'package_price_cents')
  int get packagePrice;
  @override
  @JsonKey(name: 'add_ons')
  List<QueueAddOn> get addOns;
  @override
  @JsonKey(name: 'total_price_cents')
  int get totalPrice;
  @override
  @JsonKey(name: 'estimated_duration_min')
  int get estimatedDurationMin; // Timestamps (unix epoch seconds)
  @override
  @JsonKey(name: 'checked_in_at')
  int get checkedInAt;
  @override
  @JsonKey(name: 'started_at')
  int? get startedAt;
  @override
  @JsonKey(name: 'completed_at')
  int? get completedAt;
  @override
  @JsonKey(name: 'estimated_ready_at')
  int? get estimatedReadyAt; // Discount (manual override by business)
  @override
  QueueDiscount? get discount;
  @override
  @JsonKey(name: 'price_before_discount_cents')
  int? get priceBeforeDiscount; // Extras
  @override
  String? get notes;
  @override
  @JsonKey(name: 'photos_before')
  List<String> get photosBefore;
  @override
  @JsonKey(name: 'photos_after')
  List<String> get photosAfter;
  @override
  @JsonKey(name: 'subscription_plan')
  String? get subscriptionPlan;

  /// Create a copy of QueueEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueEntryImplCopyWith<_$QueueEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
