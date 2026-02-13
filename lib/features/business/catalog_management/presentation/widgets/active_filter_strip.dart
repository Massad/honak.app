import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';

class ActiveFilter {
  final String key;
  final String label;
  final Color? bgColor;
  final Color? textColor;

  const ActiveFilter({
    required this.key,
    required this.label,
    this.bgColor,
    this.textColor,
  });
}

class ActiveFilterStrip extends StatelessWidget {
  final List<ActiveFilter> filters;
  final ValueChanged<String> onRemove;
  final VoidCallback? onClearAll;

  const ActiveFilterStrip({
    super.key,
    required this.filters,
    required this.onRemove,
    this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    if (filters.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 32,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        children: [
          ...filters.map((f) => Padding(
                padding:
                    const EdgeInsetsDirectional.only(end: AppSpacing.sm),
                child: _FilterTag(
                  filter: f,
                  onRemove: () => onRemove(f.key),
                ),
              )),
          if (filters.length > 1 && onClearAll != null)
            GestureDetector(
              onTap: onClearAll,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'مسح الكل',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.error,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _FilterTag extends StatelessWidget {
  final ActiveFilter filter;
  final VoidCallback onRemove;

  const _FilterTag({required this.filter, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final bg = filter.bgColor ?? AppColors.primary.withValues(alpha: 0.08);
    final fg = filter.textColor ?? AppColors.primary;

    return GestureDetector(
      onTap: onRemove,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              filter.label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: fg,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '✕',
              style: TextStyle(fontSize: 9, color: fg),
            ),
          ],
        ),
      ),
    );
  }
}
