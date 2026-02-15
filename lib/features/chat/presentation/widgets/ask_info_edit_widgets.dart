import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/chat_info_template_item.dart';

/// Returns the appropriate icon for a given template item type.
IconData infoItemTypeIcon(String type) => switch (type) {
      'photo' => Icons.camera_alt_outlined,
      'video' => Icons.videocam_outlined,
      'location' => Icons.location_on_outlined,
      'document' => Icons.description_outlined,
      'choice' => Icons.list_outlined,
      _ => Icons.text_fields,
    };

// ═══════════════════════════════════════════════════════════════
// Edit Item Card — Collapsible, matching Figma design
// ═══════════════════════════════════════════════════════════════

/// A collapsible card for editing a single info-template item.
///
/// Collapsed: label + type/required chip badges + delete icon.
/// Expanded: editable description, type picker, choice options as
/// removable chips with "add option" input.
class EditItemCard extends StatefulWidget {
  final ChatInfoTemplateItem item;
  final int index;
  final int totalCount;
  final ValueChanged<ChatInfoTemplateItem> onUpdate;
  final VoidCallback onRemove;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;

  const EditItemCard({
    super.key,
    required this.item,
    required this.index,
    required this.totalCount,
    required this.onUpdate,
    required this.onRemove,
    this.onMoveUp,
    this.onMoveDown,
  });

  @override
  State<EditItemCard> createState() => _EditItemCardState();
}

