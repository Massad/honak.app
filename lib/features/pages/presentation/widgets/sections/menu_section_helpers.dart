import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Horizontal scrolling pills showing modifier note segments.
class ModifiersBanner extends StatelessWidget {
  final String note;

  const ModifiersBanner({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xs,
        ),
        children: note
            .split('\u060c')
            .map((part) => part.trim())
            .where((part) => part.isNotEmpty)
            .map(
              (part) => Padding(
                padding:
                    const EdgeInsetsDirectional.only(end: AppSpacing.xs),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    part,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Colors.orange.shade800,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
