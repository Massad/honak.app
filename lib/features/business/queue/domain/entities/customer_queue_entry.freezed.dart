// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_queue_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CustomerQueueEntry _$CustomerQueueEntryFromJson(Map<String, dynamic> json) {
  return _CustomerQueueEntry.fromJson(json);
}

/// @nodoc
mixin _$CustomerQueueEntry {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_id')
  String get pageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_name')
  String get pageName => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;
  QueueStatus get status => throw _privateConstructorUsedError;
  QueueSource get source =>
      throw _privateConstructorUsedError; // Service details
  @JsonKey(name: 'package_id')
  String get packageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'package_name')
  String get packageName => throw _privateConstructorUsedError;
  @JsonKey(name: 'package_price_cents')
  int get packagePriceCents => throw _privateConstructorUsedError;
  @JsonKey(name: 'add_ons')
  List<QueueAddOn> get addOns => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_price_cents')
  int get totalPriceCents => throw _privateConstructorUsedError;
  @JsonKey(name: 'estimated_duration_min')
  int get estimatedDurationMin => throw _privateConstructorUsedError; // Queue context
  @JsonKey(name: 'ahead_count')
  int get aheadCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'estimated_wait_min')
  int get estimatedWaitMin => throw _privateConstructorUsedError; // Timestamps (unix epoch seconds)
  @JsonKey(name: 'checked_in_at')
  int get checkedInAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'started_at')
  int? get startedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_at')
  int? get completedAt => throw _privateConstructorUsedError; // Flags
  @JsonKey(name: 'on_the_way')
  bool get onTheWay => throw _privateConstructorUsedError;
  @JsonKey(name: 'modification_pending')
  bool get modificationPending => throw _privateConstructorUsedError; // Payment info (shown on ready state)
  @JsonKey(name: 'payment_methods')
  List<String> get paymentMethods => throw _privateConstructorUsedError;

  /// Serializes this CustomerQueueEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomerQueueEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerQueueEntryCopyWith<CustomerQueueEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerQueueEntryCopyWith<$Res> {
  factory $CustomerQueueEntryCopyWith(
    CustomerQueueEntry value,
    $Res Function(CustomerQueueEntry) then,
  ) = _$CustomerQueueEntryCopyWithImpl<$Res, CustomerQueueEntry>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'page_id') String pageId,
    @JsonKey(name: 'page_name') String pageName,
    int position,
    QueueStatus status,
    QueueSource source,
    @JsonKey(name: 'package_id') String packageId,
    @JsonKey(name: 'package_name') String packageName,
    @JsonKey(name: 'package_price_cents') int packagePriceCents,
    @JsonKey(name: 'add_ons') List<QueueAddOn> addOns,
    @JsonKey(name: 'total_price_cents') int totalPriceCents,
    @JsonKey(name: 'estimated_duration_min') int estimatedDurationMin,
    @JsonKey(name: 'ahead_count') int aheadCount,
    @JsonKey(name: 'estimated_wait_min') int estimatedWaitMin,
    @JsonKey(name: 'checked_in_at') int checkedInAt,
    @JsonKey(name: 'started_at') int? startedAt,
    @JsonKey(name: 'completed_at') int? completedAt,
    @JsonKey(name: 'on_the_way') bool onTheWay,
    @JsonKey(name: 'modification_pending') bool modificationPending,
    @JsonKey(name: 'payment_methods') List<String> paymentMethods,
  });
}

