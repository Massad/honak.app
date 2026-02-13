import 'package:flutter/material.dart';
import 'package:honak/shared/widgets/app_badge.dart';

/// A small colored chip with icon + label, used for request actions
/// (accept, decline, alternative, etc.).
///
/// Wraps [AppBadge] with tap support.
class RequestActionChip extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback? onTap;

  const RequestActionChip({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppBadge(
        label: label,
        color: color,
        icon: icon,
      ),
    );
  }
}
