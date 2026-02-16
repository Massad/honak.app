import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Overlay for managing directory categories — list with counts, rename,
/// delete (with reassignment), and add new.
class CategoryManagerOverlay extends StatefulWidget {
  final List<String> categories;
  final List<Tenant> tenants;
  final VoidCallback onClose;
  final ValueChanged<List<String>> onSave;

  const CategoryManagerOverlay({
    super.key,
    required this.categories,
    required this.tenants,
    required this.onClose,
    required this.onSave,
  });

  @override
  State<CategoryManagerOverlay> createState() => _CategoryManagerOverlayState();
}

class _CategoryManagerOverlayState extends State<CategoryManagerOverlay> {
  late List<String> _categories;
  bool _isAdding = false;
  int? _editIndex;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _categories = List.from(widget.categories);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _countForCategory(String category) {
    return widget.tenants.where((t) => t.category == category).length;
  }

  void _startAdd() {
    _controller.clear();
    setState(() {
      _isAdding = true;
      _editIndex = null;
    });
  }

  void _startEdit(int index) {
    _controller.text = _categories[index];
    setState(() {
      _isAdding = false;
      _editIndex = index;
    });
  }

  void _saveEdit() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;

    setState(() {
      if (_editIndex != null) {
        _categories[_editIndex!] = name;
      } else if (_isAdding) {
        _categories.add(name);
      }
      _isAdding = false;
      _editIndex = null;
    });
  }

  void _cancelEdit() {
    setState(() {
      _isAdding = false;
      _editIndex = null;
    });
  }

  void _deleteCategory(int index) {
    final cat = _categories[index];
    final count = _countForCategory(cat);
    if (count > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'لا يمكن حذف "$cat" — يحتوي على $count مستأجر',
          ),
        ),
      );
      return;
    }
    setState(() => _categories.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: widget.onClose,
        ),
        title: const Text(
          'إدارة التصنيفات',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          btn.Button(
            onPressed: () => widget.onSave(_categories),
            label: 'حفظ',
            variant: btn.Variant.text,
            size: btn.ButtonSize.small,
          ),
        ],
      ),
      body: Column(
        children: [
          // Add/edit form
          if (_isAdding || _editIndex != null)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.04),
                  borderRadius: AppRadius.card,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _editIndex != null ? 'تعديل تصنيف' : 'تصنيف جديد',
                      style: context.textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: _controller,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'اسم التصنيف',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: AppRadius.button,
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      textDirection: TextDirection.ltr,
                      children: [
                        btn.Button(
                          onPressed: _cancelEdit,
                          label: 'إلغاء',
                          variant: btn.Variant.text,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        btn.Button(
                          onPressed: _saveEdit,
                          label: _editIndex != null ? 'تحديث' : 'إضافة',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          // Categories list
          Expanded(
            child: _categories.isEmpty
                ? Center(
                    child: Text(
                      'لا توجد تصنيفات',
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: _categories.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (_, i) {
                      final cat = _categories[i];
                      final count = _countForCategory(cat);

                      return Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          borderRadius: AppRadius.card,
                          border: Border.all(
                            color: context.colorScheme.outlineVariant,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.label_outline,
                              size: 18,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cat,
                                      style: context.textTheme.titleSmall),
                                  Text(
                                    '$count مستأجر',
                                    style:
                                        context.textTheme.labelSmall?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon:
                                  const Icon(Icons.edit_outlined, size: 18),
                              onPressed: () => _startEdit(i),
                              visualDensity: VisualDensity.compact,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                                size: 18,
                                color: count > 0
                                    ? Theme.of(context).colorScheme.outline
                                    : AppColors.error,
                              ),
                              onPressed: () => _deleteCategory(i),
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // Add button
          if (!_isAdding && _editIndex == null)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: btn.Button(
                  onPressed: _startAdd,
                  label: 'إضافة تصنيف',
                  icon: const btn.ButtonIcon(Icons.add),
                  variant: btn.Variant.outlined,
                  expand: true,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
