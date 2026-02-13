// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TicketActivityEntryImpl _$$TicketActivityEntryImplFromJson(
  Map<String, dynamic> json,
) => _$TicketActivityEntryImpl(
  id: json['id'] as String,
  timestamp: json['timestamp'] as String,
  action: $enumDecode(_$TicketActivityActionEnumMap, json['action']),
  actorName: json['actor_name'] as String,
  actorRole: json['actor_role'] as String?,
  from: json['from'] as String?,
  to: json['to'] as String?,
  items: (json['items'] as List<dynamic>?)?.map((e) => e as String).toList(),
  note: json['note'] as String?,
  amount: (json['amount'] as num?)?.toInt(),
  method: json['method'] as String?,
  changes: json['changes'] as String?,
);

Map<String, dynamic> _$$TicketActivityEntryImplToJson(
  _$TicketActivityEntryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'timestamp': instance.timestamp,
  'action': _$TicketActivityActionEnumMap[instance.action]!,
  'actor_name': instance.actorName,
  'actor_role': instance.actorRole,
  'from': instance.from,
  'to': instance.to,
  'items': instance.items,
  'note': instance.note,
  'amount': instance.amount,
  'method': instance.method,
  'changes': instance.changes,
};

const _$TicketActivityActionEnumMap = {
  TicketActivityAction.ticketCreated: 'ticketCreated',
  TicketActivityAction.statusChanged: 'statusChanged',
  TicketActivityAction.photoBefore: 'photoBefore',
  TicketActivityAction.photoAfter: 'photoAfter',
  TicketActivityAction.infoRequested: 'infoRequested',
  TicketActivityAction.infoReceived: 'infoReceived',
  TicketActivityAction.paymentMarked: 'paymentMarked',
  TicketActivityAction.noteAdded: 'noteAdded',
  TicketActivityAction.itemModified: 'itemModified',
};
