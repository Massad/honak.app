import 'package:flutter/material.dart';

import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_status.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_ticket.dart';
import 'package:honak/features/business/dropoff/domain/entities/ticket_activity.dart';

/// Maps a [TicketActivityAction] to a Material icon.
IconData activityActionIcon(TicketActivityAction action) => switch (action) {
      TicketActivityAction.ticketCreated => Icons.receipt_long_rounded,
      TicketActivityAction.statusChanged => Icons.swap_horiz_rounded,
      TicketActivityAction.photoBefore => Icons.camera_alt_outlined,
      TicketActivityAction.photoAfter => Icons.camera_rounded,
      TicketActivityAction.infoRequested => Icons.help_outline_rounded,
      TicketActivityAction.infoReceived => Icons.reply_rounded,
      TicketActivityAction.paymentMarked => Icons.payments_outlined,
      TicketActivityAction.noteAdded => Icons.sticky_note_2_outlined,
      TicketActivityAction.itemModified => Icons.edit_outlined,
    };

/// Maps a [TicketActivityAction] to a semantic color.
Color activityActionColor(TicketActivityAction action) => switch (action) {
      TicketActivityAction.ticketCreated => AppColors.primary,
      TicketActivityAction.statusChanged => AppColors.info,
      TicketActivityAction.photoBefore => AppColors.secondary,
      TicketActivityAction.photoAfter => AppColors.success,
      TicketActivityAction.infoRequested => const Color(0xFF7B1FA2),
      TicketActivityAction.infoReceived => const Color(0xFF7B1FA2),
      TicketActivityAction.paymentMarked => AppColors.success,
      TicketActivityAction.noteAdded => AppColors.secondary,
      TicketActivityAction.itemModified => AppColors.primary,
    };

/// Generates mock activity entries for demo purposes based on ticket state.
List<TicketActivityEntry> generateMockActivity(DropoffTicket ticket) {
  final entries = <TicketActivityEntry>[];
  var idx = 0;

  // 1. Created
  entries.add(TicketActivityEntry(
    id: 'act_${ticket.id}_${idx++}',
    timestamp: ticket.droppedOffAt,
    action: TicketActivityAction.ticketCreated,
    actorName: 'النظام',
    actorRole: 'system',
    note: 'تم إنشاء التذكرة ${ticket.ticketNumber}',
  ));

  // 2. Photo before (if any item has it)
  final hasPhotoBefore = ticket.items.any((i) => i.photoBefore != null);
  if (hasPhotoBefore) {
    entries.add(TicketActivityEntry(
      id: 'act_${ticket.id}_${idx++}',
      timestamp: ticket.droppedOffAt,
      action: TicketActivityAction.photoBefore,
      actorName: 'الموظف',
      actorRole: 'staff',
      items: ticket.items
          .where((i) => i.photoBefore != null)
          .map((i) => i.name)
          .toList(),
    ));
  }

  // 3. Status → processing
  if (ticket.status.index >= DropoffStatus.processing.index &&
      ticket.startedAt != null) {
    entries.add(TicketActivityEntry(
      id: 'act_${ticket.id}_${idx++}',
      timestamp: ticket.startedAt!,
      action: TicketActivityAction.statusChanged,
      actorName: 'الموظف',
      actorRole: 'staff',
      from: DropoffStatus.received.labelAr,
      to: DropoffStatus.processing.labelAr,
    ));
  }

  // 4. Notes
  if (ticket.notes != null) {
    entries.add(TicketActivityEntry(
      id: 'act_${ticket.id}_${idx++}',
      timestamp: ticket.startedAt ?? ticket.droppedOffAt,
      action: TicketActivityAction.noteAdded,
      actorName: 'الموظف',
      actorRole: 'staff',
      note: ticket.notes,
    ));
  }

  // 5. Status → ready
  if (ticket.status.index >= DropoffStatus.ready.index &&
      ticket.completedAt != null) {
    entries.add(TicketActivityEntry(
      id: 'act_${ticket.id}_${idx++}',
      timestamp: ticket.completedAt!,
      action: TicketActivityAction.statusChanged,
      actorName: 'الموظف',
      actorRole: 'staff',
      from: DropoffStatus.processing.labelAr,
      to: DropoffStatus.ready.labelAr,
    ));
  }

  // 6. Photo after
  final hasPhotoAfter = ticket.items.any((i) => i.photoAfter != null);
  if (hasPhotoAfter && ticket.completedAt != null) {
    entries.add(TicketActivityEntry(
      id: 'act_${ticket.id}_${idx++}',
      timestamp: ticket.completedAt!,
      action: TicketActivityAction.photoAfter,
      actorName: 'الموظف',
      actorRole: 'staff',
      items: ticket.items
          .where((i) => i.photoAfter != null)
          .map((i) => i.name)
          .toList(),
    ));
  }

  // 7. Payment
  if (ticket.paid) {
    entries.add(TicketActivityEntry(
      id: 'act_${ticket.id}_${idx++}',
      timestamp: ticket.completedAt ?? ticket.droppedOffAt,
      action: TicketActivityAction.paymentMarked,
      actorName: 'الموظف',
      actorRole: 'staff',
      amount: ticket.totalPrice,
      method: ticket.paymentMethod ?? 'نقدي',
    ));
  }

  // 8. Status → delivered
  if (ticket.status == DropoffStatus.delivered && ticket.pickedUpAt != null) {
    entries.add(TicketActivityEntry(
      id: 'act_${ticket.id}_${idx++}',
      timestamp: ticket.pickedUpAt!,
      action: TicketActivityAction.statusChanged,
      actorName: 'النظام',
      actorRole: 'system',
      from: DropoffStatus.ready.labelAr,
      to: DropoffStatus.delivered.labelAr,
    ));
  }

  return entries;
}