/// @nodoc
class _$CustomerQueueEntryCopyWithImpl<$Res, $Val extends CustomerQueueEntry>
    implements $CustomerQueueEntryCopyWith<$Res> {
  _$CustomerQueueEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerQueueEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pageId = null,
    Object? pageName = null,
    Object? position = null,
    Object? status = null,
    Object? source = null,
    Object? packageId = null,
    Object? packageName = null,
    Object? packagePriceCents = null,
    Object? addOns = null,
    Object? totalPriceCents = null,
    Object? estimatedDurationMin = null,
    Object? aheadCount = null,
    Object? estimatedWaitMin = null,
    Object? checkedInAt = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? onTheWay = null,
    Object? modificationPending = null,
    Object? paymentMethods = null,
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
            packageId: null == packageId
                ? _value.packageId
                : packageId // ignore: cast_nullable_to_non_nullable
                      as String,
            packageName: null == packageName
                ? _value.packageName
                : packageName // ignore: cast_nullable_to_non_nullable
                      as String,
            packagePriceCents: null == packagePriceCents
                ? _value.packagePriceCents
                : packagePriceCents // ignore: cast_nullable_to_non_nullable
                      as int,
            addOns: null == addOns
                ? _value.addOns
                : addOns // ignore: cast_nullable_to_non_nullable
                      as List<QueueAddOn>,
            totalPriceCents: null == totalPriceCents
                ? _value.totalPriceCents
                : totalPriceCents // ignore: cast_nullable_to_non_nullable
                      as int,
            estimatedDurationMin: null == estimatedDurationMin
                ? _value.estimatedDurationMin
                : estimatedDurationMin // ignore: cast_nullable_to_non_nullable
                      as int,
            aheadCount: null == aheadCount
                ? _value.aheadCount
                : aheadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            estimatedWaitMin: null == estimatedWaitMin
                ? _value.estimatedWaitMin
                : estimatedWaitMin // ignore: cast_nullable_to_non_nullable
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
            onTheWay: null == onTheWay
                ? _value.onTheWay
                : onTheWay // ignore: cast_nullable_to_non_nullable
                      as bool,
            modificationPending: null == modificationPending
                ? _value.modificationPending
                : modificationPending // ignore: cast_nullable_to_non_nullable
                      as bool,
            paymentMethods: null == paymentMethods
                ? _value.paymentMethods
                : paymentMethods // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CustomerQueueEntryImplCopyWith<$Res>
    implements $CustomerQueueEntryCopyWith<$Res> {
  factory _$$CustomerQueueEntryImplCopyWith(
    _$CustomerQueueEntryImpl value,
    $Res Function(_$CustomerQueueEntryImpl) then,
  ) = __$$CustomerQueueEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'page_id') String pageId,
    @JsonKey(name: 'page_name') String pageName,
    int position,
    QueueStatus status,
    QueueSource source,
    @JsonKey(name: 'package_id') String packageId,
    @JsonKey(name: 'package_name') String packageName,
    @JsonKey(name: 'package_price_cents') int packagePriceCents,
    @JsonKey(name: 'add_ons') List<QueueAddOn> addOns,
    @JsonKey(name: 'total_price_cents') int totalPriceCents,
    @JsonKey(name: 'estimated_duration_min') int estimatedDurationMin,
    @JsonKey(name: 'ahead_count') int aheadCount,
    @JsonKey(name: 'estimated_wait_min') int estimatedWaitMin,
    @JsonKey(name: 'checked_in_at') int checkedInAt,
    @JsonKey(name: 'started_at') int? startedAt,
    @JsonKey(name: 'completed_at') int? completedAt,
    @JsonKey(name: 'on_the_way') bool onTheWay,
    @JsonKey(name: 'modification_pending') bool modificationPending,
    @JsonKey(name: 'payment_methods') List<String> paymentMethods,
  });
}

