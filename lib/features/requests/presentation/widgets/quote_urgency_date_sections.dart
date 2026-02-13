import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Urgency option data.
class UrgencyOption {
  final String id;
  final String label;
  final Color color;
  final IconData? icon;

  const UrgencyOption(this.id, this.label, this.color, this.icon);
}

/// Urgency chips for quote request.
class QuoteUrgencySection extends StatelessWidget {
  final String urgency;
  final ValueChanged<String> onChanged;

  const QuoteUrgencySection({
    super.key,
    required this.urgency,
    required this.onChanged,
  });

  static const options = [
    UrgencyOption('not_urgent', 'غير مستعجل', AppColors.success, null),
    UrgencyOption('soon', 'قريباً', AppColors.warning, null),
    UrgencyOption(
        'asap', 'طارئ', AppColors.error, Icons.warning_amber_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'درجة الاستعجال',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: options.map((opt) {
            final selected = urgency == opt.id;
            return Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  end: opt.id != options.last.id ? AppSpacing.sm : 0,
                ),
                child: InkWell(
                  onTap: () => onChanged(opt.id),
                  borderRadius: AppRadius.cardInner,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? opt.color.withValues(alpha: 0.1)
                          : AppColors.surfaceVariant,
                      borderRadius: AppRadius.cardInner,
                      border: Border.all(
                        color: selected
                            ? opt.color.withValues(alpha: 0.5)
                            : AppColors.divider,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (opt.icon != null) ...[
                          Icon(opt.icon,
                              size: 12,
                              color: selected
                                  ? opt.color
                                  : AppColors.textHint),
                          const SizedBox(width: AppSpacing.xxs),
                        ],
                        Text(
                          opt.label,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: selected
                                ? opt.color
                                : AppColors.textHint,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

/// Date option data.
class DateOption {
  final String id;
  final String label;

  const DateOption(this.id, this.label);
}

/// Preferred date chips with FG3 custom date picker.
class QuotePreferredDateSection extends StatelessWidget {
  final String preferredDate;
  final ValueChanged<String> onChanged;
  final String? selectedCustomDate;
  final VoidCallback onPickCustomDate;

  const QuotePreferredDateSection({
    super.key,
    required this.preferredDate,
    required this.onChanged,
    this.selectedCustomDate,
    required this.onPickCustomDate,
  });

  static const options = [
    DateOption('today', 'اليوم'),
    DateOption('tomorrow', 'غداً'),
    DateOption('this_week', 'هذا الأسبوع'),
    DateOption('next_week', 'الأسبوع القادم'),
    DateOption('custom', 'تاريخ محدد'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تاريخ مفضل',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          'اختياري — يساعد في تقليل التنسيق',
          style: theme.textTheme.labelSmall
              ?.copyWith(color: AppColors.textHint),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: options.map((opt) {
            final selected = preferredDate == opt.id;
            return InkWell(
              onTap: () =>
                  onChanged(preferredDate == opt.id ? '' : opt.id),
              borderRadius: AppRadius.cardInner,
              child: Container(
                constraints: const BoxConstraints(minWidth: 72),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.primary.withValues(alpha: 0.05)
                      : AppColors.surfaceVariant,
                  borderRadius: AppRadius.cardInner,
                  border: Border.all(
                    color:
                        selected ? AppColors.primary : AppColors.divider,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  opt.label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: selected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        // FG3: Custom date picker row
        if (preferredDate == 'custom') ...[
          const SizedBox(height: AppSpacing.sm),
          GestureDetector(
            onTap: onPickCustomDate,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: AppRadius.cardInner,
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today,
                      size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    selectedCustomDate ?? 'اختر تاريخ',
                    style: TextStyle(
                      color: selectedCustomDate != null
                          ? AppColors.textPrimary
                          : AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
