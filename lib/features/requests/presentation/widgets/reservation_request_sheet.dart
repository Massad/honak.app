import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/presentation/widgets/customer_questions_section.dart';
import 'package:honak/features/requests/presentation/widgets/reservation_sheet_chrome.dart';
import 'package:honak/features/requests/presentation/widgets/reservation_steps.dart';

/// Full-screen 4-step wizard for the reservation archetype.
///
/// Steps:
/// 1. Date — check-in / check-out date selection, space picker (venues)
/// 2. Details — guest count, occasion (venues), notes
/// 3. Questions — business-specific questions (skipped if none)
/// 4. Confirm — summary card, payment methods, submit
class ReservationRequestSheet extends StatefulWidget {
  final String pageName;
  final List<Map<String, dynamic>> spaces;
  final List<QuestionConfig> questions;
  final List<String> paymentMethods;
  final int? maxGuests;
  final bool isVillaType;
  final int? pricePerNightCents;
  final int? depositCents;
  final List<String>? disclaimers;
  final ValueChanged<Map<String, dynamic>> onSubmit;
  final ScrollController? scrollController;

  const ReservationRequestSheet({
    super.key,
    required this.pageName,
    this.spaces = const [],
    this.questions = const [],
    this.paymentMethods = const [],
    this.maxGuests,
    this.isVillaType = false,
    this.pricePerNightCents,
    this.depositCents,
    this.disclaimers,
    required this.onSubmit,
    this.scrollController,
  });

  static Future<void> show({
    required BuildContext context,
    required String pageName,
    List<Map<String, dynamic>> spaces = const [],
    List<QuestionConfig> questions = const [],
    List<String> paymentMethods = const [],
    int? maxGuests,
    bool isVillaType = false,
    int? pricePerNightCents,
    int? depositCents,
    List<String>? disclaimers,
    required ValueChanged<Map<String, dynamic>> onSubmit,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.92,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (_, controller) => ReservationRequestSheet(
          pageName: pageName,
          spaces: spaces,
          questions: questions,
          paymentMethods: paymentMethods,
          maxGuests: maxGuests,
          isVillaType: isVillaType,
          pricePerNightCents: pricePerNightCents,
          depositCents: depositCents,
          disclaimers: disclaimers,
          onSubmit: onSubmit,
          scrollController: controller,
        ),
      ),
    );
  }

  @override
  State<ReservationRequestSheet> createState() =>
      _ReservationRequestSheetState();
}

class _ReservationRequestSheetState extends State<ReservationRequestSheet> {
  int _currentStep = 0;
  DateTime? _checkIn;
  DateTime? _checkOut;
  String? _activeSpaceId;
  String _guestCount = '';
  String _occasion = '';
  String? _checkInTime;
  String? _checkOutTime;
  final _noteController = TextEditingController();
  Map<String, String> _questionAnswers = {};
  final Set<String> _acceptedDisclaimers = {};

  List<ReservationStepDef> get _steps {
    final s = <ReservationStepDef>[
      const ReservationStepDef('date', 'التاريخ', Icons.calendar_today),
      const ReservationStepDef('details', 'التفاصيل', Icons.people),
    ];
    if (widget.questions.isNotEmpty) {
      s.add(const ReservationStepDef(
          'questions', 'الأسئلة', Icons.chat_bubble_outline));
    }
    s.add(const ReservationStepDef('confirm', 'التأكيد', Icons.send));
    return s;
  }

  bool get _isFirst => _currentStep == 0;
  bool get _isLast => _currentStep == _steps.length - 1;

  int? get _nightCount {
    if (_checkIn == null || _checkOut == null) return null;
    return _checkOut!.difference(_checkIn!).inDays;
  }

  int get _guestNum => int.tryParse(_guestCount) ?? 0;
  bool get _overMaxGuests =>
      widget.maxGuests != null && _guestNum > widget.maxGuests!;

  @override
  void initState() {
    super.initState();
    if (widget.spaces.isNotEmpty) {
      _activeSpaceId = widget.spaces.first['id']?.toString();
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  bool _canAdvance(String stepId) {
    switch (stepId) {
      case 'date':
        return _checkIn != null && _checkOut != null;
      case 'details':
        return _guestNum >= 1 && !_overMaxGuests;
      case 'questions':
        return CustomerQuestionsSection.areRequiredAnswered(
          widget.questions, _questionAnswers,
        );
      default:
        return true;
    }
  }

  void _goNext() {
    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep++);
    }
  }

