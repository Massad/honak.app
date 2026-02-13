// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_discount.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QueueDiscount _$QueueDiscountFromJson(Map<String, dynamic> json) {
  return _QueueDiscount.fromJson(json);
}

/// @nodoc
mixin _$QueueDiscount {
  /// 'percentage' or 'fixed'
  String get type => throw _privateConstructorUsedError;

  /// Raw input: 20 (for 20%) or 150 (for 1.5 JOD in piasters)
  int get value => throw _privateConstructorUsedError;

  /// Calculated amount deducted (piasters)
  @JsonKey(name: 'amount_cents')
  int get amount => throw _privateConstructorUsedError;

  /// Internal reason label (عميل مميز, تعويض, عرض خاص, etc.)
  String get reason => throw _privateConstructorUsedError;

  /// Free-text note for "أخرى" reason
  @JsonKey(name: 'reason_note')
  String? get reasonNote => throw _privateConstructorUsedError;

  /// Serializes this QueueDiscount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueueDiscount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueueDiscountCopyWith<QueueDiscount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueDiscountCopyWith<$Res> {
  factory $QueueDiscountCopyWith(
    QueueDiscount value,
    $Res Function(QueueDiscount) then,
  ) = _$QueueDiscountCopyWithImpl<$Res, QueueDiscount>;
  @useResult
  $Res call({
    String type,
    int value,
    @JsonKey(name: 'amount_cents') int amount,
    String reason,
    @JsonKey(name: 'reason_note') String? reasonNote,
  });
}

/// @nodoc
class _$QueueDiscountCopyWithImpl<$Res, $Val extends QueueDiscount>
    implements $QueueDiscountCopyWith<$Res> {
  _$QueueDiscountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueueDiscount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? value = null,
    Object? amount = null,
    Object? reason = null,
    Object? reasonNote = freezed,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as int,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
            reasonNote: freezed == reasonNote
                ? _value.reasonNote
                : reasonNote // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QueueDiscountImplCopyWith<$Res>
    implements $QueueDiscountCopyWith<$Res> {
  factory _$$QueueDiscountImplCopyWith(
    _$QueueDiscountImpl value,
    $Res Function(_$QueueDiscountImpl) then,
  ) = __$$QueueDiscountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String type,
    int value,
    @JsonKey(name: 'amount_cents') int amount,
    String reason,
    @JsonKey(name: 'reason_note') String? reasonNote,
  });
}

/// @nodoc
class __$$QueueDiscountImplCopyWithImpl<$Res>
    extends _$QueueDiscountCopyWithImpl<$Res, _$QueueDiscountImpl>
    implements _$$QueueDiscountImplCopyWith<$Res> {
  __$$QueueDiscountImplCopyWithImpl(
    _$QueueDiscountImpl _value,
    $Res Function(_$QueueDiscountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueueDiscount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? value = null,
    Object? amount = null,
    Object? reason = null,
    Object? reasonNote = freezed,
  }) {
    return _then(
      _$QueueDiscountImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as int,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        reasonNote: freezed == reasonNote
            ? _value.reasonNote
            : reasonNote // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueDiscountImpl implements _QueueDiscount {
  const _$QueueDiscountImpl({
    required this.type,
    required this.value,
    @JsonKey(name: 'amount_cents') required this.amount,
    required this.reason,
    @JsonKey(name: 'reason_note') this.reasonNote,
  });

  factory _$QueueDiscountImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueDiscountImplFromJson(json);

  /// 'percentage' or 'fixed'
  @override
  final String type;

  /// Raw input: 20 (for 20%) or 150 (for 1.5 JOD in piasters)
  @override
  final int value;

  /// Calculated amount deducted (piasters)
  @override
  @JsonKey(name: 'amount_cents')
  final int amount;

  /// Internal reason label (عميل مميز, تعويض, عرض خاص, etc.)
  @override
  final String reason;

  /// Free-text note for "أخرى" reason
  @override
  @JsonKey(name: 'reason_note')
  final String? reasonNote;

  @override
  String toString() {
    return 'QueueDiscount(type: $type, value: $value, amount: $amount, reason: $reason, reasonNote: $reasonNote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueDiscountImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.reasonNote, reasonNote) ||
                other.reasonNote == reasonNote));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, value, amount, reason, reasonNote);

  /// Create a copy of QueueDiscount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueDiscountImplCopyWith<_$QueueDiscountImpl> get copyWith =>
      __$$QueueDiscountImplCopyWithImpl<_$QueueDiscountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueDiscountImplToJson(this);
  }
}

abstract class _QueueDiscount implements QueueDiscount {
  const factory _QueueDiscount({
    required final String type,
    required final int value,
    @JsonKey(name: 'amount_cents') required final int amount,
    required final String reason,
    @JsonKey(name: 'reason_note') final String? reasonNote,
  }) = _$QueueDiscountImpl;

  factory _QueueDiscount.fromJson(Map<String, dynamic> json) =
      _$QueueDiscountImpl.fromJson;

  /// 'percentage' or 'fixed'
  @override
  String get type;

  /// Raw input: 20 (for 20%) or 150 (for 1.5 JOD in piasters)
  @override
  int get value;

  /// Calculated amount deducted (piasters)
  @override
  @JsonKey(name: 'amount_cents')
  int get amount;

  /// Internal reason label (عميل مميز, تعويض, عرض خاص, etc.)
  @override
  String get reason;

  /// Free-text note for "أخرى" reason
  @override
  @JsonKey(name: 'reason_note')
  String? get reasonNote;

  /// Create a copy of QueueDiscount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueDiscountImplCopyWith<_$QueueDiscountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
