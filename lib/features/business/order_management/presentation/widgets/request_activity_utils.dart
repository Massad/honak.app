import 'package:flutter/material.dart';

import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/features/business/shared/domain/entities/biz_request.dart';
import 'package:honak/features/business/shared/entities/activity_action_config.dart';
import 'package:honak/features/business/shared/widgets/activity_log.dart';

// ═══════════════════════════════════════════════════════════════
// Request Activity — Actions + Mock Generation
//
// Converts BizRequest state into ActivityLogEntry list for the
// shared activity log timeline.
// ═══════════════════════════════════════════════════════════════

/// All possible activity actions for a business request.
enum RequestActivityAction {
  requestCreated,
  statusChanged,
  noteAdded,
  declineReasonAdded,
  paymentMarked,
  modificationRequested,
  alternativeOffered,
  receiptSent,
}

/// Visual config for each [RequestActivityAction].
const Map<RequestActivityAction, ActivityActionConfig> requestActionConfigs = {
  RequestActivityAction.requestCreated: ActivityActionConfig(
    icon: Icons.inbox_rounded,
    color: Color(0xFF1A73E8),
  ),
  RequestActivityAction.statusChanged: ActivityActionConfig(
    icon: Icons.autorenew_rounded,
    color: Color(0xFF1A73E8),
  ),
  RequestActivityAction.noteAdded: ActivityActionConfig(
    icon: Icons.sticky_note_2_outlined,
    color: AppColors.textSecondary,
  ),
  RequestActivityAction.declineReasonAdded: ActivityActionConfig(
    icon: Icons.cancel_outlined,
    color: Color(0xFFE53935),
  ),
  RequestActivityAction.paymentMarked: ActivityActionConfig(
    icon: Icons.credit_card_rounded,
    color: Color(0xFF43A047),
  ),
  RequestActivityAction.modificationRequested: ActivityActionConfig(
    icon: Icons.edit_outlined,
    color: Color(0xFFFF9800),
  ),
  RequestActivityAction.alternativeOffered: ActivityActionConfig(
    icon: Icons.swap_horiz_rounded,
    color: Color(0xFF1A73E8),
  ),
  RequestActivityAction.receiptSent: ActivityActionConfig(
    icon: Icons.receipt_long_rounded,
    color: AppColors.textSecondary,
  ),
};

/// Status-specific icon + color overrides for status transitions.
ActivityActionConfig _statusConfig(String status) {
  return switch (status) {
    'pending' => const ActivityActionConfig(
        icon: Icons.access_time_rounded,
        color: Color(0xFFFF9800),
      ),
    'accepted' => const ActivityActionConfig(
        icon: Icons.check_circle_outline_rounded,
        color: Color(0xFF43A047),
      ),
    'in_progress' => const ActivityActionConfig(
        icon: Icons.local_shipping_outlined,
        color: Color(0xFF1A73E8),
      ),
    'preparing' => const ActivityActionConfig(
        icon: Icons.inventory_2_outlined,
        color: Color(0xFF1A73E8),
      ),
    'ready' => const ActivityActionConfig(
        icon: Icons.inventory_2_outlined,
        color: Color(0xFF1A73E8),
      ),
    'delivered' => const ActivityActionConfig(
        icon: Icons.local_shipping_outlined,
        color: Color(0xFF43A047),
      ),
    'completed' => const ActivityActionConfig(
        icon: Icons.check_circle_outline_rounded,
        color: AppColors.textSecondary,
      ),
    'declined' => const ActivityActionConfig(
        icon: Icons.cancel_outlined,
        color: Color(0xFFE53935),
      ),
    _ => requestActionConfigs[RequestActivityAction.statusChanged]!,
  };
}

/// Arabic labels for request statuses (used in activity log entries).
String _statusLabelAr(String status) {
  return switch (status) {
    'pending' => 'معلق',
    'accepted' => 'مقبول',
    'in_progress' => 'قيد التنفيذ',
    'preparing' => 'قيد التحضير',
    'ready' => 'جاهز',
    'delivered' => 'تم التسليم',
    'completed' => 'مكتمل',
    'declined' => 'مرفوض',
    _ => status,
  };
}

/// Mock staff names with roles for realistic activity entries.
const _staffPool = [
  ('محمد', 'مدير'),
  ('أحمد', 'موظف'),
  ('فاطمة', 'موظفة'),
  ('خالد', 'مشرف'),
  ('سارة', 'موظفة'),
];

