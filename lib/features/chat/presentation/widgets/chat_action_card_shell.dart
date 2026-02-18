import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/message.dart';

class ChatActionCardShell extends StatelessWidget {
  final Message message;
  final IconData icon;
  final Color color;
  final String title;
  final Widget body;
  final Widget? footer;

  const ChatActionCardShell({
    super.key,
    required this.message,
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      constraints: const BoxConstraints(maxWidth: 320),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.04),
        border: Border.all(color: color.withValues(alpha: 0.25), width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, size: 16, color: color),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body,
          if (footer != null) footer!,
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: AppSpacing.md,
              end: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              _formatTime(message.createdAt),
              style: TextStyle(
                fontSize: 10,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int timestampSec) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestampSec * 1000);
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final period = date.hour < 12 ? 'ص' : 'م';
    return '$hour:${date.minute.toString().padLeft(2, '0')} $period';
  }
}
