import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/message.dart';

class SystemMessage extends StatelessWidget {
  final Message message;

  const SystemMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: cs.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Text(
            message.content,
            style: TextStyle(
              fontSize: 11,
              color: cs.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
