// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_policy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionPolicyImpl _$$SubscriptionPolicyImplFromJson(
  Map<String, dynamic> json,
) => _$SubscriptionPolicyImpl(
  canPause: json['can_pause'] as bool? ?? false,
  pauseLimitDays: (json['pause_limit_days'] as num?)?.toInt() ?? 0,
  canCancel: json['can_cancel'] as bool? ?? false,
  cancellationNoticeDays:
      (json['cancellation_notice_days'] as num?)?.toInt() ?? 0,
  cancellationFee: (json['cancellation_fee'] as num?)?.toInt() ?? 0,
  policyTextAr: json['policy_text_ar'] as String?,
);

Map<String, dynamic> _$$SubscriptionPolicyImplToJson(
  _$SubscriptionPolicyImpl instance,
) => <String, dynamic>{
  'can_pause': instance.canPause,
  'pause_limit_days': instance.pauseLimitDays,
  'can_cancel': instance.canCancel,
  'cancellation_notice_days': instance.cancellationNoticeDays,
  'cancellation_fee': instance.cancellationFee,
  'policy_text_ar': instance.policyTextAr,
};
