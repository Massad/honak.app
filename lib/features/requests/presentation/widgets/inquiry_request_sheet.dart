import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/presentation/widgets/customer_questions_section.dart';
import 'package:honak/features/requests/presentation/widgets/inquiry_sheet_sections.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// Bottom sheet for the portfolio_inquiry archetype.
///
/// Simpler form: description, reference photos mock, preferred date,
/// optional note.
class InquiryRequestSheet extends StatefulWidget {
  final String pageName;
  final List<QuestionConfig> questions;
  final ValueChanged<Map<String, dynamic>> onSubmit;

  const InquiryRequestSheet({
    super.key,
    required this.pageName,
    this.questions = const [],
    required this.onSubmit,
  });

  static Future<void> show({
    required BuildContext context,
    required String pageName,
    List<QuestionConfig> questions = const [],
    required ValueChanged<Map<String, dynamic>> onSubmit,
  }) {
    return showAppSheet(
      context,
      builder: (_) => _InquiryBody(
        pageName: pageName,
        questions: questions,
        onSubmit: onSubmit,
      ),
    );
  }

  @override
  State<InquiryRequestSheet> createState() => _InquiryRequestSheetState();
}

class _InquiryRequestSheetState extends State<InquiryRequestSheet> {
  @override
  Widget build(BuildContext context) {
    return _InquiryBody(
      pageName: widget.pageName,
      questions: widget.questions,
      onSubmit: widget.onSubmit,
    );
  }
}

class _InquiryBody extends StatefulWidget {
  final String pageName;
  final List<QuestionConfig> questions;
  final ValueChanged<Map<String, dynamic>> onSubmit;

  const _InquiryBody({
    required this.pageName,
    required this.questions,
    required this.onSubmit,
  });

  @override
  State<_InquiryBody> createState() => _InquiryBodyState();
}

class _InquiryBodyState extends State<_InquiryBody> {
  final _descController = TextEditingController();
  String _preferredDate = '';
  String? _selectedCustomDate;
  Map<String, String> _questionAnswers = {};

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _descController.text.trim().isNotEmpty &&
      CustomerQuestionsSection.areRequiredAnswered(
        widget.questions,
        _questionAnswers,
      );

  void _submit() {
    widget.onSubmit({
      'description': _descController.text.trim(),
      'preferred_date': _preferredDate,
      if (_preferredDate == 'custom' && _selectedCustomDate != null)
        'custom_date': _selectedCustomDate,
      'question_answers': _questionAnswers,
    });
    Navigator.of(context).pop();
  }

  void _pickCustomDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      locale: const Locale('ar'),
    );
    if (picked != null) {
      setState(() {
        _selectedCustomDate =
            '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDragHandle(),
        _buildHeader(theme),
        Flexible(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.xl, AppSpacing.lg, AppSpacing.xl, AppSpacing.lg,
            ),
            children: [
              _buildBusinessLabel(theme),
              const SizedBox(height: AppSpacing.xl),
              InquiryDescriptionSection(
                controller: _descController,
                onChanged: () => setState(() {}),
              ),
              const SizedBox(height: AppSpacing.xl),
              const InquiryRefPhotosMock(),
              const SizedBox(height: AppSpacing.xl),
              InquiryPreferredDateSection(
                preferredDate: _preferredDate,
                onChanged: (v) => setState(() => _preferredDate = v),
                selectedCustomDate: _selectedCustomDate,
                onPickCustomDate: _pickCustomDate,
              ),
              const SizedBox(height: AppSpacing.xl),
              CustomerQuestionsSection(
                questions: widget.questions,
                answers: _questionAnswers,
                onChanged: (a) =>
                    setState(() => _questionAnswers = a),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
        _buildSubmitButton(theme),
      ],
    );
  }

  Widget _buildDragHandle() {
    return Padding(
      padding:
          const EdgeInsets.only(top: AppSpacing.md, bottom: AppSpacing.sm),
      child: Center(
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.divider,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xl, 0, AppSpacing.xl, AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'إرسال استفسار',
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close, size: 20),
            style: IconButton.styleFrom(
              foregroundColor: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessLabel(ThemeData theme) {
    return Row(
      children: [
        Text(
          'استفسار لـ',
          style: theme.textTheme.bodySmall
              ?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          widget.pageName,
          style: theme.textTheme.bodySmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(ThemeData theme) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.xl, AppSpacing.sm, AppSpacing.xl, AppSpacing.lg,
        ),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: _canSubmit ? _submit : null,
            icon: const Icon(Icons.send, size: 18),
            label: const Text('إرسال الاستفسار'),
            style: FilledButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
