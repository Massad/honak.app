// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_discount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueueDiscountImpl _$$QueueDiscountImplFromJson(Map<String, dynamic> json) =>
    _$QueueDiscountImpl(
      type: json['type'] as String,
      value: (json['value'] as num).toInt(),
      amount: (json['amount_cents'] as num).toInt(),
      reason: json['reason'] as String,
      reasonNote: json['reason_note'] as String?,
    );

Map<String, dynamic> _$$QueueDiscountImplToJson(_$QueueDiscountImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
      'amount_cents': instance.amount,
      'reason': instance.reason,
      'reason_note': instance.reasonNote,
    };
