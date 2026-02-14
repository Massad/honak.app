import 'package:flutter/material.dart';

import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/intake_question.dart';

/// Expanded editor for a single intake question.
/// Shows question text, field type selector, options, required toggle, delete.
class IntakeQuestionEditor extends StatefulWidget {
  final IntakeQuestion question;
  final ValueChanged<IntakeQuestion> onUpdate;
  final VoidCallback onRemove;

  const IntakeQuestionEditor({
    super.key,
    required this.question,
    required this.onUpdate,
    required this.onRemove,
  });

  @override
  State<IntakeQuestionEditor> createState() => _IntakeQuestionEditorState();
}

class _IntakeQuestionEditorState extends State<IntakeQuestionEditor> {
  late final TextEditingController _questionCtrl;
  final _optionCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _questionCtrl =
        TextEditingController(text: widget.question.question);
  }

  @override
  void dispose() {
    _questionCtrl.dispose();
    _optionCtrl.dispose();
    super.dispose();
  }

  bool get _hasOptions => widget.question.fieldType == 'select';

  void _addOption() {
    final text = _optionCtrl.text.trim();
    if (text.isEmpty) return;
    widget.onUpdate(widget.question.copyWith(
      options: [...widget.question.options, text],
    ));
    _optionCtrl.clear();
  }

  void _removeOption(int index) {
    final opts = List<String>.from(widget.question.options);
    opts.removeAt(index);
    widget.onUpdate(widget.question.copyWith(options: opts));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Question text
        TextField(
          controller: _questionCtrl,
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            hintText: 'نص السؤال',
            hintStyle:
                TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            isDense: true,
          ),
          onChanged: (v) => widget.onUpdate(
            widget.question.copyWith(question: v),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Field type selector
        const Text(
          'نوع الحقل',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          alignment: WrapAlignment.end,
          children: [
            _FieldTypeChip(
              label: 'نص',
              icon: Icons.text_fields,
              isSelected: widget.question.fieldType == 'text',
              onTap: () => widget.onUpdate(
                widget.question
                    .copyWith(fieldType: 'text', options: []),
              ),
            ),
            _FieldTypeChip(
              label: 'اختيار',
              icon: Icons.list_alt,
              isSelected: widget.question.fieldType == 'select',
              onTap: () => widget.onUpdate(
                widget.question.copyWith(fieldType: 'select'),
              ),
            ),
            _FieldTypeChip(
              label: 'رقم',
              icon: Icons.pin_outlined,
              isSelected: widget.question.fieldType == 'number',
              onTap: () => widget.onUpdate(
                widget.question
                    .copyWith(fieldType: 'number', options: []),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // Options editor (for select type only)
        if (_hasOptions) ...[
          const Text(
            'الخيارات',
            style:
                TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: AppSpacing.sm),
          for (var i = 0; i < widget.question.options.length; i++)
            Padding(
              padding:
                  const EdgeInsetsDirectional.only(bottom: 6),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.red.shade300,
                    ),
                    onPressed: () => _removeOption(i),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                      ),
                      child: Text(
                        widget.question.options[i],
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          // Add option field
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 18,
                  color: AppColors.primary,
                ),
                onPressed: _addOption,
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: TextField(
                  controller: _optionCtrl,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    hintText: 'أضف خيار جديد',
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    isDense: true,
                  ),
                  onSubmitted: (_) => _addOption(),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // Required toggle
        Row(
          children: [
            SizedBox(
              height: 28,
              child: Switch(
                value: widget.question.isRequired,
                onChanged: (v) => widget.onUpdate(
                  widget.question.copyWith(isRequired: v),
                ),
                activeThumbColor: AppColors.primary,
                materialTapTargetSize:
                    MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const Spacer(),
            const Text('إجابة إلزامية',
                style: TextStyle(fontSize: 12)),
          ],
        ),

        const Divider(height: AppSpacing.xxl),

        // Delete button
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton.icon(
            onPressed: widget.onRemove,
            icon: const Icon(Icons.delete_outline, size: 16),
            label: const Text(
              'حذف السؤال',
              style: TextStyle(fontSize: 12),
            ),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.error,
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Field Type Chip ──────────────────────────────────────────────────────────

class _FieldTypeChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _FieldTypeChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.08)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.3)
                : Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight:
                    isSelected ? FontWeight.w500 : FontWeight.normal,
                color: isSelected ? AppColors.primary : null,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              icon,
              size: 14,
              color: isSelected
                  ? AppColors.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
