import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_policy.freezed.dart';
part 'subscription_policy.g.dart';

@freezed
class SubscriptionPolicy with _$SubscriptionPolicy {
  const factory SubscriptionPolicy({
    @JsonKey(name: 'can_pause') @Default(false) bool canPause,
    @JsonKey(name: 'pause_limit_days') @Default(0) int pauseLimitDays,
    @JsonKey(name: 'can_cancel') @Default(false) bool canCancel,
    @JsonKey(name: 'cancellation_notice_days') @Default(0) int cancellationNoticeDays,
    @JsonKey(name: 'cancellation_fee') @Default(0) int cancellationFee,
    @JsonKey(name: 'policy_text_ar') String? policyTextAr,
  }) = _SubscriptionPolicy;

  factory SubscriptionPolicy.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPolicyFromJson(json);
}
