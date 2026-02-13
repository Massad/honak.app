import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';

class ModificationItemRow extends StatelessWidget {
  final Map<String, dynamic> change;

  const ModificationItemRow({super.key, required this.change});

  @override
  Widget build(BuildContext context) {
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
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
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
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    from,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textHint,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 4),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Icon(
                        Icons.arrow_forward,
                        size: 12,
                        color: AppColors.warning,
                      ),
                    ),
                  ),
                  Text(
                    to,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
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
