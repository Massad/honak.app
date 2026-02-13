// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TicketActivityEntry _$TicketActivityEntryFromJson(Map<String, dynamic> json) {
  return _TicketActivityEntry.fromJson(json);
}

/// @nodoc
mixin _$TicketActivityEntry {
  String get id => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;
  TicketActivityAction get action => throw _privateConstructorUsedError;
  @JsonKey(name: 'actor_name')
  String get actorName => throw _privateConstructorUsedError;
  @JsonKey(name: 'actor_role')
  String? get actorRole => throw _privateConstructorUsedError;
  String? get from => throw _privateConstructorUsedError;
  String? get to => throw _privateConstructorUsedError;
  List<String>? get items => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  int? get amount => throw _privateConstructorUsedError;
  String? get method => throw _privateConstructorUsedError;
  String? get changes => throw _privateConstructorUsedError;

  /// Serializes this TicketActivityEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TicketActivityEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketActivityEntryCopyWith<TicketActivityEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketActivityEntryCopyWith<$Res> {
  factory $TicketActivityEntryCopyWith(
    TicketActivityEntry value,
    $Res Function(TicketActivityEntry) then,
  ) = _$TicketActivityEntryCopyWithImpl<$Res, TicketActivityEntry>;
  @useResult
  $Res call({
    String id,
    String timestamp,
    TicketActivityAction action,
    @JsonKey(name: 'actor_name') String actorName,
    @JsonKey(name: 'actor_role') String? actorRole,
    String? from,
    String? to,
    List<String>? items,
    String? note,
    int? amount,
    String? method,
    String? changes,
  });
}

/// @nodoc
class _$TicketActivityEntryCopyWithImpl<$Res, $Val extends TicketActivityEntry>
    implements $TicketActivityEntryCopyWith<$Res> {
  _$TicketActivityEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TicketActivityEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? action = null,
    Object? actorName = null,
    Object? actorRole = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? items = freezed,
    Object? note = freezed,
    Object? amount = freezed,
    Object? method = freezed,
    Object? changes = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as String,
            action: null == action
                ? _value.action
                : action // ignore: cast_nullable_to_non_nullable
                      as TicketActivityAction,
            actorName: null == actorName
                ? _value.actorName
                : actorName // ignore: cast_nullable_to_non_nullable
                      as String,
            actorRole: freezed == actorRole
                ? _value.actorRole
                : actorRole // ignore: cast_nullable_to_non_nullable
                      as String?,
            from: freezed == from
                ? _value.from
                : from // ignore: cast_nullable_to_non_nullable
                      as String?,
            to: freezed == to
                ? _value.to
                : to // ignore: cast_nullable_to_non_nullable
                      as String?,
            items: freezed == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
            amount: freezed == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int?,
            method: freezed == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                      as String?,
            changes: freezed == changes
                ? _value.changes
                : changes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TicketActivityEntryImplCopyWith<$Res>
    implements $TicketActivityEntryCopyWith<$Res> {
  factory _$$TicketActivityEntryImplCopyWith(
    _$TicketActivityEntryImpl value,
    $Res Function(_$TicketActivityEntryImpl) then,
  ) = __$$TicketActivityEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String timestamp,
    TicketActivityAction action,
    @JsonKey(name: 'actor_name') String actorName,
    @JsonKey(name: 'actor_role') String? actorRole,
    String? from,
    String? to,
    List<String>? items,
    String? note,
    int? amount,
    String? method,
    String? changes,
  });
}

