import 'package:flutter/material.dart';

/// Base visual configuration for a status badge.
///
/// Both [DropoffStatusConfig] and [QueueStatusConfig] extend this,
/// so shared widgets like [GenericStatusPickerSheet] and [PhotoToggleButton]
/// can work with any status type.
class StatusConfig {
  const StatusConfig({
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
}