/// Pick a deterministic staff member based on request ID + entry index.
(String name, String role) _pickStaff(String requestId, int idx) {
  final hash = requestId.hashCode.abs();
  return _staffPool[(hash + idx) % _staffPool.length];
}

/// Ordered status chain for computing intermediate transitions.
const _statusChain = [
  'pending',
  'accepted',
  'in_progress',
  'preparing',
  'ready',
  'delivered',
  'completed',
];

/// Generates deterministic mock activity entries from a [BizRequest].
///
/// Uses the request's current state (status, note, declineReason, etc.)
/// to build a realistic timeline. Follows the same pattern as
/// [generateMockActivity] in dropoff.
List<ActivityLogEntry> generateRequestActivity(BizRequest request) {
  final entries = <ActivityLogEntry>[];
  var idx = 0;

  final createdDt =
      DateTime.fromMillisecondsSinceEpoch(request.createdAt * 1000);

  // 1. Request created
  entries.add(buildActivityLogEntry(
    id: 'ract_${request.id}_${idx++}',
    timestamp: createdDt.toIso8601String(),
    label: 'تم إرسال الطلب',
    config: requestActionConfigs[RequestActivityAction.requestCreated]!,
    actorName: request.customer.name,
    actorRole: 'عميل',
  ));

  // 2. Status chain — add transitions up to current status
  if (request.status == 'declined') {
    // Declined path: pending → declined
    final staff = _pickStaff(request.id, idx);
    final declinedAt = createdDt.add(Duration(minutes: 15 + idx * 7));
    entries.add(buildActivityLogEntry(
      id: 'ract_${request.id}_${idx++}',
      timestamp: declinedAt.toIso8601String(),
      label: 'تم تغيير الحالة',
      config: _statusConfig('declined'),
      actorName: staff.$1,
      actorRole: staff.$2,
      from: _statusLabelAr('pending'),
      to: _statusLabelAr('declined'),
    ));

    // Decline reason
    if (request.declineReason != null) {
      final noter = _pickStaff(request.id, idx);
      entries.add(buildActivityLogEntry(
        id: 'ract_${request.id}_${idx++}',
        timestamp: declinedAt.add(const Duration(seconds: 30)).toIso8601String(),
        label: 'تم إضافة سبب الرفض',
        config: requestActionConfigs[RequestActivityAction.declineReasonAdded]!,
        actorName: noter.$1,
        actorRole: noter.$2,
        note: request.declineReason,
      ));
    }
  } else {
    // Normal progression chain
    final currentIdx = _statusChain.indexOf(request.status);
    if (currentIdx > 0) {
      for (var i = 0; i < currentIdx; i++) {
        final staff = _pickStaff(request.id, idx);
        final transitionAt = createdDt.add(Duration(minutes: 15 + i * 20));
        entries.add(buildActivityLogEntry(
          id: 'ract_${request.id}_${idx++}',
          timestamp: transitionAt.toIso8601String(),
          label: 'تم تغيير الحالة',
          config: _statusConfig(_statusChain[i + 1]),
          actorName: staff.$1,
          actorRole: staff.$2,
          from: _statusLabelAr(_statusChain[i]),
          to: _statusLabelAr(_statusChain[i + 1]),
        ));
      }
    }
  }

  // 3. Note (if present)
  if (request.note != null && request.note!.isNotEmpty) {
    entries.add(buildActivityLogEntry(
      id: 'ract_${request.id}_${idx++}',
      timestamp: createdDt.add(const Duration(minutes: 2)).toIso8601String(),
      label: 'ملاحظة من العميل',
      config: requestActionConfigs[RequestActivityAction.noteAdded]!,
      actorName: request.customer.name,
      actorRole: 'عميل',
      note: request.note,
    ));
  }

  // 4. Payment (for completed/delivered)
  if ((request.status == 'completed' || request.status == 'delivered') &&
      request.total != null) {
    final payer = _pickStaff(request.id, idx);
    entries.add(buildActivityLogEntry(
      id: 'ract_${request.id}_${idx++}',
      timestamp: createdDt.add(Duration(minutes: 60 + idx * 5)).toIso8601String(),
      label: 'تم تسجيل الدفع',
      config: requestActionConfigs[RequestActivityAction.paymentMarked]!,
      actorName: payer.$1,
      actorRole: payer.$2,
      amount: request.total!.cents,
      method: 'نقدي',
    ));
  }

  return entries;
}
