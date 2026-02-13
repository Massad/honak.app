import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// Branch selector widget shown when a page has 2+ branches.
/// Tapping opens a bottom sheet to pick a different branch.
class BranchSelector extends StatelessWidget {
  final List<Branch> branches;
  final int selectedIndex;
  final ValueChanged<int> onBranchChanged;

  const BranchSelector({
    super.key,
    required this.branches,
    required this.selectedIndex,
    required this.onBranchChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (branches.length < 2) return const SizedBox.shrink();

    final branch = branches[selectedIndex];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      child: Material(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _showBranchPicker(context),
          child: Container(
            padding: EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.colorScheme.outlineVariant,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 20,
                  color: context.colorScheme.primary,
                ),
                SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\u0627\u0644\u0641\u0631\u0639',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: AppSpacing.xxs),
                      Text(
                        branch.name,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBranchPicker(BuildContext context) {
    showAppSheet<void>(
      context,
      builder: (_) => _BranchPickerSheet(
        branches: branches,
        selectedIndex: selectedIndex,
        onBranchChanged: (index) {
          onBranchChanged(index);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

class _BranchPickerSheet extends StatelessWidget {
  final List<Branch> branches;
  final int selectedIndex;
  final ValueChanged<int> onBranchChanged;

  const _BranchPickerSheet({
    required this.branches,
    required this.selectedIndex,
    required this.onBranchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '\u0627\u062e\u062a\u0631 \u0627\u0644\u0641\u0631\u0639',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),

          // Branch list
          ...List.generate(branches.length, (index) {
            final branch = branches[index];
            final isSelected = index == selectedIndex;

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.xs,
              ),
              child: Material(
                color: isSelected
                    ? context.colorScheme.primary.withValues(alpha: 0.06)
                    : context.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => onBranchChanged(index),
                  child: Container(
                    padding: EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? context.colorScheme.primary
                            : context.colorScheme.outlineVariant,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                branch.name,
                                style:
                                    context.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (branch.address != null &&
                                  branch.address!.isNotEmpty) ...[
                                SizedBox(height: AppSpacing.xxs),
                                Text(
                                  branch.address!,
                                  style: context.textTheme.bodySmall
                                      ?.copyWith(
                                    color: context
                                        .colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                              if (branch.hours != null &&
                                  branch.hours!.isNotEmpty) ...[
                                SizedBox(height: AppSpacing.xxs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_outlined,
                                      size: 12,
                                      color: context
                                          .colorScheme.onSurfaceVariant,
                                    ),
                                    SizedBox(width: AppSpacing.xxs),
                                    Text(
                                      branch.hours!,
                                      style: context.textTheme.labelSmall
                                          ?.copyWith(
                                        color: context
                                            .colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              if (branch.phone != null &&
                                  branch.phone!.isNotEmpty) ...[
                                SizedBox(height: AppSpacing.xxs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone_outlined,
                                      size: 12,
                                      color: context
                                          .colorScheme.onSurfaceVariant,
                                    ),
                                    SizedBox(width: AppSpacing.xxs),
                                    Text(
                                      branch.phone!,
                                      style: context.textTheme.labelSmall
                                          ?.copyWith(
                                        color: context
                                            .colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: context.colorScheme.primary,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),

        SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}