/// @nodoc
class __$$CustomerQueueEntryImplCopyWithImpl<$Res>
    extends _$CustomerQueueEntryCopyWithImpl<$Res, _$CustomerQueueEntryImpl>
    implements _$$CustomerQueueEntryImplCopyWith<$Res> {
  __$$CustomerQueueEntryImplCopyWithImpl(
    _$CustomerQueueEntryImpl _value,
    $Res Function(_$CustomerQueueEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CustomerQueueEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pageId = null,
    Object? pageName = null,
    Object? position = null,
    Object? status = null,
    Object? source = null,
    Object? packageId = null,
    Object? packageName = null,
    Object? packagePriceCents = null,
    Object? addOns = null,
    Object? totalPriceCents = null,
    Object? estimatedDurationMin = null,
    Object? aheadCount = null,
    Object? estimatedWaitMin = null,
    Object? checkedInAt = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? onTheWay = null,
    Object? modificationPending = null,
    Object? paymentMethods = null,
  }) {
    return _then(
      _$CustomerQueueEntryImpl(
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
        packageId: null == packageId
            ? _value.packageId
            : packageId // ignore: cast_nullable_to_non_nullable
                  as String,
        packageName: null == packageName
            ? _value.packageName
            : packageName // ignore: cast_nullable_to_non_nullable
                  as String,
        packagePriceCents: null == packagePriceCents
            ? _value.packagePriceCents
            : packagePriceCents // ignore: cast_nullable_to_non_nullable
                  as int,
        addOns: null == addOns
            ? _value._addOns
            : addOns // ignore: cast_nullable_to_non_nullable
                  as List<QueueAddOn>,
        totalPriceCents: null == totalPriceCents
            ? _value.totalPriceCents
            : totalPriceCents // ignore: cast_nullable_to_non_nullable
                  as int,
        estimatedDurationMin: null == estimatedDurationMin
            ? _value.estimatedDurationMin
            : estimatedDurationMin // ignore: cast_nullable_to_non_nullable
                  as int,
        aheadCount: null == aheadCount
            ? _value.aheadCount
            : aheadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        estimatedWaitMin: null == estimatedWaitMin
            ? _value.estimatedWaitMin
            : estimatedWaitMin // ignore: cast_nullable_to_non_nullable
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
        onTheWay: null == onTheWay
            ? _value.onTheWay
            : onTheWay // ignore: cast_nullable_to_non_nullable
                  as bool,
        modificationPending: null == modificationPending
            ? _value.modificationPending
            : modificationPending // ignore: cast_nullable_to_non_nullable
                  as bool,
        paymentMethods: null == paymentMethods
            ? _value._paymentMethods
            : paymentMethods // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerQueueEntryImpl implements _CustomerQueueEntry {
  const _$CustomerQueueEntryImpl({
    required this.id,
    @JsonKey(name: 'page_id') required this.pageId,
    @JsonKey(name: 'page_name') required this.pageName,
    required this.position,
    required this.status,
    required this.source,
    @JsonKey(name: 'package_id') required this.packageId,
    @JsonKey(name: 'package_name') required this.packageName,
    @JsonKey(name: 'package_price_cents') required this.packagePriceCents,
    @JsonKey(name: 'add_ons') final List<QueueAddOn> addOns = const [],
    @JsonKey(name: 'total_price_cents') required this.totalPriceCents,
    @JsonKey(name: 'estimated_duration_min') required this.estimatedDurationMin,
    @JsonKey(name: 'ahead_count') this.aheadCount = 0,
    @JsonKey(name: 'estimated_wait_min') this.estimatedWaitMin = 0,
    @JsonKey(name: 'checked_in_at') required this.checkedInAt,
    @JsonKey(name: 'started_at') this.startedAt,
    @JsonKey(name: 'completed_at') this.completedAt,
    @JsonKey(name: 'on_the_way') this.onTheWay = false,
    @JsonKey(name: 'modification_pending') this.modificationPending = false,
    @JsonKey(name: 'payment_methods')
    final List<String> paymentMethods = const [],
  }) : _addOns = addOns,
       _paymentMethods = paymentMethods;

  factory _$CustomerQueueEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerQueueEntryImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'page_id')
  final String pageId;
  @override
  @JsonKey(name: 'page_name')
  final String pageName;
  @override
  final int position;
  @override
  final QueueStatus status;
  @override
  final QueueSource source;
  // Service details
  @override
  @JsonKey(name: 'package_id')
  final String packageId;
  @override
  @JsonKey(name: 'package_name')
  final String packageName;
  @override
  @JsonKey(name: 'package_price_cents')
  final int packagePriceCents;
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
  final int totalPriceCents;
  @override
  @JsonKey(name: 'estimated_duration_min')
  final int estimatedDurationMin;
  // Queue context
  @override
  @JsonKey(name: 'ahead_count')
  final int aheadCount;
  @override
  @JsonKey(name: 'estimated_wait_min')
  final int estimatedWaitMin;
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
  // Flags
  @override
  @JsonKey(name: 'on_the_way')
  final bool onTheWay;
  @override
  @JsonKey(name: 'modification_pending')
  final bool modificationPending;
  // Payment info (shown on ready state)
  final List<String> _paymentMethods;
  // Payment info (shown on ready state)
  @override
  @JsonKey(name: 'payment_methods')
  List<String> get paymentMethods {
    if (_paymentMethods is EqualUnmodifiableListView) return _paymentMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentMethods);
  }

  @override
  String toString() {
    return 'CustomerQueueEntry(id: $id, pageId: $pageId, pageName: $pageName, position: $position, status: $status, source: $source, packageId: $packageId, packageName: $packageName, packagePriceCents: $packagePriceCents, addOns: $addOns, totalPriceCents: $totalPriceCents, estimatedDurationMin: $estimatedDurationMin, aheadCount: $aheadCount, estimatedWaitMin: $estimatedWaitMin, checkedInAt: $checkedInAt, startedAt: $startedAt, completedAt: $completedAt, onTheWay: $onTheWay, modificationPending: $modificationPending, paymentMethods: $paymentMethods)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerQueueEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pageId, pageId) || other.pageId == pageId) &&
            (identical(other.pageName, pageName) ||
                other.pageName == pageName) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.packageId, packageId) ||
                other.packageId == packageId) &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.packagePriceCents, packagePriceCents) ||
                other.packagePriceCents == packagePriceCents) &&
            const DeepCollectionEquality().equals(other._addOns, _addOns) &&
            (identical(other.totalPriceCents, totalPriceCents) ||
                other.totalPriceCents == totalPriceCents) &&
            (identical(other.estimatedDurationMin, estimatedDurationMin) ||
                other.estimatedDurationMin == estimatedDurationMin) &&
            (identical(other.aheadCount, aheadCount) ||
                other.aheadCount == aheadCount) &&
            (identical(other.estimatedWaitMin, estimatedWaitMin) ||
                other.estimatedWaitMin == estimatedWaitMin) &&
            (identical(other.checkedInAt, checkedInAt) ||
                other.checkedInAt == checkedInAt) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.onTheWay, onTheWay) ||
                other.onTheWay == onTheWay) &&
            (identical(other.modificationPending, modificationPending) ||
                other.modificationPending == modificationPending) &&
            const DeepCollectionEquality().equals(
              other._paymentMethods,
              _paymentMethods,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    pageId,
    pageName,
    position,
    status,
    source,
    packageId,
    packageName,
    packagePriceCents,
    const DeepCollectionEquality().hash(_addOns),
    totalPriceCents,
    estimatedDurationMin,
    aheadCount,
    estimatedWaitMin,
    checkedInAt,
    startedAt,
    completedAt,
    onTheWay,
    modificationPending,
    const DeepCollectionEquality().hash(_paymentMethods),
  ]);

  /// Create a copy of CustomerQueueEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerQueueEntryImplCopyWith<_$CustomerQueueEntryImpl> get copyWith =>
      __$$CustomerQueueEntryImplCopyWithImpl<_$CustomerQueueEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerQueueEntryImplToJson(this);
  }
}

