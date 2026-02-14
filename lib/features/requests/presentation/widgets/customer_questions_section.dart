import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/core/extensions/context_ext.dart';

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
              color: context.colorScheme.onSurfaceVariant,
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
          'number' => _buildNumberInput(context),
          'select' => _buildSelectChips(context),
          _ => _buildTextInput(context),
        },
      ],
    );
  }

  Widget _buildTextInput(BuildContext context) {
    final theme = Theme.of(context);
    final cs = Theme.of(context).colorScheme;
    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        hintText: 'اكتب إجابتك...',
        hintStyle: theme.textTheme.bodySmall?.copyWith(
          color: cs.onSurfaceVariant,
        ),
        filled: true,
        fillColor: cs.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: AppRadius.cardInner,
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.cardInner,
          borderSide: BorderSide(color: cs.outlineVariant),
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

  Widget _buildNumberInput(BuildContext context) {
    final theme = Theme.of(context);
    final cs = Theme.of(context).colorScheme;
    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      textDirection: TextDirection.ltr,
      decoration: InputDecoration(
        hintText: '0',
        hintStyle: theme.textTheme.bodySmall?.copyWith(
          color: cs.onSurfaceVariant,
        ),
        filled: true,
        fillColor: cs.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: AppRadius.cardInner,
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.cardInner,
          borderSide: BorderSide(color: cs.outlineVariant),
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

  Widget _buildSelectChips(BuildContext context) {
    final theme = Theme.of(context);
    final cs = Theme.of(context).colorScheme;
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
          backgroundColor: cs.surfaceContainerLow,
          labelStyle: theme.textTheme.bodySmall?.copyWith(
            color: selected ? AppColors.primary : cs.onSurfaceVariant,
          ),
          side: BorderSide(
            color: selected ? AppColors.primary : cs.outlineVariant,
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
