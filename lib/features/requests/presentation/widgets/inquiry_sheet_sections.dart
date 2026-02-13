import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Description textarea for inquiry request.
class InquiryDescriptionSection extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;

  const InquiryDescriptionSection({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ماذا تريد؟',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: controller,
          maxLines: 5,
          textDirection: TextDirection.rtl,
          onChanged: (_) => onChanged(),
          decoration: InputDecoration(
            hintText:
                'اشرح ماذا تريد بالتفصيل... مثال: أريد تصوير حفل تخرج في حديقة، ٣٠ شخص تقريباً',
            hintStyle: theme.textTheme.bodySmall
                ?.copyWith(color: AppColors.textHint),
            filled: true,
            fillColor: AppColors.surfaceVariant,
            border: OutlineInputBorder(
              borderRadius: AppRadius.cardInner,
              borderSide: BorderSide(color: AppColors.divider),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.cardInner,
              borderSide: BorderSide(color: AppColors.divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.cardInner,
              borderSide: BorderSide(color: AppColors.primary),
            ),
            contentPadding: const EdgeInsets.all(AppSpacing.md),
          ),
        ),
      ],
    );
  }
}

/// Reference photos mock for inquiry request.
class InquiryRefPhotosMock extends StatelessWidget {
  const InquiryRefPhotosMock({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'صور مرجعية (اختياري)',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('قريباً: إرفاق صور كمرجع')),
            );
          },
          borderRadius: AppRadius.cardInner,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              borderRadius: AppRadius.cardInner,
              border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.attach_file,
                    size: 16, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'إرفاق صور كمرجع',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'أرفق صور لأعمال مشابهة لما تريد',
          style: theme.textTheme.labelSmall
              ?.copyWith(color: AppColors.textHint),
        ),
      ],
    );
  }
}

/// Preferred date section with FG4 custom date picker.
class InquiryPreferredDateSection extends StatelessWidget {
  final String preferredDate;
  final ValueChanged<String> onChanged;
  final String? selectedCustomDate;
  final VoidCallback onPickCustomDate;

  const InquiryPreferredDateSection({
    super.key,
    required this.preferredDate,
    required this.onChanged,
    this.selectedCustomDate,
    required this.onPickCustomDate,
  });

  static const _dateOptions = [
    ('this_week', 'هذا الأسبوع'),
    ('next_week', 'الأسبوع القادم'),
    ('this_month', 'هذا الشهر'),
    ('flexible', 'مرن'),
    ('custom', 'تاريخ محدد'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'التاريخ المطلوب',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          'اختياري — متى تحتاج الخدمة؟',
          style: theme.textTheme.labelSmall
              ?.copyWith(color: AppColors.textHint),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: _dateOptions.map((opt) {
            final (id, label) = opt;
            final selected = preferredDate == id;
            return InkWell(
              onTap: () =>
                  onChanged(preferredDate == id ? '' : id),
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
                  label,
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
        // FG4: Custom date picker row
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
