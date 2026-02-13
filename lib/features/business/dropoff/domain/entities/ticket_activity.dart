import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_activity.freezed.dart';
part 'ticket_activity.g.dart';

enum TicketActivityAction {
  ticketCreated,
  statusChanged,
  photoBefore,
  photoAfter,
  infoRequested,
  infoReceived,
  paymentMarked,
  noteAdded,
  itemModified;

  String get labelAr => switch (this) {
        ticketCreated => 'تم إنشاء التذكرة',
        statusChanged => 'تغيير الحالة',
        photoBefore => 'صورة قبل',
        photoAfter => 'صورة بعد',
        infoRequested => 'طلب معلومات',
        infoReceived => 'رد العميل',
        paymentMarked => 'تم الدفع',
        noteAdded => 'ملاحظة',
        itemModified => 'تعديل القطع',
      };
}

@freezed
class TicketActivityEntry with _$TicketActivityEntry {
  const factory TicketActivityEntry({
    required String id,
    required String timestamp,
    required TicketActivityAction action,
    @JsonKey(name: 'actor_name') required String actorName,
    @JsonKey(name: 'actor_role') String? actorRole,
    String? from,
    String? to,
    List<String>? items,
    String? note,
    int? amount,
    String? method,
    String? changes,
  }) = _TicketActivityEntry;

  factory TicketActivityEntry.fromJson(Map<String, dynamic> json) =>
      _$TicketActivityEntryFromJson(json);
}
