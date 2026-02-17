import 'dart:async';

import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/shared/domain/entities/biz_category.dart';
import 'package:honak/shared/widgets/app_screen.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

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

  // ── Reorder ────────────────────────────────────────────────────────────

  void _moveCategory(int index, int direction) {
    final newIndex = index + direction;
    if (newIndex < 0 || newIndex >= _categories.length) return;
    setState(() {
      final cat = _categories.removeAt(index);
      _categories.insert(newIndex, cat);
      for (int i = 0; i < _categories.length; i++) {
        _categories[i] = _categories[i].copyWith(sortOrder: i);
      }
    });
    _notifyChanged();
  }

  // ── Add ──────────────────────────────────────────────────────────────────

  void _confirmAdd() {
    final name = _addController.text.trim();
    if (name.isEmpty) return;
    if (_isDuplicate(name)) {
      _flash(context.l10n.catMgrDuplicateName);
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
    _flash(context.l10n.catMgrAdded(name));
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
        _flash(context.l10n.catMgrDuplicateName);
        return;
      }
      setState(() => _categories[idx] = _categories[idx].copyWith(name: name));
      _notifyChanged();
      _flash(context.l10n.catMgrRenamed(oldName, name));
    }
    setState(() => _editingId = null);
  }

  void _cancelEdit() => setState(() => _editingId = null);

  // ── Delete ───────────────────────────────────────────────────────────────

  void _showDeleteSheet(BizCategory cat) {
    final others = _categories.where((c) => c.id != cat.id).toList();
    var reassignTo = '';

    showAppSheet<void>(
      context,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.xl,
            AppSpacing.xl,
            AppSpacing.xl,
            AppSpacing.xxxl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: AppColors.error,
                    size: 18,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    context.l10n.catMgrDeleteTitle(cat.name),
                    style: context.textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              if (cat.itemCount > 0) ...[
                Text(
                  context.l10n.catMgrDeleteHasItems(
                    cat.itemCount,
                    widget.itemLabelAr,
                  ),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _RadioOption(
                  label: context.l10n.catMgrUncategorized,
                  selected: reassignTo == '',
                  onTap: () => setSheetState(() => reassignTo = ''),
                ),
                const SizedBox(height: AppSpacing.xs),
                ...others.map(
                  (c) => Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: AppSpacing.xs,
                    ),
                    child: _RadioOption(
                      label: c.name,
                      trailing: '${c.itemCount} ${widget.itemLabelAr}',
                      selected: reassignTo == c.id,
                      onTap: () => setSheetState(() => reassignTo = c.id),
                    ),
                  ),
                ),
              ] else
                Text(
                  context.l10n.catMgrDeleteEmpty,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                textDirection: Directionality.of(context),
                children: [
                  Expanded(
                    child: btn.Button(
                      onPressed: () => Navigator.pop(ctx),
                      label: context.l10n.cancel,
                      variant: btn.Variant.outlined,
                      size: btn.ButtonSize.large,
                      expand: true,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: btn.Button(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _performDelete(cat);
                      },
                      label: context.l10n.catMgrDeleteBtn,
                      icon: const btn.ButtonIcon(
                        Icons.delete_outline,
                        size: 16,
                      ),
                      style: btn.Style.danger,
                      size: btn.ButtonSize.large,
                      expand: true,
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
    _flash(context.l10n.catMgrDeleted(name));
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: Text(context.l10n.catMgrTitle),
      showBack: true,
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
            for (var index = 0; index < _categories.length; index++) ...[
              Builder(
                builder: (context) {
                  final cat = _categories[index];
                  final isEditing = _editingId == cat.id;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: _CategoryCard(
                      category: cat,
                      index: index,
                      totalCount: _categories.length,
                      itemLabelAr: widget.itemLabelAr,
                      isEditing: isEditing,
                      editController: isEditing ? _editController : null,
                      onEdit: () => _startEdit(cat),
                      onConfirmEdit: _confirmEdit,
                      onCancelEdit: _cancelEdit,
                      onDelete: () => _showDeleteSheet(cat),
                      onMoveUp: index > 0
                          ? () => _moveCategory(index, -1)
                          : null,
                      onMoveDown: index < _categories.length - 1
                          ? () => _moveCategory(index, 1)
                          : null,
                    ),
                  );
                },
              ),
            ],
            if (_categories.isEmpty && !_addMode)
              _EmptyState(onAdd: () => setState(() => _addMode = true)),
          ],
        ),
      ),
    );
  }
}
