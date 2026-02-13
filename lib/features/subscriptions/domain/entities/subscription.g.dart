// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionImpl _$$SubscriptionImplFromJson(
  Map<String, dynamic> json,
) => _$SubscriptionImpl(
  id: json['id'] as String,
  pageId: json['page_id'] as String,
  pageName: json['page_name'] as String,
  pageLogo: json['page_logo'] as String?,
  packageId: json['package_id'] as String,
  packageName: json['package_name'] as String,
  model: $enumDecode(_$SubscriptionModelEnumMap, json['model']),
  totalCredits: (json['total_credits'] as num?)?.toInt(),
  remainingCredits: (json['remaining_credits'] as num?)?.toInt(),
  creditLabel: json['credit_label'] as String?,
  startsAt: json['starts_at'] as String,
  expiresAt: json['expires_at'] as String?,
  status: $enumDecode(_$SubscriptionStatusEnumMap, json['status']),
  history:
      (json['history'] as List<dynamic>?)
          ?.map((e) => CreditHistoryEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  itemIds:
      (json['item_ids'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  pausedAt: json['paused_at'] as String?,
  policy: json['policy'] == null
      ? null
      : SubscriptionPolicy.fromJson(json['policy'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$SubscriptionImplToJson(_$SubscriptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'page_id': instance.pageId,
      'page_name': instance.pageName,
      'page_logo': instance.pageLogo,
      'package_id': instance.packageId,
      'package_name': instance.packageName,
      'model': _$SubscriptionModelEnumMap[instance.model]!,
      'total_credits': instance.totalCredits,
      'remaining_credits': instance.remainingCredits,
      'credit_label': instance.creditLabel,
      'starts_at': instance.startsAt,
      'expires_at': instance.expiresAt,
      'status': _$SubscriptionStatusEnumMap[instance.status]!,
      'history': instance.history,
      'item_ids': instance.itemIds,
      'paused_at': instance.pausedAt,
      'policy': instance.policy,
    };

const _$SubscriptionModelEnumMap = {
  SubscriptionModel.visitsAndDate: 'visits_and_date',
  SubscriptionModel.visitsOnly: 'visits_only',
  SubscriptionModel.dateOnly: 'date_only',
  SubscriptionModel.bundle: 'bundle',
};

const _$SubscriptionStatusEnumMap = {
  SubscriptionStatus.active: 'active',
  SubscriptionStatus.paused: 'paused',
  SubscriptionStatus.depleted: 'depleted',
  SubscriptionStatus.expired: 'expired',
  SubscriptionStatus.cancelled: 'cancelled',
};
