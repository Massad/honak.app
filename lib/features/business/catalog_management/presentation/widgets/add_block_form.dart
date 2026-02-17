import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/availability_data.dart';

// ═══════════════════════════════════════════════════════════════════
// Add Block Form — form for creating a blocked date (recurring,
// specific, or range). Colored border per type.
// Matches Figma AddBlockForm pixel-for-pixel.
// ═══════════════════════════════════════════════════════════════════

class AddBlockForm extends StatefulWidget {
  final String mode; // 'specific' | 'range' | 'recurring'
  final ValueChanged<BlockedDate> onAdd;
  final VoidCallback onCancel;

  const AddBlockForm({
    super.key,
    required this.mode,
    required this.onAdd,
    required this.onCancel,
  });

  @override
  State<AddBlockForm> createState() => _AddBlockFormState();
}

class _AddBlockFormState extends State<AddBlockForm> {
  String _weekday = 'fri';
  DateTime? _date;
  DateTime? _startDate;
  DateTime? _endDate;
  final _reasonCtrl = TextEditingController();

  bool get _canSave {
    switch (widget.mode) {
      case 'specific':
        return _date != null;
      case 'range':
        return _startDate != null && _endDate != null;
      case 'recurring':
        return true;
      default:
        return false;
    }
  }

  void _handleAdd() {
    if (!_canSave) return;
    final reason =
        _reasonCtrl.text.trim().isNotEmpty ? _reasonCtrl.text.trim() : null;
    final id = 'b${DateTime.now().millisecondsSinceEpoch}';
    switch (widget.mode) {
      case 'specific':
        widget.onAdd(BlockedDate(
            id: id,
            type: 'specific',
            date: formatIso(_date!),
            reason: reason));
      case 'range':
        widget.onAdd(BlockedDate(
            id: id,
            type: 'range',
            startDate: formatIso(_startDate!),
            endDate: formatIso(_endDate!),
            reason: reason));
      case 'recurring':
        widget.onAdd(BlockedDate(
            id: id, type: 'recurring', weekday: _weekday, reason: reason));
    }
  }

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final initial =
        isStart ? (_startDate ?? now) : (_endDate ?? _startDate ?? now);
    final result = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
      locale: const Locale('ar'),
    );
    if (result == null) return;
    setState(() {
      if (widget.mode == 'specific') {
        _date = result;
      } else if (isStart) {
        _startDate = result;
        if (_endDate != null && _endDate!.isBefore(result)) _endDate = null;
      } else {
        _endDate = result;
      }
    });
  }

  @override
  void dispose() {
    _reasonCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = blockColors[widget.mode]!;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Header
          Row(
            children: [
              GestureDetector(
                onTap: widget.onCancel,
                child: const Icon(Icons.close,
                    size: 16, color: AppColors.textHint),
              ),
              const Spacer(),
              Text(formLabels[widget.mode]!,
                  style: TextStyle(
                      fontSize: 14,
                      color: context.colorScheme.onSurface)),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Mode-specific content
          if (widget.mode == 'recurring') _buildRecurringForm(),
          if (widget.mode == 'specific') _buildSpecificForm(),
          if (widget.mode == 'range') _buildRangeForm(),
          const SizedBox(height: AppSpacing.md),

          // Reason
          Text(context.l10n.blockReasonOptional,
              style:
                  const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _reasonCtrl,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              hintText: context.l10n.blockReasonHint,
              hintStyle:
                  const TextStyle(fontSize: 12, color: AppColors.textHint),
              filled: true,
              fillColor: context.colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                borderSide:
                    BorderSide(color: context.colorScheme.outlineVariant),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                borderSide:
                    BorderSide(color: context.colorScheme.outlineVariant),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
              isDense: true,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Actions
          Row(
            textDirection: TextDirection.ltr,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: widget.onCancel,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    alignment: Alignment.center,
                    child: Text(context.l10n.cancel,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textSecondary)),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: _canSave ? _handleAdd : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color:
                          _canSave ? AppColors.primary : AppColors.divider,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.l10n.blockAdd,
                            style: TextStyle(
                                fontSize: 12,
                                color: _canSave
                                    ? Colors.white
                                    : AppColors.textHint)),
                        const SizedBox(width: 4),
                        Icon(Icons.add,
                            size: 14,
                            color: _canSave
                                ? Colors.white
                                : AppColors.textHint),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecurringForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(context.l10n.blockChooseDay,
            style:
                const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: weekdays.map((day) {
            final isActive = _weekday == day.id;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _weekday = day.id),
                child: Container(
                  margin: EdgeInsetsDirectional.only(
                      start: day.id == weekdays.first.id ? 0 : 4),
                  padding:
                      const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.secondary
                        : AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  alignment: Alignment.center,
                  child: Text(day.short,
                      style: TextStyle(
                          fontSize: 10,
                          color: isActive
                              ? Colors.white
                              : AppColors.textSecondary)),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          context.l10n.blockRecurringInfo(weekdays.where((d) => d.id == _weekday).first.label),
          style: const TextStyle(fontSize: 10, color: AppColors.textHint),
        ),
      ],
    );
  }

  Widget _buildSpecificForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(context.l10n.blockDate,
            style:
                const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        const SizedBox(height: AppSpacing.sm),
        _datePickerButton(
          _date != null
              ? '${_date!.day} ${arabicMonths[_date!.month - 1]} ${_date!.year}'
              : context.l10n.blockChooseDate,
          () => _pickDate(isStart: true),
        ),
      ],
    );
  }

  Widget _buildRangeForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(context.l10n.blockFrom,
            style:
                const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        const SizedBox(height: AppSpacing.sm),
        _datePickerButton(
          _startDate != null
              ? '${_startDate!.day} ${arabicMonths[_startDate!.month - 1]} ${_startDate!.year}'
              : context.l10n.blockStartDate,
          () => _pickDate(isStart: true),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(context.l10n.blockTo,
            style:
                const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        const SizedBox(height: AppSpacing.sm),
        _datePickerButton(
          _endDate != null
              ? '${_endDate!.day} ${arabicMonths[_endDate!.month - 1]} ${_endDate!.year}'
              : context.l10n.blockEndDate,
          () => _pickDate(isStart: false),
        ),
      ],
    );
  }

  Widget _datePickerButton(String label, VoidCallback onTap) {
    final hasValue =
        !label.startsWith('اختر') && !label.startsWith('تاريخ');
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: 10),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: context.colorScheme.outlineVariant),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today,
                size: 14, color: AppColors.textHint),
            const Spacer(),
            Text(label,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    fontSize: 13,
                    color: hasValue
                        ? context.colorScheme.onSurface
                        : AppColors.textHint)),
          ],
        ),
      ),
    );
  }
}
