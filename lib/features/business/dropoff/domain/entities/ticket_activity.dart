import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:honak/core/l10n/arb/app_localizations.dart';

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

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (this) {
      ticketCreated => l10n.dropoffActionTicketCreated,
      statusChanged => l10n.dropoffActionStatusChanged,
      photoBefore => l10n.dropoffActionPhotoBefore,
      photoAfter => l10n.dropoffActionPhotoAfter,
      infoRequested => l10n.dropoffActionInfoRequested,
      infoReceived => l10n.dropoffActionInfoReceived,
      paymentMarked => l10n.dropoffActionPaymentMarked,
      noteAdded => l10n.dropoffActionNoteAdded,
      itemModified => l10n.dropoffActionItemModified,
    };
  }
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
