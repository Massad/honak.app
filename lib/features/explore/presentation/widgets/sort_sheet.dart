import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

enum CategorySortBy { nearest, popular, alphabetical }

String sortLabel(CategorySortBy sort) {
  switch (sort) {
    case CategorySortBy.nearest:
      return 'الأقرب';
    case CategorySortBy.popular:
      return 'الأكثر شهرة';
    case CategorySortBy.alphabetical:
      return 'الاسم أبجدياً';
  }
}

Future<CategorySortBy?> showSortSheet(
  BuildContext context, {
  required CategorySortBy current,
  bool isGovernment = false,
}) async {
  return showAppSheet<CategorySortBy>(
    context,
    builder: (context) => _SortSheetContent(
      current: current,
      isGovernment: isGovernment,
    ),
  );
}

class _SortSheetContent extends StatelessWidget {
  final CategorySortBy current;
  final bool isGovernment;

  const _SortSheetContent({
    required this.current,
    required this.isGovernment,
  });

  @override
  Widget build(BuildContext context) {
    final options = isGovernment
        ? [CategorySortBy.popular, CategorySortBy.alphabetical]
        : CategorySortBy.values;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header row
        Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.sm,
              0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ترتيب حسب',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Sort options
          ...options.map((sortBy) {
            final isActive = sortBy == current;
            return ListTile(
              title: Text(
                sortLabel(sortBy),
                style: TextStyle(
                  color: isActive
                      ? context.colorScheme.primary
                      : context.colorScheme.onSurface,
                ),
              ),
              trailing: isActive
                  ? Icon(Icons.check, color: context.colorScheme.primary)
                  : null,
              onTap: () => Navigator.pop(context, sortBy),
            );
          }),
        SizedBox(height: AppSpacing.sm),
      ],
    );
  }
}
