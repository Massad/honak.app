import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/power_chat_types.dart';
import 'package:honak/shared/widgets/button.dart';

class AvailabilityPickerSheet extends StatefulWidget {
  final void Function(
    List<AvailabilitySlot> slots,
    String? serviceName,
  ) onSend;

  const AvailabilityPickerSheet({super.key, required this.onSend});

  @override
  State<AvailabilityPickerSheet> createState() =>
      _AvailabilityPickerSheetState();
}

class _AvailabilityPickerSheetState extends State<AvailabilityPickerSheet> {
  final _serviceController = TextEditingController();
  int _selectedDayIndex = 0; // 0=today, 1=tomorrow, 2=day after
  final Set<int> _selectedHours = {};

  static const _hourPresets = [9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];

  @override
  void dispose() {
    _serviceController.dispose();
    super.dispose();
  }

  DateTime get _selectedDate =>
      DateTime.now().add(Duration(days: _selectedDayIndex));

  String _dayLabel(int index) {
    return switch (index) {
      0 => 'اليوم',
      1 => 'غداً',
      _ => 'بعد غداً',
    };
  }

  String _formatDate(DateTime date) {
    const months = [
      'كانون الثاني',
      'شباط',
      'آذار',
      'نيسان',
      'أيار',
      'حزيران',
      'تموز',
      'آب',
      'أيلول',
      'تشرين الأول',
      'تشرين الثاني',
      'كانون الأول',
    ];
    const days = [
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];
    return '${days[date.weekday - 1]} ${date.day} ${months[date.month - 1]}';
  }

  String _formatHour(int hour) {
    final h = hour % 12 == 0 ? 12 : hour % 12;
    final period = hour < 12 ? 'ص' : 'م';
    return '$h:00 $period';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHandle(),
        _buildHeader(context),
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildServiceInput(),
                const SizedBox(height: AppSpacing.lg),
                _buildDaySelector(),
                const SizedBox(height: AppSpacing.lg),
                _buildTimeGrid(),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
        _buildSendButton(context),
      ],
    );
  }

  Widget _buildHandle() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: AppSpacing.sm),
      child: Container(
        width: 36,
        height: 4,
        decoration: BoxDecoration(
          color: context.colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.lg,
        end: AppSpacing.sm,
        top: AppSpacing.md,
        bottom: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'أوقات متاحة',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onSurface,
              ),
            ),
          ),
          Button(
            onPressed: () => Navigator.pop(context),
            icon: ButtonIcon(Icons.close, size: 20, color: context.colorScheme.onSurfaceVariant),
            variant: Variant.text,
            size: ButtonSize.small,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اسم الخدمة (اختياري)',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: _serviceController,
          decoration: InputDecoration(
            hintText: 'مثل: قص شعر، كشف طبي...',
            hintStyle: TextStyle(
              color: context.colorScheme.onSurfaceVariant,
              fontSize: 14,
            ),
            filled: true,
            fillColor: context.colorScheme.surfaceContainerLowest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            isDense: true,
          ),
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildDaySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اختر اليوم',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: List.generate(3, (i) {
            final isSelected = _selectedDayIndex == i;
            final date = DateTime.now().add(Duration(days: i));
            return Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  end: i < 2 ? AppSpacing.sm : 0,
                ),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedDayIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsetsDirectional.symmetric(
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.success.withValues(alpha: 0.1)
                          : context.colorScheme.surfaceContainerLow,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.success
                            : context.colorScheme.outlineVariant,
                        width: isSelected ? 1.5 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _dayLabel(i),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? AppColors.success
                                : context.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${date.day}/${date.month}',
                          style: TextStyle(
                            fontSize: 11,
                            color: isSelected
                                ? AppColors.success
                                : context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTimeGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اختر الأوقات',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 2.2,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
          ),
          itemCount: _hourPresets.length,
          itemBuilder: (context, index) {
            final hour = _hourPresets[index];
            final isSelected = _selectedHours.contains(hour);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedHours.remove(hour);
                  } else {
                    _selectedHours.add(hour);
                  }
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.success.withValues(alpha: 0.12)
                      : context.colorScheme.surfaceContainerLow,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.success
                        : context.colorScheme.outlineVariant,
                    width: isSelected ? 1.5 : 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  _formatHour(hour),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected
                        ? AppColors.success
                        : context.colorScheme.onSurface,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSendButton(BuildContext context) {
    final count = _selectedHours.length;
    final isEnabled = count > 0;

    return Padding(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      child: SizedBox(
        width: double.infinity,
        child: Button(
          onPressed: isEnabled ? () => _send(context) : null,
          label: isEnabled ? 'إرسال ($count أوقات)' : 'اختر وقت واحد على الأقل',
          icon: ButtonIcon(Icons.send_rounded),
          style: Style.success,
          size: ButtonSize.large,
          expand: true,
        ),
      ),
    );
  }

  void _send(BuildContext context) {
    final dateLabel = _formatDate(_selectedDate);
    final sortedHours = _selectedHours.toList()..sort();
    final slots = sortedHours.asMap().entries.map((entry) {
      final hour = entry.value;
      return AvailabilitySlot(
        id: 'slot_${_selectedDayIndex}_$hour',
        date: dateLabel,
        time: _formatHour(hour),
      );
    }).toList();

    final serviceName = _serviceController.text.trim().isNotEmpty
        ? _serviceController.text.trim()
        : null;

    widget.onSend(slots, serviceName);
    Navigator.pop(context);
  }
}