abstract class _CustomerQueueEntry implements CustomerQueueEntry {
  const factory _CustomerQueueEntry({
    required final String id,
    @JsonKey(name: 'page_id') required final String pageId,
    @JsonKey(name: 'page_name') required final String pageName,
    required final int position,
    required final QueueStatus status,
    required final QueueSource source,
    @JsonKey(name: 'package_id') required final String packageId,
    @JsonKey(name: 'package_name') required final String packageName,
    @JsonKey(name: 'package_price_cents') required final int packagePriceCents,
    @JsonKey(name: 'add_ons') final List<QueueAddOn> addOns,
    @JsonKey(name: 'total_price_cents') required final int totalPriceCents,
    @JsonKey(name: 'estimated_duration_min')
    required final int estimatedDurationMin,
    @JsonKey(name: 'ahead_count') final int aheadCount,
    @JsonKey(name: 'estimated_wait_min') final int estimatedWaitMin,
    @JsonKey(name: 'checked_in_at') required final int checkedInAt,
    @JsonKey(name: 'started_at') final int? startedAt,
    @JsonKey(name: 'completed_at') final int? completedAt,
    @JsonKey(name: 'on_the_way') final bool onTheWay,
    @JsonKey(name: 'modification_pending') final bool modificationPending,
    @JsonKey(name: 'payment_methods') final List<String> paymentMethods,
  }) = _$CustomerQueueEntryImpl;

  factory _CustomerQueueEntry.fromJson(Map<String, dynamic> json) =
      _$CustomerQueueEntryImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'page_id')
  String get pageId;
  @override
  @JsonKey(name: 'page_name')
  String get pageName;
  @override
  int get position;
  @override
  QueueStatus get status;
  @override
  QueueSource get source; // Service details
  @override
  @JsonKey(name: 'package_id')
  String get packageId;
  @override
  @JsonKey(name: 'package_name')
  String get packageName;
  @override
  @JsonKey(name: 'package_price_cents')
  int get packagePriceCents;
  @override
  @JsonKey(name: 'add_ons')
  List<QueueAddOn> get addOns;
  @override
  @JsonKey(name: 'total_price_cents')
  int get totalPriceCents;
  @override
  @JsonKey(name: 'estimated_duration_min')
  int get estimatedDurationMin; // Queue context
  @override
  @JsonKey(name: 'ahead_count')
  int get aheadCount;
  @override
  @JsonKey(name: 'estimated_wait_min')
  int get estimatedWaitMin; // Timestamps (unix epoch seconds)
  @override
  @JsonKey(name: 'checked_in_at')
  int get checkedInAt;
  @override
  @JsonKey(name: 'started_at')
  int? get startedAt;
  @override
  @JsonKey(name: 'completed_at')
  int? get completedAt; // Flags
  @override
  @JsonKey(name: 'on_the_way')
  bool get onTheWay;
  @override
  @JsonKey(name: 'modification_pending')
  bool get modificationPending; // Payment info (shown on ready state)
  @override
  @JsonKey(name: 'payment_methods')
  List<String> get paymentMethods;

  /// Create a copy of CustomerQueueEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerQueueEntryImplCopyWith<_$CustomerQueueEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
