import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// A single question definition from the business config.
class QuestionConfig {
  final String id;
  final String question;

  /// 'text' | 'number' | 'select'
  final String type;
  final bool required;
  final List<String> options;

  const QuestionConfig({
    required this.id,
    required this.question,
    required this.type,
    this.required = false,
    this.options = const [],
  });

  factory QuestionConfig.fromJson(Map<String, dynamic> json) {
    return QuestionConfig(
      id: json['id'] as String,
      question: json['question'] as String,
      type: json['type'] as String? ?? 'text',
      required: json['required'] as bool? ?? false,
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }
}

/// Config-driven customer questions section.
///
/// Takes a list of [QuestionConfig] and renders type-specific inputs:
/// - text -> TextFormField
/// - number -> number input
/// - select -> option chips
class CustomerQuestionsSection extends StatelessWidget {
  final List<QuestionConfig> questions;
  final Map<String, String> answers;
  final ValueChanged<Map<String, String>> onChanged;

  const CustomerQuestionsSection({
    super.key,
    required this.questions,
    required this.answers,
    required this.onChanged,
  });

  /// Check if all required questions have been answered.
  static bool areRequiredAnswered(
    List<QuestionConfig> questions,
    Map<String, String> answers,
  ) {
    if (questions.isEmpty) return true;
    return questions
        .where((q) => q.required)
        .every((q) => (answers[q.id] ?? '').trim().isNotEmpty);
  }

  void _updateAnswer(String id, String value) {
    onChanged({...answers, id: value});
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.help_outline_rounded,
              size: 16,
              color: AppColors.primary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'أسئلة إضافية',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        ...questions.map((q) => Padding(
              padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.md),
              child: _QuestionField(
                config: q,
                value: answers[q.id] ?? '',
                onChanged: (v) => _updateAnswer(q.id, v),
              ),
            )),
      ],
    );
  }
}

class _QuestionField extends StatelessWidget {
  final QuestionConfig config;
  final String value;
  final ValueChanged<String> onChanged;

  const _QuestionField({
    required this.config,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        RichText(
          text: TextSpan(
            text: config.question,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
            children: [
              if (config.required)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: AppColors.error),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        // Input based on type
        switch (config.type) {
          'number' => _buildNumberInput(theme),
          'select' => _buildSelectChips(theme),
          _ => _buildTextInput(theme),
        },
      ],
    );
  }

  Widget _buildTextInput(ThemeData theme) {
    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        hintText: 'اكتب إجابتك...',
        hintStyle: theme.textTheme.bodySmall?.copyWith(
          color: AppColors.textHint,
        ),
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
        contentPadding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
      ),
    );
  }

  Widget _buildNumberInput(ThemeData theme) {
    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      textDirection: TextDirection.ltr,
      decoration: InputDecoration(
        hintText: '0',
        hintStyle: theme.textTheme.bodySmall?.copyWith(
          color: AppColors.textHint,
        ),
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
        contentPadding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
      ),
    );
  }

  Widget _buildSelectChips(ThemeData theme) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: config.options.map((opt) {
        final selected = value == opt;
        return ChoiceChip(
          label: Text(opt),
          selected: selected,
          onSelected: (_) => onChanged(value == opt ? '' : opt),
          selectedColor: AppColors.primary.withValues(alpha: 0.12),
          backgroundColor: AppColors.surfaceVariant,
          labelStyle: theme.textTheme.bodySmall?.copyWith(
            color: selected ? AppColors.primary : AppColors.textSecondary,
          ),
          side: BorderSide(
            color: selected ? AppColors.primary : AppColors.divider,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.cardInner,
          ),
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xxs,
          ),
        );
      }).toList(),
    );
  }
}
