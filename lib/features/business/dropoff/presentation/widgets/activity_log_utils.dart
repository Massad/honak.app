import 'package:flutter/material.dart';

import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_status.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_ticket.dart';
import 'package:honak/features/business/dropoff/domain/entities/ticket_activity.dart';
import 'package:honak/features/business/shared/entities/activity_action_config.dart';

/// Visual config for each [TicketActivityAction].
const Map<TicketActivityAction, ActivityActionConfig> dropoffActionConfigs = {
  TicketActivityAction.ticketCreated: ActivityActionConfig(
    icon: Icons.inbox_rounded,
    color: Color(0xFF1A73E8),
  ),
  TicketActivityAction.statusChanged: ActivityActionConfig(
    icon: Icons.autorenew_rounded,
    color: Color(0xFF1A73E8),
  ),
  TicketActivityAction.photoBefore: ActivityActionConfig(
    icon: Icons.camera_alt_outlined,
    color: Color(0xFF1A73E8),
  ),
  TicketActivityAction.photoAfter: ActivityActionConfig(
    icon: Icons.image_rounded,
    color: Color(0xFF43A047),
  ),
  TicketActivityAction.infoRequested: ActivityActionConfig(
    icon: Icons.chat_bubble_outline_rounded,
    color: Color(0xFFFF9800),
  ),
  TicketActivityAction.infoReceived: ActivityActionConfig(
    icon: Icons.chat_rounded,
    color: Color(0xFF43A047),
  ),
  TicketActivityAction.paymentMarked: ActivityActionConfig(
    icon: Icons.credit_card_rounded,
    color: Color(0xFF43A047),
  ),
  TicketActivityAction.noteAdded: ActivityActionConfig(
    icon: Icons.sticky_note_2_outlined,
    color: AppColors.textSecondary,
  ),
  TicketActivityAction.itemModified: ActivityActionConfig(
    icon: Icons.edit_outlined,
    color: Color(0xFFFF9800),
  ),
};

/// Maps a [TicketActivityAction] to a Material icon.
IconData activityActionIcon(TicketActivityAction action) =>
    dropoffActionConfigs[action]!.icon;

/// Maps a [TicketActivityAction] to a semantic color.
Color activityActionColor(TicketActivityAction action) =>
    dropoffActionConfigs[action]!.color;

/// Mock staff names with roles for realistic activity log entries.
const _staffPool = [
  ('محمد', 'استقبال'),
  ('عمر', 'فني'),
  ('خالد', 'مشرف'),
  ('أحمد', 'فني'),
  ('سعيد', 'عامل'),
];

/// Pick a deterministic staff member based on ticket + entry index.
(String name, String role) _pickStaff(String ticketId, int idx) {
  final hash = ticketId.hashCode.abs();
  return _staffPool[(hash + idx) % _staffPool.length];
}

