import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/presentation/widgets/booking_sheet_chrome.dart';
import 'package:honak/features/requests/presentation/widgets/booking_sheet_sections.dart';
import 'package:honak/features/requests/presentation/widgets/customer_questions_section.dart';

/// Bottom sheet for the service_booking archetype.
///
/// Lets the customer pick a service, optional team member,
/// preferred time, answer business questions, and add notes.
class BookingRequestSheet extends StatelessWidget {
  final String pageName;
  final List<Map<String, dynamic>> services;
  final List<Map<String, dynamic>> team;
  final List<QuestionConfig> questions;
  final String? initialServiceId;
  final List<String>? branches;
  final ValueChanged<Map<String, dynamic>> onSubmit;

  const BookingRequestSheet({
    super.key,
    required this.pageName,
    required this.services,
    this.team = const [],
    this.questions = const [],
    this.initialServiceId,
    this.branches,
    required this.onSubmit,
  });

  static Future<void> show({
    required BuildContext context,
    required String pageName,
    required List<Map<String, dynamic>> services,
    List<Map<String, dynamic>> team = const [],
    List<QuestionConfig> questions = const [],
    String? initialServiceId,
    List<String>? branches,
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
        builder: (_, controller) => _BookingBody(
          pageName: pageName,
          services: services,
          team: team,
          questions: questions,
          initialServiceId: initialServiceId,
          branches: branches,
          onSubmit: onSubmit,
          scrollController: controller,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _BookingBody(
      pageName: pageName,
      services: services,
      team: team,
      questions: questions,
      initialServiceId: initialServiceId,
      branches: branches,
      onSubmit: onSubmit,
    );
  }
}

class _BookingBody extends StatefulWidget {
  final String pageName;
  final List<Map<String, dynamic>> services;
  final List<Map<String, dynamic>> team;
  final List<QuestionConfig> questions;
  final String? initialServiceId;
  final List<String>? branches;
  final ValueChanged<Map<String, dynamic>> onSubmit;
  final ScrollController? scrollController;

  const _BookingBody({
    required this.pageName,
    required this.services,
    this.team = const [],
    this.questions = const [],
    this.initialServiceId,
    this.branches,
    required this.onSubmit,
    this.scrollController,
  });

  @override
  State<_BookingBody> createState() => _BookingBodyState();
}

class _BookingBodyState extends State<_BookingBody> {
  late String? _activeServiceId;
  String? _selectedTeam;
  String _preferredTime = 'any_week';
  String? _specificDay;
  String? _specificPeriod;
  String? _selectedBranch;
  final _otherTextController = TextEditingController();
  final _noteController = TextEditingController();
  Map<String, String> _questionAnswers = {};

  @override
  void initState() {
    super.initState();
    _activeServiceId = widget.initialServiceId ??
        (widget.services.isNotEmpty
            ? widget.services.first['id']?.toString()
            : null);
    if (widget.branches != null && widget.branches!.isNotEmpty) {
      _selectedBranch = widget.branches!.first;
    }
  }

  @override
  void dispose() {
    _otherTextController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Map<String, dynamic>? get _currentService {
    if (_activeServiceId == null) return null;
    return widget.services.cast<Map<String, dynamic>?>().firstWhere(
          (s) => s?['id']?.toString() == _activeServiceId,
          orElse: () => null,
        );
  }

  bool get _questionsValid =>
      CustomerQuestionsSection.areRequiredAnswered(
        widget.questions,
        _questionAnswers,
      );

  void _submit() {
    final service = _currentService;
    widget.onSubmit({
      'service_id': _activeServiceId,
      'service_name': service?['name'],
      'team_member': _selectedTeam,
      'preferred_time': _preferredTime,
      if (_preferredTime == 'specific') ...{
        'specific_day': _specificDay,
        'specific_period': _specificPeriod,
      },
      if (_preferredTime == 'other')
        'other_time': _otherTextController.text.trim(),
      'note': _noteController.text.trim(),
      'question_answers': _questionAnswers,
      if (_selectedBranch != null) 'branch': _selectedBranch,
    });
    Navigator.of(context).pop();
  }

  String get _servicePriceStr {
    final service = _currentService;
    return service?['price'] != null
        ? ' — ${service!['price']} د.أ'
        : '';
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
          const BookingSheetDragHandle(),
          BookingSheetHeader(
            onClose: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: ListView(
              controller: widget.scrollController,
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.xl, AppSpacing.lg, AppSpacing.xl, AppSpacing.lg,
              ),
              children: [
                BookingBusinessLabel(pageName: widget.pageName),
                const SizedBox(height: AppSpacing.xl),
                BookingServiceSelector(
                  services: widget.services,
                  activeServiceId: _activeServiceId,
                  onChanged: (id) =>
                      setState(() => _activeServiceId = id),
                ),
                // FG2: Branch selector
                if (widget.branches != null &&
                    widget.branches!.length > 1) ...[
                  const SizedBox(height: AppSpacing.xl),
                  BookingBranchSelector(
                    branches: widget.branches!,
                    selected: _selectedBranch,
                    onChanged: (b) =>
                        setState(() => _selectedBranch = b),
                  ),
                ],
                const SizedBox(height: AppSpacing.xl),
                if (widget.team.isNotEmpty) ...[
                  BookingTeamSelector(
                    team: widget.team,
                    selectedTeam: _selectedTeam,
                    onChanged: (t) =>
                        setState(() => _selectedTeam = t),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],
                BookingTimePreference(
                  preferredTime: _preferredTime,
                  onTimeChanged: (v) =>
                      setState(() => _preferredTime = v),
                  specificDay: _specificDay,
                  onDayChanged: (d) =>
                      setState(() => _specificDay = d),
                  specificPeriod: _specificPeriod,
                  onPeriodChanged: (p) =>
                      setState(() => _specificPeriod = p),
                  otherTextController: _otherTextController,
                ),
                const SizedBox(height: AppSpacing.xl),
                BookingNoteField(controller: _noteController),
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
          BookingSubmitButton(
            questionsValid: _questionsValid,
            servicePriceStr: _servicePriceStr,
            onSubmit: _submit,
          ),
        ],
      ),
    );
  }
}
