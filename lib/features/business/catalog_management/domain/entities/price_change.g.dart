// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_change.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PriceChangeImpl _$$PriceChangeImplFromJson(Map<String, dynamic> json) =>
    _$PriceChangeImpl(
      id: json['id'] as String,
      direction: json['direction'] as String,
      method: json['method'] as String,
      value: (json['value'] as num).toDouble(),
      scope: json['scope'] as String? ?? 'all',
      categoryNames:
          (json['category_names'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      itemIds:
          (json['item_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      startsAt: json['starts_at'] as String,
      endsAt: json['ends_at'] as String?,
      reason: json['reason'] as String? ?? '',
      isPublic: json['is_public'] as bool? ?? true,
      status: json['status'] as String? ?? 'active',
      affectedCount: (json['affected_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PriceChangeImplToJson(_$PriceChangeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'direction': instance.direction,
      'method': instance.method,
      'value': instance.value,
      'scope': instance.scope,
      'category_names': instance.categoryNames,
      'item_ids': instance.itemIds,
      'starts_at': instance.startsAt,
      'ends_at': instance.endsAt,
      'reason': instance.reason,
      'is_public': instance.isPublic,
      'status': instance.status,
      'affected_count': instance.affectedCount,
    };
