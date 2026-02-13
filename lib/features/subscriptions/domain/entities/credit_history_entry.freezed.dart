// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_history_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreditHistoryEntry _$CreditHistoryEntryFromJson(Map<String, dynamic> json) {
  return _CreditHistoryEntry.fromJson(json);
}

/// @nodoc
mixin _$CreditHistoryEntry {
  String get date => throw _privateConstructorUsedError;
  CreditHistoryType get type => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this CreditHistoryEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreditHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreditHistoryEntryCopyWith<CreditHistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditHistoryEntryCopyWith<$Res> {
  factory $CreditHistoryEntryCopyWith(
    CreditHistoryEntry value,
    $Res Function(CreditHistoryEntry) then,
  ) = _$CreditHistoryEntryCopyWithImpl<$Res, CreditHistoryEntry>;
  @useResult
  $Res call({String date, CreditHistoryType type, int amount, String? note});
}

/// @nodoc
class _$CreditHistoryEntryCopyWithImpl<$Res, $Val extends CreditHistoryEntry>
    implements $CreditHistoryEntryCopyWith<$Res> {
  _$CreditHistoryEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreditHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? type = null,
    Object? amount = null,
    Object? note = freezed,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as CreditHistoryType,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreditHistoryEntryImplCopyWith<$Res>
    implements $CreditHistoryEntryCopyWith<$Res> {
  factory _$$CreditHistoryEntryImplCopyWith(
    _$CreditHistoryEntryImpl value,
    $Res Function(_$CreditHistoryEntryImpl) then,
  ) = __$$CreditHistoryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, CreditHistoryType type, int amount, String? note});
}

/// @nodoc
class __$$CreditHistoryEntryImplCopyWithImpl<$Res>
    extends _$CreditHistoryEntryCopyWithImpl<$Res, _$CreditHistoryEntryImpl>
    implements _$$CreditHistoryEntryImplCopyWith<$Res> {
  __$$CreditHistoryEntryImplCopyWithImpl(
    _$CreditHistoryEntryImpl _value,
    $Res Function(_$CreditHistoryEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreditHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? type = null,
    Object? amount = null,
    Object? note = freezed,
  }) {
    return _then(
      _$CreditHistoryEntryImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as CreditHistoryType,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreditHistoryEntryImpl implements _CreditHistoryEntry {
  const _$CreditHistoryEntryImpl({
    required this.date,
    required this.type,
    this.amount = 0,
    this.note,
  });

  factory _$CreditHistoryEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreditHistoryEntryImplFromJson(json);

  @override
  final String date;
  @override
  final CreditHistoryType type;
  @override
  @JsonKey()
  final int amount;
  @override
  final String? note;

  @override
  String toString() {
    return 'CreditHistoryEntry(date: $date, type: $type, amount: $amount, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditHistoryEntryImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, type, amount, note);

  /// Create a copy of CreditHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditHistoryEntryImplCopyWith<_$CreditHistoryEntryImpl> get copyWith =>
      __$$CreditHistoryEntryImplCopyWithImpl<_$CreditHistoryEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreditHistoryEntryImplToJson(this);
  }
}

abstract class _CreditHistoryEntry implements CreditHistoryEntry {
  const factory _CreditHistoryEntry({
    required final String date,
    required final CreditHistoryType type,
    final int amount,
    final String? note,
  }) = _$CreditHistoryEntryImpl;

  factory _CreditHistoryEntry.fromJson(Map<String, dynamic> json) =
      _$CreditHistoryEntryImpl.fromJson;

  @override
  String get date;
  @override
  CreditHistoryType get type;
  @override
  int get amount;
  @override
  String? get note;

  /// Create a copy of CreditHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreditHistoryEntryImplCopyWith<_$CreditHistoryEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
