// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_history_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreditHistoryEntryImpl _$$CreditHistoryEntryImplFromJson(
  Map<String, dynamic> json,
) => _$CreditHistoryEntryImpl(
  date: json['date'] as String,
  type: $enumDecode(_$CreditHistoryTypeEnumMap, json['type']),
  amount: (json['amount'] as num?)?.toInt() ?? 0,
  note: json['note'] as String?,
);

Map<String, dynamic> _$$CreditHistoryEntryImplToJson(
  _$CreditHistoryEntryImpl instance,
) => <String, dynamic>{
  'date': instance.date,
  'type': _$CreditHistoryTypeEnumMap[instance.type]!,
  'amount': instance.amount,
  'note': instance.note,
};

const _$CreditHistoryTypeEnumMap = {
  CreditHistoryType.purchase: 'purchase',
  CreditHistoryType.autoDeduct: 'auto_deduct',
  CreditHistoryType.adjustment: 'adjustment',
  CreditHistoryType.expired: 'expired',
  CreditHistoryType.pause: 'pause',
  CreditHistoryType.resume: 'resume',
  CreditHistoryType.cancel: 'cancel',
};