  void _goBack() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _submit() {
    widget.onSubmit({
      'check_in': _checkIn?.toIso8601String(),
      'check_out': _checkOut?.toIso8601String(),
      'nights': _nightCount,
      'space_id': _activeSpaceId,
      'guest_count': _guestNum,
      'occasion': _occasion,
      'note': _noteController.text.trim(),
      'question_answers': _questionAnswers,
      'check_in_time': _checkInTime,
      'check_out_time': _checkOutTime,
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final currentStepId = _steps[_currentStep].id;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.xxl),
        ),
      ),
      child: Column(
        children: [
          ReservationSheetHeader(
            pageName: widget.pageName,
            onClose: () => Navigator.of(context).pop(),
          ),
          ReservationStepIndicator(
            steps: _steps,
            currentStep: _currentStep,
            onTapStep: (i) => setState(() => _currentStep = i),
          ),
          Expanded(
            child: ListView(
              controller: widget.scrollController,
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.xl, AppSpacing.lg, AppSpacing.xl, AppSpacing.lg,
              ),
              children: [_buildCurrentStep()],
            ),
          ),
          ReservationSheetFooter(
            isLast: _isLast,
            isFirst: _isFirst,
            canAdvance: _canAdvance(currentStepId),
            currentStepId: currentStepId,
            guestNum: _guestNum,
            onSubmit: _submit,
            onNext: _goNext,
            onBack: _goBack,
            canSubmitAll: _canAdvance('date') && _guestNum >= 1,
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    final stepId = _steps[_currentStep].id;
    switch (stepId) {
      case 'date':
        return ReservationDateStep(
          isVillaType: widget.isVillaType,
          spaces: widget.spaces,
          activeSpaceId: _activeSpaceId,
          onSpaceChanged: (id) => setState(() => _activeSpaceId = id),
          checkIn: _checkIn,
          checkOut: _checkOut,
          onCheckInPicked: (d) => setState(() => _checkIn = d),
          onCheckOutPicked: (d) => setState(() => _checkOut = d),
          checkInTime: _checkInTime,
          checkOutTime: _checkOutTime,
          onPickCheckInTime: _pickCheckInTime,
          onPickCheckOutTime: _pickCheckOutTime,
        );
      case 'details':
        return ReservationDetailsStep(
          isVillaType: widget.isVillaType,
          maxGuests: widget.maxGuests,
          guestCount: _guestCount,
          onGuestCountChanged: (v) => setState(() => _guestCount = v),
          occasion: _occasion,
          onOccasionChanged: (v) => setState(() => _occasion = v),
          noteController: _noteController,
        );
      case 'questions':
        return ReservationQuestionsStep(
          pageName: widget.pageName,
          questions: widget.questions,
          answers: _questionAnswers,
          onChanged: (a) => setState(() => _questionAnswers = a),
        );
      case 'confirm':
        return ReservationConfirmStep(
          checkIn: _checkIn,
          checkOut: _checkOut,
          nightCount: _nightCount,
          guestCount: _guestNum,
          occasion: _occasion,
          activeSpaceId: _activeSpaceId,
          spaces: widget.spaces,
          paymentMethods: widget.paymentMethods,
          pricePerNightCents: widget.pricePerNightCents,
          depositCents: widget.depositCents,
          disclaimers: widget.disclaimers,
          acceptedDisclaimers: _acceptedDisclaimers,
          onDisclaimerToggle: (d) => setState(() {
            if (_acceptedDisclaimers.contains(d)) {
              _acceptedDisclaimers.remove(d);
            } else {
              _acceptedDisclaimers.add(d);
            }
          }),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  void _pickCheckInTime() => _pickTime((t) => _checkInTime = t);
  void _pickCheckOutTime() => _pickTime((t) => _checkOutTime = t);

  Future<void> _pickTime(ValueChanged<String> setter) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) setState(() => setter(time.format(context)));
  }
}
