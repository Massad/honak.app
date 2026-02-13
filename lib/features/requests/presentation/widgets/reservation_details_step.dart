import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/presentation/widgets/customer_questions_section.dart';

/// Details step: guest count, occasion (venues), notes.
class ReservationDetailsStep extends StatelessWidget {
  final bool isVillaType;
  final int? maxGuests;
  final String guestCount;
  final ValueChanged<String> onGuestCountChanged;
  final String occasion;
  final ValueChanged<String> onOccasionChanged;
  final TextEditingController noteController;

  const ReservationDetailsStep({
    super.key,
    required this.isVillaType,
    required this.maxGuests,
    required this.guestCount,
    required this.onGuestCountChanged,
    required this.occasion,
    required this.onOccasionChanged,
    required this.noteController,
  });

  List<int> get _guestPresets =>
      isVillaType ? [2, 4, 6, 8, 10] : [20, 50, 100, 150, 200];

  static const _occasionOptions = [
    'عرس',
    'خطوبة',
    'شركات',
    'عيد ميلاد',
    'حفل تخرج',
    'اجتماع',
    'آخر',
  ];

  int get _guestNum => int.tryParse(guestCount) ?? 0;
  bool get _overMaxGuests => maxGuests != null && _guestNum > maxGuests!;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Guest count
        Text(
          'عدد الضيوف',
          style: theme.textTheme.labelSmall
              ?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: _guestPresets.map((n) {
            final selected = guestCount == '$n';
            return Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  end: n != _guestPresets.last ? AppSpacing.sm : 0,
                ),
                child: InkWell(
                  onTap: () => onGuestCountChanged('$n'),
                  borderRadius: AppRadius.cardInner,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primary
                          : AppColors.surfaceVariant,
                      borderRadius: AppRadius.cardInner,
                      border: Border.all(
                        color:
                            selected ? AppColors.primary : AppColors.divider,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$n',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: selected
                            ? Colors.white
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.sm),
        // Custom guest input
        TextFormField(
          initialValue:
              !_guestPresets.map((n) => '$n').contains(guestCount)
                  ? guestCount
                  : null,
          onChanged: onGuestCountChanged,
          keyboardType: TextInputType.number,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: 'أدخل عدد آخر...',
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
        if (_overMaxGuests)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Text(
              'الحد الأقصى $maxGuests ضيف',
              style: theme.textTheme.labelSmall
                  ?.copyWith(color: AppColors.error),
            ),
          ),
        const SizedBox(height: AppSpacing.xl),
        // Occasion (venues only)
        if (!isVillaType) ...[
          Text(
            'نوع المناسبة',
            style: theme.textTheme.labelSmall
                ?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: _occasionOptions.map((occ) {
              final selected = occasion == occ;
              return InkWell(
                onTap: () =>
                    onOccasionChanged(occasion == occ ? '' : occ),
                borderRadius: AppRadius.cardInner,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primary
                        : AppColors.surfaceVariant,
                    borderRadius: AppRadius.cardInner,
                    border: Border.all(
                      color:
                          selected ? AppColors.primary : AppColors.divider,
                    ),
                  ),
                  child: Text(
                    occ,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      color: selected
                          ? Colors.white
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
        // Notes
        Text(
          'ملاحظات (اختياري)',
          style: theme.textTheme.labelSmall
              ?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: noteController,
          maxLines: 3,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: 'أي طلبات خاصة أو استفسارات...',
            hintStyle: theme.textTheme.labelSmall
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

/// Questions step: business-specific questions.
class ReservationQuestionsStep extends StatelessWidget {
  final String pageName;
  final List<QuestionConfig> questions;
  final Map<String, String> answers;
  final ValueChanged<Map<String, String>> onChanged;

  const ReservationQuestionsStep({
    super.key,
    required this.pageName,
    required this.questions,
    required this.answers,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.chat_bubble_outline,
                size: 14, color: AppColors.secondary),
            const SizedBox(width: AppSpacing.sm),
            Text('أسئلة من $pageName', style: theme.textTheme.bodySmall),
          ],
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          'ساعدنا نجهّز لك أفضل تجربة بالإجابة على هذه الأسئلة',
          style: theme.textTheme.labelSmall
              ?.copyWith(color: AppColors.textHint),
        ),
        const SizedBox(height: AppSpacing.lg),
        CustomerQuestionsSection(
          questions: questions,
          answers: answers,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
