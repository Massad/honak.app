import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/shared/domain/entities/biz_category.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

Future<void> showFilterSheet(
  BuildContext context, {
  required List<BizCategory> categories,
  required String activeCategoryId,
  required String activeStatus,
  required int totalCount,
  required int filteredCount,
  required String itemLabelAr,
  required String itemsLabelAr,
  required void Function(String categoryId, String status) onApply,
}) {
  return showAppSheet(
    context,
    builder: (_) => _FilterSheetContent(
      categories: categories,
      initialCategoryId: activeCategoryId,
      initialStatus: activeStatus,
      totalCount: totalCount,
      filteredCount: filteredCount,
      itemLabelAr: itemLabelAr,
      itemsLabelAr: itemsLabelAr,
      onApply: onApply,
    ),
  );
}

class _FilterSheetContent extends StatefulWidget {
  final List<BizCategory> categories;
  final String initialCategoryId;
  final String initialStatus;
  final int totalCount;
  final int filteredCount;
  final String itemLabelAr;
  final String itemsLabelAr;
  final void Function(String categoryId, String status) onApply;

  const _FilterSheetContent({
    required this.categories,
    required this.initialCategoryId,
    required this.initialStatus,
    required this.totalCount,
    required this.filteredCount,
    required this.itemLabelAr,
    required this.itemsLabelAr,
    required this.onApply,
  });

  @override
  State<_FilterSheetContent> createState() => _FilterSheetContentState();
}

class _FilterSheetContentState extends State<_FilterSheetContent> {
  late String _categoryId;
  late String _status;

  @override
  void initState() {
    super.initState();
    _categoryId = widget.initialCategoryId;
    _status = widget.initialStatus;
  }

  bool get _hasActiveFilters => _categoryId.isNotEmpty || _status != 'all';

  int get _filteredCount => widget.filteredCount;

  void _reset() {
    setState(() {
      _categoryId = '';
      _status = 'all';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              // Drag handle
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outline,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.catalogFilterItems(widget.itemsLabelAr),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerLow,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 18,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),

              // Category filter
              if (widget.categories.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xl),
                Text(
                  context.l10n.wizardCategory,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    _Chip(
                      label: context.l10n.all,
                      isActive: _categoryId.isEmpty,
                      onTap: () => setState(() => _categoryId = ''),
                    ),
                    ...widget.categories.map((cat) => _Chip(
                          label: '${cat.name} (${cat.itemCount})',
                          isActive: _categoryId == cat.id,
                          onTap: () => setState(() => _categoryId = cat.id),
                        )),
                  ],
                ),
              ],

              // Status filter
              const SizedBox(height: AppSpacing.xl),
              Text(
                context.l10n.catalogStatus,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  _Chip(
                    label: context.l10n.all,
                    isActive: _status == 'all',
                    onTap: () => setState(() => _status = 'all'),
                  ),
                  _Chip(
                    label: context.l10n.catalogStatusAvailable,
                    isActive: _status == 'active',
                    onTap: () => setState(() => _status = 'active'),
                  ),
                  _Chip(
                    label: context.l10n.catalogStatusOutOfStock,
                    isActive: _status == 'out_of_stock',
                    onTap: () => setState(() => _status = 'out_of_stock'),
                  ),
                  _Chip(
                    label: context.l10n.catalogStatusHidden,
                    isActive: _status == 'hidden',
                    onTap: () => setState(() => _status = 'hidden'),
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
                child: Divider(height: 1),
              ),

              // Result count + reset
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '$_filteredCount من ${widget.totalCount} ${widget.itemLabelAr}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  if (_hasActiveFilters)
                    GestureDetector(
                      onTap: _reset,
                      child: Text(
                        context.l10n.catalogResetFilters,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.error,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: AppSpacing.md),

              // Apply button
              btn.Button(
                onPressed: () {
                  widget.onApply(_categoryId, _status);
                  Navigator.pop(context);
                },
                label: context.l10n.catalogShowResults(_filteredCount),
                size: btn.ButtonSize.large,
                expand: true,
              ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _Chip({
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
