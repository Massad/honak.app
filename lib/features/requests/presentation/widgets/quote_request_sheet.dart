import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/presentation/widgets/customer_questions_section.dart';
import 'package:honak/features/requests/presentation/widgets/quote_sheet_sections.dart';

/// Bottom sheet for the quote_request archetype.
///
/// Customer describes their problem, attaches photos (mock),
/// selects urgency, preferred date, location, and answers
/// business-specific questions.
class QuoteRequestSheet extends StatefulWidget {
  final String pageName;
  final String ctaLabel;
  final List<QuestionConfig> questions;
  final ValueChanged<Map<String, dynamic>> onSubmit;

  const QuoteRequestSheet({
    super.key,
    required this.pageName,
    this.ctaLabel = 'اطلب معاينة',
    this.questions = const [],
    required this.onSubmit,
  });

  static Future<void> show({
    required BuildContext context,
    required String pageName,
    String ctaLabel = 'اطلب معاينة',
    List<QuestionConfig> questions = const [],
    required ValueChanged<Map<String, dynamic>> onSubmit,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (_, controller) => _QuoteBody(
          pageName: pageName,
          ctaLabel: ctaLabel,
          questions: questions,
          onSubmit: onSubmit,
          scrollController: controller,
        ),
      ),
    );
  }

  @override
  State<QuoteRequestSheet> createState() => _QuoteRequestSheetState();
}

class _QuoteRequestSheetState extends State<QuoteRequestSheet> {
  @override
  Widget build(BuildContext context) {
    return _QuoteBody(
      pageName: widget.pageName,
      ctaLabel: widget.ctaLabel,
      questions: widget.questions,
      onSubmit: widget.onSubmit,
    );
  }
}

class _QuoteBody extends StatefulWidget {
  final String pageName;
  final String ctaLabel;
  final List<QuestionConfig> questions;
  final ValueChanged<Map<String, dynamic>> onSubmit;
  final ScrollController? scrollController;

  const _QuoteBody({
    required this.pageName,
    required this.ctaLabel,
    required this.questions,
    required this.onSubmit,
    this.scrollController,
  });

  @override
  State<_QuoteBody> createState() => _QuoteBodyState();
}

class _QuoteBodyState extends State<_QuoteBody> {
  final _descController = TextEditingController();
  String _urgency = 'soon';
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
      'urgency': _urgency,
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

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.xxl),
        ),
      ),
      child: Column(
        children: [
          _buildDragHandle(),
          _buildHeader(theme),
          Expanded(
            child: ListView(
              controller: widget.scrollController,
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.xl, AppSpacing.lg, AppSpacing.xl, AppSpacing.lg,
              ),
              children: [
                _buildBusinessLabel(theme),
                const SizedBox(height: AppSpacing.xl),
                QuoteDescriptionSection(
                  controller: _descController,
                  onChanged: () => setState(() {}),
                ),
                const SizedBox(height: AppSpacing.xl),
                const QuotePhotosMock(),
                const SizedBox(height: AppSpacing.xl),
                QuoteUrgencySection(
                  urgency: _urgency,
                  onChanged: (v) => setState(() => _urgency = v),
                ),
                const SizedBox(height: AppSpacing.xl),
                QuotePreferredDateSection(
                  preferredDate: _preferredDate,
                  onChanged: (v) => setState(() => _preferredDate = v),
                  selectedCustomDate: _selectedCustomDate,
                  onPickCustomDate: _pickCustomDate,
                ),
                const SizedBox(height: AppSpacing.xl),
                const QuoteLocationSection(),
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
      ),
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
            widget.ctaLabel,
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
          'معاينة من',
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
            label: const Text('إرسال طلب المعاينة'),
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
