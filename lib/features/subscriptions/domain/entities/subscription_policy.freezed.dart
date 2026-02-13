// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_policy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SubscriptionPolicy _$SubscriptionPolicyFromJson(Map<String, dynamic> json) {
  return _SubscriptionPolicy.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionPolicy {
  @JsonKey(name: 'can_pause')
  bool get canPause => throw _privateConstructorUsedError;
  @JsonKey(name: 'pause_limit_days')
  int get pauseLimitDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_cancel')
  bool get canCancel => throw _privateConstructorUsedError;
  @JsonKey(name: 'cancellation_notice_days')
  int get cancellationNoticeDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'cancellation_fee')
  int get cancellationFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'policy_text_ar')
  String? get policyTextAr => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionPolicy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionPolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionPolicyCopyWith<SubscriptionPolicy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionPolicyCopyWith<$Res> {
  factory $SubscriptionPolicyCopyWith(
    SubscriptionPolicy value,
    $Res Function(SubscriptionPolicy) then,
  ) = _$SubscriptionPolicyCopyWithImpl<$Res, SubscriptionPolicy>;
  @useResult
  $Res call({
    @JsonKey(name: 'can_pause') bool canPause,
    @JsonKey(name: 'pause_limit_days') int pauseLimitDays,
    @JsonKey(name: 'can_cancel') bool canCancel,
    @JsonKey(name: 'cancellation_notice_days') int cancellationNoticeDays,
    @JsonKey(name: 'cancellation_fee') int cancellationFee,
    @JsonKey(name: 'policy_text_ar') String? policyTextAr,
  });
}

/// @nodoc
class _$SubscriptionPolicyCopyWithImpl<$Res, $Val extends SubscriptionPolicy>
    implements $SubscriptionPolicyCopyWith<$Res> {
  _$SubscriptionPolicyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionPolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canPause = null,
    Object? pauseLimitDays = null,
    Object? canCancel = null,
    Object? cancellationNoticeDays = null,
    Object? cancellationFee = null,
    Object? policyTextAr = freezed,
  }) {
    return _then(
      _value.copyWith(
            canPause: null == canPause
                ? _value.canPause
                : canPause // ignore: cast_nullable_to_non_nullable
                      as bool,
            pauseLimitDays: null == pauseLimitDays
                ? _value.pauseLimitDays
                : pauseLimitDays // ignore: cast_nullable_to_non_nullable
                      as int,
            canCancel: null == canCancel
                ? _value.canCancel
                : canCancel // ignore: cast_nullable_to_non_nullable
                      as bool,
            cancellationNoticeDays: null == cancellationNoticeDays
                ? _value.cancellationNoticeDays
                : cancellationNoticeDays // ignore: cast_nullable_to_non_nullable
                      as int,
            cancellationFee: null == cancellationFee
                ? _value.cancellationFee
                : cancellationFee // ignore: cast_nullable_to_non_nullable
                      as int,
            policyTextAr: freezed == policyTextAr
                ? _value.policyTextAr
                : policyTextAr // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubscriptionPolicyImplCopyWith<$Res>
    implements $SubscriptionPolicyCopyWith<$Res> {
  factory _$$SubscriptionPolicyImplCopyWith(
    _$SubscriptionPolicyImpl value,
    $Res Function(_$SubscriptionPolicyImpl) then,
  ) = __$$SubscriptionPolicyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'can_pause') bool canPause,
    @JsonKey(name: 'pause_limit_days') int pauseLimitDays,
    @JsonKey(name: 'can_cancel') bool canCancel,
    @JsonKey(name: 'cancellation_notice_days') int cancellationNoticeDays,
    @JsonKey(name: 'cancellation_fee') int cancellationFee,
    @JsonKey(name: 'policy_text_ar') String? policyTextAr,
  });
}

