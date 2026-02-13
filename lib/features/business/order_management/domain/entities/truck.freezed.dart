// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'truck.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Truck _$TruckFromJson(Map<String, dynamic> json) {
  return _Truck.fromJson(json);
}

/// @nodoc
mixin _$Truck {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'driver_name')
  String get driverName => throw _privateConstructorUsedError;
  @JsonKey(name: 'driver_phone')
  String get driverPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'assigned_driver_ids')
  List<String> get assignedDriverIds => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  @JsonKey(name: 'capacity_full')
  int get capacityFull => throw _privateConstructorUsedError;
  @JsonKey(name: 'capacity_empty')
  int get capacityEmpty => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivery_days')
  List<String> get deliveryDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'route_window')
  RouteWindow? get routeWindow => throw _privateConstructorUsedError;
  List<TruckZone> get zones => throw _privateConstructorUsedError;
  TruckToday get today => throw _privateConstructorUsedError;

  /// Serializes this Truck to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Truck
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TruckCopyWith<Truck> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TruckCopyWith<$Res> {
  factory $TruckCopyWith(Truck value, $Res Function(Truck) then) =
      _$TruckCopyWithImpl<$Res, Truck>;
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'driver_name') String driverName,
    @JsonKey(name: 'driver_phone') String driverPhone,
    @JsonKey(name: 'assigned_driver_ids') List<String> assignedDriverIds,
    String color,
    @JsonKey(name: 'capacity_full') int capacityFull,
    @JsonKey(name: 'capacity_empty') int capacityEmpty,
    @JsonKey(name: 'delivery_days') List<String> deliveryDays,
    @JsonKey(name: 'route_window') RouteWindow? routeWindow,
    List<TruckZone> zones,
    TruckToday today,
  });

  $RouteWindowCopyWith<$Res>? get routeWindow;
  $TruckTodayCopyWith<$Res> get today;
}

/// @nodoc
class _$TruckCopyWithImpl<$Res, $Val extends Truck>
    implements $TruckCopyWith<$Res> {
  _$TruckCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Truck
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? driverName = null,
    Object? driverPhone = null,
    Object? assignedDriverIds = null,
    Object? color = null,
    Object? capacityFull = null,
    Object? capacityEmpty = null,
    Object? deliveryDays = null,
    Object? routeWindow = freezed,
    Object? zones = null,
    Object? today = null,
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
            driverName: null == driverName
                ? _value.driverName
                : driverName // ignore: cast_nullable_to_non_nullable
                      as String,
            driverPhone: null == driverPhone
                ? _value.driverPhone
                : driverPhone // ignore: cast_nullable_to_non_nullable
                      as String,
            assignedDriverIds: null == assignedDriverIds
                ? _value.assignedDriverIds
                : assignedDriverIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String,
            capacityFull: null == capacityFull
                ? _value.capacityFull
                : capacityFull // ignore: cast_nullable_to_non_nullable
                      as int,
            capacityEmpty: null == capacityEmpty
                ? _value.capacityEmpty
                : capacityEmpty // ignore: cast_nullable_to_non_nullable
                      as int,
            deliveryDays: null == deliveryDays
                ? _value.deliveryDays
                : deliveryDays // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            routeWindow: freezed == routeWindow
                ? _value.routeWindow
                : routeWindow // ignore: cast_nullable_to_non_nullable
                      as RouteWindow?,
            zones: null == zones
                ? _value.zones
                : zones // ignore: cast_nullable_to_non_nullable
                      as List<TruckZone>,
            today: null == today
                ? _value.today
                : today // ignore: cast_nullable_to_non_nullable
                      as TruckToday,
          )
          as $Val,
    );
  }

  /// Create a copy of Truck
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RouteWindowCopyWith<$Res>? get routeWindow {
    if (_value.routeWindow == null) {
      return null;
    }

    return $RouteWindowCopyWith<$Res>(_value.routeWindow!, (value) {
      return _then(_value.copyWith(routeWindow: value) as $Val);
    });
  }

  /// Create a copy of Truck
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TruckTodayCopyWith<$Res> get today {
    return $TruckTodayCopyWith<$Res>(_value.today, (value) {
      return _then(_value.copyWith(today: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TruckImplCopyWith<$Res> implements $TruckCopyWith<$Res> {
  factory _$$TruckImplCopyWith(
    _$TruckImpl value,
    $Res Function(_$TruckImpl) then,
  ) = __$$TruckImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'driver_name') String driverName,
    @JsonKey(name: 'driver_phone') String driverPhone,
    @JsonKey(name: 'assigned_driver_ids') List<String> assignedDriverIds,
    String color,
    @JsonKey(name: 'capacity_full') int capacityFull,
    @JsonKey(name: 'capacity_empty') int capacityEmpty,
    @JsonKey(name: 'delivery_days') List<String> deliveryDays,
    @JsonKey(name: 'route_window') RouteWindow? routeWindow,
    List<TruckZone> zones,
    TruckToday today,
  });

  @override
  $RouteWindowCopyWith<$Res>? get routeWindow;
  @override
  $TruckTodayCopyWith<$Res> get today;
}

/// @nodoc
class __$$TruckImplCopyWithImpl<$Res>
    extends _$TruckCopyWithImpl<$Res, _$TruckImpl>
    implements _$$TruckImplCopyWith<$Res> {
  __$$TruckImplCopyWithImpl(
    _$TruckImpl _value,
    $Res Function(_$TruckImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Truck
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? driverName = null,
    Object? driverPhone = null,
    Object? assignedDriverIds = null,
    Object? color = null,
    Object? capacityFull = null,
    Object? capacityEmpty = null,
    Object? deliveryDays = null,
    Object? routeWindow = freezed,
    Object? zones = null,
    Object? today = null,
  }) {
    return _then(
      _$TruckImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        driverName: null == driverName
            ? _value.driverName
            : driverName // ignore: cast_nullable_to_non_nullable
                  as String,
        driverPhone: null == driverPhone
            ? _value.driverPhone
            : driverPhone // ignore: cast_nullable_to_non_nullable
                  as String,
        assignedDriverIds: null == assignedDriverIds
            ? _value._assignedDriverIds
            : assignedDriverIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String,
        capacityFull: null == capacityFull
            ? _value.capacityFull
            : capacityFull // ignore: cast_nullable_to_non_nullable
                  as int,
        capacityEmpty: null == capacityEmpty
            ? _value.capacityEmpty
            : capacityEmpty // ignore: cast_nullable_to_non_nullable
                  as int,
        deliveryDays: null == deliveryDays
            ? _value._deliveryDays
            : deliveryDays // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        routeWindow: freezed == routeWindow
            ? _value.routeWindow
            : routeWindow // ignore: cast_nullable_to_non_nullable
                  as RouteWindow?,
        zones: null == zones
            ? _value._zones
            : zones // ignore: cast_nullable_to_non_nullable
                  as List<TruckZone>,
        today: null == today
            ? _value.today
            : today // ignore: cast_nullable_to_non_nullable
                  as TruckToday,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TruckImpl implements _Truck {
  const _$TruckImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'driver_name') required this.driverName,
    @JsonKey(name: 'driver_phone') required this.driverPhone,
    @JsonKey(name: 'assigned_driver_ids')
    final List<String> assignedDriverIds = const [],
    required this.color,
    @JsonKey(name: 'capacity_full') required this.capacityFull,
    @JsonKey(name: 'capacity_empty') required this.capacityEmpty,
    @JsonKey(name: 'delivery_days') final List<String> deliveryDays = const [],
    @JsonKey(name: 'route_window') this.routeWindow,
    final List<TruckZone> zones = const [],
    required this.today,
  }) : _assignedDriverIds = assignedDriverIds,
       _deliveryDays = deliveryDays,
       _zones = zones;

  factory _$TruckImpl.fromJson(Map<String, dynamic> json) =>
      _$$TruckImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'driver_name')
  final String driverName;
  @override
  @JsonKey(name: 'driver_phone')
  final String driverPhone;
  final List<String> _assignedDriverIds;
  @override
  @JsonKey(name: 'assigned_driver_ids')
  List<String> get assignedDriverIds {
    if (_assignedDriverIds is EqualUnmodifiableListView)
      return _assignedDriverIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assignedDriverIds);
  }

  @override
  final String color;
  @override
  @JsonKey(name: 'capacity_full')
  final int capacityFull;
  @override
  @JsonKey(name: 'capacity_empty')
  final int capacityEmpty;
  final List<String> _deliveryDays;
  @override
  @JsonKey(name: 'delivery_days')
  List<String> get deliveryDays {
    if (_deliveryDays is EqualUnmodifiableListView) return _deliveryDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deliveryDays);
  }

  @override
  @JsonKey(name: 'route_window')
  final RouteWindow? routeWindow;
  final List<TruckZone> _zones;
  @override
  @JsonKey()
  List<TruckZone> get zones {
    if (_zones is EqualUnmodifiableListView) return _zones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_zones);
  }

  @override
  final TruckToday today;

  @override
  String toString() {
    return 'Truck(id: $id, name: $name, driverName: $driverName, driverPhone: $driverPhone, assignedDriverIds: $assignedDriverIds, color: $color, capacityFull: $capacityFull, capacityEmpty: $capacityEmpty, deliveryDays: $deliveryDays, routeWindow: $routeWindow, zones: $zones, today: $today)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TruckImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.driverName, driverName) ||
                other.driverName == driverName) &&
            (identical(other.driverPhone, driverPhone) ||
                other.driverPhone == driverPhone) &&
            const DeepCollectionEquality().equals(
              other._assignedDriverIds,
              _assignedDriverIds,
            ) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.capacityFull, capacityFull) ||
                other.capacityFull == capacityFull) &&
            (identical(other.capacityEmpty, capacityEmpty) ||
                other.capacityEmpty == capacityEmpty) &&
            const DeepCollectionEquality().equals(
              other._deliveryDays,
              _deliveryDays,
            ) &&
            (identical(other.routeWindow, routeWindow) ||
                other.routeWindow == routeWindow) &&
            const DeepCollectionEquality().equals(other._zones, _zones) &&
            (identical(other.today, today) || other.today == today));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    driverName,
    driverPhone,
    const DeepCollectionEquality().hash(_assignedDriverIds),
    color,
    capacityFull,
    capacityEmpty,
    const DeepCollectionEquality().hash(_deliveryDays),
    routeWindow,
    const DeepCollectionEquality().hash(_zones),
    today,
  );

  /// Create a copy of Truck
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TruckImplCopyWith<_$TruckImpl> get copyWith =>
      __$$TruckImplCopyWithImpl<_$TruckImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TruckImplToJson(this);
  }
}

abstract class _Truck implements Truck {
  const factory _Truck({
    required final String id,
    required final String name,
    @JsonKey(name: 'driver_name') required final String driverName,
    @JsonKey(name: 'driver_phone') required final String driverPhone,
    @JsonKey(name: 'assigned_driver_ids') final List<String> assignedDriverIds,
    required final String color,
    @JsonKey(name: 'capacity_full') required final int capacityFull,
    @JsonKey(name: 'capacity_empty') required final int capacityEmpty,
    @JsonKey(name: 'delivery_days') final List<String> deliveryDays,
    @JsonKey(name: 'route_window') final RouteWindow? routeWindow,
    final List<TruckZone> zones,
    required final TruckToday today,
  }) = _$TruckImpl;

  factory _Truck.fromJson(Map<String, dynamic> json) = _$TruckImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'driver_name')
  String get driverName;
  @override
  @JsonKey(name: 'driver_phone')
  String get driverPhone;
  @override
  @JsonKey(name: 'assigned_driver_ids')
  List<String> get assignedDriverIds;
  @override
  String get color;
  @override
  @JsonKey(name: 'capacity_full')
  int get capacityFull;
  @override
  @JsonKey(name: 'capacity_empty')
  int get capacityEmpty;
  @override
  @JsonKey(name: 'delivery_days')
  List<String> get deliveryDays;
  @override
  @JsonKey(name: 'route_window')
  RouteWindow? get routeWindow;
  @override
  List<TruckZone> get zones;
  @override
  TruckToday get today;

  /// Create a copy of Truck
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TruckImplCopyWith<_$TruckImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TruckToday _$TruckTodayFromJson(Map<String, dynamic> json) {
  return _TruckToday.fromJson(json);
}

/// @nodoc
mixin _$TruckToday {
  TruckStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'started_at')
  String? get startedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'ended_at')
  String? get endedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_full')
  int get currentFull => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_empty')
  int get currentEmpty => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivered_count')
  int get deliveredCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'remaining_count')
  int get remainingCount => throw _privateConstructorUsedError;
  int get reloads => throw _privateConstructorUsedError;

  /// Serializes this TruckToday to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TruckToday
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TruckTodayCopyWith<TruckToday> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TruckTodayCopyWith<$Res> {
  factory $TruckTodayCopyWith(
    TruckToday value,
    $Res Function(TruckToday) then,
  ) = _$TruckTodayCopyWithImpl<$Res, TruckToday>;
  @useResult
  $Res call({
    TruckStatus status,
    @JsonKey(name: 'started_at') String? startedAt,
    @JsonKey(name: 'ended_at') String? endedAt,
    @JsonKey(name: 'current_full') int currentFull,
    @JsonKey(name: 'current_empty') int currentEmpty,
    @JsonKey(name: 'delivered_count') int deliveredCount,
    @JsonKey(name: 'remaining_count') int remainingCount,
    int reloads,
  });
}

/// @nodoc
class _$TruckTodayCopyWithImpl<$Res, $Val extends TruckToday>
    implements $TruckTodayCopyWith<$Res> {
  _$TruckTodayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TruckToday
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
    Object? currentFull = null,
    Object? currentEmpty = null,
    Object? deliveredCount = null,
    Object? remainingCount = null,
    Object? reloads = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as TruckStatus,
            startedAt: freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            endedAt: freezed == endedAt
                ? _value.endedAt
                : endedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentFull: null == currentFull
                ? _value.currentFull
                : currentFull // ignore: cast_nullable_to_non_nullable
                      as int,
            currentEmpty: null == currentEmpty
                ? _value.currentEmpty
                : currentEmpty // ignore: cast_nullable_to_non_nullable
                      as int,
            deliveredCount: null == deliveredCount
                ? _value.deliveredCount
                : deliveredCount // ignore: cast_nullable_to_non_nullable
                      as int,
            remainingCount: null == remainingCount
                ? _value.remainingCount
                : remainingCount // ignore: cast_nullable_to_non_nullable
                      as int,
            reloads: null == reloads
                ? _value.reloads
                : reloads // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TruckTodayImplCopyWith<$Res>
    implements $TruckTodayCopyWith<$Res> {
  factory _$$TruckTodayImplCopyWith(
    _$TruckTodayImpl value,
    $Res Function(_$TruckTodayImpl) then,
  ) = __$$TruckTodayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    TruckStatus status,
    @JsonKey(name: 'started_at') String? startedAt,
    @JsonKey(name: 'ended_at') String? endedAt,
    @JsonKey(name: 'current_full') int currentFull,
    @JsonKey(name: 'current_empty') int currentEmpty,
    @JsonKey(name: 'delivered_count') int deliveredCount,
    @JsonKey(name: 'remaining_count') int remainingCount,
    int reloads,
  });
}