class _EditItemCardState extends State<EditItemCard> {
  late TextEditingController _labelController;
  late TextEditingController _descController;
  final _addOptionController = TextEditingController();
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController(text: widget.item.labelAr);
    _descController =
        TextEditingController(text: widget.item.descriptionAr ?? '');
  }

  @override
  void didUpdateWidget(covariant EditItemCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.id != widget.item.id) {
      _labelController.text = widget.item.labelAr;
      _descController.text = widget.item.descriptionAr ?? '';
    }
  }

  @override
  void dispose() {
    _labelController.dispose();
    _descController.dispose();
    _addOptionController.dispose();
    super.dispose();
  }

  void _commitLabel() {
    final text = _labelController.text.trim();
    if (text != widget.item.labelAr) {
      widget.onUpdate(widget.item.copyWith(labelAr: text));
    }
  }

  void _commitDescription() {
    final text = _descController.text.trim();
    final desc = text.isEmpty ? null : text;
    if (desc != widget.item.descriptionAr) {
      widget.onUpdate(widget.item.copyWith(descriptionAr: desc ?? ''));
    }
  }

  static const _typeLabels = <String, String>{
    'text': 'نص',
    'photo': 'صورة',
    'video': 'فيديو',
    'location': 'موقع',
    'document': 'مستند',
    'choice': 'اختيار',
  };

  void _selectType(String type) {
    if (type != widget.item.type) {
      widget.onUpdate(widget.item.copyWith(type: type));
    }
  }

  void _updateOption(int index, String value) {
    final opts = List<String>.from(widget.item.optionsAr ?? []);
    if (index < opts.length) {
      opts[index] = value;
      widget.onUpdate(widget.item.copyWith(optionsAr: opts));
    }
  }

  void _removeOption(int index) {
    final opts = List<String>.from(widget.item.optionsAr ?? []);
    if (index < opts.length) {
      opts.removeAt(index);
      widget.onUpdate(
          widget.item.copyWith(optionsAr: opts.isEmpty ? null : opts));
    }
  }

  void _addOption() {
    final text = _addOptionController.text.trim();
    if (text.isEmpty) return;
    final opts = (widget.item.optionsAr ?? [])
        .where((o) => o.trim().isNotEmpty)
        .toList();
    if (opts.length >= InfoRequestLimits.maxOptionsPerItem) return;
    opts.add(text);
    widget.onUpdate(widget.item.copyWith(optionsAr: opts));
    _addOptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    final error = widget.item.validationError;
    final hasError = error != null;

    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: hasError ? AppColors.error.withValues(alpha: 0.5) : cs.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderRow(cs, hasError: hasError),
          if (_expanded) ...[
            Divider(height: 1, color: cs.outlineVariant),
            _buildExpandedContent(cs),
          ],
          if (hasError && !_expanded)
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: AppSpacing.md + 28,
                bottom: AppSpacing.xs,
              ),
              child: Text(
                error,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.error,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeaderRow(ColorScheme cs, {bool hasError = false}) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            // Expand/collapse chevron
            Icon(
              _expanded ? Icons.expand_less : Icons.expand_more,
              size: 20,
              color: cs.onSurfaceVariant,
            ),
            const SizedBox(width: AppSpacing.xs),
            // Label (always plain text — editable in expanded content)
            Expanded(
              child: Text(
                widget.item.labelAr.isEmpty
                    ? 'عنصر جديد'
                    : widget.item.labelAr,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: widget.item.labelAr.isEmpty
                      ? cs.onSurfaceVariant
                      : cs.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (hasError) ...[
              const SizedBox(width: AppSpacing.xs),
              const Icon(Icons.error_outline,
                  size: 16, color: AppColors.error),
            ],
            const SizedBox(width: AppSpacing.xs),
            // Chip badges
            ..._buildBadges(cs),
            const SizedBox(width: AppSpacing.xs),
            // Delete
            GestureDetector(
              onTap: widget.onRemove,
              child: Icon(Icons.delete_outline,
                  size: 18, color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBadges(ColorScheme cs) {
    return [
      // Type badge (read-only indicator — picker is in expanded content)
      _Chip(
        icon: infoItemTypeIcon(widget.item.type),
        label: _typeLabels[widget.item.type] ?? widget.item.type,
        color: AppColors.warning,
      ),
      const SizedBox(width: 4),
      // Required/optional badge
      GestureDetector(
        onTap: () => widget.onUpdate(
          widget.item.copyWith(required: !widget.item.required),
        ),
        child: _Chip(
          label: widget.item.required ? 'إلزامي' : 'اختياري',
          color: widget.item.required ? AppColors.error : cs.onSurfaceVariant,
        ),
      ),
    ];
  }

  /// Expanded content — order: title → description → type picker → options (if choice).
  Widget _buildExpandedContent(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title ──
          TextField(
            controller: _labelController,
            onChanged: (_) => _commitLabel(),
            maxLength: InfoRequestLimits.maxTitleLength,
            decoration: InputDecoration(
              hintText: 'اسم العنصر',
              hintStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 14),
              filled: true,
              fillColor: cs.surfaceContainerLowest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              isDense: true,
              counterText: '',
            ),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: AppSpacing.sm),
          // ── Description ──
          TextField(
            controller: _descController,
            onChanged: (_) => _commitDescription(),
            maxLength: InfoRequestLimits.maxDescriptionLength,
            decoration: InputDecoration(
              hintText: 'وصف (اختياري)',
              hintStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
              filled: true,
              fillColor: cs.surfaceContainerLowest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              isDense: true,
              counterText: '',
            ),
            style: const TextStyle(fontSize: 12),
          ),
          // ── Type picker pills ──
          const SizedBox(height: AppSpacing.md),
          Text(
            'نوع المعلومة:',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: _typeLabels.entries.map((entry) {
              final isSelected = widget.item.type == entry.key;
              return GestureDetector(
                onTap: () => _selectType(entry.key),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.warning
                        : cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.warning
                          : cs.outlineVariant,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        infoItemTypeIcon(entry.key),
                        size: 14,
                        color: isSelected
                            ? Colors.white
                            : cs.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        entry.value,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : cs.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          // ── Choice options (editable text fields + add input) ──
          if (widget.item.type == 'choice') ...[
            const SizedBox(height: AppSpacing.md),
            for (var i = 0;
                i < (widget.item.optionsAr?.length ?? 0);
                i++)
              Padding(
                padding:
                    const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
                child: Row(
                  children: [
                    Expanded(
                      child: _OptionTextField(
                        key: ValueKey('${widget.item.id}_opt_$i'),
                        initialValue: widget.item.optionsAr![i],
                        maxLength: InfoRequestLimits.maxOptionLength,
                        onChanged: (val) => _updateOption(i, val),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    GestureDetector(
                      onTap: () => _removeOption(i),
                      child: Icon(Icons.close,
                          size: 18, color: cs.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            if ((widget.item.optionsAr?.length ?? 0) <
                InfoRequestLimits.maxOptionsPerItem)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _addOptionController,
                      onSubmitted: (_) => _addOption(),
                      maxLength: InfoRequestLimits.maxOptionLength,
                      decoration: InputDecoration(
                        hintText: 'أضف خيار...',
                        hintStyle: TextStyle(
                            color: cs.onSurfaceVariant, fontSize: 12),
                        filled: true,
                        fillColor: cs.surfaceContainerLowest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsetsDirectional.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        isDense: true,
                        counterText: '',
                      ),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  GestureDetector(
                    onTap: _addOption,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.warning,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.add,
                          size: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Small shared widgets
// ═══════════════════════════════════════════════════════════════

/// Compact chip badge (type, required/optional).
class _Chip extends StatelessWidget {
  final IconData? icon;
  final String label;
  final Color color;

  const _Chip({this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 3),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// Editable text field for a single choice option.
class _OptionTextField extends StatefulWidget {
  final String initialValue;
  final int? maxLength;
  final ValueChanged<String> onChanged;

  const _OptionTextField({
    super.key,
    required this.initialValue,
    this.maxLength,
    required this.onChanged,
  });

  @override
  State<_OptionTextField> createState() => _OptionTextFieldState();
}

class _OptionTextFieldState extends State<_OptionTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant _OptionTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue &&
        _controller.text != widget.initialValue) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    return TextField(
      controller: _controller,
      onChanged: (val) => widget.onChanged(val.trim()),
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        filled: true,
        fillColor: cs.surfaceContainerLowest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        isDense: true,
        counterText: '',
      ),
      style: const TextStyle(fontSize: 12),
    );
  }
}

/// Small arrow button used for reordering items in edit mode.
class ReorderArrow extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const ReorderArrow({
    super.key,
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
          color: enabled
              ? AppColors.primary
              : Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
    );
  }
}
