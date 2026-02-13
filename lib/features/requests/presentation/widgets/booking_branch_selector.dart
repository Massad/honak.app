import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// FG2: Branch selector for booking sheet (when multiple branches exist).
class BookingBranchSelector extends StatelessWidget {
  final List<String> branches;
  final String? selected;
  final ValueChanged<String> onChanged;

  const BookingBranchSelector({
    super.key,
    required this.branches,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الفرع',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 38,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: branches.map((branch) {
              final isSelected = selected == branch;
              return Padding(
                padding:
                    const EdgeInsetsDirectional.only(end: AppSpacing.sm),
                child: InkWell(
                  onTap: () => onChanged(branch),
                  borderRadius: AppRadius.cardInner,
                  child: Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.white,
                      borderRadius: AppRadius.cardInner,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.divider,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.store,
                            size: 12,
                            color: isSelected
                                ? Colors.white
                                : AppColors.textSecondary),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          branch,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Colors.white
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
