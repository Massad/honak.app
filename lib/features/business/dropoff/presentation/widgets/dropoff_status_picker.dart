import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_status.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_ticket.dart';
import 'package:honak/features/business/dropoff/domain/entities/ticket_activity.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/activity_log_utils.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/dropoff_status_config.dart';
import 'package:honak/features/business/shared/widgets/activity_log.dart';

/// Shows a full-screen activity log bottom sheet for a ticket.
void showDropoffActivityLogSheet(
  BuildContext context, {
  required DropoffTicket ticket,
  required List<TicketActivityEntry> activityLog,
}) {
  showActivityLogSheet(
    context,
    title: 'سجل النشاط',
    subtitle: '#${ticket.ticketNumber} — ${ticket.customerName}',
    entries: activityLog.map((e) => toActivityLogEntry(e)).toList(),
  );
}

/// Converts a domain-specific [TicketActivityEntry] to the shared
/// [ActivityLogEntry] UI model.
ActivityLogEntry toActivityLogEntry(TicketActivityEntry e) {
  return ActivityLogEntry(
    id: e.id,
    timestamp: e.timestamp,
    label: e.action.labelAr,
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
  return showModalBottomSheet<DropoffStatus>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _StatusPickerSheet(
      ticket: ticket,
      activityLog: activityLog,
      onViewFullLog: onViewFullLog,
    ),
  );
}

class _StatusPickerSheet extends StatelessWidget {
  const _StatusPickerSheet({
    required this.ticket,
    required this.activityLog,
    this.onViewFullLog,
  });

  final DropoffTicket ticket;
  final List<TicketActivityEntry> activityLog;
  final VoidCallback? onViewFullLog;

  @override
  Widget build(BuildContext context) {
    final statusConf = DropoffStatusConfig.of(ticket.status);
    final currentIdx =
        DropoffStatusConfig.allStatuses.indexOf(ticket.status);

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xxl),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: AppSpacing.sm),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'تغيير حالة التذكرة',
                          style: context.textTheme.titleSmall?.copyWith(
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '#${ticket.ticketNumber} — ${ticket.customerName}',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerLow,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Divider(height: 1, color: Theme.of(context).colorScheme.outlineVariant),

            // Current status highlight
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الحالة الحالية',
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: statusConf.bgColor,
                      borderRadius: AppRadius.cardInner,
                      border: Border.all(
                        color: statusConf.borderColor,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          statusConf.icon,
                          size: 16,
                          color: statusConf.color,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          statusConf.label,
                          style: TextStyle(
                            fontSize: 12,
                            color: statusConf.color,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'الحالية',
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Available statuses
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'نقل إلى',
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ...DropoffStatusConfig.allStatuses
                      .where((s) => s != ticket.status)
                      .map((status) {
                    final conf = DropoffStatusConfig.of(status);
                    final statusIdx =
                        DropoffStatusConfig.allStatuses.indexOf(status);
                    final isBackward = statusIdx < currentIdx;

                    return Padding(
                      padding: const EdgeInsetsDirectional.only(bottom: 6),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context, status),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isBackward
                                ? const Color(0xFFFFF8E1).withValues(
                                    alpha: 0.5,
                                  )
                                : context.colorScheme.surface,
                            borderRadius: AppRadius.cardInner,
                            border: Border.all(
                              color: isBackward
                                  ? const Color(0xFFFFE082)
                                  : Theme.of(context).colorScheme.surfaceContainerLow,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                conf.icon,
                                size: 16,
                                color: conf.color,
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Text(
                                  conf.label,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: conf.color,
                                  ),
                                ),
                              ),
                              if (isBackward)
                                Container(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF3E0),
                                    borderRadius: AppRadius.pill,
                                  ),
                                  child: const Text(
                                    'تراجع',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Color(0xFFFF9800),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Activity log preview — reuses shared widget
            if (activityLog.isNotEmpty) ...[
              Divider(height: 1, color: Theme.of(context).colorScheme.outlineVariant),
              Padding(
                padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
                child: ActivityLogPreview(
                  entries: activityLog
                      .map((e) => toActivityLogEntry(e))
                      .toList(),
                  onViewFull: () {
                    Navigator.pop(context); // close picker first
                    onViewFullLog?.call();
                  },
                ),
              ),
            ],

            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}
