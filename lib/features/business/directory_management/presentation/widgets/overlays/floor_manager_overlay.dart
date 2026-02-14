import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/directory_management/domain/entities/directory_floor.dart';

/// Overlay for managing floors — reorderable list with add/edit/delete.
class FloorManagerOverlay extends StatefulWidget {
  final List<DirectoryFloor> floors;
  final VoidCallback onClose;
  final ValueChanged<List<DirectoryFloor>> onSave;

  const FloorManagerOverlay({
    super.key,
    required this.floors,
    required this.onClose,
    required this.onSave,
  });

  @override
  State<FloorManagerOverlay> createState() => _FloorManagerOverlayState();
}

class _FloorManagerOverlayState extends State<FloorManagerOverlay> {
  late List<DirectoryFloor> _floors;
  bool _isEditing = false;
  int? _editIndex;
  final _nameController = TextEditingController();
  final _labelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _floors = List.from(widget.floors);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  void _moveFloor(int index, int direction) {
    final newIdx = index + direction;
    if (newIdx < 0 || newIdx >= _floors.length) return;
    setState(() {
      final floor = _floors.removeAt(index);
      _floors.insert(newIdx, floor);
    });
  }

  void _startEdit(int index) {
    final floor = _floors[index];
    _nameController.text = floor.name;
    _labelController.text = floor.label ?? '';
    setState(() {
      _isEditing = true;
      _editIndex = index;
    });
  }

  void _startAdd() {
    _nameController.clear();
    _labelController.clear();
    setState(() {
      _isEditing = true;
      _editIndex = null;
    });
  }

  void _saveEdit() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    setState(() {
      if (_editIndex != null) {
        _floors[_editIndex!] = _floors[_editIndex!].copyWith(
          name: name,
          label: _labelController.text.trim().isEmpty
              ? null
              : _labelController.text.trim(),
        );
      } else {
        _floors.add(DirectoryFloor(
          id: 'floor_new_${DateTime.now().millisecondsSinceEpoch}',
          name: name,
          label: _labelController.text.trim().isEmpty
              ? null
              : _labelController.text.trim(),
        ));
      }
      _isEditing = false;
      _editIndex = null;
    });
  }

  void _cancelEdit() {
    setState(() {
      _isEditing = false;
      _editIndex = null;
    });
  }

  void _deleteFloor(int index) {
    final floor = _floors[index];
    if (floor.tenantCount > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('لا يمكن حذف "${floor.name}" — يحتوي على مستأجرين'),
        ),
      );
      return;
    }
    setState(() => _floors.removeAt(index));
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
          'إدارة الطوابق',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => widget.onSave(_floors),
            child: const Text('حفظ'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Edit form
          if (_isEditing)
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
                      _editIndex != null ? 'تعديل طابق' : 'طابق جديد',
                      style: context.textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'اسم الطابق (مثال: الطابق الأرضي)',
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
                    const SizedBox(height: AppSpacing.sm),
                    TextField(
                      controller: _labelController,
                      decoration: InputDecoration(
                        hintText: 'تسمية مختصرة (اختياري، مثال: أرضي)',
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
                        TextButton(
                          onPressed: _cancelEdit,
                          child: const Text('إلغاء'),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        ElevatedButton(
                          onPressed: _saveEdit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Theme.of(context).colorScheme.surface,
                          ),
                          child: Text(
                            _editIndex != null ? 'تحديث' : 'إضافة',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          // Floor list
          Expanded(
            child: _floors.isEmpty
                ? Center(
                    child: Text(
                      'لا توجد طوابق',
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: _floors.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (_, i) {
                      final floor = _floors[i];
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
                            // Reorder buttons
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _ArrowBtn(
                                  icon: Icons.arrow_upward,
                                  enabled: i > 0,
                                  onTap: () => _moveFloor(i, -1),
                                ),
                                const SizedBox(height: 2),
                                _ArrowBtn(
                                  icon: Icons.arrow_downward,
                                  enabled: i < _floors.length - 1,
                                  onTap: () => _moveFloor(i, 1),
                                ),
                              ],
                            ),
                            const SizedBox(width: AppSpacing.md),

                            // Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    floor.name,
                                    style: context.textTheme.titleSmall,
                                  ),
                                  if (floor.label != null)
                                    Text(
                                      floor.label!,
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(
                                        color: context
                                            .colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  Text(
                                    '${floor.tenantCount} مستأجر',
                                    style:
                                        context.textTheme.labelSmall?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Actions
                            IconButton(
                              icon: const Icon(Icons.edit_outlined, size: 18),
                              onPressed: () => _startEdit(i),
                              visualDensity: VisualDensity.compact,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                                size: 18,
                                color: floor.tenantCount > 0
                                    ? Theme.of(context).colorScheme.outline
                                    : AppColors.error,
                              ),
                              onPressed: () => _deleteFloor(i),
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // Add button
          if (!_isEditing)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _startAdd,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('إضافة طابق'),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ArrowBtn extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _ArrowBtn({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: enabled
              ? AppColors.primary.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 14,
          color: enabled ? AppColors.primary : Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
    );
  }
}
