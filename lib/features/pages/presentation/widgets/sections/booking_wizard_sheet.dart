import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/presentation/widgets/sections/booking_wizard_steps.dart';

/// 3-step booking wizard: team member, date/time, confirm.
/// Step 1 (team) is skipped when [teamMembers] is empty.
class BookingWizardSheet extends StatefulWidget {
  final String pageName;
  final String serviceId;
  final String serviceName;
  final int priceCents;
  final int? durationMinutes;
  final List<Map<String, dynamic>> teamMembers;

  const BookingWizardSheet({
    super.key,
    required this.pageName,
    required this.serviceId,
    required this.serviceName,
    required this.priceCents,
    this.durationMinutes,
    this.teamMembers = const [],
  });

  static Future<void> show({
    required BuildContext context,
    required String pageName,
    required String serviceId,
    required String serviceName,
    required int priceCents,
    int? durationMinutes,
    List<Map<String, dynamic>> teamMembers = const [],
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (sheetContext, controller) => BookingWizardSheet(
          pageName: pageName,
          serviceId: serviceId,
          serviceName: serviceName,
          priceCents: priceCents,
          durationMinutes: durationMinutes,
          teamMembers: teamMembers,
        ),
      ),
    );
  }

  @override
  State<BookingWizardSheet> createState() => _BookingWizardSheetState();
}

class _BookingWizardSheetState extends State<BookingWizardSheet> {
  late int _currentStep;
  late final bool _hasTeamStep;
  String? _selectedMemberId;
  String? _selectedMemberName;
  DateTime? _selectedDate;
  String? _selectedTime;
  final _notesController = TextEditingController();

  int get _duration => widget.durationMinutes ?? 30;

  List<String> get _stepLabels => [
        if (_hasTeamStep) '\u0627\u0644\u0645\u0648\u0638\u0641', // Team member
        '\u0627\u0644\u0645\u0648\u0639\u062f', // Date & Time
        '\u062a\u0623\u0643\u064a\u062f', // Confirm
      ];

  @override
  void initState() {
    super.initState();
    _hasTeamStep = widget.teamMembers.isNotEmpty;
    _currentStep = 0;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentStep < _stepLabels.length - 1) {
      setState(() => _currentStep++);
    }
  }

  void _back() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Navigator.of(context).pop();
    }
  }

  void _confirm() {
    Navigator.of(context).pop();
    // \u062a\u0645 \u062a\u0623\u0643\u064a\u062f \u0627\u0644\u062d\u062c\u0632 \u0628\u0646\u062c\u0627\u062d = "Booking confirmed"
    context.showSnackBar('\u062a\u0645 \u062a\u0623\u0643\u064a\u062f \u0627\u0644\u062d\u062c\u0632 \u0628\u0646\u062c\u0627\u062d');
  }
  _WizardStepType get _activeStepType {
    if (_hasTeamStep) {
      return _WizardStepType.values[_currentStep];
    }
    // Skip team step — index 0 = dateTime, 1 = confirm
    return _currentStep == 0
        ? _WizardStepType.dateTime
        : _WizardStepType.confirm;
  }

  bool get _canProceed {
    switch (_activeStepType) {
      case _WizardStepType.team:
        return true; // "any available" is valid default
      case _WizardStepType.dateTime:
        return _selectedDate != null && _selectedTime != null;
      case _WizardStepType.confirm:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.xxl),
        ),
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: AppSpacing.sm),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          _WizardHeader(
            pageName: widget.pageName,
            serviceName: widget.serviceName,
            onClose: () => Navigator.of(context).pop(),
          ),
          WizardStepIndicator(
            labels: _stepLabels,
            currentStep: _currentStep,
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: _buildStepContent(),
          ),
          _WizardBottomBar(
            isFirstStep: _currentStep == 0,
            isLastStep: _activeStepType == _WizardStepType.confirm,
            canProceed: _canProceed,
            onBack: _back,
            onNext: _activeStepType == _WizardStepType.confirm
                ? _confirm
                : _next,
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_activeStepType) {
      case _WizardStepType.team:
        return TeamStepContent(
          members: widget.teamMembers,
          selectedMemberId: _selectedMemberId,
          onSelected: (id, name) => setState(() {
            _selectedMemberId = id;
            _selectedMemberName = name;
          }),
        );
      case _WizardStepType.dateTime:
        return DateTimeStepContent(
          durationMinutes: _duration,
          selectedDate: _selectedDate,
          selectedTime: _selectedTime,
          onDateSelected: (d) => setState(() => _selectedDate = d),
          onTimeSelected: (t) => setState(() => _selectedTime = t),
        );
      case _WizardStepType.confirm:
        return ConfirmStepContent(
          serviceName: widget.serviceName,
          priceCents: widget.priceCents,
          durationMinutes: _duration,
          memberName: _selectedMemberName,
          selectedDate: _selectedDate,
          selectedTime: _selectedTime,
          notesController: _notesController,
        );
    }
  }
}

enum _WizardStepType { team, dateTime, confirm }

class _WizardHeader extends StatelessWidget {
  final String pageName;
  final String serviceName;
  final VoidCallback onClose;

  const _WizardHeader({
    required this.pageName,
    required this.serviceName,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg, AppSpacing.md, AppSpacing.sm, 0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\u062d\u062c\u0632 \u0645\u0648\u0639\u062f', // Book appointment
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  '$serviceName \u2014 $pageName',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}

class _WizardBottomBar extends StatelessWidget {
  final bool isFirstStep;
  final bool isLastStep;
  final bool canProceed;
  final VoidCallback onBack;
  final VoidCallback onNext;

  const _WizardBottomBar({
    required this.isFirstStep,
    required this.isLastStep,
    required this.canProceed,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.colorScheme.outlineVariant),
        ),
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          if (!isFirstStep)
            Expanded(
              child: OutlinedButton(
                onPressed: onBack,
                // \u0631\u062c\u0648\u0639 = "Back"
                child: const Text('\u0631\u062c\u0648\u0639'),
              ),
            )
          else
            const Spacer(),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: FilledButton(
              onPressed: canProceed ? onNext : null,
              child: Text(
                isLastStep
                    // \u062a\u0623\u0643\u064a\u062f \u0627\u0644\u062d\u062c\u0632 = "Confirm booking"
                    ? '\u062a\u0623\u0643\u064a\u062f \u0627\u0644\u062d\u062c\u0632'
                    // \u0627\u0644\u062a\u0627\u0644\u064a = "Next"
                    : '\u0627\u0644\u062a\u0627\u0644\u064a',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
