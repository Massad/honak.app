import 'dart:async';

import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/shared/domain/entities/biz_category.dart';

part 'category_manager_widgets.dart';

/// Opens a full-screen category manager page.
void openCategoryManager(
  BuildContext context, {
  required List<BizCategory> categories,
  required String itemLabelAr,
  required ValueChanged<List<BizCategory>> onChanged,
}) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => _CategoryManagerPage(
        categories: categories,
        itemLabelAr: itemLabelAr,
        onChanged: onChanged,
      ),
    ),
  );
}

class _CategoryManagerPage extends StatefulWidget {
  final List<BizCategory> categories;
  final String itemLabelAr;
  final ValueChanged<List<BizCategory>> onChanged;

  const _CategoryManagerPage({
    required this.categories,
    required this.itemLabelAr,
    required this.onChanged,
  });

  @override
  State<_CategoryManagerPage> createState() => _CategoryManagerPageState();
}

class _CategoryManagerPageState extends State<_CategoryManagerPage> {
  late List<BizCategory> _categories;
  String? _editingId;
  final _editController = TextEditingController();
  bool _addMode = false;
  final _addController = TextEditingController();
  String? _flashMessage;
  Timer? _flashTimer;

  @override
  void initState() {
    super.initState();
    _categories = List.of(widget.categories);
  }

  @override
  void dispose() {
    _editController.dispose();
    _addController.dispose();
    _flashTimer?.cancel();
    super.dispose();
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  void _flash(String msg) {
    _flashTimer?.cancel();
    setState(() => _flashMessage = msg);
    _flashTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _flashMessage = null);
    });
  }

  bool _isDuplicate(String name, {String? excludeId}) =>
      _categories.any((c) => c.name == name && c.id != excludeId);

  int get _totalItems =>
      _categories.fold<int>(0, (sum, c) => sum + c.itemCount);

  void _notifyChanged() => widget.onChanged(_categories);

  // ── Add ──────────────────────────────────────────────────────────────────

  void _confirmAdd() {
    final name = _addController.text.trim();
    if (name.isEmpty) return;
    if (_isDuplicate(name)) {
      _flash('يوجد تصنيف بهذا الاسم بالفعل');
      return;
    }
    final newCat = BizCategory(
      id: 'cat_new_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      sortOrder: _categories.length,
    );
    setState(() {
      _categories.add(newCat);
      _addController.clear();
      _addMode = false;
    });
    _notifyChanged();
    _flash('تمت إضافة تصنيف "$name"');
  }

  void _cancelAdd() {
    setState(() {
      _addMode = false;
      _addController.clear();
    });
  }

  // ── Edit ─────────────────────────────────────────────────────────────────

  void _startEdit(BizCategory cat) {
    setState(() {
      _editingId = cat.id;
      _editController.text = cat.name;
    });
  }

  void _confirmEdit() {
    if (_editingId == null) return;
    final name = _editController.text.trim();
    if (name.isEmpty) return;

    final idx = _categories.indexWhere((c) => c.id == _editingId);
    if (idx == -1) return;

    final oldName = _categories[idx].name;
    if (name != oldName) {
      if (_isDuplicate(name, excludeId: _editingId)) {
        _flash('يوجد تصنيف بهذا الاسم بالفعل');
        return;
      }
      setState(() => _categories[idx] = _categories[idx].copyWith(name: name));
      _notifyChanged();
      _flash('تم تغيير "$oldName" إلى "$name"');
    }
    setState(() => _editingId = null);
  }

  void _cancelEdit() => setState(() => _editingId = null);

  // ── Delete ───────────────────────────────────────────────────────────────

  void _showDeleteSheet(BizCategory cat) {
    final others = _categories.where((c) => c.id != cat.id).toList();
    var reassignTo = '';

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xxl)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.xl, AppSpacing.xl, AppSpacing.xl, AppSpacing.xxxl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.error_outline, color: AppColors.error, size: 18),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'حذف تصنيف "${cat.name}"',
                    style: context.textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              if (cat.itemCount > 0) ...[
                Text(
                  'يوجد ${cat.itemCount} ${widget.itemLabelAr} في هذا التصنيف. اختر تصنيفاً لنقلهم إليه:',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _RadioOption(
                  label: 'بدون تصنيف',
                  selected: reassignTo == '',
                  onTap: () => setSheetState(() => reassignTo = ''),
                ),
                const SizedBox(height: AppSpacing.xs),
                ...others.map((c) => Padding(
                  padding: const EdgeInsetsDirectional.only(top: AppSpacing.xs),
                  child: _RadioOption(
                    label: c.name,
                    trailing: '${c.itemCount} ${widget.itemLabelAr}',
                    selected: reassignTo == c.id,
                    onTap: () => setSheetState(() => reassignTo = c.id),
                  ),
                )),
              ] else
                Text(
                  'هذا التصنيف فارغ ويمكن حذفه مباشرة.',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                textDirection: TextDirection.ltr,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                        shape: RoundedRectangleBorder(borderRadius: AppRadius.cardInner),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                      child: const Text('إلغاء'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _performDelete(cat);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.error,
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                        shape: RoundedRectangleBorder(borderRadius: AppRadius.cardInner),
                      ),
                      icon: const Icon(Icons.delete_outline, size: 16),
                      label: const Text('حذف التصنيف'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _performDelete(BizCategory cat) {
    final name = cat.name;
    setState(() => _categories.removeWhere((c) => c.id == cat.id));
    _notifyChanged();
    _flash('تم حذف تصنيف "$name"');
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('إدارة التصنيفات'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            if (_flashMessage != null) _FlashBanner(message: _flashMessage!),
            _SummaryCard(
              categoryCount: _categories.length,
              totalItems: _totalItems,
              itemLabelAr: widget.itemLabelAr,
              onAdd: () => setState(() => _addMode = true),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (_addMode)
              _AddCard(
                controller: _addController,
                onConfirm: _confirmAdd,
                onCancel: _cancelAdd,
              ),
            if (_categories.isNotEmpty)
              ..._categories.map((cat) {
                final isEditing = _editingId == cat.id;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _CategoryCard(
                    category: cat,
                    itemLabelAr: widget.itemLabelAr,
                    isEditing: isEditing,
                    editController: isEditing ? _editController : null,
                    onEdit: () => _startEdit(cat),
                    onConfirmEdit: _confirmEdit,
                    onCancelEdit: _cancelEdit,
                    onDelete: () => _showDeleteSheet(cat),
                  ),
                );
              }),
            if (_categories.isEmpty && !_addMode)
              _EmptyState(onAdd: () => setState(() => _addMode = true)),
          ],
        ),
      ),
    );
  }
}
