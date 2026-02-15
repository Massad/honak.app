import 'package:flutter/material.dart';

import 'package:honak/features/business/queue/domain/entities/queue_status.dart';
import 'package:honak/features/business/shared/entities/status_config.dart';

/// Visual configuration for each [QueueStatus].
///
/// Extends shared [StatusConfig] so it can be used with
/// [GenericStatusPickerSheet] and other shared widgets.
class QueueStatusConfig extends StatusConfig {
  const QueueStatusConfig._({
    required super.color,
    required super.bgColor,
    required super.borderColor,
    required super.icon,
    required super.label,
  });

  static const Map<QueueStatus, QueueStatusConfig> _configs = {
    QueueStatus.waiting: QueueStatusConfig._(
      color: Color(0xFFFF9800),
      bgColor: Color(0xFFFFF8E1),
      borderColor: Color(0xFFFF9800),
      icon: Icons.schedule_rounded,
      label: 'في الانتظار',
    ),
    QueueStatus.onTheWay: QueueStatusConfig._(
      color: Color(0xFF43A047),
      bgColor: Color(0xFFF0FDF4),
      borderColor: Color(0xFF43A047),
      icon: Icons.navigation_rounded,
      label: 'في الطريق',
    ),
    QueueStatus.inProgress: QueueStatusConfig._(
      color: Color(0xFF1A73E8),
      bgColor: Color(0xFFEFF6FF),
      borderColor: Color(0xFF1A73E8),
      icon: Icons.play_arrow_rounded,
      label: 'قيد الخدمة',
    ),
    QueueStatus.ready: QueueStatusConfig._(
      color: Color(0xFF43A047),
      bgColor: Color(0xFFF0FDF4),
      borderColor: Color(0xFF43A047),
      icon: Icons.check_circle_outline_rounded,
      label: 'جاهز للاستلام',
    ),
    QueueStatus.completed: QueueStatusConfig._(
      color: Color(0xFF6B7280),
      bgColor: Color(0xFFF9FAFB),
      borderColor: Color(0xFF9CA3AF),
      icon: Icons.local_shipping_rounded,
      label: 'مكتمل',
    ),
    QueueStatus.noShow: QueueStatusConfig._(
      color: Color(0xFFE53935),
      bgColor: Color(0xFFFEF2F2),
      borderColor: Color(0xFFE53935),
      icon: Icons.block_rounded,
      label: 'لم يحضر',
    ),
  };

  /// Get config for a specific status.
  static QueueStatusConfig of(QueueStatus status) => _configs[status]!;

  /// Canonical status ordering for forward/backward detection.
  static const List<QueueStatus> statusOrder = [
    QueueStatus.waiting,
    QueueStatus.onTheWay,
    QueueStatus.inProgress,
    QueueStatus.ready,
    QueueStatus.completed,
    QueueStatus.noShow,
  ];

  /// Statuses shown in the picker (excludes onTheWay — not user-selectable).
  static const List<QueueStatus> pickerStatuses = [
    QueueStatus.waiting,
    QueueStatus.inProgress,
    QueueStatus.ready,
    QueueStatus.completed,
    QueueStatus.noShow,
  ];
}
