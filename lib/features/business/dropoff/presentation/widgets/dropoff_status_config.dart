import 'package:flutter/material.dart';

import 'package:honak/core/l10n/arb/app_localizations.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_status.dart';
import 'package:honak/features/business/shared/entities/status_config.dart';

/// Centralized visual configuration for each [DropoffStatus].
///
/// Extends shared [StatusConfig] so it can be used with
/// [GenericStatusPickerSheet] and other shared widgets.
class DropoffStatusConfig extends StatusConfig {
  const DropoffStatusConfig._({
    required super.color,
    required super.bgColor,
    required super.borderColor,
    required super.icon,
    required super.label,
  });

  /// Status config map keyed by [DropoffStatus].
  /// Labels here are Arabic fallbacks; use [ofLocalized] for l10n-aware labels.
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

  /// Get config for a specific status (fallback Arabic label).
  static DropoffStatusConfig of(DropoffStatus status) => _configs[status]!;

  /// Get config with a localized label.
  static DropoffStatusConfig ofLocalized(
    DropoffStatus status,
    BuildContext context,
  ) {
    final base = _configs[status]!;
    return DropoffStatusConfig._(
      color: base.color,
      bgColor: base.bgColor,
      borderColor: base.borderColor,
      icon: base.icon,
      label: status.label(context),
    );
  }

  /// The standard status flow (excludes cancelled).
  static const List<DropoffStatus> statusFlow = [
    DropoffStatus.received,
    DropoffStatus.processing,
    DropoffStatus.ready,
    DropoffStatus.delivered,
  ];

  /// All statuses including cancelled.
  static const List<DropoffStatus> allStatuses = DropoffStatus.values;

  /// Next action config for advance buttons (fallback Arabic labels).
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

  /// Localized next action label.
  static String? nextActionLabel(
    DropoffStatus status,
    BuildContext context,
  ) {
    final l10n = AppLocalizations.of(context);
    return switch (status) {
      DropoffStatus.received => l10n.dropoffNextStartProcessing,
      DropoffStatus.processing => l10n.dropoffNextReadyForPickup,
      DropoffStatus.ready => l10n.dropoffNextDelivered,
      _ => null,
    };
  }
}