/// @nodoc
class __$$TruckTodayImplCopyWithImpl<$Res>
    extends _$TruckTodayCopyWithImpl<$Res, _$TruckTodayImpl>
    implements _$$TruckTodayImplCopyWith<$Res> {
  __$$TruckTodayImplCopyWithImpl(
    _$TruckTodayImpl _value,
    $Res Function(_$TruckTodayImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TruckToday
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
    Object? currentFull = null,
    Object? currentEmpty = null,
    Object? deliveredCount = null,
    Object? remainingCount = null,
    Object? reloads = null,
  }) {
    return _then(
      _$TruckTodayImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as TruckStatus,
        startedAt: freezed == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        endedAt: freezed == endedAt
            ? _value.endedAt
            : endedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentFull: null == currentFull
            ? _value.currentFull
            : currentFull // ignore: cast_nullable_to_non_nullable
                  as int,
        currentEmpty: null == currentEmpty
            ? _value.currentEmpty
            : currentEmpty // ignore: cast_nullable_to_non_nullable
                  as int,
        deliveredCount: null == deliveredCount
            ? _value.deliveredCount
            : deliveredCount // ignore: cast_nullable_to_non_nullable
                  as int,
        remainingCount: null == remainingCount
            ? _value.remainingCount
            : remainingCount // ignore: cast_nullable_to_non_nullable
                  as int,
        reloads: null == reloads
            ? _value.reloads
            : reloads // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TruckTodayImpl implements _TruckToday {
  const _$TruckTodayImpl({
    required this.status,
    @JsonKey(name: 'started_at') this.startedAt,
    @JsonKey(name: 'ended_at') this.endedAt,
    @JsonKey(name: 'current_full') this.currentFull = 0,
    @JsonKey(name: 'current_empty') this.currentEmpty = 0,
    @JsonKey(name: 'delivered_count') this.deliveredCount = 0,
    @JsonKey(name: 'remaining_count') this.remainingCount = 0,
    this.reloads = 0,
  });

  factory _$TruckTodayImpl.fromJson(Map<String, dynamic> json) =>
      _$$TruckTodayImplFromJson(json);

  @override
  final TruckStatus status;
  @override
  @JsonKey(name: 'started_at')
  final String? startedAt;
  @override
  @JsonKey(name: 'ended_at')
  final String? endedAt;
  @override
  @JsonKey(name: 'current_full')
  final int currentFull;
  @override
  @JsonKey(name: 'current_empty')
  final int currentEmpty;
  @override
  @JsonKey(name: 'delivered_count')
  final int deliveredCount;
  @override
  @JsonKey(name: 'remaining_count')
  final int remainingCount;
  @override
  @JsonKey()
  final int reloads;

  @override
  String toString() {
    return 'TruckToday(status: $status, startedAt: $startedAt, endedAt: $endedAt, currentFull: $currentFull, currentEmpty: $currentEmpty, deliveredCount: $deliveredCount, remainingCount: $remainingCount, reloads: $reloads)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TruckTodayImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.currentFull, currentFull) ||
                other.currentFull == currentFull) &&
            (identical(other.currentEmpty, currentEmpty) ||
                other.currentEmpty == currentEmpty) &&
            (identical(other.deliveredCount, deliveredCount) ||
                other.deliveredCount == deliveredCount) &&
            (identical(other.remainingCount, remainingCount) ||
                other.remainingCount == remainingCount) &&
            (identical(other.reloads, reloads) || other.reloads == reloads));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    startedAt,
    endedAt,
    currentFull,
    currentEmpty,
    deliveredCount,
    remainingCount,
    reloads,
  );

  /// Create a copy of TruckToday
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TruckTodayImplCopyWith<_$TruckTodayImpl> get copyWith =>
      __$$TruckTodayImplCopyWithImpl<_$TruckTodayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TruckTodayImplToJson(this);
  }
}

abstract class _TruckToday implements TruckToday {
  const factory _TruckToday({
    required final TruckStatus status,
    @JsonKey(name: 'started_at') final String? startedAt,
    @JsonKey(name: 'ended_at') final String? endedAt,
    @JsonKey(name: 'current_full') final int currentFull,
    @JsonKey(name: 'current_empty') final int currentEmpty,
    @JsonKey(name: 'delivered_count') final int deliveredCount,
    @JsonKey(name: 'remaining_count') final int remainingCount,
    final int reloads,
  }) = _$TruckTodayImpl;

  factory _TruckToday.fromJson(Map<String, dynamic> json) =
      _$TruckTodayImpl.fromJson;

  @override
  TruckStatus get status;
  @override
  @JsonKey(name: 'started_at')
  String? get startedAt;
  @override
  @JsonKey(name: 'ended_at')
  String? get endedAt;
  @override
  @JsonKey(name: 'current_full')
  int get currentFull;
  @override
  @JsonKey(name: 'current_empty')
  int get currentEmpty;
  @override
  @JsonKey(name: 'delivered_count')
  int get deliveredCount;
  @override
  @JsonKey(name: 'remaining_count')
  int get remainingCount;
  @override
  int get reloads;

