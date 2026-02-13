import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/shared/domain/entities/biz_category.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

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
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'تصفية ${widget.itemsLabelAr}',
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
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),

              // Category filter
              if (widget.categories.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xl),
                const Text(
                  'التصنيف',
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
                      label: 'الكل',
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
              const Text(
                'الحالة',
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
                    label: 'الكل',
                    isActive: _status == 'all',
                    onTap: () => setState(() => _status = 'all'),
                  ),
                  _Chip(
                    label: 'متوفر',
                    isActive: _status == 'active',
                    onTap: () => setState(() => _status = 'active'),
                  ),
                  _Chip(
                    label: 'غير متوفر',
                    isActive: _status == 'out_of_stock',
                    onTap: () => setState(() => _status = 'out_of_stock'),
                  ),
                  _Chip(
                    label: 'مخفي',
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
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  if (_hasActiveFilters)
                    GestureDetector(
                      onTap: _reset,
                      child: const Text(
                        'إعادة ضبط',
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApply(_categoryId, _status);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSpacing.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'عرض النتائج ($_filteredCount)',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
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
          color: isActive ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isActive ? null : Border.all(color: Colors.grey.shade200),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.white : Colors.grey.shade600,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
