import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/add_block_form.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/availability_data.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/blocked_dates_calendar.dart';

// ═══════════════════════════════════════════════════════════════════
// Blocked Dates Tab — add/view/remove date blocks
// Matches Figma BlockedDatesTab pixel-for-pixel.
// ═══════════════════════════════════════════════════════════════════

class BlockedDatesTab extends StatefulWidget {
  final List<BlockedDate> blocks;
  final ValueChanged<List<BlockedDate>> onChange;

  const BlockedDatesTab({
    super.key,
    required this.blocks,
    required this.onChange,
  });

  @override
  State<BlockedDatesTab> createState() => _BlockedDatesTabState();
}

class _BlockedDatesTabState extends State<BlockedDatesTab> {
  String? _addMode; // 'specific' | 'range' | 'recurring' | null
  DateTime _calendarMonth = DateTime(2026, 2);

  void _removeBlock(String id) {
    widget.onChange(widget.blocks.where((b) => b.id != id).toList());
  }

  void _addBlock(BlockedDate block) {
    widget.onChange([...widget.blocks, block]);
    setState(() => _addMode = null);
  }

  @override
  Widget build(BuildContext context) {
    final recurring =
        widget.blocks.where((b) => b.type == 'recurring').toList();
    final specific =
        widget.blocks.where((b) => b.type == 'specific').toList();
    final ranges = widget.blocks.where((b) => b.type == 'range').toList();

    return Column(
      children: [
        // Mini calendar
        MiniBlockedCalendar(
          month: _calendarMonth,
          blocks: widget.blocks,
          onPrev: () => setState(() => _calendarMonth =
              DateTime(_calendarMonth.year, _calendarMonth.month - 1)),
          onNext: () => setState(() => _calendarMonth =
              DateTime(_calendarMonth.year, _calendarMonth.month + 1)),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Add block buttons (hidden when form is open)
        if (_addMode == null) ...[
          Row(
            children: [
              _addBlockButton('recurring', Icons.repeat,
                  AppColors.secondary, 'يوم أسبوعي'),
              const SizedBox(width: AppSpacing.sm),
              _addBlockButton(
                  'specific', Icons.event_busy, AppColors.error, 'يوم محدد'),
              const SizedBox(width: AppSpacing.sm),
              _addBlockButton('range', Icons.date_range,
                  const Color(0xFF7B1FA2), 'فترة زمنية'),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
        ],

        // Add block form
        if (_addMode != null) ...[
          AddBlockForm(
            mode: _addMode!,
            onAdd: _addBlock,
            onCancel: () => setState(() => _addMode = null),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],

        // Grouped block lists
        if (recurring.isNotEmpty)
          _blockGroup('recurring', Icons.repeat, recurring),
        if (specific.isNotEmpty)
          _blockGroup('specific', Icons.event_busy, specific),
        if (ranges.isNotEmpty) _blockGroup('range', Icons.date_range, ranges),

        // Empty state
        if (widget.blocks.isEmpty && _addMode == null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
            child: Column(
              children: [
                const Icon(Icons.calendar_today,
                    size: 40, color: AppColors.divider),
                const SizedBox(height: AppSpacing.md),
                const Text('لا يوجد تواريخ محظورة',
                    style:
                        TextStyle(fontSize: 14, color: AppColors.textHint)),
                const SizedBox(height: AppSpacing.xs),
                Text('أضف حظر لأيام أو فترات لا تستقبل فيها طلبات',
                    style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textHint.withValues(alpha: 0.6))),
              ],
            ),
          ),

        // Info box
        if (widget.blocks.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: const Color(0xFFBBDEFB)),
            ),
            child: const Text(
              'التواريخ المحظورة تلغي الجدول الأسبوعي — العملاء لن '
              'يتمكنوا من الحجز في هذه الأوقات.',
              style: TextStyle(fontSize: 10, color: AppColors.primary),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ],
    );
  }

  Widget _addBlockButton(
      String mode, IconData icon, Color color, String label) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _addMode = mode),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: context.colorScheme.outlineVariant),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(height: AppSpacing.sm),
              Text(label,
                  style: const TextStyle(
                      fontSize: 10, color: AppColors.textSecondary)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _blockGroup(
      String type, IconData icon, List<BlockedDate> blocks) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(groupLabels[type]!,
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textSecondary)),
              const SizedBox(width: 6),
              Icon(icon, size: 12, color: blockColors[type]),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final block in blocks) ...[
            _BlockCard(block: block, onRemove: _removeBlock),
            const SizedBox(height: 6),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// Block Card
// ═══════════════════════════════════════════════════════════════════

class _BlockCard extends StatelessWidget {
  final BlockedDate block;
  final ValueChanged<String> onRemove;

  const _BlockCard({required this.block, required this.onRemove});

  String get _description {
    switch (block.type) {
      case 'recurring':
        final day =
            weekdays.where((d) => d.id == block.weekday).firstOrNull;
        return 'كل ${day?.label ?? block.weekday}';
      case 'specific':
        return formatBlockDate(block.date ?? '');
      case 'range':
        return '${formatBlockDate(block.startDate ?? '')} — ${formatBlockDate(block.endDate ?? '')}';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: context.colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onRemove(block.id),
            child: const Icon(Icons.delete_outline,
                size: 14, color: AppColors.textHint),
          ),
          const Spacer(),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(_description,
                    style: TextStyle(
                        fontSize: 14,
                        color: context.colorScheme.onSurface),
                    overflow: TextOverflow.ellipsis),
                if (block.reason != null && block.reason!.isNotEmpty)
                  Text(block.reason!,
                      style: const TextStyle(
                          fontSize: 10, color: AppColors.textHint)),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Icon(blockIcons[block.type],
              size: 14, color: blockColors[block.type]),
        ],
      ),
    );
  }
}
