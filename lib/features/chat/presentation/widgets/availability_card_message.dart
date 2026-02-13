import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/message.dart';
import 'package:honak/features/chat/domain/entities/power_chat_types.dart';

class AvailabilityCardMessage extends StatefulWidget {
  final Message message;
  final bool isBusinessMode;

  const AvailabilityCardMessage({
    super.key,
    required this.message,
    this.isBusinessMode = false,
  });

  @override
  State<AvailabilityCardMessage> createState() =>
      _AvailabilityCardMessageState();
}

class _AvailabilityCardMessageState extends State<AvailabilityCardMessage> {
  late String _status;
  String? _selectedSlotId;

  @override
  void initState() {
    super.initState();
    final data = AvailabilityCardData.fromMetadata(widget.message.metadata);
    _status = data.status;
    _selectedSlotId = data.selectedSlotId;
  }

  AvailabilityCardData get _data =>
      AvailabilityCardData.fromMetadata(widget.message.metadata);

  Color get _borderColor => switch (_status) {
        'selected' => AppColors.success,
        'expired' => AppColors.textHint,
        _ => AppColors.success,
      };

  Color get _bgColor => switch (_status) {
        'expired' => AppColors.background,
        _ => AppColors.success.withValues(alpha: 0.04),
      };

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _status == 'expired' ? 0.7 : 1.0,
      child: Container(
        margin: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: _bgColor,
          border: Border.all(
            color: _borderColor.withValues(alpha: 0.25),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSlots(),
            if (_status == 'selected') _buildSelectedBadge(),
            if (_status == 'expired') _buildExpiredBadge(),
            _buildTimestamp(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final label = widget.isBusinessMode
        ? 'تم إرسال أوقات متاحة'
        : 'أوقات متاحة';

    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: _borderColor.withValues(alpha: 0.06),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.schedule, size: 16, color: _borderColor),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _borderColor,
              ),
            ),
          ),
          if (_data.serviceName != null)
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 6,
                vertical: 1,
              ),
              decoration: BoxDecoration(
                color: _borderColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                _data.serviceName!,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: _borderColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSlots() {
    // Group slots by date
    final grouped = <String, List<AvailabilitySlot>>{};
    for (final slot in _data.slots) {
      grouped.putIfAbsent(slot.date, () => []).add(slot);
    }

    return Padding(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: grouped.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: entry.value.map((slot) {
                  final isSelected = _selectedSlotId == slot.id;
                  return _SlotChip(
                    slot: slot,
                    isSelected: isSelected,
                    isDisabled:
                        widget.isBusinessMode || _status == 'expired',
                    onTap: (!widget.isBusinessMode &&
                            _status != 'expired')
                        ? () => _selectSlot(slot)
                        : null,
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _selectSlot(AvailabilitySlot slot) {
    setState(() {
      _selectedSlotId = slot.id;
      _status = 'selected';
    });
  }

  Widget _buildSelectedBadge() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline, size: 16, color: AppColors.success),
          SizedBox(width: AppSpacing.xs),
          Text(
            'تم الاختيار',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpiredBadge() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.textHint.withValues(alpha: 0.1),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.timer_off_outlined, size: 16, color: AppColors.textHint),
          SizedBox(width: AppSpacing.xs),
          Text(
            'انتهت الصلاحية',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimestamp() {
    final date =
        DateTime.fromMillisecondsSinceEpoch(widget.message.createdAt * 1000);
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final period = date.hour < 12 ? 'ص' : 'م';
    final time =
        '$hour:${date.minute.toString().padLeft(2, '0')} $period';

    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.md,
        end: AppSpacing.md,
        bottom: AppSpacing.sm,
      ),
      child: Text(
        time,
        style: const TextStyle(
          fontSize: 10,
          color: AppColors.textHint,
        ),
      ),
    );
  }
}

class _SlotChip extends StatelessWidget {
  final AvailabilitySlot slot;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback? onTap;

  const _SlotChip({
    required this.slot,
    required this.isSelected,
    required this.isDisabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.success : AppColors.textSecondary;
    final bg = isSelected
        ? AppColors.success.withValues(alpha: 0.12)
        : AppColors.surfaceVariant;

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: bg,
          border: Border.all(
            color: isSelected
                ? AppColors.success
                : AppColors.divider,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              slot.time,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
            if (slot.teamMember != null) ...[
              const SizedBox(height: 1),
              Text(
                slot.teamMember!,
                style: TextStyle(
                  fontSize: 10,
                  color: color.withValues(alpha: 0.7),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