/// Generates mock activity entries for demo purposes based on ticket state.
List<TicketActivityEntry> generateMockActivity(DropoffTicket ticket) {
  final entries = <TicketActivityEntry>[];
  var idx = 0;

  // 1. Created
  final creator = _pickStaff(ticket.id, 0);
  entries.add(TicketActivityEntry(
    id: 'act_${ticket.id}_${idx++}',
    timestamp: ticket.droppedOffAt,
    action: TicketActivityAction.ticketCreated,
    actorName: creator.$1,
    actorRole: creator.$2,
    note: 'تم إنشاء التذكرة ${ticket.ticketNumber}',
  ));

  // 2. Photo before (if any item has it)
  final hasPhotoBefore = ticket.items.any((i) => i.photoBefore != null);
  if (hasPhotoBefore) {
    final photoPerson = _pickStaff(ticket.id, 1);
    entries.add(TicketActivityEntry(
      id: 'act_${ticket.id}_${idx++}',
      timestamp: ticket.droppedOffAt,
      action: TicketActivityAction.photoBefore,
      actorName: photoPerson.$1,
      actorRole: photoPerson.$2,
      items: ticket.items
          .where((i) => i.photoBefore != null)
          .map((i) => i.name)
          .toList(),
    ));
  }

  // 3. Status → processing
  if (ticket.status.index >= DropoffStatus.processing.index &&
      ticket.startedAt != null) {
    final processor = _pickStaff(ticket.id, 2);
    entries.add(TicketActivityEntry(
      id: 'act_${ticket.id}_${idx++}',
      timestamp: ticket.startedAt!,
      action: TicketActivityAction.statusChanged,
      actorName: processor.$1,
      actorRole: processor.$2,
      from: DropoffStatus.received.labelAr,
      to: DropoffStatus.processing.labelAr,
    ));
  }

  // 4. Info requested (processing tickets with notes — matches Figma)
  if (ticket.status == DropoffStatus.processing && ticket.notes != null) {
    final infoRequester = _pickStaff(ticket.id, 3);
    entries.add(TicketActivityEntry(
      id: 'act_${ticket.id}_${idx++}',
      timestamp: ticket.startedAt ?? ticket.droppedOffAt,
      action: TicketActivityAction.infoRequested,
      actorName: infoRequester.$1,
      actorRole: infoRequester.$2,
      items: const ['صورة إضافية', 'تفاصيل المشكلة'],
      note: 'تم إرسال الطلب إلى المحادثة',
    ));
  }

  // 5. Notes
  if (ticket.notes != null) {
    final noter = _pickStaff(ticket.id, 3);
    entries.add(TicketActivityEntry(
      id: 'act_${ticket.id}_${idx++}',
      timestamp: ticket.startedAt ?? ticket.droppedOffAt,
      action: TicketActivityAction.noteAdded,
      actorName: noter.$1,
      actorRole: noter.$2,
      note: ticket.notes,
    ));
  }

  // 5. Status → ready
  if (ticket.status.index >= DropoffStatus.ready.index &&
      ticket.completedAt != null) {
    final completer = _pickStaff(ticket.id, 4);
    entries.add(TicketActivityEntry(
      id: 'act_${ticket.id}_${idx++}',
      timestamp: ticket.completedAt!,
      action: TicketActivityAction.statusChanged,
      actorName: completer.$1,
      actorRole: completer.$2,
      from: DropoffStatus.processing.labelAr,
      to: DropoffStatus.ready.labelAr,
    ));
  }

  // 6. Photo after
  final hasPhotoAfter = ticket.items.any((i) => i.photoAfter != null);
  if (hasPhotoAfter && ticket.completedAt != null) {
    final afterPerson = _pickStaff(ticket.id, 1);
    entries.add(TicketActivityEntry(
      id: 'act_${ticket.id}_${idx++}',
      timestamp: ticket.completedAt!,
      action: TicketActivityAction.photoAfter,
      actorName: afterPerson.$1,
      actorRole: afterPerson.$2,
      items: ticket.items
          .where((i) => i.photoAfter != null)
          .map((i) => i.name)
          .toList(),
    ));
  }

  // 7. Payment
  if (ticket.paid) {
    final payer = _pickStaff(ticket.id, 0);
    entries.add(TicketActivityEntry(
      id: 'act_${ticket.id}_${idx++}',
      timestamp: ticket.completedAt ?? ticket.droppedOffAt,
      action: TicketActivityAction.paymentMarked,
      actorName: payer.$1,
      actorRole: payer.$2,
      amount: ticket.totalPrice,
      method: ticket.paymentMethod ?? 'نقدي',
    ));
  }

  // 8. Status → delivered
  if (ticket.status == DropoffStatus.delivered && ticket.pickedUpAt != null) {
    final deliverer = _pickStaff(ticket.id, 2);
    entries.add(TicketActivityEntry(
      id: 'act_${ticket.id}_${idx++}',
      timestamp: ticket.pickedUpAt!,
      action: TicketActivityAction.statusChanged,
      actorName: deliverer.$1,
      actorRole: deliverer.$2,
      from: DropoffStatus.ready.labelAr,
      to: DropoffStatus.delivered.labelAr,
    ));
  }

  return entries;
}