/// @nodoc
class __$$SubscriptionPolicyImplCopyWithImpl<$Res>
    extends _$SubscriptionPolicyCopyWithImpl<$Res, _$SubscriptionPolicyImpl>
    implements _$$SubscriptionPolicyImplCopyWith<$Res> {
  __$$SubscriptionPolicyImplCopyWithImpl(
    _$SubscriptionPolicyImpl _value,
    $Res Function(_$SubscriptionPolicyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionPolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canPause = null,
    Object? pauseLimitDays = null,
    Object? canCancel = null,
    Object? cancellationNoticeDays = null,
    Object? cancellationFee = null,
    Object? policyTextAr = freezed,
  }) {
    return _then(
      _$SubscriptionPolicyImpl(
        canPause: null == canPause
            ? _value.canPause
            : canPause // ignore: cast_nullable_to_non_nullable
                  as bool,
        pauseLimitDays: null == pauseLimitDays
            ? _value.pauseLimitDays
            : pauseLimitDays // ignore: cast_nullable_to_non_nullable
                  as int,
        canCancel: null == canCancel
            ? _value.canCancel
            : canCancel // ignore: cast_nullable_to_non_nullable
                  as bool,
        cancellationNoticeDays: null == cancellationNoticeDays
            ? _value.cancellationNoticeDays
            : cancellationNoticeDays // ignore: cast_nullable_to_non_nullable
                  as int,
        cancellationFee: null == cancellationFee
            ? _value.cancellationFee
            : cancellationFee // ignore: cast_nullable_to_non_nullable
                  as int,
        policyTextAr: freezed == policyTextAr
            ? _value.policyTextAr
            : policyTextAr // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionPolicyImpl implements _SubscriptionPolicy {
  const _$SubscriptionPolicyImpl({
    @JsonKey(name: 'can_pause') this.canPause = false,
    @JsonKey(name: 'pause_limit_days') this.pauseLimitDays = 0,
    @JsonKey(name: 'can_cancel') this.canCancel = false,
    @JsonKey(name: 'cancellation_notice_days') this.cancellationNoticeDays = 0,
    @JsonKey(name: 'cancellation_fee') this.cancellationFee = 0,
    @JsonKey(name: 'policy_text_ar') this.policyTextAr,
  });

  factory _$SubscriptionPolicyImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionPolicyImplFromJson(json);

  @override
  @JsonKey(name: 'can_pause')
  final bool canPause;
  @override
  @JsonKey(name: 'pause_limit_days')
  final int pauseLimitDays;
  @override
  @JsonKey(name: 'can_cancel')
  final bool canCancel;
  @override
  @JsonKey(name: 'cancellation_notice_days')
  final int cancellationNoticeDays;
  @override
  @JsonKey(name: 'cancellation_fee')
  final int cancellationFee;
  @override
  @JsonKey(name: 'policy_text_ar')
  final String? policyTextAr;

  @override
  String toString() {
    return 'SubscriptionPolicy(canPause: $canPause, pauseLimitDays: $pauseLimitDays, canCancel: $canCancel, cancellationNoticeDays: $cancellationNoticeDays, cancellationFee: $cancellationFee, policyTextAr: $policyTextAr)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionPolicyImpl &&
            (identical(other.canPause, canPause) ||
                other.canPause == canPause) &&
            (identical(other.pauseLimitDays, pauseLimitDays) ||
                other.pauseLimitDays == pauseLimitDays) &&
            (identical(other.canCancel, canCancel) ||
                other.canCancel == canCancel) &&
            (identical(other.cancellationNoticeDays, cancellationNoticeDays) ||
                other.cancellationNoticeDays == cancellationNoticeDays) &&
            (identical(other.cancellationFee, cancellationFee) ||
                other.cancellationFee == cancellationFee) &&
            (identical(other.policyTextAr, policyTextAr) ||
                other.policyTextAr == policyTextAr));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    canPause,
    pauseLimitDays,
    canCancel,
    cancellationNoticeDays,
    cancellationFee,
    policyTextAr,
  );

  /// Create a copy of SubscriptionPolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionPolicyImplCopyWith<_$SubscriptionPolicyImpl> get copyWith =>
      __$$SubscriptionPolicyImplCopyWithImpl<_$SubscriptionPolicyImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionPolicyImplToJson(this);
  }
}

abstract class _SubscriptionPolicy implements SubscriptionPolicy {
  const factory _SubscriptionPolicy({
    @JsonKey(name: 'can_pause') final bool canPause,
    @JsonKey(name: 'pause_limit_days') final int pauseLimitDays,
    @JsonKey(name: 'can_cancel') final bool canCancel,
    @JsonKey(name: 'cancellation_notice_days') final int cancellationNoticeDays,
    @JsonKey(name: 'cancellation_fee') final int cancellationFee,
    @JsonKey(name: 'policy_text_ar') final String? policyTextAr,
  }) = _$SubscriptionPolicyImpl;

  factory _SubscriptionPolicy.fromJson(Map<String, dynamic> json) =
      _$SubscriptionPolicyImpl.fromJson;

  @override
  @JsonKey(name: 'can_pause')
  bool get canPause;
  @override
  @JsonKey(name: 'pause_limit_days')
  int get pauseLimitDays;
  @override
  @JsonKey(name: 'can_cancel')
  bool get canCancel;
  @override
  @JsonKey(name: 'cancellation_notice_days')
  int get cancellationNoticeDays;
  @override
  @JsonKey(name: 'cancellation_fee')
  int get cancellationFee;
  @override
  @JsonKey(name: 'policy_text_ar')
  String? get policyTextAr;

  /// Create a copy of SubscriptionPolicy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionPolicyImplCopyWith<_$SubscriptionPolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
