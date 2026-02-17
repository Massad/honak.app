import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_direction.dart';

class ModificationItemRow extends StatelessWidget {
  final Map<String, dynamic> change;

  const ModificationItemRow({super.key, required this.change});

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    final name = change['name'] as String? ?? '';
    final changes =
        (change['changes'] as List?)?.cast<Map<String, dynamic>>() ?? [];

    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: cs.onSurface,
            ),
          ),
          ...changes.map((c) {
            final field = c['field'] as String? ?? '';
            final from = c['from']?.toString() ?? '';
            final to = c['to']?.toString() ?? '';

            return Padding(
              padding: const EdgeInsetsDirectional.only(
                start: AppSpacing.md,
                top: AppSpacing.xxs,
              ),
              child: Row(
                children: [
                  Text(
                    '$field: ',
                    style: TextStyle(
                      fontSize: 12,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    from,
                    style: TextStyle(
                      fontSize: 12,
                      color: cs.onSurfaceVariant,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 4),
                    child: Icon(
                      AppDirection.forwardIcon(context),
                      size: 12,
                      color: AppColors.warning,
                    ),
                  ),
                  Text(
                    to,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
