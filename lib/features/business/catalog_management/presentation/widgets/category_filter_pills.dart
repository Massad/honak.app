import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/shared/domain/entities/biz_category.dart';

/// Horizontal scrollable category filter pills.
class CategoryFilterPills extends StatelessWidget {
  final List<BizCategory> categories;
  final String? activeCategoryId;
  final ValueChanged<String?> onCategoryChanged;
  final VoidCallback onManageCategories;

  const CategoryFilterPills({
    super.key,
    required this.categories,
    required this.activeCategoryId,
    required this.onCategoryChanged,
    required this.onManageCategories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        children: [
          // "All" pill
          _FilterPill(
            label: context.l10n.all,
            isActive: activeCategoryId == null,
            onTap: () => onCategoryChanged(null),
          ),

          // Category pills
          ...categories.map((cat) => Padding(
                padding:
                    const EdgeInsetsDirectional.only(start: AppSpacing.sm),
                child: _FilterPill(
                  label: cat.name,
                  isActive: activeCategoryId == cat.id,
                  onTap: () => onCategoryChanged(
                    activeCategoryId == cat.id ? null : cat.id,
                  ),
                ),
              )),

          // Manage categories button
          Padding(
            padding: const EdgeInsetsDirectional.only(start: AppSpacing.sm),
            child: GestureDetector(
              onTap: onManageCategories,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.settings_outlined,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterPill({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: isActive ? null : Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.white : Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
