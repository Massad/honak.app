import 'package:flutter/material.dart';

import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/features/business/queue/domain/entities/queue_entry.dart';
import 'package:honak/features/business/queue/domain/entities/queue_source.dart';
import 'package:honak/features/business/queue/domain/entities/queue_status.dart';
import 'package:honak/features/business/shared/entities/activity_action_config.dart';

// ═══════════════════════════════════════════════════════════════
// Queue Activity Log Utilities
// Generates mock activity logs from queue entry state.
// ═══════════════════════════════════════════════════════════════

/// Actions that can appear in a queue activity log.
enum QueueActivityAction {
  entryCreated,
  statusChanged,
  photoBefore,
  photoAfter,
  noShow,
  paymentMarked,
  noteAdded,
  onTheWay;

  String get labelAr => switch (this) {
        entryCreated => 'تم إضافة للدور',
        statusChanged => 'تغيير الحالة',
        photoBefore => 'صورة قبل',
        photoAfter => 'صورة بعد',
        noShow => 'لم يحضر',
        paymentMarked => 'تم الدفع',
        noteAdded => 'ملاحظة',
        onTheWay => 'العميل في الطريق',
      };
}

/// A single entry in the queue activity log.
class QueueActivityEntry {
  const QueueActivityEntry({
    required this.id,
    required this.timestamp,
    required this.action,
    required this.actorName,
    this.actorRole,
    this.from,
    this.to,
    this.note,
    this.amount,
    this.method,
  });

  final String id;
  final String timestamp; // ISO 8601
  final QueueActivityAction action;
  final String actorName;
  final String? actorRole;
  final String? from;
  final String? to;
  final String? note;
  final int? amount; // piasters
  final String? method;
}

/// Visual config for each [QueueActivityAction].
const Map<QueueActivityAction, ActivityActionConfig> queueActionConfigs = {
  QueueActivityAction.entryCreated: ActivityActionConfig(
    icon: Icons.inbox_rounded,
    color: Color(0xFF1A73E8),
  ),
  QueueActivityAction.statusChanged: ActivityActionConfig(
    icon: Icons.play_arrow_rounded,
    color: Color(0xFF1A73E8),
  ),
  QueueActivityAction.photoBefore: ActivityActionConfig(
    icon: Icons.camera_alt_outlined,
    color: Color(0xFF1A73E8),
  ),
  QueueActivityAction.photoAfter: ActivityActionConfig(
    icon: Icons.image_rounded,
    color: Color(0xFF43A047),
  ),
  QueueActivityAction.noShow: ActivityActionConfig(
    icon: Icons.block_rounded,
    color: Color(0xFFE53935),
  ),
  QueueActivityAction.paymentMarked: ActivityActionConfig(
    icon: Icons.credit_card_rounded,
    color: Color(0xFF43A047),
  ),
  QueueActivityAction.noteAdded: ActivityActionConfig(
    icon: Icons.sticky_note_2_outlined,
    color: AppColors.textSecondary,
  ),
  QueueActivityAction.onTheWay: ActivityActionConfig(
    icon: Icons.navigation_rounded,
    color: Color(0xFF43A047),
  ),
};

/// Maps a [QueueActivityAction] to a Material icon.
IconData activityActionIcon(QueueActivityAction action) =>
    queueActionConfigs[action]!.icon;

/// Maps a [QueueActivityAction] to a semantic color.
Color activityActionColor(QueueActivityAction action) =>
    queueActionConfigs[action]!.color;

/// Mock staff names with roles for realistic activity log entries.
const _staffPool = [
  ('محمد', 'عامل غسيل'),
  ('عمر', 'عامل تفصيلي'),
  ('خالد', 'مدير'),
  ('أحمد', 'عامل غسيل'),
  ('سعيد', 'استقبال'),
];

/// Pick a deterministic staff member based on entry ID + index offset.
(String name, String role) _pickStaff(String entryId, int offset) {
  final hash = entryId.hashCode.abs();
  return _staffPool[(hash + offset) % _staffPool.length];
}

/// Convert unix epoch seconds to ISO 8601 string.
String _epochToIso(int epochSeconds) {
  return DateTime.fromMillisecondsSinceEpoch(
    epochSeconds * 1000,
  ).toIso8601String();
}

/// Offset an ISO timestamp by [minutes] (negative = earlier).
String _offsetTime(String iso, int minutes) {
  final dt = DateTime.tryParse(iso);
  if (dt == null) return iso;
  return dt.add(Duration(minutes: minutes)).toIso8601String();
}

