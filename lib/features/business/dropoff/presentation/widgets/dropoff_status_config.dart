import 'package:flutter/material.dart';

import 'package:honak/features/business/dropoff/domain/entities/dropoff_status.dart';

/// Centralized visual configuration for each [DropoffStatus].
///
/// Provides consistent colors, icons, and labels across all dropoff widgets
/// (entry card, board, detail view, status picker, customer view).
class DropoffStatusConfig {
  const DropoffStatusConfig._({
    required this.color,
    required this.bgColor,
    required this.borderColor,
    required this.icon,
    required this.label,
  });

  final Color color;
  final Color bgColor;
  final Color borderColor;
  final IconData icon;
  final String label;

  /// Status config map keyed by [DropoffStatus].
  static const Map<DropoffStatus, DropoffStatusConfig> _configs = {
    DropoffStatus.received: DropoffStatusConfig._(
      color: Color(0xFF1A73E8),
      bgColor: Color(0xFFEFF6FF),
      borderColor: Color(0xFF1A73E8),
      icon: Icons.inbox_rounded,
      label: 'تم الاستلام',
    ),
    DropoffStatus.processing: DropoffStatusConfig._(
      color: Color(0xFFFF9800),
      bgColor: Color(0xFFFFF8E1),
      borderColor: Color(0xFFFF9800),
      icon: Icons.autorenew_rounded,
      label: 'قيد المعالجة',
    ),
    DropoffStatus.ready: DropoffStatusConfig._(
      color: Color(0xFF43A047),
      bgColor: Color(0xFFF0FDF4),
      borderColor: Color(0xFF43A047),
      icon: Icons.check_circle_rounded,
      label: 'جاهز للاستلام',
    ),
    DropoffStatus.delivered: DropoffStatusConfig._(
      color: Color(0xFF9CA3AF),
      bgColor: Color(0xFFF9FAFB),
      borderColor: Color(0xFF9CA3AF),
      icon: Icons.local_shipping_rounded,
      label: 'تم التسليم',
    ),
    DropoffStatus.cancelled: DropoffStatusConfig._(
      color: Color(0xFFE53935),
      bgColor: Color(0xFFFEF2F2),
      borderColor: Color(0xFFE53935),
      icon: Icons.cancel_rounded,
      label: 'ملغي',
    ),
  };

  /// Get config for a specific status.
  static DropoffStatusConfig of(DropoffStatus status) => _configs[status]!;

  /// The standard status flow (excludes cancelled).
  static const List<DropoffStatus> statusFlow = [
    DropoffStatus.received,
    DropoffStatus.processing,
    DropoffStatus.ready,
    DropoffStatus.delivered,
  ];

  /// All statuses including cancelled.
  static const List<DropoffStatus> allStatuses = DropoffStatus.values;

  /// Next action config for advance buttons.
  static const Map<DropoffStatus, ({String label, DropoffStatus next})>
      nextAction = {
    DropoffStatus.received: (
      label: 'بدء المعالجة',
      next: DropoffStatus.processing,
    ),
    DropoffStatus.processing: (
      label: 'جاهز للاستلام',
      next: DropoffStatus.ready,
    ),
    DropoffStatus.ready: (
      label: 'تم التسليم',
      next: DropoffStatus.delivered,
    ),
  };
}
