import 'package:flutter/material.dart';

import 'package:honak/features/business/shared/widgets/activity_log.dart';

/// Visual config for a single activity action type.
class ActivityActionConfig {
  const ActivityActionConfig({required this.icon, required this.color});

  final IconData icon;
  final Color color;
}

/// Builds an [ActivityLogEntry] from common fields, reducing boilerplate
/// in both dropoff and queue activity converters.
ActivityLogEntry buildActivityLogEntry({
  required String id,
  required String timestamp,
  required String label,
  required ActivityActionConfig config,
  required String actorName,
  String? actorRole,
  String? from,
  String? to,
  String? note,
  int? amount,
  String? method,
}) {
  return ActivityLogEntry(
    id: id,
    timestamp: timestamp,
    label: label,
    icon: config.icon,
    color: config.color,
    actorName: actorName,
    actorRole: actorRole,
    from: from,
    to: to,
    note: note,
    amount: amount,
    method: method,
  );
}