/// Generates mock activity entries for a queue entry based on its state.
List<QueueActivityEntry> generateQueueActivity(QueueEntry entry) {
  final entries = <QueueActivityEntry>[];
  var idx = 0;

  final checkedInIso = _epochToIso(entry.checkedInAt);
  final startedIso =
      entry.startedAt != null ? _epochToIso(entry.startedAt!) : null;
  final completedIso =
      entry.completedAt != null ? _epochToIso(entry.completedAt!) : null;

  // 1. Entry created
  final creator = _pickStaff(entry.id, 0);
  entries.add(QueueActivityEntry(
    id: '${entry.id}-qlog-${idx++}',
    timestamp: checkedInIso,
    action: QueueActivityAction.entryCreated,
    actorName: entry.source == QueueSource.appReserve
        ? entry.customerName
        : creator.$1,
    actorRole: entry.source == QueueSource.appReserve ? 'عميل' : creator.$2,
    note: '${entry.packageName} — ${entry.customerName}',
  ));

  // 2. On the way (app_reserve customers who progressed past waiting)
  if (entry.source == QueueSource.appReserve &&
      entry.status != QueueStatus.waiting) {
    entries.add(QueueActivityEntry(
      id: '${entry.id}-qlog-${idx++}',
      timestamp: _offsetTime(startedIso ?? checkedInIso, -5),
      action: QueueActivityAction.onTheWay,
      actorName: entry.customerName,
      actorRole: 'عميل',
    ));
  }

  // 3. Photo before
  if (entry.photosBefore.isNotEmpty) {
    final photoPerson = _pickStaff(entry.id, 1);
    entries.add(QueueActivityEntry(
      id: '${entry.id}-qlog-${idx++}',
      timestamp: _offsetTime(startedIso ?? checkedInIso, -2),
      action: QueueActivityAction.photoBefore,
      actorName: photoPerson.$1,
      actorRole: photoPerson.$2,
    ));
  }

  // 4. Status → in_progress
  if (startedIso != null) {
    final starter = _pickStaff(entry.id, 2);
    entries.add(QueueActivityEntry(
      id: '${entry.id}-qlog-${idx++}',
      timestamp: startedIso,
      action: QueueActivityAction.statusChanged,
      actorName: starter.$1,
      actorRole: starter.$2,
      from: QueueStatus.waiting.labelAr,
      to: QueueStatus.inProgress.labelAr,
    ));
  }

  // 5. Note added (only if not completed)
  if (entry.notes != null && entry.status != QueueStatus.completed) {
    final noter = _pickStaff(entry.id, 3);
    entries.add(QueueActivityEntry(
      id: '${entry.id}-qlog-${idx++}',
      timestamp: _offsetTime(startedIso ?? checkedInIso, 10),
      action: QueueActivityAction.noteAdded,
      actorName: noter.$1,
      actorRole: noter.$2,
      note: entry.notes,
    ));
  }

  // 6. Status → ready
  if (completedIso != null &&
      (entry.status == QueueStatus.ready ||
          entry.status == QueueStatus.completed)) {
    final completer = _pickStaff(entry.id, 4);
    entries.add(QueueActivityEntry(
      id: '${entry.id}-qlog-${idx++}',
      timestamp: completedIso,
      action: QueueActivityAction.statusChanged,
      actorName: completer.$1,
      actorRole: completer.$2,
      from: QueueStatus.inProgress.labelAr,
      to: QueueStatus.ready.labelAr,
    ));

    // 7. Photo after
    if (entry.photosAfter.isNotEmpty) {
      entries.add(QueueActivityEntry(
        id: '${entry.id}-qlog-${idx++}',
        timestamp: _offsetTime(completedIso, 1),
        action: QueueActivityAction.photoAfter,
        actorName: completer.$1,
        actorRole: completer.$2,
      ));
    }
  }

  // 8. Status → completed
  if (entry.status == QueueStatus.completed && completedIso != null) {
    final finisher = _pickStaff(entry.id, 0);
    entries.add(QueueActivityEntry(
      id: '${entry.id}-qlog-${idx++}',
      timestamp: completedIso,
      action: QueueActivityAction.statusChanged,
      actorName: finisher.$1,
      actorRole: finisher.$2,
      from: QueueStatus.ready.labelAr,
      to: QueueStatus.completed.labelAr,
    ));

    // 9. Payment marked
    entries.add(QueueActivityEntry(
      id: '${entry.id}-qlog-${idx++}',
      timestamp: completedIso,
      action: QueueActivityAction.paymentMarked,
      actorName: finisher.$1,
      actorRole: finisher.$2,
      amount: entry.totalPrice,
      method: 'كاش',
    ));
  }

  // 10. No show
  if (entry.status == QueueStatus.noShow) {
    final marker = _pickStaff(entry.id, 5);
    entries.add(QueueActivityEntry(
      id: '${entry.id}-qlog-${idx++}',
      timestamp: completedIso ?? _epochToIso(entry.checkedInAt),
      action: QueueActivityAction.noShow,
      actorName: marker.$1,
      actorRole: marker.$2,
    ));
  }

  // Sort newest first
  entries.sort((a, b) => b.timestamp.compareTo(a.timestamp));

  return entries;
}
