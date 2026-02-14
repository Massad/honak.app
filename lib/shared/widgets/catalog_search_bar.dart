import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Unified search bar for catalog/menu/service sections.
///
/// Supports two modes:
/// - **Simple** (business manage): pass [query] + [onChanged] + optional [hintText].
/// - **With filter** (customer catalog): additionally pass [onFilterTap] and [activeFilterCount].
class CatalogSearchBar extends StatelessWidget {
  final String? query;
  final ValueChanged<String> onChanged;
  final String? hintText;
  final VoidCallback? onFilterTap;
  final int activeFilterCount;

  const CatalogSearchBar({
    super.key,
    this.query,
    required this.onChanged,
    this.hintText,
    this.onFilterTap,
    this.activeFilterCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText ?? 'بحث...',
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  size: 20,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                suffixIcon: (query != null && query!.isNotEmpty)
                    ? IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 18,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        onPressed: () => onChanged(''),
                      )
                    : null,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                filled: true,
                fillColor: context.colorScheme.surfaceContainerLowest,
                border: OutlineInputBorder(
                  borderRadius: AppRadius.button,
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppRadius.button,
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppRadius.button,
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 1),
                ),
              ),
            ),
          ),
          if (onFilterTap != null) ...[
            const SizedBox(width: AppSpacing.sm),
            _FilterButton(
              onTap: onFilterTap!,
              activeCount: activeFilterCount,
            ),
          ],
        ],
      ),
    );
  }
}

// ===============================================================
// Filter button with optional badge
// ===============================================================

class _FilterButton extends StatelessWidget {
  final VoidCallback onTap;
  final int activeCount;

  const _FilterButton({
    required this.onTap,
    required this.activeCount,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(
            Icons.tune,
            color: context.colorScheme.onSurfaceVariant,
          ),
          style: IconButton.styleFrom(
            backgroundColor: context.colorScheme.surfaceContainerLowest,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              side: BorderSide.none,
            ),
          ),
        ),
        if (activeCount > 0)
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '$activeCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
