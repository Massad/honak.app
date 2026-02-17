import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_status.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_ticket.dart';
import 'package:honak/features/business/dropoff/domain/entities/ticket_activity.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/activity_log_utils.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/dropoff_status_config.dart';
import 'package:honak/features/business/shared/widgets/activity_log.dart';
import 'package:honak/features/business/shared/widgets/generic_status_picker_sheet.dart';

/// Shows a full-screen activity log bottom sheet for a ticket.
void showDropoffActivityLogSheet(
  BuildContext context, {
  required DropoffTicket ticket,
  required List<TicketActivityEntry> activityLog,
}) {
  showActivityLogSheet(
    context,
    title: context.l10n.dropoffActivityLog,
    subtitle: '#${ticket.ticketNumber} — ${ticket.customerName}',
    entries: activityLog.map((e) => toActivityLogEntry(context, e)).toList(),
  );
}

/// Converts a domain-specific [TicketActivityEntry] to the shared
/// [ActivityLogEntry] UI model.
ActivityLogEntry toActivityLogEntry(BuildContext context, TicketActivityEntry e) {
  return ActivityLogEntry(
    id: e.id,
    timestamp: e.timestamp,
    label: e.action.label(context),
    icon: activityActionIcon(e.action),
    color: activityActionColor(e.action),
    actorName: e.actorName,
    actorRole: e.actorRole,
    from: e.from,
    to: e.to,
    note: e.note,
    amount: e.amount,
    method: e.method,
  );
}

/// Bottom sheet allowing the business owner to change ticket status.
///
/// Shows current status highlighted, forward moves as normal options,
/// backward moves tagged with orange "تراجع" pill.
/// Optionally shows a mini activity log preview at the bottom.
Future<DropoffStatus?> showDropoffStatusPicker(
  BuildContext context, {
  required DropoffTicket ticket,
  List<TicketActivityEntry> activityLog = const [],
  VoidCallback? onViewFullLog,
}) {
  final currentConfig = DropoffStatusConfig.ofLocalized(ticket.status, context);
  final currentIdx =
      DropoffStatusConfig.allStatuses.indexOf(ticket.status);

  final options = DropoffStatusConfig.allStatuses
      .where((s) => s != ticket.status)
      .map((status) {
    final conf = DropoffStatusConfig.ofLocalized(status, context);
    final statusIdx = DropoffStatusConfig.allStatuses.indexOf(status);
    return StatusOption<DropoffStatus>(
      status: status,
      config: conf,
      isBackward: statusIdx < currentIdx,
    );
  }).toList();

  Widget? preview;
  if (activityLog.isNotEmpty) {
    preview = ActivityLogPreview(
      entries: activityLog.map((e) => toActivityLogEntry(context, e)).toList(),
      onViewFull: () {
        Navigator.pop(context); // close picker first
        onViewFullLog?.call();
      },
    );
  }

  return showGenericStatusPicker<DropoffStatus>(
    context,
    title: context.l10n.dropoffChangeTicketStatus,
    subtitle: '#${ticket.ticketNumber} — ${ticket.customerName}',
    currentConfig: currentConfig,
    availableStatuses: options,
    activityLogPreview: preview,
  );
}
