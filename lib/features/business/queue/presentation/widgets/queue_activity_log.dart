import 'package:flutter/material.dart';

import 'package:honak/features/business/queue/domain/entities/queue_entry.dart';
import 'package:honak/features/business/queue/presentation/widgets/queue_activity_utils.dart';
import 'package:honak/features/business/shared/widgets/activity_log.dart';

// ═══════════════════════════════════════════════════════════════
// Queue Activity Log — thin wrappers over shared components
// ═══════════════════════════════════════════════════════════════

/// Converts a domain-specific [QueueActivityEntry] to the shared
/// [ActivityLogEntry] UI model.
ActivityLogEntry toQueueActivityLogEntry(QueueActivityEntry e) {
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

/// Shows a full-screen activity log bottom sheet for a queue entry.
void showQueueActivityLogSheet(
  BuildContext context, {
  required QueueEntry entry,
  required List<QueueActivityEntry> activityLog,
}) {
  showActivityLogSheet(
    context,
    title: 'سجل النشاط',
    subtitle: '${entry.customerName} — ${entry.packageName}',
    entries: activityLog.map(toQueueActivityLogEntry).toList(),
  );
}

/// Compact preview widget for queue activity log. Shows last N
/// entries with a "عرض السجل الكامل" link.
class QueueActivityPreview extends StatelessWidget {
  const QueueActivityPreview({
    super.key,
    required this.entries,
    this.maxEntries = 3,
    required this.onViewFull,
  });

  final List<QueueActivityEntry> entries;
  final int maxEntries;
  final VoidCallback onViewFull;

  @override
  Widget build(BuildContext context) {
    return ActivityLogPreview(
      entries: entries.map(toQueueActivityLogEntry).toList(),
      maxEntries: maxEntries,
      onViewFull: onViewFull,
    );
  }
}