/// @nodoc
class __$$TicketActivityEntryImplCopyWithImpl<$Res>
    extends _$TicketActivityEntryCopyWithImpl<$Res, _$TicketActivityEntryImpl>
    implements _$$TicketActivityEntryImplCopyWith<$Res> {
  __$$TicketActivityEntryImplCopyWithImpl(
    _$TicketActivityEntryImpl _value,
    $Res Function(_$TicketActivityEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TicketActivityEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? action = null,
    Object? actorName = null,
    Object? actorRole = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? items = freezed,
    Object? note = freezed,
    Object? amount = freezed,
    Object? method = freezed,
    Object? changes = freezed,
  }) {
    return _then(
      _$TicketActivityEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as String,
        action: null == action
            ? _value.action
            : action // ignore: cast_nullable_to_non_nullable
                  as TicketActivityAction,
        actorName: null == actorName
            ? _value.actorName
            : actorName // ignore: cast_nullable_to_non_nullable
                  as String,
        actorRole: freezed == actorRole
            ? _value.actorRole
            : actorRole // ignore: cast_nullable_to_non_nullable
                  as String?,
        from: freezed == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as String?,
        to: freezed == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as String?,
        items: freezed == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        amount: freezed == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int?,
        method: freezed == method
            ? _value.method
            : method // ignore: cast_nullable_to_non_nullable
                  as String?,
        changes: freezed == changes
            ? _value.changes
            : changes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketActivityEntryImpl implements _TicketActivityEntry {
  const _$TicketActivityEntryImpl({
    required this.id,
    required this.timestamp,
    required this.action,
    @JsonKey(name: 'actor_name') required this.actorName,
    @JsonKey(name: 'actor_role') this.actorRole,
    this.from,
    this.to,
    final List<String>? items,
    this.note,
    this.amount,
    this.method,
    this.changes,
  }) : _items = items;

  factory _$TicketActivityEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketActivityEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String timestamp;
  @override
  final TicketActivityAction action;
  @override
  @JsonKey(name: 'actor_name')
  final String actorName;
  @override
  @JsonKey(name: 'actor_role')
  final String? actorRole;
  @override
  final String? from;
  @override
  final String? to;
  final List<String>? _items;
  @override
  List<String>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? note;
  @override
  final int? amount;
  @override
  final String? method;
  @override
  final String? changes;

  @override
  String toString() {
    return 'TicketActivityEntry(id: $id, timestamp: $timestamp, action: $action, actorName: $actorName, actorRole: $actorRole, from: $from, to: $to, items: $items, note: $note, amount: $amount, method: $method, changes: $changes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketActivityEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.actorName, actorName) ||
                other.actorName == actorName) &&
            (identical(other.actorRole, actorRole) ||
                other.actorRole == actorRole) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.changes, changes) || other.changes == changes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    timestamp,
    action,
    actorName,
    actorRole,
    from,
    to,
    const DeepCollectionEquality().hash(_items),
    note,
    amount,
    method,
    changes,
  );

  /// Create a copy of TicketActivityEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketActivityEntryImplCopyWith<_$TicketActivityEntryImpl> get copyWith =>
      __$$TicketActivityEntryImplCopyWithImpl<_$TicketActivityEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketActivityEntryImplToJson(this);
  }
}

abstract class _TicketActivityEntry implements TicketActivityEntry {
  const factory _TicketActivityEntry({
    required final String id,
    required final String timestamp,
    required final TicketActivityAction action,
    @JsonKey(name: 'actor_name') required final String actorName,
    @JsonKey(name: 'actor_role') final String? actorRole,
    final String? from,
    final String? to,
    final List<String>? items,
    final String? note,
    final int? amount,
    final String? method,
    final String? changes,
  }) = _$TicketActivityEntryImpl;

  factory _TicketActivityEntry.fromJson(Map<String, dynamic> json) =
      _$TicketActivityEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get timestamp;
  @override
  TicketActivityAction get action;
  @override
  @JsonKey(name: 'actor_name')
  String get actorName;
  @override
  @JsonKey(name: 'actor_role')
  String? get actorRole;
  @override
  String? get from;
  @override
  String? get to;
  @override
  List<String>? get items;
  @override
  String? get note;
  @override
  int? get amount;
  @override
  String? get method;
  @override
  String? get changes;

  /// Create a copy of TicketActivityEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketActivityEntryImplCopyWith<_$TicketActivityEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