  /// Create a copy of TruckToday
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TruckTodayImplCopyWith<_$TruckTodayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RouteWindow _$RouteWindowFromJson(Map<String, dynamic> json) {
  return _RouteWindow.fromJson(json);
}

/// @nodoc
mixin _$RouteWindow {
  String get start => throw _privateConstructorUsedError;
  String get end => throw _privateConstructorUsedError;

  /// Serializes this RouteWindow to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteWindow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteWindowCopyWith<RouteWindow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteWindowCopyWith<$Res> {
  factory $RouteWindowCopyWith(
    RouteWindow value,
    $Res Function(RouteWindow) then,
  ) = _$RouteWindowCopyWithImpl<$Res, RouteWindow>;
  @useResult
  $Res call({String start, String end});
}

/// @nodoc
class _$RouteWindowCopyWithImpl<$Res, $Val extends RouteWindow>
    implements $RouteWindowCopyWith<$Res> {
  _$RouteWindowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteWindow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? start = null, Object? end = null}) {
    return _then(
      _value.copyWith(
            start: null == start
                ? _value.start
                : start // ignore: cast_nullable_to_non_nullable
                      as String,
            end: null == end
                ? _value.end
                : end // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RouteWindowImplCopyWith<$Res>
    implements $RouteWindowCopyWith<$Res> {
  factory _$$RouteWindowImplCopyWith(
    _$RouteWindowImpl value,
    $Res Function(_$RouteWindowImpl) then,
  ) = __$$RouteWindowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String start, String end});
}

/// @nodoc
class __$$RouteWindowImplCopyWithImpl<$Res>
    extends _$RouteWindowCopyWithImpl<$Res, _$RouteWindowImpl>
    implements _$$RouteWindowImplCopyWith<$Res> {
  __$$RouteWindowImplCopyWithImpl(
    _$RouteWindowImpl _value,
    $Res Function(_$RouteWindowImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RouteWindow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? start = null, Object? end = null}) {
    return _then(
      _$RouteWindowImpl(
        start: null == start
            ? _value.start
            : start // ignore: cast_nullable_to_non_nullable
                  as String,
        end: null == end
            ? _value.end
            : end // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteWindowImpl implements _RouteWindow {
  const _$RouteWindowImpl({required this.start, required this.end});

  factory _$RouteWindowImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteWindowImplFromJson(json);

  @override
  final String start;
  @override
  final String end;

  @override
  String toString() {
    return 'RouteWindow(start: $start, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteWindowImpl &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, start, end);

  /// Create a copy of RouteWindow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteWindowImplCopyWith<_$RouteWindowImpl> get copyWith =>
      __$$RouteWindowImplCopyWithImpl<_$RouteWindowImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteWindowImplToJson(this);
  }
}

abstract class _RouteWindow implements RouteWindow {
  const factory _RouteWindow({
    required final String start,
    required final String end,
  }) = _$RouteWindowImpl;

  factory _RouteWindow.fromJson(Map<String, dynamic> json) =
      _$RouteWindowImpl.fromJson;

  @override
  String get start;
  @override
  String get end;

  /// Create a copy of RouteWindow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteWindowImplCopyWith<_$RouteWindowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TruckZone _$TruckZoneFromJson(Map<String, dynamic> json) {
  return _TruckZone.fromJson(json);
}

/// @nodoc
mixin _$TruckZone {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<LatLng> get polygon => throw _privateConstructorUsedError;
  @JsonKey(name: 'approximate_area_km2')
  double get approximateAreaKm2 => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;

  /// Serializes this TruckZone to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TruckZone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TruckZoneCopyWith<TruckZone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TruckZoneCopyWith<$Res> {
  factory $TruckZoneCopyWith(TruckZone value, $Res Function(TruckZone) then) =
      _$TruckZoneCopyWithImpl<$Res, TruckZone>;
  @useResult
  $Res call({
    String id,
    String name,
    List<LatLng> polygon,
    @JsonKey(name: 'approximate_area_km2') double approximateAreaKm2,
    String label,
  });
}

/// @nodoc
class _$TruckZoneCopyWithImpl<$Res, $Val extends TruckZone>
    implements $TruckZoneCopyWith<$Res> {
  _$TruckZoneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TruckZone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? polygon = null,
    Object? approximateAreaKm2 = null,
    Object? label = null,
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
            polygon: null == polygon
                ? _value.polygon
                : polygon // ignore: cast_nullable_to_non_nullable
                      as List<LatLng>,
            approximateAreaKm2: null == approximateAreaKm2
                ? _value.approximateAreaKm2
                : approximateAreaKm2 // ignore: cast_nullable_to_non_nullable
                      as double,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TruckZoneImplCopyWith<$Res>
    implements $TruckZoneCopyWith<$Res> {
  factory _$$TruckZoneImplCopyWith(
    _$TruckZoneImpl value,
    $Res Function(_$TruckZoneImpl) then,
  ) = __$$TruckZoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    List<LatLng> polygon,
    @JsonKey(name: 'approximate_area_km2') double approximateAreaKm2,
    String label,
  });
}

/// @nodoc
class __$$TruckZoneImplCopyWithImpl<$Res>
    extends _$TruckZoneCopyWithImpl<$Res, _$TruckZoneImpl>
    implements _$$TruckZoneImplCopyWith<$Res> {
  __$$TruckZoneImplCopyWithImpl(
    _$TruckZoneImpl _value,
    $Res Function(_$TruckZoneImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TruckZone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? polygon = null,
    Object? approximateAreaKm2 = null,
    Object? label = null,
  }) {
    return _then(
      _$TruckZoneImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        polygon: null == polygon
            ? _value._polygon
            : polygon // ignore: cast_nullable_to_non_nullable
                  as List<LatLng>,
        approximateAreaKm2: null == approximateAreaKm2
            ? _value.approximateAreaKm2
            : approximateAreaKm2 // ignore: cast_nullable_to_non_nullable
                  as double,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TruckZoneImpl implements _TruckZone {
  const _$TruckZoneImpl({
    required this.id,
    required this.name,
    final List<LatLng> polygon = const [],
    @JsonKey(name: 'approximate_area_km2') this.approximateAreaKm2 = 0,
    this.label = '',
  }) : _polygon = polygon;

  factory _$TruckZoneImpl.fromJson(Map<String, dynamic> json) =>
      _$$TruckZoneImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<LatLng> _polygon;
  @override
  @JsonKey()
  List<LatLng> get polygon {
    if (_polygon is EqualUnmodifiableListView) return _polygon;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_polygon);
  }

  @override
  @JsonKey(name: 'approximate_area_km2')
  final double approximateAreaKm2;
  @override
  @JsonKey()
  final String label;

  @override
  String toString() {
    return 'TruckZone(id: $id, name: $name, polygon: $polygon, approximateAreaKm2: $approximateAreaKm2, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TruckZoneImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._polygon, _polygon) &&
            (identical(other.approximateAreaKm2, approximateAreaKm2) ||
                other.approximateAreaKm2 == approximateAreaKm2) &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    const DeepCollectionEquality().hash(_polygon),
    approximateAreaKm2,
    label,
  );

  /// Create a copy of TruckZone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TruckZoneImplCopyWith<_$TruckZoneImpl> get copyWith =>
      __$$TruckZoneImplCopyWithImpl<_$TruckZoneImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TruckZoneImplToJson(this);
  }
}

abstract class _TruckZone implements TruckZone {
  const factory _TruckZone({
    required final String id,
    required final String name,
    final List<LatLng> polygon,
    @JsonKey(name: 'approximate_area_km2') final double approximateAreaKm2,
    final String label,
  }) = _$TruckZoneImpl;

  factory _TruckZone.fromJson(Map<String, dynamic> json) =
      _$TruckZoneImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<LatLng> get polygon;
  @override
  @JsonKey(name: 'approximate_area_km2')
  double get approximateAreaKm2;
  @override
  String get label;

  /// Create a copy of TruckZone
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TruckZoneImplCopyWith<_$TruckZoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LatLng _$LatLngFromJson(Map<String, dynamic> json) {
  return _LatLng.fromJson(json);
}

/// @nodoc
mixin _$LatLng {
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;

  /// Serializes this LatLng to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LatLng
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LatLngCopyWith<LatLng> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LatLngCopyWith<$Res> {
  factory $LatLngCopyWith(LatLng value, $Res Function(LatLng) then) =
      _$LatLngCopyWithImpl<$Res, LatLng>;
  @useResult
  $Res call({double lat, double lng});
}

/// @nodoc
class _$LatLngCopyWithImpl<$Res, $Val extends LatLng>
    implements $LatLngCopyWith<$Res> {
  _$LatLngCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LatLng
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? lat = null, Object? lng = null}) {
    return _then(
      _value.copyWith(
            lat: null == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double,
            lng: null == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LatLngImplCopyWith<$Res> implements $LatLngCopyWith<$Res> {
  factory _$$LatLngImplCopyWith(
    _$LatLngImpl value,
    $Res Function(_$LatLngImpl) then,
  ) = __$$LatLngImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double lat, double lng});
}

/// @nodoc
class __$$LatLngImplCopyWithImpl<$Res>
    extends _$LatLngCopyWithImpl<$Res, _$LatLngImpl>
    implements _$$LatLngImplCopyWith<$Res> {
  __$$LatLngImplCopyWithImpl(
    _$LatLngImpl _value,
    $Res Function(_$LatLngImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LatLng
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? lat = null, Object? lng = null}) {
    return _then(
      _$LatLngImpl(
        lat: null == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double,
        lng: null == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LatLngImpl implements _LatLng {
  const _$LatLngImpl({required this.lat, required this.lng});

  factory _$LatLngImpl.fromJson(Map<String, dynamic> json) =>
      _$$LatLngImplFromJson(json);

  @override
  final double lat;
  @override
  final double lng;

  @override
  String toString() {
    return 'LatLng(lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LatLngImpl &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lng);

  /// Create a copy of LatLng
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LatLngImplCopyWith<_$LatLngImpl> get copyWith =>
      __$$LatLngImplCopyWithImpl<_$LatLngImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LatLngImplToJson(this);
  }
}

abstract class _LatLng implements LatLng {
  const factory _LatLng({
    required final double lat,
    required final double lng,
  }) = _$LatLngImpl;

  factory _LatLng.fromJson(Map<String, dynamic> json) = _$LatLngImpl.fromJson;

  @override
  double get lat;
  @override
  double get lng;

  /// Create a copy of LatLng
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LatLngImplCopyWith<_$LatLngImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QueueItem _$QueueItemFromJson(Map<String, dynamic> json) {
  return _QueueItem.fromJson(json);
}

/// @nodoc
mixin _$QueueItem {
  int get position => throw _privateConstructorUsedError;
  QueueItemStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_name')
  String get customerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_phone')
  String get customerPhone => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  LatLng? get coordinates => throw _privateConstructorUsedError;
  List<QueueOrderItem> get items => throw _privateConstructorUsedError;
  OrderSource get source => throw _privateConstructorUsedError;
  PaymentType get payment => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivered_at')
  String? get deliveredAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_delivered')
  int? get fullDelivered => throw _privateConstructorUsedError;
  @JsonKey(name: 'empties_collected')
  int? get emptiesCollected => throw _privateConstructorUsedError;
  @JsonKey(name: 'credits_before')
  int? get creditsBefore => throw _privateConstructorUsedError;
  @JsonKey(name: 'credits_after')
  int? get creditsAfter => throw _privateConstructorUsedError;
  @JsonKey(name: 'cash_collected')
  double? get cashCollected => throw _privateConstructorUsedError;
  @JsonKey(name: 'skip_reason')
  String? get skipReason => throw _privateConstructorUsedError;
  @JsonKey(name: 'rescheduled_to')
  String? get rescheduledTo => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'credits_remaining')
  int? get creditsRemaining => throw _privateConstructorUsedError;
  @JsonKey(name: 'recurring_label')
  String? get recurringLabel => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_new_customer')
  bool get isNewCustomer => throw _privateConstructorUsedError;
  @JsonKey(name: 'actual_payment')
  PaymentType? get actualPayment => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivery_note')
  String? get deliveryNote => throw _privateConstructorUsedError;

  /// Serializes this QueueItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueueItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueueItemCopyWith<QueueItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueItemCopyWith<$Res> {
  factory $QueueItemCopyWith(QueueItem value, $Res Function(QueueItem) then) =
      _$QueueItemCopyWithImpl<$Res, QueueItem>;
  @useResult
  $Res call({
    int position,
    QueueItemStatus status,
    @JsonKey(name: 'customer_name') String customerName,
    @JsonKey(name: 'customer_phone') String customerPhone,
    String address,
    LatLng? coordinates,
    List<QueueOrderItem> items,
    OrderSource source,
    PaymentType payment,
    @JsonKey(name: 'delivered_at') String? deliveredAt,
    @JsonKey(name: 'full_delivered') int? fullDelivered,
    @JsonKey(name: 'empties_collected') int? emptiesCollected,
    @JsonKey(name: 'credits_before') int? creditsBefore,
    @JsonKey(name: 'credits_after') int? creditsAfter,
    @JsonKey(name: 'cash_collected') double? cashCollected,
    @JsonKey(name: 'skip_reason') String? skipReason,
    @JsonKey(name: 'rescheduled_to') String? rescheduledTo,
    String? notes,
    @JsonKey(name: 'credits_remaining') int? creditsRemaining,
    @JsonKey(name: 'recurring_label') String? recurringLabel,
    @JsonKey(name: 'is_new_customer') bool isNewCustomer,
    @JsonKey(name: 'actual_payment') PaymentType? actualPayment,
    @JsonKey(name: 'delivery_note') String? deliveryNote,
  });

  $LatLngCopyWith<$Res>? get coordinates;
}

/// @nodoc
class _$QueueItemCopyWithImpl<$Res, $Val extends QueueItem>
    implements $QueueItemCopyWith<$Res> {
  _$QueueItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueueItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? status = null,
    Object? customerName = null,
    Object? customerPhone = null,
    Object? address = null,
    Object? coordinates = freezed,
    Object? items = null,
    Object? source = null,
    Object? payment = null,
    Object? deliveredAt = freezed,
    Object? fullDelivered = freezed,
    Object? emptiesCollected = freezed,
    Object? creditsBefore = freezed,
    Object? creditsAfter = freezed,
    Object? cashCollected = freezed,
    Object? skipReason = freezed,
    Object? rescheduledTo = freezed,
    Object? notes = freezed,
    Object? creditsRemaining = freezed,
    Object? recurringLabel = freezed,
    Object? isNewCustomer = null,
    Object? actualPayment = freezed,
    Object? deliveryNote = freezed,
  }) {
    return _then(
      _value.copyWith(
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as QueueItemStatus,
            customerName: null == customerName
                ? _value.customerName
                : customerName // ignore: cast_nullable_to_non_nullable
                      as String,
            customerPhone: null == customerPhone
                ? _value.customerPhone
                : customerPhone // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            coordinates: freezed == coordinates
                ? _value.coordinates
                : coordinates // ignore: cast_nullable_to_non_nullable
                      as LatLng?,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<QueueOrderItem>,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as OrderSource,
            payment: null == payment
                ? _value.payment
                : payment // ignore: cast_nullable_to_non_nullable
                      as PaymentType,
            deliveredAt: freezed == deliveredAt
                ? _value.deliveredAt
                : deliveredAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            fullDelivered: freezed == fullDelivered
                ? _value.fullDelivered
                : fullDelivered // ignore: cast_nullable_to_non_nullable
                      as int?,
            emptiesCollected: freezed == emptiesCollected
                ? _value.emptiesCollected
                : emptiesCollected // ignore: cast_nullable_to_non_nullable
                      as int?,
            creditsBefore: freezed == creditsBefore
                ? _value.creditsBefore
                : creditsBefore // ignore: cast_nullable_to_non_nullable
                      as int?,
            creditsAfter: freezed == creditsAfter
                ? _value.creditsAfter
                : creditsAfter // ignore: cast_nullable_to_non_nullable
                      as int?,
            cashCollected: freezed == cashCollected
                ? _value.cashCollected
                : cashCollected // ignore: cast_nullable_to_non_nullable
                      as double?,
            skipReason: freezed == skipReason
                ? _value.skipReason
                : skipReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            rescheduledTo: freezed == rescheduledTo
                ? _value.rescheduledTo
                : rescheduledTo // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            creditsRemaining: freezed == creditsRemaining
                ? _value.creditsRemaining
                : creditsRemaining // ignore: cast_nullable_to_non_nullable
                      as int?,
            recurringLabel: freezed == recurringLabel
                ? _value.recurringLabel
                : recurringLabel // ignore: cast_nullable_to_non_nullable
                      as String?,
            isNewCustomer: null == isNewCustomer
                ? _value.isNewCustomer
                : isNewCustomer // ignore: cast_nullable_to_non_nullable
                      as bool,
            actualPayment: freezed == actualPayment
                ? _value.actualPayment
                : actualPayment // ignore: cast_nullable_to_non_nullable
                      as PaymentType?,
            deliveryNote: freezed == deliveryNote
                ? _value.deliveryNote
                : deliveryNote // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of QueueItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LatLngCopyWith<$Res>? get coordinates {
    if (_value.coordinates == null) {
      return null;
    }

    return $LatLngCopyWith<$Res>(_value.coordinates!, (value) {
      return _then(_value.copyWith(coordinates: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QueueItemImplCopyWith<$Res>
    implements $QueueItemCopyWith<$Res> {
  factory _$$QueueItemImplCopyWith(
    _$QueueItemImpl value,
    $Res Function(_$QueueItemImpl) then,
  ) = __$$QueueItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int position,
    QueueItemStatus status,
    @JsonKey(name: 'customer_name') String customerName,
    @JsonKey(name: 'customer_phone') String customerPhone,
    String address,
    LatLng? coordinates,
    List<QueueOrderItem> items,
    OrderSource source,
    PaymentType payment,
    @JsonKey(name: 'delivered_at') String? deliveredAt,
    @JsonKey(name: 'full_delivered') int? fullDelivered,
    @JsonKey(name: 'empties_collected') int? emptiesCollected,
    @JsonKey(name: 'credits_before') int? creditsBefore,
    @JsonKey(name: 'credits_after') int? creditsAfter,
    @JsonKey(name: 'cash_collected') double? cashCollected,
    @JsonKey(name: 'skip_reason') String? skipReason,
    @JsonKey(name: 'rescheduled_to') String? rescheduledTo,
    String? notes,
    @JsonKey(name: 'credits_remaining') int? creditsRemaining,
    @JsonKey(name: 'recurring_label') String? recurringLabel,
    @JsonKey(name: 'is_new_customer') bool isNewCustomer,
    @JsonKey(name: 'actual_payment') PaymentType? actualPayment,
    @JsonKey(name: 'delivery_note') String? deliveryNote,
  });

  @override
  $LatLngCopyWith<$Res>? get coordinates;
}

/// @nodoc
class __$$QueueItemImplCopyWithImpl<$Res>
    extends _$QueueItemCopyWithImpl<$Res, _$QueueItemImpl>
    implements _$$QueueItemImplCopyWith<$Res> {
  __$$QueueItemImplCopyWithImpl(
    _$QueueItemImpl _value,
    $Res Function(_$QueueItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueueItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? status = null,
    Object? customerName = null,
    Object? customerPhone = null,
    Object? address = null,
    Object? coordinates = freezed,
    Object? items = null,
    Object? source = null,
    Object? payment = null,
    Object? deliveredAt = freezed,
    Object? fullDelivered = freezed,
    Object? emptiesCollected = freezed,
    Object? creditsBefore = freezed,
    Object? creditsAfter = freezed,
    Object? cashCollected = freezed,
    Object? skipReason = freezed,
    Object? rescheduledTo = freezed,
    Object? notes = freezed,
    Object? creditsRemaining = freezed,
    Object? recurringLabel = freezed,
    Object? isNewCustomer = null,
    Object? actualPayment = freezed,
    Object? deliveryNote = freezed,
  }) {
    return _then(
      _$QueueItemImpl(
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as QueueItemStatus,
        customerName: null == customerName
            ? _value.customerName
            : customerName // ignore: cast_nullable_to_non_nullable
                  as String,
        customerPhone: null == customerPhone
            ? _value.customerPhone
            : customerPhone // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        coordinates: freezed == coordinates
            ? _value.coordinates
            : coordinates // ignore: cast_nullable_to_non_nullable
                  as LatLng?,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<QueueOrderItem>,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as OrderSource,
        payment: null == payment
            ? _value.payment
            : payment // ignore: cast_nullable_to_non_nullable
                  as PaymentType,
        deliveredAt: freezed == deliveredAt
            ? _value.deliveredAt
            : deliveredAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        fullDelivered: freezed == fullDelivered
            ? _value.fullDelivered
            : fullDelivered // ignore: cast_nullable_to_non_nullable
                  as int?,
        emptiesCollected: freezed == emptiesCollected
            ? _value.emptiesCollected
            : emptiesCollected // ignore: cast_nullable_to_non_nullable
                  as int?,
        creditsBefore: freezed == creditsBefore
            ? _value.creditsBefore
            : creditsBefore // ignore: cast_nullable_to_non_nullable
                  as int?,
        creditsAfter: freezed == creditsAfter
            ? _value.creditsAfter
            : creditsAfter // ignore: cast_nullable_to_non_nullable
                  as int?,
        cashCollected: freezed == cashCollected
            ? _value.cashCollected
            : cashCollected // ignore: cast_nullable_to_non_nullable
                  as double?,
        skipReason: freezed == skipReason
            ? _value.skipReason
            : skipReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        rescheduledTo: freezed == rescheduledTo
            ? _value.rescheduledTo
            : rescheduledTo // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        creditsRemaining: freezed == creditsRemaining
            ? _value.creditsRemaining
            : creditsRemaining // ignore: cast_nullable_to_non_nullable
                  as int?,
        recurringLabel: freezed == recurringLabel
            ? _value.recurringLabel
            : recurringLabel // ignore: cast_nullable_to_non_nullable
                  as String?,
        isNewCustomer: null == isNewCustomer
            ? _value.isNewCustomer
            : isNewCustomer // ignore: cast_nullable_to_non_nullable
                  as bool,
        actualPayment: freezed == actualPayment
            ? _value.actualPayment
            : actualPayment // ignore: cast_nullable_to_non_nullable
                  as PaymentType?,
        deliveryNote: freezed == deliveryNote
            ? _value.deliveryNote
            : deliveryNote // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueItemImpl implements _QueueItem {
  const _$QueueItemImpl({
    required this.position,
    required this.status,
    @JsonKey(name: 'customer_name') required this.customerName,
    @JsonKey(name: 'customer_phone') required this.customerPhone,
    required this.address,
    this.coordinates,
    final List<QueueOrderItem> items = const [],
    required this.source,
    required this.payment,
    @JsonKey(name: 'delivered_at') this.deliveredAt,
    @JsonKey(name: 'full_delivered') this.fullDelivered,
    @JsonKey(name: 'empties_collected') this.emptiesCollected,
    @JsonKey(name: 'credits_before') this.creditsBefore,
    @JsonKey(name: 'credits_after') this.creditsAfter,
    @JsonKey(name: 'cash_collected') this.cashCollected,
    @JsonKey(name: 'skip_reason') this.skipReason,
    @JsonKey(name: 'rescheduled_to') this.rescheduledTo,
    this.notes,
    @JsonKey(name: 'credits_remaining') this.creditsRemaining,
    @JsonKey(name: 'recurring_label') this.recurringLabel,
    @JsonKey(name: 'is_new_customer') this.isNewCustomer = false,
    @JsonKey(name: 'actual_payment') this.actualPayment,
    @JsonKey(name: 'delivery_note') this.deliveryNote,
  }) : _items = items;

  factory _$QueueItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueItemImplFromJson(json);

  @override
  final int position;
  @override
  final QueueItemStatus status;
  @override
  @JsonKey(name: 'customer_name')
  final String customerName;
  @override
  @JsonKey(name: 'customer_phone')
  final String customerPhone;
  @override
  final String address;
  @override
  final LatLng? coordinates;
  final List<QueueOrderItem> _items;
  @override
  @JsonKey()
  List<QueueOrderItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final OrderSource source;
  @override
  final PaymentType payment;
  @override
  @JsonKey(name: 'delivered_at')
  final String? deliveredAt;
  @override
  @JsonKey(name: 'full_delivered')
  final int? fullDelivered;
  @override
  @JsonKey(name: 'empties_collected')
  final int? emptiesCollected;
  @override
  @JsonKey(name: 'credits_before')
  final int? creditsBefore;
  @override
  @JsonKey(name: 'credits_after')
  final int? creditsAfter;
  @override
  @JsonKey(name: 'cash_collected')
  final double? cashCollected;
  @override
  @JsonKey(name: 'skip_reason')
  final String? skipReason;
  @override
  @JsonKey(name: 'rescheduled_to')
  final String? rescheduledTo;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'credits_remaining')
  final int? creditsRemaining;
  @override
  @JsonKey(name: 'recurring_label')
  final String? recurringLabel;
  @override
  @JsonKey(name: 'is_new_customer')
  final bool isNewCustomer;
  @override
  @JsonKey(name: 'actual_payment')
  final PaymentType? actualPayment;
  @override
  @JsonKey(name: 'delivery_note')
  final String? deliveryNote;

  @override
  String toString() {
    return 'QueueItem(position: $position, status: $status, customerName: $customerName, customerPhone: $customerPhone, address: $address, coordinates: $coordinates, items: $items, source: $source, payment: $payment, deliveredAt: $deliveredAt, fullDelivered: $fullDelivered, emptiesCollected: $emptiesCollected, creditsBefore: $creditsBefore, creditsAfter: $creditsAfter, cashCollected: $cashCollected, skipReason: $skipReason, rescheduledTo: $rescheduledTo, notes: $notes, creditsRemaining: $creditsRemaining, recurringLabel: $recurringLabel, isNewCustomer: $isNewCustomer, actualPayment: $actualPayment, deliveryNote: $deliveryNote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueItemImpl &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerPhone, customerPhone) ||
                other.customerPhone == customerPhone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.coordinates, coordinates) ||
                other.coordinates == coordinates) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.payment, payment) || other.payment == payment) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt) &&
            (identical(other.fullDelivered, fullDelivered) ||
                other.fullDelivered == fullDelivered) &&
            (identical(other.emptiesCollected, emptiesCollected) ||
                other.emptiesCollected == emptiesCollected) &&
            (identical(other.creditsBefore, creditsBefore) ||
                other.creditsBefore == creditsBefore) &&
            (identical(other.creditsAfter, creditsAfter) ||
                other.creditsAfter == creditsAfter) &&
            (identical(other.cashCollected, cashCollected) ||
                other.cashCollected == cashCollected) &&
            (identical(other.skipReason, skipReason) ||
                other.skipReason == skipReason) &&
            (identical(other.rescheduledTo, rescheduledTo) ||
                other.rescheduledTo == rescheduledTo) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.creditsRemaining, creditsRemaining) ||
                other.creditsRemaining == creditsRemaining) &&
            (identical(other.recurringLabel, recurringLabel) ||
                other.recurringLabel == recurringLabel) &&
            (identical(other.isNewCustomer, isNewCustomer) ||
                other.isNewCustomer == isNewCustomer) &&
            (identical(other.actualPayment, actualPayment) ||
                other.actualPayment == actualPayment) &&
            (identical(other.deliveryNote, deliveryNote) ||
                other.deliveryNote == deliveryNote));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    position,
    status,
    customerName,
    customerPhone,
    address,
    coordinates,
    const DeepCollectionEquality().hash(_items),
    source,
    payment,
    deliveredAt,
    fullDelivered,
    emptiesCollected,
    creditsBefore,
    creditsAfter,
    cashCollected,
    skipReason,
    rescheduledTo,
    notes,
    creditsRemaining,
    recurringLabel,
    isNewCustomer,
    actualPayment,
    deliveryNote,
  ]);

  /// Create a copy of QueueItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueItemImplCopyWith<_$QueueItemImpl> get copyWith =>
      __$$QueueItemImplCopyWithImpl<_$QueueItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueItemImplToJson(this);
  }
}

abstract class _QueueItem implements QueueItem {
  const factory _QueueItem({
    required final int position,
    required final QueueItemStatus status,
    @JsonKey(name: 'customer_name') required final String customerName,
    @JsonKey(name: 'customer_phone') required final String customerPhone,
    required final String address,
    final LatLng? coordinates,
    final List<QueueOrderItem> items,
    required final OrderSource source,
    required final PaymentType payment,
    @JsonKey(name: 'delivered_at') final String? deliveredAt,
    @JsonKey(name: 'full_delivered') final int? fullDelivered,
    @JsonKey(name: 'empties_collected') final int? emptiesCollected,
    @JsonKey(name: 'credits_before') final int? creditsBefore,
    @JsonKey(name: 'credits_after') final int? creditsAfter,
    @JsonKey(name: 'cash_collected') final double? cashCollected,
    @JsonKey(name: 'skip_reason') final String? skipReason,
    @JsonKey(name: 'rescheduled_to') final String? rescheduledTo,
    final String? notes,
    @JsonKey(name: 'credits_remaining') final int? creditsRemaining,
    @JsonKey(name: 'recurring_label') final String? recurringLabel,
    @JsonKey(name: 'is_new_customer') final bool isNewCustomer,
    @JsonKey(name: 'actual_payment') final PaymentType? actualPayment,
    @JsonKey(name: 'delivery_note') final String? deliveryNote,
  }) = _$QueueItemImpl;

  factory _QueueItem.fromJson(Map<String, dynamic> json) =
      _$QueueItemImpl.fromJson;

  @override
  int get position;
  @override
  QueueItemStatus get status;
  @override
  @JsonKey(name: 'customer_name')
  String get customerName;
  @override
  @JsonKey(name: 'customer_phone')
  String get customerPhone;
  @override
  String get address;
  @override
  LatLng? get coordinates;
  @override
  List<QueueOrderItem> get items;
  @override
  OrderSource get source;
  @override
  PaymentType get payment;
  @override
  @JsonKey(name: 'delivered_at')
  String? get deliveredAt;
  @override
  @JsonKey(name: 'full_delivered')
  int? get fullDelivered;
  @override
  @JsonKey(name: 'empties_collected')
  int? get emptiesCollected;
  @override
  @JsonKey(name: 'credits_before')
  int? get creditsBefore;
  @override
  @JsonKey(name: 'credits_after')
  int? get creditsAfter;
  @override
  @JsonKey(name: 'cash_collected')
  double? get cashCollected;
  @override
  @JsonKey(name: 'skip_reason')
  String? get skipReason;
  @override
  @JsonKey(name: 'rescheduled_to')
  String? get rescheduledTo;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'credits_remaining')
  int? get creditsRemaining;
  @override
  @JsonKey(name: 'recurring_label')
  String? get recurringLabel;
  @override
  @JsonKey(name: 'is_new_customer')
  bool get isNewCustomer;
  @override
  @JsonKey(name: 'actual_payment')
  PaymentType? get actualPayment;
  @override
  @JsonKey(name: 'delivery_note')
  String? get deliveryNote;

  /// Create a copy of QueueItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueItemImplCopyWith<_$QueueItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QueueOrderItem _$QueueOrderItemFromJson(Map<String, dynamic> json) {
  return _QueueOrderItem.fromJson(json);
}

/// @nodoc
mixin _$QueueOrderItem {
  String get name => throw _privateConstructorUsedError;
  int get qty => throw _privateConstructorUsedError;

  /// Serializes this QueueOrderItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueueOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueueOrderItemCopyWith<QueueOrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueOrderItemCopyWith<$Res> {
  factory $QueueOrderItemCopyWith(
    QueueOrderItem value,
    $Res Function(QueueOrderItem) then,
  ) = _$QueueOrderItemCopyWithImpl<$Res, QueueOrderItem>;
  @useResult
  $Res call({String name, int qty});
}

/// @nodoc
class _$QueueOrderItemCopyWithImpl<$Res, $Val extends QueueOrderItem>
    implements $QueueOrderItemCopyWith<$Res> {
  _$QueueOrderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueueOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? qty = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            qty: null == qty
                ? _value.qty
                : qty // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QueueOrderItemImplCopyWith<$Res>
    implements $QueueOrderItemCopyWith<$Res> {
  factory _$$QueueOrderItemImplCopyWith(
    _$QueueOrderItemImpl value,
    $Res Function(_$QueueOrderItemImpl) then,
  ) = __$$QueueOrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int qty});
}

/// @nodoc
class __$$QueueOrderItemImplCopyWithImpl<$Res>
    extends _$QueueOrderItemCopyWithImpl<$Res, _$QueueOrderItemImpl>
    implements _$$QueueOrderItemImplCopyWith<$Res> {
  __$$QueueOrderItemImplCopyWithImpl(
    _$QueueOrderItemImpl _value,
    $Res Function(_$QueueOrderItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueueOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? qty = null}) {
    return _then(
      _$QueueOrderItemImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        qty: null == qty
            ? _value.qty
            : qty // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueOrderItemImpl implements _QueueOrderItem {
  const _$QueueOrderItemImpl({required this.name, required this.qty});

  factory _$QueueOrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueOrderItemImplFromJson(json);

  @override
  final String name;
  @override
  final int qty;

  @override
  String toString() {
    return 'QueueOrderItem(name: $name, qty: $qty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueOrderItemImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.qty, qty) || other.qty == qty));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, qty);

  /// Create a copy of QueueOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueOrderItemImplCopyWith<_$QueueOrderItemImpl> get copyWith =>
      __$$QueueOrderItemImplCopyWithImpl<_$QueueOrderItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueOrderItemImplToJson(this);
  }
}

abstract class _QueueOrderItem implements QueueOrderItem {
  const factory _QueueOrderItem({
    required final String name,
    required final int qty,
  }) = _$QueueOrderItemImpl;

  factory _QueueOrderItem.fromJson(Map<String, dynamic> json) =
      _$QueueOrderItemImpl.fromJson;

  @override
  String get name;
  @override
  int get qty;

  /// Create a copy of QueueOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueOrderItemImplCopyWith<_$QueueOrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RouteData _$RouteDataFromJson(Map<String, dynamic> json) {
  return _RouteData.fromJson(json);
}

/// @nodoc
mixin _$RouteData {
  @JsonKey(name: 'truck_id')
  String get truckId => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  List<QueueItem> get queue => throw _privateConstructorUsedError;

  /// Serializes this RouteData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteDataCopyWith<RouteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteDataCopyWith<$Res> {
  factory $RouteDataCopyWith(RouteData value, $Res Function(RouteData) then) =
      _$RouteDataCopyWithImpl<$Res, RouteData>;
  @useResult
  $Res call({
    @JsonKey(name: 'truck_id') String truckId,
    String date,
    List<QueueItem> queue,
  });
}

/// @nodoc
class _$RouteDataCopyWithImpl<$Res, $Val extends RouteData>
    implements $RouteDataCopyWith<$Res> {
  _$RouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? truckId = null,
    Object? date = null,
    Object? queue = null,
  }) {
    return _then(
      _value.copyWith(
            truckId: null == truckId
                ? _value.truckId
                : truckId // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            queue: null == queue
                ? _value.queue
                : queue // ignore: cast_nullable_to_non_nullable
                      as List<QueueItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RouteDataImplCopyWith<$Res>
    implements $RouteDataCopyWith<$Res> {
  factory _$$RouteDataImplCopyWith(
    _$RouteDataImpl value,
    $Res Function(_$RouteDataImpl) then,
  ) = __$$RouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'truck_id') String truckId,
    String date,
    List<QueueItem> queue,
  });
}

/// @nodoc
class __$$RouteDataImplCopyWithImpl<$Res>
    extends _$RouteDataCopyWithImpl<$Res, _$RouteDataImpl>
    implements _$$RouteDataImplCopyWith<$Res> {
  __$$RouteDataImplCopyWithImpl(
    _$RouteDataImpl _value,
    $Res Function(_$RouteDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? truckId = null,
    Object? date = null,
    Object? queue = null,
  }) {
    return _then(
      _$RouteDataImpl(
        truckId: null == truckId
            ? _value.truckId
            : truckId // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        queue: null == queue
            ? _value._queue
            : queue // ignore: cast_nullable_to_non_nullable
                  as List<QueueItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteDataImpl implements _RouteData {
  const _$RouteDataImpl({
    @JsonKey(name: 'truck_id') this.truckId = '',
    required this.date,
    final List<QueueItem> queue = const [],
  }) : _queue = queue;

  factory _$RouteDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteDataImplFromJson(json);

  @override
  @JsonKey(name: 'truck_id')
  final String truckId;
  @override
  final String date;
  final List<QueueItem> _queue;
  @override
  @JsonKey()
  List<QueueItem> get queue {
    if (_queue is EqualUnmodifiableListView) return _queue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_queue);
  }

  @override
  String toString() {
    return 'RouteData(truckId: $truckId, date: $date, queue: $queue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteDataImpl &&
            (identical(other.truckId, truckId) || other.truckId == truckId) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._queue, _queue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    truckId,
    date,
    const DeepCollectionEquality().hash(_queue),
  );

  /// Create a copy of RouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteDataImplCopyWith<_$RouteDataImpl> get copyWith =>
      __$$RouteDataImplCopyWithImpl<_$RouteDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteDataImplToJson(this);
  }
}

abstract class _RouteData implements RouteData {
  const factory _RouteData({
    @JsonKey(name: 'truck_id') final String truckId,
    required final String date,
    final List<QueueItem> queue,
  }) = _$RouteDataImpl;

  factory _RouteData.fromJson(Map<String, dynamic> json) =
      _$RouteDataImpl.fromJson;

  @override
  @JsonKey(name: 'truck_id')
  String get truckId;
  @override
  String get date;
  @override
  List<QueueItem> get queue;

  /// Create a copy of RouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteDataImplCopyWith<_$RouteDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RouteSummary _$RouteSummaryFromJson(Map<String, dynamic> json) {
  return _RouteSummary.fromJson(json);
}

/// @nodoc
mixin _$RouteSummary {
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes => throw _privateConstructorUsedError;
  @JsonKey(name: 'loaded_full')
  int get loadedFull => throw _privateConstructorUsedError;
  int get reloads => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_delivered')
  int get totalDelivered => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_skipped')
  int get totalSkipped => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_failed')
  int get totalFailed => throw _privateConstructorUsedError;
  @JsonKey(name: 'empties_collected')
  int get emptiesCollected => throw _privateConstructorUsedError;
  RouteSummaryRevenue? get revenue => throw _privateConstructorUsedError;
  Map<String, int> get sources => throw _privateConstructorUsedError;

  /// Serializes this RouteSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteSummaryCopyWith<RouteSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteSummaryCopyWith<$Res> {
  factory $RouteSummaryCopyWith(
    RouteSummary value,
    $Res Function(RouteSummary) then,
  ) = _$RouteSummaryCopyWithImpl<$Res, RouteSummary>;
  @useResult
  $Res call({
    @JsonKey(name: 'duration_minutes') int durationMinutes,
    @JsonKey(name: 'loaded_full') int loadedFull,
    int reloads,
    @JsonKey(name: 'total_delivered') int totalDelivered,
    @JsonKey(name: 'total_skipped') int totalSkipped,
    @JsonKey(name: 'total_failed') int totalFailed,
    @JsonKey(name: 'empties_collected') int emptiesCollected,
    RouteSummaryRevenue? revenue,
    Map<String, int> sources,
  });

  $RouteSummaryRevenueCopyWith<$Res>? get revenue;
}

/// @nodoc
class _$RouteSummaryCopyWithImpl<$Res, $Val extends RouteSummary>
    implements $RouteSummaryCopyWith<$Res> {
  _$RouteSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? durationMinutes = null,
    Object? loadedFull = null,
    Object? reloads = null,
    Object? totalDelivered = null,
    Object? totalSkipped = null,
    Object? totalFailed = null,
    Object? emptiesCollected = null,
    Object? revenue = freezed,
    Object? sources = null,
  }) {
    return _then(
      _value.copyWith(
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            loadedFull: null == loadedFull
                ? _value.loadedFull
                : loadedFull // ignore: cast_nullable_to_non_nullable
                      as int,
            reloads: null == reloads
                ? _value.reloads
                : reloads // ignore: cast_nullable_to_non_nullable
                      as int,
            totalDelivered: null == totalDelivered
                ? _value.totalDelivered
                : totalDelivered // ignore: cast_nullable_to_non_nullable
                      as int,
            totalSkipped: null == totalSkipped
                ? _value.totalSkipped
                : totalSkipped // ignore: cast_nullable_to_non_nullable
                      as int,
            totalFailed: null == totalFailed
                ? _value.totalFailed
                : totalFailed // ignore: cast_nullable_to_non_nullable
                      as int,
            emptiesCollected: null == emptiesCollected
                ? _value.emptiesCollected
                : emptiesCollected // ignore: cast_nullable_to_non_nullable
                      as int,
            revenue: freezed == revenue
                ? _value.revenue
                : revenue // ignore: cast_nullable_to_non_nullable
                      as RouteSummaryRevenue?,
            sources: null == sources
                ? _value.sources
                : sources // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
          )
          as $Val,
    );
  }

  /// Create a copy of RouteSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RouteSummaryRevenueCopyWith<$Res>? get revenue {
    if (_value.revenue == null) {
      return null;
    }

    return $RouteSummaryRevenueCopyWith<$Res>(_value.revenue!, (value) {
      return _then(_value.copyWith(revenue: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RouteSummaryImplCopyWith<$Res>
    implements $RouteSummaryCopyWith<$Res> {
  factory _$$RouteSummaryImplCopyWith(
    _$RouteSummaryImpl value,
    $Res Function(_$RouteSummaryImpl) then,
  ) = __$$RouteSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'duration_minutes') int durationMinutes,
    @JsonKey(name: 'loaded_full') int loadedFull,
    int reloads,
    @JsonKey(name: 'total_delivered') int totalDelivered,
    @JsonKey(name: 'total_skipped') int totalSkipped,
    @JsonKey(name: 'total_failed') int totalFailed,
    @JsonKey(name: 'empties_collected') int emptiesCollected,
    RouteSummaryRevenue? revenue,
    Map<String, int> sources,
  });

  @override
  $RouteSummaryRevenueCopyWith<$Res>? get revenue;
}

/// @nodoc
class __$$RouteSummaryImplCopyWithImpl<$Res>
    extends _$RouteSummaryCopyWithImpl<$Res, _$RouteSummaryImpl>
    implements _$$RouteSummaryImplCopyWith<$Res> {
  __$$RouteSummaryImplCopyWithImpl(
    _$RouteSummaryImpl _value,
    $Res Function(_$RouteSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RouteSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? durationMinutes = null,
    Object? loadedFull = null,
    Object? reloads = null,
    Object? totalDelivered = null,
    Object? totalSkipped = null,
    Object? totalFailed = null,
    Object? emptiesCollected = null,
    Object? revenue = freezed,
    Object? sources = null,
  }) {
    return _then(
      _$RouteSummaryImpl(
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        loadedFull: null == loadedFull
            ? _value.loadedFull
            : loadedFull // ignore: cast_nullable_to_non_nullable
                  as int,
        reloads: null == reloads
            ? _value.reloads
            : reloads // ignore: cast_nullable_to_non_nullable
                  as int,
        totalDelivered: null == totalDelivered
            ? _value.totalDelivered
            : totalDelivered // ignore: cast_nullable_to_non_nullable
                  as int,
        totalSkipped: null == totalSkipped
            ? _value.totalSkipped
            : totalSkipped // ignore: cast_nullable_to_non_nullable
                  as int,
        totalFailed: null == totalFailed
            ? _value.totalFailed
            : totalFailed // ignore: cast_nullable_to_non_nullable
                  as int,
        emptiesCollected: null == emptiesCollected
            ? _value.emptiesCollected
            : emptiesCollected // ignore: cast_nullable_to_non_nullable
                  as int,
        revenue: freezed == revenue
            ? _value.revenue
            : revenue // ignore: cast_nullable_to_non_nullable
                  as RouteSummaryRevenue?,
        sources: null == sources
            ? _value._sources
            : sources // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteSummaryImpl implements _RouteSummary {
  const _$RouteSummaryImpl({
    @JsonKey(name: 'duration_minutes') this.durationMinutes = 0,
    @JsonKey(name: 'loaded_full') this.loadedFull = 0,
    this.reloads = 0,
    @JsonKey(name: 'total_delivered') this.totalDelivered = 0,
    @JsonKey(name: 'total_skipped') this.totalSkipped = 0,
    @JsonKey(name: 'total_failed') this.totalFailed = 0,
    @JsonKey(name: 'empties_collected') this.emptiesCollected = 0,
    this.revenue,
    final Map<String, int> sources = const {},
  }) : _sources = sources;

  factory _$RouteSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteSummaryImplFromJson(json);

  @override
  @JsonKey(name: 'duration_minutes')
  final int durationMinutes;
  @override
  @JsonKey(name: 'loaded_full')
  final int loadedFull;
  @override
  @JsonKey()
  final int reloads;
  @override
  @JsonKey(name: 'total_delivered')
  final int totalDelivered;
  @override
  @JsonKey(name: 'total_skipped')
  final int totalSkipped;
  @override
  @JsonKey(name: 'total_failed')
  final int totalFailed;
  @override
  @JsonKey(name: 'empties_collected')
  final int emptiesCollected;
  @override
  final RouteSummaryRevenue? revenue;
  final Map<String, int> _sources;
  @override
  @JsonKey()
  Map<String, int> get sources {
    if (_sources is EqualUnmodifiableMapView) return _sources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sources);
  }

  @override
  String toString() {
    return 'RouteSummary(durationMinutes: $durationMinutes, loadedFull: $loadedFull, reloads: $reloads, totalDelivered: $totalDelivered, totalSkipped: $totalSkipped, totalFailed: $totalFailed, emptiesCollected: $emptiesCollected, revenue: $revenue, sources: $sources)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteSummaryImpl &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.loadedFull, loadedFull) ||
                other.loadedFull == loadedFull) &&
            (identical(other.reloads, reloads) || other.reloads == reloads) &&
            (identical(other.totalDelivered, totalDelivered) ||
                other.totalDelivered == totalDelivered) &&
            (identical(other.totalSkipped, totalSkipped) ||
                other.totalSkipped == totalSkipped) &&
            (identical(other.totalFailed, totalFailed) ||
                other.totalFailed == totalFailed) &&
            (identical(other.emptiesCollected, emptiesCollected) ||
                other.emptiesCollected == emptiesCollected) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            const DeepCollectionEquality().equals(other._sources, _sources));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    durationMinutes,
    loadedFull,
    reloads,
    totalDelivered,
    totalSkipped,
    totalFailed,
    emptiesCollected,
    revenue,
    const DeepCollectionEquality().hash(_sources),
  );

  /// Create a copy of RouteSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteSummaryImplCopyWith<_$RouteSummaryImpl> get copyWith =>
      __$$RouteSummaryImplCopyWithImpl<_$RouteSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteSummaryImplToJson(this);
  }
}

abstract class _RouteSummary implements RouteSummary {
  const factory _RouteSummary({
    @JsonKey(name: 'duration_minutes') final int durationMinutes,
    @JsonKey(name: 'loaded_full') final int loadedFull,
    final int reloads,
    @JsonKey(name: 'total_delivered') final int totalDelivered,
    @JsonKey(name: 'total_skipped') final int totalSkipped,
    @JsonKey(name: 'total_failed') final int totalFailed,
    @JsonKey(name: 'empties_collected') final int emptiesCollected,
    final RouteSummaryRevenue? revenue,
    final Map<String, int> sources,
  }) = _$RouteSummaryImpl;

  factory _RouteSummary.fromJson(Map<String, dynamic> json) =
      _$RouteSummaryImpl.fromJson;

  @override
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes;
  @override
  @JsonKey(name: 'loaded_full')
  int get loadedFull;
  @override
  int get reloads;
  @override
  @JsonKey(name: 'total_delivered')
  int get totalDelivered;
  @override
  @JsonKey(name: 'total_skipped')
  int get totalSkipped;
  @override
  @JsonKey(name: 'total_failed')
  int get totalFailed;
  @override
  @JsonKey(name: 'empties_collected')
  int get emptiesCollected;
  @override
  RouteSummaryRevenue? get revenue;
  @override
  Map<String, int> get sources;

  /// Create a copy of RouteSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteSummaryImplCopyWith<_$RouteSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RouteSummaryRevenue _$RouteSummaryRevenueFromJson(Map<String, dynamic> json) {
  return _RouteSummaryRevenue.fromJson(json);
}

/// @nodoc
mixin _$RouteSummaryRevenue {
  @JsonKey(name: 'prepaid_units')
  int get prepaidUnits => throw _privateConstructorUsedError;
  @JsonKey(name: 'cash_jod')
  double get cashJod => throw _privateConstructorUsedError;
  @JsonKey(name: 'cash_units')
  int get cashUnits => throw _privateConstructorUsedError;
  @JsonKey(name: 'on_account_units')
  int get onAccountUnits => throw _privateConstructorUsedError;

  /// Serializes this RouteSummaryRevenue to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteSummaryRevenue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteSummaryRevenueCopyWith<RouteSummaryRevenue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteSummaryRevenueCopyWith<$Res> {
  factory $RouteSummaryRevenueCopyWith(
    RouteSummaryRevenue value,
    $Res Function(RouteSummaryRevenue) then,
  ) = _$RouteSummaryRevenueCopyWithImpl<$Res, RouteSummaryRevenue>;
  @useResult
  $Res call({
    @JsonKey(name: 'prepaid_units') int prepaidUnits,
    @JsonKey(name: 'cash_jod') double cashJod,
    @JsonKey(name: 'cash_units') int cashUnits,
    @JsonKey(name: 'on_account_units') int onAccountUnits,
  });
}

/// @nodoc
class _$RouteSummaryRevenueCopyWithImpl<$Res, $Val extends RouteSummaryRevenue>
    implements $RouteSummaryRevenueCopyWith<$Res> {
  _$RouteSummaryRevenueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteSummaryRevenue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prepaidUnits = null,
    Object? cashJod = null,
    Object? cashUnits = null,
    Object? onAccountUnits = null,
  }) {
    return _then(
      _value.copyWith(
            prepaidUnits: null == prepaidUnits
                ? _value.prepaidUnits
                : prepaidUnits // ignore: cast_nullable_to_non_nullable
                      as int,
            cashJod: null == cashJod
                ? _value.cashJod
                : cashJod // ignore: cast_nullable_to_non_nullable
                      as double,
            cashUnits: null == cashUnits
                ? _value.cashUnits
                : cashUnits // ignore: cast_nullable_to_non_nullable
                      as int,
            onAccountUnits: null == onAccountUnits
                ? _value.onAccountUnits
                : onAccountUnits // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RouteSummaryRevenueImplCopyWith<$Res>
    implements $RouteSummaryRevenueCopyWith<$Res> {
  factory _$$RouteSummaryRevenueImplCopyWith(
    _$RouteSummaryRevenueImpl value,
    $Res Function(_$RouteSummaryRevenueImpl) then,
  ) = __$$RouteSummaryRevenueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'prepaid_units') int prepaidUnits,
    @JsonKey(name: 'cash_jod') double cashJod,
    @JsonKey(name: 'cash_units') int cashUnits,
    @JsonKey(name: 'on_account_units') int onAccountUnits,
  });
}

/// @nodoc
class __$$RouteSummaryRevenueImplCopyWithImpl<$Res>
    extends _$RouteSummaryRevenueCopyWithImpl<$Res, _$RouteSummaryRevenueImpl>
    implements _$$RouteSummaryRevenueImplCopyWith<$Res> {
  __$$RouteSummaryRevenueImplCopyWithImpl(
    _$RouteSummaryRevenueImpl _value,
    $Res Function(_$RouteSummaryRevenueImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RouteSummaryRevenue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prepaidUnits = null,
    Object? cashJod = null,
    Object? cashUnits = null,
    Object? onAccountUnits = null,
  }) {
    return _then(
      _$RouteSummaryRevenueImpl(
        prepaidUnits: null == prepaidUnits
            ? _value.prepaidUnits
            : prepaidUnits // ignore: cast_nullable_to_non_nullable
                  as int,
        cashJod: null == cashJod
            ? _value.cashJod
            : cashJod // ignore: cast_nullable_to_non_nullable
                  as double,
        cashUnits: null == cashUnits
            ? _value.cashUnits
            : cashUnits // ignore: cast_nullable_to_non_nullable
                  as int,
        onAccountUnits: null == onAccountUnits
            ? _value.onAccountUnits
            : onAccountUnits // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteSummaryRevenueImpl implements _RouteSummaryRevenue {
  const _$RouteSummaryRevenueImpl({
    @JsonKey(name: 'prepaid_units') this.prepaidUnits = 0,
    @JsonKey(name: 'cash_jod') this.cashJod = 0,
    @JsonKey(name: 'cash_units') this.cashUnits = 0,
    @JsonKey(name: 'on_account_units') this.onAccountUnits = 0,
  });

  factory _$RouteSummaryRevenueImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteSummaryRevenueImplFromJson(json);

  @override
  @JsonKey(name: 'prepaid_units')
  final int prepaidUnits;
  @override
  @JsonKey(name: 'cash_jod')
  final double cashJod;
  @override
  @JsonKey(name: 'cash_units')
  final int cashUnits;
  @override
  @JsonKey(name: 'on_account_units')
  final int onAccountUnits;

  @override
  String toString() {
    return 'RouteSummaryRevenue(prepaidUnits: $prepaidUnits, cashJod: $cashJod, cashUnits: $cashUnits, onAccountUnits: $onAccountUnits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteSummaryRevenueImpl &&
            (identical(other.prepaidUnits, prepaidUnits) ||
                other.prepaidUnits == prepaidUnits) &&
            (identical(other.cashJod, cashJod) || other.cashJod == cashJod) &&
            (identical(other.cashUnits, cashUnits) ||
                other.cashUnits == cashUnits) &&
            (identical(other.onAccountUnits, onAccountUnits) ||
                other.onAccountUnits == onAccountUnits));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    prepaidUnits,
    cashJod,
    cashUnits,
    onAccountUnits,
  );

  /// Create a copy of RouteSummaryRevenue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteSummaryRevenueImplCopyWith<_$RouteSummaryRevenueImpl> get copyWith =>
      __$$RouteSummaryRevenueImplCopyWithImpl<_$RouteSummaryRevenueImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteSummaryRevenueImplToJson(this);
  }
}

abstract class _RouteSummaryRevenue implements RouteSummaryRevenue {
  const factory _RouteSummaryRevenue({
    @JsonKey(name: 'prepaid_units') final int prepaidUnits,
    @JsonKey(name: 'cash_jod') final double cashJod,
    @JsonKey(name: 'cash_units') final int cashUnits,
    @JsonKey(name: 'on_account_units') final int onAccountUnits,
  }) = _$RouteSummaryRevenueImpl;

  factory _RouteSummaryRevenue.fromJson(Map<String, dynamic> json) =
      _$RouteSummaryRevenueImpl.fromJson;

  @override
  @JsonKey(name: 'prepaid_units')
  int get prepaidUnits;
  @override
  @JsonKey(name: 'cash_jod')
  double get cashJod;
  @override
  @JsonKey(name: 'cash_units')
  int get cashUnits;
  @override
  @JsonKey(name: 'on_account_units')
  int get onAccountUnits;

  /// Create a copy of RouteSummaryRevenue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteSummaryRevenueImplCopyWith<_$RouteSummaryRevenueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RouteHistoryEntry _$RouteHistoryEntryFromJson(Map<String, dynamic> json) {
  return _RouteHistoryEntry.fromJson(json);
}

/// @nodoc
mixin _$RouteHistoryEntry {
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'truck_id')
  String get truckId => throw _privateConstructorUsedError;
  String get driver => throw _privateConstructorUsedError;
  @JsonKey(name: 'started_at')
  String get startedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'ended_at')
  String get endedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes => throw _privateConstructorUsedError;
  @JsonKey(name: 'loaded_full')
  int get loadedFull => throw _privateConstructorUsedError;
  int get reloads => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_delivered')
  int get totalDelivered => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_skipped')
  int get totalSkipped => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_failed')
  int get totalFailed => throw _privateConstructorUsedError;
  @JsonKey(name: 'empties_collected')
  int get emptiesCollected => throw _privateConstructorUsedError;
  RouteSummaryRevenue? get revenue => throw _privateConstructorUsedError;
  Map<String, int> get sources => throw _privateConstructorUsedError;

  /// Serializes this RouteHistoryEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteHistoryEntryCopyWith<RouteHistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteHistoryEntryCopyWith<$Res> {
  factory $RouteHistoryEntryCopyWith(
    RouteHistoryEntry value,
    $Res Function(RouteHistoryEntry) then,
  ) = _$RouteHistoryEntryCopyWithImpl<$Res, RouteHistoryEntry>;
  @useResult
  $Res call({
    String date,
    @JsonKey(name: 'truck_id') String truckId,
    String driver,
    @JsonKey(name: 'started_at') String startedAt,
    @JsonKey(name: 'ended_at') String endedAt,
    @JsonKey(name: 'duration_minutes') int durationMinutes,
    @JsonKey(name: 'loaded_full') int loadedFull,
    int reloads,
    @JsonKey(name: 'total_delivered') int totalDelivered,
    @JsonKey(name: 'total_skipped') int totalSkipped,
    @JsonKey(name: 'total_failed') int totalFailed,
    @JsonKey(name: 'empties_collected') int emptiesCollected,
    RouteSummaryRevenue? revenue,
    Map<String, int> sources,
  });

  $RouteSummaryRevenueCopyWith<$Res>? get revenue;
}

/// @nodoc
class _$RouteHistoryEntryCopyWithImpl<$Res, $Val extends RouteHistoryEntry>
    implements $RouteHistoryEntryCopyWith<$Res> {
  _$RouteHistoryEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? truckId = null,
    Object? driver = null,
    Object? startedAt = null,
    Object? endedAt = null,
    Object? durationMinutes = null,
    Object? loadedFull = null,
    Object? reloads = null,
    Object? totalDelivered = null,
    Object? totalSkipped = null,
    Object? totalFailed = null,
    Object? emptiesCollected = null,
    Object? revenue = freezed,
    Object? sources = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            truckId: null == truckId
                ? _value.truckId
                : truckId // ignore: cast_nullable_to_non_nullable
                      as String,
            driver: null == driver
                ? _value.driver
                : driver // ignore: cast_nullable_to_non_nullable
                      as String,
            startedAt: null == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as String,
            endedAt: null == endedAt
                ? _value.endedAt
                : endedAt // ignore: cast_nullable_to_non_nullable
                      as String,
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            loadedFull: null == loadedFull
                ? _value.loadedFull
                : loadedFull // ignore: cast_nullable_to_non_nullable
                      as int,
            reloads: null == reloads
                ? _value.reloads
                : reloads // ignore: cast_nullable_to_non_nullable
                      as int,
            totalDelivered: null == totalDelivered
                ? _value.totalDelivered
                : totalDelivered // ignore: cast_nullable_to_non_nullable
                      as int,
            totalSkipped: null == totalSkipped
                ? _value.totalSkipped
                : totalSkipped // ignore: cast_nullable_to_non_nullable
                      as int,
            totalFailed: null == totalFailed
                ? _value.totalFailed
                : totalFailed // ignore: cast_nullable_to_non_nullable
                      as int,
            emptiesCollected: null == emptiesCollected
                ? _value.emptiesCollected
                : emptiesCollected // ignore: cast_nullable_to_non_nullable
                      as int,
            revenue: freezed == revenue
                ? _value.revenue
                : revenue // ignore: cast_nullable_to_non_nullable
                      as RouteSummaryRevenue?,
            sources: null == sources
                ? _value.sources
                : sources // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
          )
          as $Val,
    );
  }

  /// Create a copy of RouteHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RouteSummaryRevenueCopyWith<$Res>? get revenue {
    if (_value.revenue == null) {
      return null;
    }

    return $RouteSummaryRevenueCopyWith<$Res>(_value.revenue!, (value) {
      return _then(_value.copyWith(revenue: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RouteHistoryEntryImplCopyWith<$Res>
    implements $RouteHistoryEntryCopyWith<$Res> {
  factory _$$RouteHistoryEntryImplCopyWith(
    _$RouteHistoryEntryImpl value,
    $Res Function(_$RouteHistoryEntryImpl) then,
  ) = __$$RouteHistoryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String date,
    @JsonKey(name: 'truck_id') String truckId,
    String driver,
    @JsonKey(name: 'started_at') String startedAt,
    @JsonKey(name: 'ended_at') String endedAt,
    @JsonKey(name: 'duration_minutes') int durationMinutes,
    @JsonKey(name: 'loaded_full') int loadedFull,
    int reloads,
    @JsonKey(name: 'total_delivered') int totalDelivered,
    @JsonKey(name: 'total_skipped') int totalSkipped,
    @JsonKey(name: 'total_failed') int totalFailed,
    @JsonKey(name: 'empties_collected') int emptiesCollected,
    RouteSummaryRevenue? revenue,
    Map<String, int> sources,
  });

  @override
  $RouteSummaryRevenueCopyWith<$Res>? get revenue;
}

/// @nodoc
class __$$RouteHistoryEntryImplCopyWithImpl<$Res>
    extends _$RouteHistoryEntryCopyWithImpl<$Res, _$RouteHistoryEntryImpl>
    implements _$$RouteHistoryEntryImplCopyWith<$Res> {
  __$$RouteHistoryEntryImplCopyWithImpl(
    _$RouteHistoryEntryImpl _value,
    $Res Function(_$RouteHistoryEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RouteHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? truckId = null,
    Object? driver = null,
    Object? startedAt = null,
    Object? endedAt = null,
    Object? durationMinutes = null,
    Object? loadedFull = null,
    Object? reloads = null,
    Object? totalDelivered = null,
    Object? totalSkipped = null,
    Object? totalFailed = null,
    Object? emptiesCollected = null,
    Object? revenue = freezed,
    Object? sources = null,
  }) {
    return _then(
      _$RouteHistoryEntryImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        truckId: null == truckId
            ? _value.truckId
            : truckId // ignore: cast_nullable_to_non_nullable
                  as String,
        driver: null == driver
            ? _value.driver
            : driver // ignore: cast_nullable_to_non_nullable
                  as String,
        startedAt: null == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as String,
        endedAt: null == endedAt
            ? _value.endedAt
            : endedAt // ignore: cast_nullable_to_non_nullable
                  as String,
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        loadedFull: null == loadedFull
            ? _value.loadedFull
            : loadedFull // ignore: cast_nullable_to_non_nullable
                  as int,
        reloads: null == reloads
            ? _value.reloads
            : reloads // ignore: cast_nullable_to_non_nullable
                  as int,
        totalDelivered: null == totalDelivered
            ? _value.totalDelivered
            : totalDelivered // ignore: cast_nullable_to_non_nullable
                  as int,
        totalSkipped: null == totalSkipped
            ? _value.totalSkipped
            : totalSkipped // ignore: cast_nullable_to_non_nullable
                  as int,
        totalFailed: null == totalFailed
            ? _value.totalFailed
            : totalFailed // ignore: cast_nullable_to_non_nullable
                  as int,
        emptiesCollected: null == emptiesCollected
            ? _value.emptiesCollected
            : emptiesCollected // ignore: cast_nullable_to_non_nullable
                  as int,
        revenue: freezed == revenue
            ? _value.revenue
            : revenue // ignore: cast_nullable_to_non_nullable
                  as RouteSummaryRevenue?,
        sources: null == sources
            ? _value._sources
            : sources // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteHistoryEntryImpl implements _RouteHistoryEntry {
  const _$RouteHistoryEntryImpl({
    required this.date,
    @JsonKey(name: 'truck_id') required this.truckId,
    required this.driver,
    @JsonKey(name: 'started_at') required this.startedAt,
    @JsonKey(name: 'ended_at') required this.endedAt,
    @JsonKey(name: 'duration_minutes') this.durationMinutes = 0,
    @JsonKey(name: 'loaded_full') this.loadedFull = 0,
    this.reloads = 0,
    @JsonKey(name: 'total_delivered') this.totalDelivered = 0,
    @JsonKey(name: 'total_skipped') this.totalSkipped = 0,
    @JsonKey(name: 'total_failed') this.totalFailed = 0,
    @JsonKey(name: 'empties_collected') this.emptiesCollected = 0,
    this.revenue,
    final Map<String, int> sources = const {},
  }) : _sources = sources;

  factory _$RouteHistoryEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteHistoryEntryImplFromJson(json);

  @override
  final String date;
  @override
  @JsonKey(name: 'truck_id')
  final String truckId;
  @override
  final String driver;
  @override
  @JsonKey(name: 'started_at')
  final String startedAt;
  @override
  @JsonKey(name: 'ended_at')
  final String endedAt;
  @override
  @JsonKey(name: 'duration_minutes')
  final int durationMinutes;
  @override
  @JsonKey(name: 'loaded_full')
  final int loadedFull;
  @override
  @JsonKey()
  final int reloads;
  @override
  @JsonKey(name: 'total_delivered')
  final int totalDelivered;
  @override
  @JsonKey(name: 'total_skipped')
  final int totalSkipped;
  @override
  @JsonKey(name: 'total_failed')
  final int totalFailed;
  @override
  @JsonKey(name: 'empties_collected')
  final int emptiesCollected;
  @override
  final RouteSummaryRevenue? revenue;
  final Map<String, int> _sources;
  @override
  @JsonKey()
  Map<String, int> get sources {
    if (_sources is EqualUnmodifiableMapView) return _sources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sources);
  }

  @override
  String toString() {
    return 'RouteHistoryEntry(date: $date, truckId: $truckId, driver: $driver, startedAt: $startedAt, endedAt: $endedAt, durationMinutes: $durationMinutes, loadedFull: $loadedFull, reloads: $reloads, totalDelivered: $totalDelivered, totalSkipped: $totalSkipped, totalFailed: $totalFailed, emptiesCollected: $emptiesCollected, revenue: $revenue, sources: $sources)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteHistoryEntryImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.truckId, truckId) || other.truckId == truckId) &&
            (identical(other.driver, driver) || other.driver == driver) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.loadedFull, loadedFull) ||
                other.loadedFull == loadedFull) &&
            (identical(other.reloads, reloads) || other.reloads == reloads) &&
            (identical(other.totalDelivered, totalDelivered) ||
                other.totalDelivered == totalDelivered) &&
            (identical(other.totalSkipped, totalSkipped) ||
                other.totalSkipped == totalSkipped) &&
            (identical(other.totalFailed, totalFailed) ||
                other.totalFailed == totalFailed) &&
            (identical(other.emptiesCollected, emptiesCollected) ||
                other.emptiesCollected == emptiesCollected) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            const DeepCollectionEquality().equals(other._sources, _sources));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    truckId,
    driver,
    startedAt,
    endedAt,
    durationMinutes,
    loadedFull,
    reloads,
    totalDelivered,
    totalSkipped,
    totalFailed,
    emptiesCollected,
    revenue,
    const DeepCollectionEquality().hash(_sources),
  );

  /// Create a copy of RouteHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteHistoryEntryImplCopyWith<_$RouteHistoryEntryImpl> get copyWith =>
      __$$RouteHistoryEntryImplCopyWithImpl<_$RouteHistoryEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteHistoryEntryImplToJson(this);
  }
}

abstract class _RouteHistoryEntry implements RouteHistoryEntry {
  const factory _RouteHistoryEntry({
    required final String date,
    @JsonKey(name: 'truck_id') required final String truckId,
    required final String driver,
    @JsonKey(name: 'started_at') required final String startedAt,
    @JsonKey(name: 'ended_at') required final String endedAt,
    @JsonKey(name: 'duration_minutes') final int durationMinutes,
    @JsonKey(name: 'loaded_full') final int loadedFull,
    final int reloads,
    @JsonKey(name: 'total_delivered') final int totalDelivered,
    @JsonKey(name: 'total_skipped') final int totalSkipped,
    @JsonKey(name: 'total_failed') final int totalFailed,
    @JsonKey(name: 'empties_collected') final int emptiesCollected,
    final RouteSummaryRevenue? revenue,
    final Map<String, int> sources,
  }) = _$RouteHistoryEntryImpl;

  factory _RouteHistoryEntry.fromJson(Map<String, dynamic> json) =
      _$RouteHistoryEntryImpl.fromJson;

  @override
  String get date;
  @override
  @JsonKey(name: 'truck_id')
  String get truckId;
  @override
  String get driver;
  @override
  @JsonKey(name: 'started_at')
  String get startedAt;
  @override
  @JsonKey(name: 'ended_at')
  String get endedAt;
  @override
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes;
  @override
  @JsonKey(name: 'loaded_full')
  int get loadedFull;
  @override
  int get reloads;
  @override
  @JsonKey(name: 'total_delivered')
  int get totalDelivered;
  @override
  @JsonKey(name: 'total_skipped')
  int get totalSkipped;
  @override
  @JsonKey(name: 'total_failed')
  int get totalFailed;
  @override
  @JsonKey(name: 'empties_collected')
  int get emptiesCollected;
  @override
  RouteSummaryRevenue? get revenue;
  @override
  Map<String, int> get sources;

  /// Create a copy of RouteHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteHistoryEntryImplCopyWith<_$RouteHistoryEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeliveryEstimationConfig _$DeliveryEstimationConfigFromJson(
  Map<String, dynamic> json,
) {
  return _DeliveryEstimationConfig.fromJson(json);
}

/// @nodoc
mixin _$DeliveryEstimationConfig {
  EstimationMode get mode => throw _privateConstructorUsedError;
  @JsonKey(name: 'show_queue_position')
  bool get showQueuePosition => throw _privateConstructorUsedError;
  @JsonKey(name: 'show_driver_contact')
  bool get showDriverContact => throw _privateConstructorUsedError;
  @JsonKey(name: 'show_live_tracking')
  bool get showLiveTracking => throw _privateConstructorUsedError;
  @JsonKey(name: 'typical_delivery_window')
  String get typicalDeliveryWindow => throw _privateConstructorUsedError;
  @JsonKey(name: 'route_days_label')
  String get routeDaysLabel => throw _privateConstructorUsedError;
  @JsonKey(name: 'off_day_message')
  String get offDayMessage => throw _privateConstructorUsedError;

  /// Serializes this DeliveryEstimationConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeliveryEstimationConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeliveryEstimationConfigCopyWith<DeliveryEstimationConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeliveryEstimationConfigCopyWith<$Res> {
  factory $DeliveryEstimationConfigCopyWith(
    DeliveryEstimationConfig value,
    $Res Function(DeliveryEstimationConfig) then,
  ) = _$DeliveryEstimationConfigCopyWithImpl<$Res, DeliveryEstimationConfig>;
  @useResult
  $Res call({
    EstimationMode mode,
    @JsonKey(name: 'show_queue_position') bool showQueuePosition,
    @JsonKey(name: 'show_driver_contact') bool showDriverContact,
    @JsonKey(name: 'show_live_tracking') bool showLiveTracking,
    @JsonKey(name: 'typical_delivery_window') String typicalDeliveryWindow,
    @JsonKey(name: 'route_days_label') String routeDaysLabel,
    @JsonKey(name: 'off_day_message') String offDayMessage,
  });
}

/// @nodoc
class _$DeliveryEstimationConfigCopyWithImpl<
  $Res,
  $Val extends DeliveryEstimationConfig
>
    implements $DeliveryEstimationConfigCopyWith<$Res> {
  _$DeliveryEstimationConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeliveryEstimationConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? showQueuePosition = null,
    Object? showDriverContact = null,
    Object? showLiveTracking = null,
    Object? typicalDeliveryWindow = null,
    Object? routeDaysLabel = null,
    Object? offDayMessage = null,
  }) {
    return _then(
      _value.copyWith(
            mode: null == mode
                ? _value.mode
                : mode // ignore: cast_nullable_to_non_nullable
                      as EstimationMode,
            showQueuePosition: null == showQueuePosition
                ? _value.showQueuePosition
                : showQueuePosition // ignore: cast_nullable_to_non_nullable
                      as bool,
            showDriverContact: null == showDriverContact
                ? _value.showDriverContact
                : showDriverContact // ignore: cast_nullable_to_non_nullable
                      as bool,
            showLiveTracking: null == showLiveTracking
                ? _value.showLiveTracking
                : showLiveTracking // ignore: cast_nullable_to_non_nullable
                      as bool,
            typicalDeliveryWindow: null == typicalDeliveryWindow
                ? _value.typicalDeliveryWindow
                : typicalDeliveryWindow // ignore: cast_nullable_to_non_nullable
                      as String,
            routeDaysLabel: null == routeDaysLabel
                ? _value.routeDaysLabel
                : routeDaysLabel // ignore: cast_nullable_to_non_nullable
                      as String,
            offDayMessage: null == offDayMessage
                ? _value.offDayMessage
                : offDayMessage // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeliveryEstimationConfigImplCopyWith<$Res>
    implements $DeliveryEstimationConfigCopyWith<$Res> {
  factory _$$DeliveryEstimationConfigImplCopyWith(
    _$DeliveryEstimationConfigImpl value,
    $Res Function(_$DeliveryEstimationConfigImpl) then,
  ) = __$$DeliveryEstimationConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    EstimationMode mode,
    @JsonKey(name: 'show_queue_position') bool showQueuePosition,
    @JsonKey(name: 'show_driver_contact') bool showDriverContact,
    @JsonKey(name: 'show_live_tracking') bool showLiveTracking,
    @JsonKey(name: 'typical_delivery_window') String typicalDeliveryWindow,
    @JsonKey(name: 'route_days_label') String routeDaysLabel,
    @JsonKey(name: 'off_day_message') String offDayMessage,
  });
}

/// @nodoc
class __$$DeliveryEstimationConfigImplCopyWithImpl<$Res>
    extends
        _$DeliveryEstimationConfigCopyWithImpl<
          $Res,
          _$DeliveryEstimationConfigImpl
        >
    implements _$$DeliveryEstimationConfigImplCopyWith<$Res> {
  __$$DeliveryEstimationConfigImplCopyWithImpl(
    _$DeliveryEstimationConfigImpl _value,
    $Res Function(_$DeliveryEstimationConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeliveryEstimationConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? showQueuePosition = null,
    Object? showDriverContact = null,
    Object? showLiveTracking = null,
    Object? typicalDeliveryWindow = null,
    Object? routeDaysLabel = null,
    Object? offDayMessage = null,
  }) {
    return _then(
      _$DeliveryEstimationConfigImpl(
        mode: null == mode
            ? _value.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as EstimationMode,
        showQueuePosition: null == showQueuePosition
            ? _value.showQueuePosition
            : showQueuePosition // ignore: cast_nullable_to_non_nullable
                  as bool,
        showDriverContact: null == showDriverContact
            ? _value.showDriverContact
            : showDriverContact // ignore: cast_nullable_to_non_nullable
                  as bool,
        showLiveTracking: null == showLiveTracking
            ? _value.showLiveTracking
            : showLiveTracking // ignore: cast_nullable_to_non_nullable
                  as bool,
        typicalDeliveryWindow: null == typicalDeliveryWindow
            ? _value.typicalDeliveryWindow
            : typicalDeliveryWindow // ignore: cast_nullable_to_non_nullable
                  as String,
        routeDaysLabel: null == routeDaysLabel
            ? _value.routeDaysLabel
            : routeDaysLabel // ignore: cast_nullable_to_non_nullable
                  as String,
        offDayMessage: null == offDayMessage
            ? _value.offDayMessage
            : offDayMessage // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeliveryEstimationConfigImpl implements _DeliveryEstimationConfig {
  const _$DeliveryEstimationConfigImpl({
    required this.mode,
    @JsonKey(name: 'show_queue_position') this.showQueuePosition = false,
    @JsonKey(name: 'show_driver_contact') this.showDriverContact = false,
    @JsonKey(name: 'show_live_tracking') this.showLiveTracking = false,
    @JsonKey(name: 'typical_delivery_window') this.typicalDeliveryWindow = '',
    @JsonKey(name: 'route_days_label') this.routeDaysLabel = '',
    @JsonKey(name: 'off_day_message') this.offDayMessage = '',
  });

  factory _$DeliveryEstimationConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeliveryEstimationConfigImplFromJson(json);

  @override
  final EstimationMode mode;
  @override
  @JsonKey(name: 'show_queue_position')
  final bool showQueuePosition;
  @override
  @JsonKey(name: 'show_driver_contact')
  final bool showDriverContact;
  @override
  @JsonKey(name: 'show_live_tracking')
  final bool showLiveTracking;
  @override
  @JsonKey(name: 'typical_delivery_window')
  final String typicalDeliveryWindow;
  @override
  @JsonKey(name: 'route_days_label')
  final String routeDaysLabel;
  @override
  @JsonKey(name: 'off_day_message')
  final String offDayMessage;

  @override
  String toString() {
    return 'DeliveryEstimationConfig(mode: $mode, showQueuePosition: $showQueuePosition, showDriverContact: $showDriverContact, showLiveTracking: $showLiveTracking, typicalDeliveryWindow: $typicalDeliveryWindow, routeDaysLabel: $routeDaysLabel, offDayMessage: $offDayMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliveryEstimationConfigImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.showQueuePosition, showQueuePosition) ||
                other.showQueuePosition == showQueuePosition) &&
            (identical(other.showDriverContact, showDriverContact) ||
                other.showDriverContact == showDriverContact) &&
            (identical(other.showLiveTracking, showLiveTracking) ||
                other.showLiveTracking == showLiveTracking) &&
            (identical(other.typicalDeliveryWindow, typicalDeliveryWindow) ||
                other.typicalDeliveryWindow == typicalDeliveryWindow) &&
            (identical(other.routeDaysLabel, routeDaysLabel) ||
                other.routeDaysLabel == routeDaysLabel) &&
            (identical(other.offDayMessage, offDayMessage) ||
                other.offDayMessage == offDayMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    mode,
    showQueuePosition,
    showDriverContact,
    showLiveTracking,
    typicalDeliveryWindow,
    routeDaysLabel,
    offDayMessage,
  );

  /// Create a copy of DeliveryEstimationConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliveryEstimationConfigImplCopyWith<_$DeliveryEstimationConfigImpl>
  get copyWith =>
      __$$DeliveryEstimationConfigImplCopyWithImpl<
        _$DeliveryEstimationConfigImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeliveryEstimationConfigImplToJson(this);
  }
}

abstract class _DeliveryEstimationConfig implements DeliveryEstimationConfig {
  const factory _DeliveryEstimationConfig({
    required final EstimationMode mode,
    @JsonKey(name: 'show_queue_position') final bool showQueuePosition,
    @JsonKey(name: 'show_driver_contact') final bool showDriverContact,
    @JsonKey(name: 'show_live_tracking') final bool showLiveTracking,
    @JsonKey(name: 'typical_delivery_window')
    final String typicalDeliveryWindow,
    @JsonKey(name: 'route_days_label') final String routeDaysLabel,
    @JsonKey(name: 'off_day_message') final String offDayMessage,
  }) = _$DeliveryEstimationConfigImpl;

  factory _DeliveryEstimationConfig.fromJson(Map<String, dynamic> json) =
      _$DeliveryEstimationConfigImpl.fromJson;

  @override
  EstimationMode get mode;
  @override
  @JsonKey(name: 'show_queue_position')
  bool get showQueuePosition;
  @override
  @JsonKey(name: 'show_driver_contact')
  bool get showDriverContact;
  @override
  @JsonKey(name: 'show_live_tracking')
  bool get showLiveTracking;
  @override
  @JsonKey(name: 'typical_delivery_window')
  String get typicalDeliveryWindow;
  @override
  @JsonKey(name: 'route_days_label')
  String get routeDaysLabel;
  @override
  @JsonKey(name: 'off_day_message')
  String get offDayMessage;

  /// Create a copy of DeliveryEstimationConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliveryEstimationConfigImplCopyWith<_$DeliveryEstimationConfigImpl>
  get copyWith => throw _privateConstructorUsedError;
}

RecurringCustomer _$RecurringCustomerFromJson(Map<String, dynamic> json) {
  return _RecurringCustomer.fromJson(json);
}

/// @nodoc
mixin _$RecurringCustomer {
  @JsonKey(name: 'customer_name')
  String get customerName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  List<QueueOrderItem> get items => throw _privateConstructorUsedError;
  String get schedule => throw _privateConstructorUsedError;
  String get area => throw _privateConstructorUsedError;

  /// Serializes this RecurringCustomer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecurringCustomer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecurringCustomerCopyWith<RecurringCustomer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecurringCustomerCopyWith<$Res> {
  factory $RecurringCustomerCopyWith(
    RecurringCustomer value,
    $Res Function(RecurringCustomer) then,
  ) = _$RecurringCustomerCopyWithImpl<$Res, RecurringCustomer>;
  @useResult
  $Res call({
    @JsonKey(name: 'customer_name') String customerName,
    String phone,
    List<QueueOrderItem> items,
    String schedule,
    String area,
  });
}

/// @nodoc
class _$RecurringCustomerCopyWithImpl<$Res, $Val extends RecurringCustomer>
    implements $RecurringCustomerCopyWith<$Res> {
  _$RecurringCustomerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecurringCustomer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerName = null,
    Object? phone = null,
    Object? items = null,
    Object? schedule = null,
    Object? area = null,
  }) {
    return _then(
      _value.copyWith(
            customerName: null == customerName
                ? _value.customerName
                : customerName // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<QueueOrderItem>,
            schedule: null == schedule
                ? _value.schedule
                : schedule // ignore: cast_nullable_to_non_nullable
                      as String,
            area: null == area
                ? _value.area
                : area // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecurringCustomerImplCopyWith<$Res>
    implements $RecurringCustomerCopyWith<$Res> {
  factory _$$RecurringCustomerImplCopyWith(
    _$RecurringCustomerImpl value,
    $Res Function(_$RecurringCustomerImpl) then,
  ) = __$$RecurringCustomerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'customer_name') String customerName,
    String phone,
    List<QueueOrderItem> items,
    String schedule,
    String area,
  });
}

/// @nodoc
class __$$RecurringCustomerImplCopyWithImpl<$Res>
    extends _$RecurringCustomerCopyWithImpl<$Res, _$RecurringCustomerImpl>
    implements _$$RecurringCustomerImplCopyWith<$Res> {
  __$$RecurringCustomerImplCopyWithImpl(
    _$RecurringCustomerImpl _value,
    $Res Function(_$RecurringCustomerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecurringCustomer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerName = null,
    Object? phone = null,
    Object? items = null,
    Object? schedule = null,
    Object? area = null,
  }) {
    return _then(
      _$RecurringCustomerImpl(
        customerName: null == customerName
            ? _value.customerName
            : customerName // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<QueueOrderItem>,
        schedule: null == schedule
            ? _value.schedule
            : schedule // ignore: cast_nullable_to_non_nullable
                  as String,
        area: null == area
            ? _value.area
            : area // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecurringCustomerImpl implements _RecurringCustomer {
  const _$RecurringCustomerImpl({
    @JsonKey(name: 'customer_name') required this.customerName,
    required this.phone,
    final List<QueueOrderItem> items = const [],
    required this.schedule,
    required this.area,
  }) : _items = items;

  factory _$RecurringCustomerImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecurringCustomerImplFromJson(json);

  @override
  @JsonKey(name: 'customer_name')
  final String customerName;
  @override
  final String phone;
  final List<QueueOrderItem> _items;
  @override
  @JsonKey()
  List<QueueOrderItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final String schedule;
  @override
  final String area;

  @override
  String toString() {
    return 'RecurringCustomer(customerName: $customerName, phone: $phone, items: $items, schedule: $schedule, area: $area)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurringCustomerImpl &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.schedule, schedule) ||
                other.schedule == schedule) &&
            (identical(other.area, area) || other.area == area));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    customerName,
    phone,
    const DeepCollectionEquality().hash(_items),
    schedule,
    area,
  );

  /// Create a copy of RecurringCustomer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecurringCustomerImplCopyWith<_$RecurringCustomerImpl> get copyWith =>
      __$$RecurringCustomerImplCopyWithImpl<_$RecurringCustomerImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RecurringCustomerImplToJson(this);
  }
}

abstract class _RecurringCustomer implements RecurringCustomer {
  const factory _RecurringCustomer({
    @JsonKey(name: 'customer_name') required final String customerName,
    required final String phone,
    final List<QueueOrderItem> items,
    required final String schedule,
    required final String area,
  }) = _$RecurringCustomerImpl;

  factory _RecurringCustomer.fromJson(Map<String, dynamic> json) =
      _$RecurringCustomerImpl.fromJson;

  @override
  @JsonKey(name: 'customer_name')
  String get customerName;
  @override
  String get phone;
  @override
  List<QueueOrderItem> get items;
  @override
  String get schedule;
  @override
  String get area;

  /// Create a copy of RecurringCustomer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecurringCustomerImplCopyWith<_$RecurringCustomerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomerInsight _$CustomerInsightFromJson(Map<String, dynamic> json) {
  return _CustomerInsight.fromJson(json);
}

/// @nodoc
mixin _$CustomerInsight {
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_name')
  String get customerName => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;

  /// Serializes this CustomerInsight to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomerInsight
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerInsightCopyWith<CustomerInsight> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerInsightCopyWith<$Res> {
  factory $CustomerInsightCopyWith(
    CustomerInsight value,
    $Res Function(CustomerInsight) then,
  ) = _$CustomerInsightCopyWithImpl<$Res, CustomerInsight>;
  @useResult
  $Res call({
    String type,
    @JsonKey(name: 'customer_name') String customerName,
    String message,
    String severity,
  });
}

/// @nodoc
class _$CustomerInsightCopyWithImpl<$Res, $Val extends CustomerInsight>
    implements $CustomerInsightCopyWith<$Res> {
  _$CustomerInsightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerInsight
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? customerName = null,
    Object? message = null,
    Object? severity = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            customerName: null == customerName
                ? _value.customerName
                : customerName // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CustomerInsightImplCopyWith<$Res>
    implements $CustomerInsightCopyWith<$Res> {
  factory _$$CustomerInsightImplCopyWith(
    _$CustomerInsightImpl value,
    $Res Function(_$CustomerInsightImpl) then,
  ) = __$$CustomerInsightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String type,
    @JsonKey(name: 'customer_name') String customerName,
    String message,
    String severity,
  });
}

/// @nodoc
class __$$CustomerInsightImplCopyWithImpl<$Res>
    extends _$CustomerInsightCopyWithImpl<$Res, _$CustomerInsightImpl>
    implements _$$CustomerInsightImplCopyWith<$Res> {
  __$$CustomerInsightImplCopyWithImpl(
    _$CustomerInsightImpl _value,
    $Res Function(_$CustomerInsightImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CustomerInsight
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? customerName = null,
    Object? message = null,
    Object? severity = null,
  }) {
    return _then(
      _$CustomerInsightImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        customerName: null == customerName
            ? _value.customerName
            : customerName // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerInsightImpl implements _CustomerInsight {
  const _$CustomerInsightImpl({
    required this.type,
    @JsonKey(name: 'customer_name') required this.customerName,
    required this.message,
    required this.severity,
  });

  factory _$CustomerInsightImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerInsightImplFromJson(json);

  @override
  final String type;
  @override
  @JsonKey(name: 'customer_name')
  final String customerName;
  @override
  final String message;
  @override
  final String severity;

  @override
  String toString() {
    return 'CustomerInsight(type: $type, customerName: $customerName, message: $message, severity: $severity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerInsightImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, customerName, message, severity);

  /// Create a copy of CustomerInsight
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerInsightImplCopyWith<_$CustomerInsightImpl> get copyWith =>
      __$$CustomerInsightImplCopyWithImpl<_$CustomerInsightImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerInsightImplToJson(this);
  }
}

abstract class _CustomerInsight implements CustomerInsight {
  const factory _CustomerInsight({
    required final String type,
    @JsonKey(name: 'customer_name') required final String customerName,
    required final String message,
    required final String severity,
  }) = _$CustomerInsightImpl;

  factory _CustomerInsight.fromJson(Map<String, dynamic> json) =
      _$CustomerInsightImpl.fromJson;

  @override
  String get type;
  @override
  @JsonKey(name: 'customer_name')
  String get customerName;
  @override
  String get message;
  @override
  String get severity;

  /// Create a copy of CustomerInsight
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerInsightImplCopyWith<_$CustomerInsightImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TruckDeliveryData _$TruckDeliveryDataFromJson(Map<String, dynamic> json) {
  return _TruckDeliveryData.fromJson(json);
}

/// @nodoc
mixin _$TruckDeliveryData {
  List<Truck> get trucks => throw _privateConstructorUsedError;
  @JsonKey(name: 'route_queue')
  Map<String, RouteData> get routeQueue => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivery_estimation')
  DeliveryEstimationConfig? get deliveryEstimation =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'recurring_tomorrow')
  List<RecurringCustomer> get recurringTomorrow =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_insights')
  List<CustomerInsight> get customerInsights =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'route_history')
  List<RouteHistoryEntry> get routeHistory =>
      throw _privateConstructorUsedError;

  /// Serializes this TruckDeliveryData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TruckDeliveryData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TruckDeliveryDataCopyWith<TruckDeliveryData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TruckDeliveryDataCopyWith<$Res> {
  factory $TruckDeliveryDataCopyWith(
    TruckDeliveryData value,
    $Res Function(TruckDeliveryData) then,
  ) = _$TruckDeliveryDataCopyWithImpl<$Res, TruckDeliveryData>;
  @useResult
  $Res call({
    List<Truck> trucks,
    @JsonKey(name: 'route_queue') Map<String, RouteData> routeQueue,
    @JsonKey(name: 'delivery_estimation')
    DeliveryEstimationConfig? deliveryEstimation,
    @JsonKey(name: 'recurring_tomorrow')
    List<RecurringCustomer> recurringTomorrow,
    @JsonKey(name: 'customer_insights') List<CustomerInsight> customerInsights,
    @JsonKey(name: 'route_history') List<RouteHistoryEntry> routeHistory,
  });

  $DeliveryEstimationConfigCopyWith<$Res>? get deliveryEstimation;
}

/// @nodoc
class _$TruckDeliveryDataCopyWithImpl<$Res, $Val extends TruckDeliveryData>
    implements $TruckDeliveryDataCopyWith<$Res> {
  _$TruckDeliveryDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TruckDeliveryData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trucks = null,
    Object? routeQueue = null,
    Object? deliveryEstimation = freezed,
    Object? recurringTomorrow = null,
    Object? customerInsights = null,
    Object? routeHistory = null,
  }) {
    return _then(
      _value.copyWith(
            trucks: null == trucks
                ? _value.trucks
                : trucks // ignore: cast_nullable_to_non_nullable
                      as List<Truck>,
            routeQueue: null == routeQueue
                ? _value.routeQueue
                : routeQueue // ignore: cast_nullable_to_non_nullable
                      as Map<String, RouteData>,
            deliveryEstimation: freezed == deliveryEstimation
                ? _value.deliveryEstimation
                : deliveryEstimation // ignore: cast_nullable_to_non_nullable
                      as DeliveryEstimationConfig?,
            recurringTomorrow: null == recurringTomorrow
                ? _value.recurringTomorrow
                : recurringTomorrow // ignore: cast_nullable_to_non_nullable
                      as List<RecurringCustomer>,
            customerInsights: null == customerInsights
                ? _value.customerInsights
                : customerInsights // ignore: cast_nullable_to_non_nullable
                      as List<CustomerInsight>,
            routeHistory: null == routeHistory
                ? _value.routeHistory
                : routeHistory // ignore: cast_nullable_to_non_nullable
                      as List<RouteHistoryEntry>,
          )
          as $Val,
    );
  }

  /// Create a copy of TruckDeliveryData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeliveryEstimationConfigCopyWith<$Res>? get deliveryEstimation {
    if (_value.deliveryEstimation == null) {
      return null;
    }

    return $DeliveryEstimationConfigCopyWith<$Res>(_value.deliveryEstimation!, (
      value,
    ) {
      return _then(_value.copyWith(deliveryEstimation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TruckDeliveryDataImplCopyWith<$Res>
    implements $TruckDeliveryDataCopyWith<$Res> {
  factory _$$TruckDeliveryDataImplCopyWith(
    _$TruckDeliveryDataImpl value,
    $Res Function(_$TruckDeliveryDataImpl) then,
  ) = __$$TruckDeliveryDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Truck> trucks,
    @JsonKey(name: 'route_queue') Map<String, RouteData> routeQueue,
    @JsonKey(name: 'delivery_estimation')
    DeliveryEstimationConfig? deliveryEstimation,
    @JsonKey(name: 'recurring_tomorrow')
    List<RecurringCustomer> recurringTomorrow,
    @JsonKey(name: 'customer_insights') List<CustomerInsight> customerInsights,
    @JsonKey(name: 'route_history') List<RouteHistoryEntry> routeHistory,
  });

  @override
  $DeliveryEstimationConfigCopyWith<$Res>? get deliveryEstimation;
}

/// @nodoc
class __$$TruckDeliveryDataImplCopyWithImpl<$Res>
    extends _$TruckDeliveryDataCopyWithImpl<$Res, _$TruckDeliveryDataImpl>
    implements _$$TruckDeliveryDataImplCopyWith<$Res> {
  __$$TruckDeliveryDataImplCopyWithImpl(
    _$TruckDeliveryDataImpl _value,
    $Res Function(_$TruckDeliveryDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TruckDeliveryData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trucks = null,
    Object? routeQueue = null,
    Object? deliveryEstimation = freezed,
    Object? recurringTomorrow = null,
    Object? customerInsights = null,
    Object? routeHistory = null,
  }) {
    return _then(
      _$TruckDeliveryDataImpl(
        trucks: null == trucks
            ? _value._trucks
            : trucks // ignore: cast_nullable_to_non_nullable
                  as List<Truck>,
        routeQueue: null == routeQueue
            ? _value._routeQueue
            : routeQueue // ignore: cast_nullable_to_non_nullable
                  as Map<String, RouteData>,
        deliveryEstimation: freezed == deliveryEstimation
            ? _value.deliveryEstimation
            : deliveryEstimation // ignore: cast_nullable_to_non_nullable
                  as DeliveryEstimationConfig?,
        recurringTomorrow: null == recurringTomorrow
            ? _value._recurringTomorrow
            : recurringTomorrow // ignore: cast_nullable_to_non_nullable
                  as List<RecurringCustomer>,
        customerInsights: null == customerInsights
            ? _value._customerInsights
            : customerInsights // ignore: cast_nullable_to_non_nullable
                  as List<CustomerInsight>,
        routeHistory: null == routeHistory
            ? _value._routeHistory
            : routeHistory // ignore: cast_nullable_to_non_nullable
                  as List<RouteHistoryEntry>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TruckDeliveryDataImpl implements _TruckDeliveryData {
  const _$TruckDeliveryDataImpl({
    final List<Truck> trucks = const [],
    @JsonKey(name: 'route_queue')
    final Map<String, RouteData> routeQueue = const {},
    @JsonKey(name: 'delivery_estimation') this.deliveryEstimation,
    @JsonKey(name: 'recurring_tomorrow')
    final List<RecurringCustomer> recurringTomorrow = const [],
    @JsonKey(name: 'customer_insights')
    final List<CustomerInsight> customerInsights = const [],
    @JsonKey(name: 'route_history')
    final List<RouteHistoryEntry> routeHistory = const [],
  }) : _trucks = trucks,
       _routeQueue = routeQueue,
       _recurringTomorrow = recurringTomorrow,
       _customerInsights = customerInsights,
       _routeHistory = routeHistory;

  factory _$TruckDeliveryDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TruckDeliveryDataImplFromJson(json);

  final List<Truck> _trucks;
  @override
  @JsonKey()
  List<Truck> get trucks {
    if (_trucks is EqualUnmodifiableListView) return _trucks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trucks);
  }

  final Map<String, RouteData> _routeQueue;
  @override
  @JsonKey(name: 'route_queue')
  Map<String, RouteData> get routeQueue {
    if (_routeQueue is EqualUnmodifiableMapView) return _routeQueue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_routeQueue);
  }

  @override
  @JsonKey(name: 'delivery_estimation')
  final DeliveryEstimationConfig? deliveryEstimation;
  final List<RecurringCustomer> _recurringTomorrow;
  @override
  @JsonKey(name: 'recurring_tomorrow')
  List<RecurringCustomer> get recurringTomorrow {
    if (_recurringTomorrow is EqualUnmodifiableListView)
      return _recurringTomorrow;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recurringTomorrow);
  }

  final List<CustomerInsight> _customerInsights;
  @override
  @JsonKey(name: 'customer_insights')
  List<CustomerInsight> get customerInsights {
    if (_customerInsights is EqualUnmodifiableListView)
      return _customerInsights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customerInsights);
  }

  final List<RouteHistoryEntry> _routeHistory;
  @override
  @JsonKey(name: 'route_history')
  List<RouteHistoryEntry> get routeHistory {
    if (_routeHistory is EqualUnmodifiableListView) return _routeHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_routeHistory);
  }

  @override
  String toString() {
    return 'TruckDeliveryData(trucks: $trucks, routeQueue: $routeQueue, deliveryEstimation: $deliveryEstimation, recurringTomorrow: $recurringTomorrow, customerInsights: $customerInsights, routeHistory: $routeHistory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TruckDeliveryDataImpl &&
            const DeepCollectionEquality().equals(other._trucks, _trucks) &&
            const DeepCollectionEquality().equals(
              other._routeQueue,
              _routeQueue,
            ) &&
            (identical(other.deliveryEstimation, deliveryEstimation) ||
                other.deliveryEstimation == deliveryEstimation) &&
            const DeepCollectionEquality().equals(
              other._recurringTomorrow,
              _recurringTomorrow,
            ) &&
            const DeepCollectionEquality().equals(
              other._customerInsights,
              _customerInsights,
            ) &&
            const DeepCollectionEquality().equals(
              other._routeHistory,
              _routeHistory,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_trucks),
    const DeepCollectionEquality().hash(_routeQueue),
    deliveryEstimation,
    const DeepCollectionEquality().hash(_recurringTomorrow),
    const DeepCollectionEquality().hash(_customerInsights),
    const DeepCollectionEquality().hash(_routeHistory),
  );

  /// Create a copy of TruckDeliveryData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TruckDeliveryDataImplCopyWith<_$TruckDeliveryDataImpl> get copyWith =>
      __$$TruckDeliveryDataImplCopyWithImpl<_$TruckDeliveryDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TruckDeliveryDataImplToJson(this);
  }
}

abstract class _TruckDeliveryData implements TruckDeliveryData {
  const factory _TruckDeliveryData({
    final List<Truck> trucks,
    @JsonKey(name: 'route_queue') final Map<String, RouteData> routeQueue,
    @JsonKey(name: 'delivery_estimation')
    final DeliveryEstimationConfig? deliveryEstimation,
    @JsonKey(name: 'recurring_tomorrow')
    final List<RecurringCustomer> recurringTomorrow,
    @JsonKey(name: 'customer_insights')
    final List<CustomerInsight> customerInsights,
    @JsonKey(name: 'route_history') final List<RouteHistoryEntry> routeHistory,
  }) = _$TruckDeliveryDataImpl;

  factory _TruckDeliveryData.fromJson(Map<String, dynamic> json) =
      _$TruckDeliveryDataImpl.fromJson;

  @override
  List<Truck> get trucks;
  @override
  @JsonKey(name: 'route_queue')
  Map<String, RouteData> get routeQueue;
  @override
  @JsonKey(name: 'delivery_estimation')
  DeliveryEstimationConfig? get deliveryEstimation;
  @override
  @JsonKey(name: 'recurring_tomorrow')
  List<RecurringCustomer> get recurringTomorrow;
  @override
  @JsonKey(name: 'customer_insights')
  List<CustomerInsight> get customerInsights;
  @override
  @JsonKey(name: 'route_history')
  List<RouteHistoryEntry> get routeHistory;

  /// Create a copy of TruckDeliveryData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TruckDeliveryDataImplCopyWith<_$TruckDeliveryDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
