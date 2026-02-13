import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

// ─── Report reason model ────────────────────────────────────

class _ReportReason {
  final String id;
  final String label;
  final String desc;
  const _ReportReason(this.id, this.label, this.desc);
}

// ─── Reason sets per claim_status ───────────────────────────

const _claimedReasons = [
  _ReportReason(
      'impersonation',
      '\u0627\u0646\u062a\u062d\u0627\u0644 \u0647\u0648\u064a\u0629',
      '\u0634\u062e\u0635 \u064a\u0646\u062a\u062d\u0644 \u0635\u0641\u0629 \u0647\u0630\u0627 \u0627\u0644\u0646\u0634\u0627\u0637 \u0627\u0644\u062a\u062c\u0627\u0631\u064a'),
  _ReportReason(
      'closed',
      '\u0645\u063a\u0644\u0642 \u0646\u0647\u0627\u0626\u064a\u0627\u064b',
      '\u0647\u0630\u0627 \u0627\u0644\u0645\u062a\u062c\u0631 \u0644\u0645 \u064a\u0639\u062f \u0645\u0648\u062c\u0648\u062f\u0627\u064b'),
  _ReportReason(
      'misleading',
      '\u0645\u062d\u062a\u0648\u0649 \u0645\u0636\u0644\u0644',
      '\u0645\u0646\u062a\u062c\u0627\u062a \u0648\u0647\u0645\u064a\u0629 \u0623\u0648 \u0623\u0633\u0639\u0627\u0631 \u062e\u0627\u0637\u0626\u0629'),
  _ReportReason(
      'inappropriate',
      '\u0645\u062d\u062a\u0648\u0649 \u063a\u064a\u0631 \u0644\u0627\u0626\u0642',
      '\u0645\u062e\u0627\u0644\u0641 \u0644\u0633\u064a\u0627\u0633\u0629 \u0627\u0644\u0645\u0646\u0635\u0629'),
  _ReportReason(
      'wrong_contact',
      '\u0645\u0639\u0644\u0648\u0645\u0627\u062a \u062a\u0648\u0627\u0635\u0644 \u062e\u0627\u0637\u0626\u0629',
      '\u0631\u0642\u0645 \u0627\u0644\u0647\u0627\u062a\u0641 \u0623\u0648 \u0627\u0644\u0639\u0646\u0648\u0627\u0646 \u063a\u064a\u0631 \u0635\u062d\u064a\u062d'),
  _ReportReason(
      'other', '\u0633\u0628\u0628 \u0622\u062e\u0631', ''),
];

const _unclaimedReasons = [
  _ReportReason(
      'wrong_info',
      '\u0645\u0639\u0644\u0648\u0645\u0627\u062a \u063a\u064a\u0631 \u0635\u062d\u064a\u062d\u0629',
      '\u0627\u0644\u0627\u0633\u0645 \u0623\u0648 \u0627\u0644\u0639\u0646\u0648\u0627\u0646 \u0623\u0648 \u0631\u0642\u0645 \u0627\u0644\u0647\u0627\u062a\u0641 \u062e\u0637\u0623'),
  _ReportReason(
      'permanently_closed',
      '\u0627\u0644\u0646\u0634\u0627\u0637 \u0645\u063a\u0644\u0642 \u0646\u0647\u0627\u0626\u064a\u0627\u064b',
      '\u0647\u0630\u0627 \u0627\u0644\u0645\u062d\u0644 \u0644\u0645 \u064a\u0639\u062f \u0645\u0648\u062c\u0648\u062f\u0627\u064b \u0641\u064a \u0647\u0630\u0627 \u0627\u0644\u0645\u0648\u0642\u0639'),
  _ReportReason(
      'duplicate',
      '\u0635\u0641\u062d\u0629 \u0645\u0643\u0631\u0651\u0631\u0629',
      '\u064a\u0648\u062c\u062f \u0635\u0641\u062d\u0629 \u0623\u062e\u0631\u0649 \u0644\u0646\u0641\u0633 \u0627\u0644\u0646\u0634\u0627\u0637 \u0639\u0644\u0649 \u0647\u0646\u0627\u0643'),
  _ReportReason(
      'moved',
      '\u0627\u0644\u0646\u0634\u0627\u0637 \u0627\u0646\u062a\u0642\u0644',
      '\u0627\u0644\u0645\u062d\u0644 \u0645\u0648\u062c\u0648\u062f \u0644\u0643\u0646 \u0641\u064a \u0639\u0646\u0648\u0627\u0646 \u0645\u062e\u062a\u0644\u0641'),
  _ReportReason(
      'wrong_type',
      '\u0646\u0648\u0639 \u0627\u0644\u0646\u0634\u0627\u0637 \u062e\u0637\u0623',
      '\u0627\u0644\u062a\u0635\u0646\u064a\u0641 \u0644\u0627 \u064a\u062a\u0637\u0627\u0628\u0642 \u0645\u0639 \u0627\u0644\u0646\u0634\u0627\u0637 \u0627\u0644\u0641\u0639\u0644\u064a'),
  _ReportReason(
      'other',
      '\u0645\u0644\u0627\u062d\u0638\u0629 \u0623\u062e\u0631\u0649',
      ''),
];

const _platformManagedReasons = [
  _ReportReason(
      'suggest_update',
      '\u0627\u0642\u062a\u0631\u0627\u062d \u062a\u062d\u062f\u064a\u062b',
      '\u0644\u062f\u064a\u0651 \u0645\u0639\u0644\u0648\u0645\u0627\u062a \u0623\u062d\u062f\u062b \u0623\u0648 \u0623\u062f\u0642'),
  _ReportReason(
      'not_official',
      '\u0644\u064a\u0633 \u062d\u0633\u0627\u0628\u0627\u064b \u0631\u0633\u0645\u064a\u0627\u064b',
      '\u0647\u0630\u0647 \u0627\u0644\u062c\u0647\u0629 \u0644\u0627 \u062a\u0633\u062a\u062e\u062f\u0645 \u0647\u0646\u0627\u0643 \u0631\u0633\u0645\u064a\u0627\u064b'),
  _ReportReason(
      'other',
      '\u0645\u0644\u0627\u062d\u0638\u0629 \u0623\u062e\u0631\u0649',
      ''),
];

// ─── Helper functions ───────────────────────────────────────

List<_ReportReason> _getReasons(String claimStatus) {
  switch (claimStatus) {
    case 'unclaimed':
      return _unclaimedReasons;
    case 'platform_managed':
      return _platformManagedReasons;
    default:
      return _claimedReasons;
  }
}

String _getTitle(String claimStatus) {
  switch (claimStatus) {
    case 'unclaimed':
      return '\u0627\u0644\u0625\u0628\u0644\u0627\u063a \u0639\u0646 \u0645\u0639\u0644\u0648\u0645\u0627\u062a \u062e\u0627\u0637\u0626\u0629';
    case 'platform_managed':
      return '\u0627\u0642\u062a\u0631\u0627\u062d \u062a\u0635\u062d\u064a\u062d';
    default:
      return '\u0627\u0644\u0625\u0628\u0644\u0627\u063a \u0639\u0646 \u0647\u0630\u0647 \u0627\u0644\u0635\u0641\u062d\u0629';
  }
}

String _getSubmitLabel(String claimStatus) {
  switch (claimStatus) {
    case 'platform_managed':
      return '\u0625\u0631\u0633\u0627\u0644 \u0627\u0644\u0627\u0642\u062a\u0631\u0627\u062d';
    default:
      return '\u0625\u0631\u0633\u0627\u0644 \u0627\u0644\u0628\u0644\u0627\u063a';
  }
}

({String title, String desc}) _getSuccessMessage(String claimStatus) {
  switch (claimStatus) {
    case 'unclaimed':
      return (
        title: '\u0634\u0643\u0631\u0627\u064b \u0644\u0645\u0633\u0627\u0639\u062f\u062a\u0646\u0627!',
        desc: '\u0628\u0646\u0631\u0627\u062c\u0639 \u0627\u0644\u0645\u0639\u0644\u0648\u0645\u0627\u062a \u0648\u0646\u062d\u062f\u0651\u062b\u0647\u0627 \u2014 \u0647\u064a\u0643 \u0628\u0646\u062d\u0633\u0651\u0646 \u0627\u0644\u062a\u062c\u0631\u0628\u0629 \u0644\u0644\u062c\u0645\u064a\u0639',
      );
    case 'platform_managed':
      return (
        title: '\u062a\u0645 \u0627\u0633\u062a\u0644\u0627\u0645 \u0627\u0642\u062a\u0631\u0627\u062d\u0643',
        desc: '\u0633\u0646\u0631\u0627\u062c\u0639\u0647 \u0648\u0646\u062d\u062f\u0651\u062b \u0627\u0644\u0645\u0639\u0644\u0648\u0645\u0627\u062a \u0625\u0646 \u0644\u0632\u0645 \u0627\u0644\u0623\u0645\u0631',
      );
    default:
      return (
        title: '\u062a\u0645 \u0627\u0633\u062a\u0644\u0627\u0645 \u0628\u0644\u0627\u063a\u0643',
        desc: '\u0633\u064a\u062a\u0645 \u0645\u0631\u0627\u062c\u0639\u062a\u0647 \u0645\u0646 \u0641\u0631\u064a\u0642\u0646\u0627 \u0648\u0633\u0646\u062a\u062e\u0630 \u0627\u0644\u0625\u062c\u0631\u0627\u0621 \u0627\u0644\u0645\u0646\u0627\u0633\u0628',
      );
  }
}

bool _showCorrectionFields(String reasonId) {
  return ['wrong_contact', 'wrong_info', 'moved', 'suggest_update']
      .contains(reasonId);
}

// ─── Report Sheet ───────────────────────────────────────────

/// Claim-status-aware report sheet matching Figma ReportSheet.tsx.
class ReportSheet extends StatefulWidget {
  final String pageName;
  final String claimStatus;

  const ReportSheet._({
    required this.pageName,
    required this.claimStatus,
  });

  /// Opens the report sheet as a bottom sheet.
  static void show({
    required BuildContext context,
    required String pageName,
    required String claimStatus,
  }) {
    showAppSheet<void>(
      context,
      builder: (_) => ReportSheet._(
        pageName: pageName,
        claimStatus: claimStatus,
      ),
    );
  }

  @override
  State<ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends State<ReportSheet> {
  String _selectedReason = '';
  final _otherController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();
  bool _submitted = false;

  bool get _isPlatformManaged => widget.claimStatus == 'platform_managed';
  bool get _isUnclaimed => widget.claimStatus == 'unclaimed';

  Color get _accentColor =>
      _isPlatformManaged ? context.colorScheme.primary : Colors.red.shade600;

  Color get _accentBg => _isPlatformManaged
      ? Colors.blue.shade50
      : Colors.red.shade50;

  bool get _canSubmit =>
      _selectedReason.isNotEmpty &&
      (_selectedReason != 'other' ||
          _otherController.text.trim().isNotEmpty);

  @override
  void dispose() {
    _otherController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    setState(() => _submitted = true);
  }

  @override
  Widget build(BuildContext context) {
    final title = _getTitle(widget.claimStatus);
    final reasons = _getReasons(widget.claimStatus);
    final submitLabel = _getSubmitLabel(widget.claimStatus);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Drag handle
        Padding(
          padding: const EdgeInsets.only(top: AppSpacing.sm),
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.colorScheme.outlineVariant,
              borderRadius: AppRadius.pill,
            ),
          ),
        ),

        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.pageName,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 14,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),

        if (_submitted)
          _buildSuccess(context)
        else ...[
          Divider(height: 1, color: context.colorScheme.outlineVariant.withValues(alpha: 0.5)),

          // Scrollable content — auto-expands, scrolls only if needed
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Info banner for unclaimed pages
                  if (_isUnclaimed) ...[
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: AppRadius.cardInner,
                        border: Border.all(
                          color: Colors.blue.shade100,
                        ),
                      ),
                      child: Text(
                        '\u0647\u0630\u0647 \u0627\u0644\u0635\u0641\u062d\u0629 \u062a\u0645 \u0625\u0646\u0634\u0627\u0624\u0647\u0627 \u062a\u0644\u0642\u0627\u0626\u064a\u0627\u064b \u0645\u0646 \u0628\u064a\u0627\u0646\u0627\u062a \u0639\u0627\u0645\u0629.\n\u0628\u0644\u0627\u063a\u0643 \u064a\u0633\u0627\u0639\u062f\u0646\u0627 \u0646\u062d\u0633\u0651\u0646 \u062f\u0642\u0629 \u0627\u0644\u0645\u0639\u0644\u0648\u0645\u0627\u062a \u0644\u0644\u062c\u0645\u064a\u0639.',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                          fontSize: 11,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],

                  // Reason radio buttons
                  ...reasons.map((reason) => _ReasonOption(
                        reason: reason,
                        isSelected: _selectedReason == reason.id,
                        accentColor: _accentColor,
                        accentBg: _accentBg,
                        onTap: () =>
                            setState(() => _selectedReason = reason.id),
                      )),

                  // Other text area
                  if (_selectedReason == 'other') ...[
                    const SizedBox(height: AppSpacing.sm),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md),
                      child: TextField(
                        controller: _otherController,
                        onChanged: (_) => setState(() {}),
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: _isPlatformManaged
                              ? '\u0627\u0643\u062a\u0628 \u0627\u0642\u062a\u0631\u0627\u062d\u0643...'
                              : '\u0627\u0643\u062a\u0628 \u0627\u0644\u0633\u0628\u0628...',
                          hintStyle: TextStyle(
                            color: context.colorScheme.outlineVariant,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: context.colorScheme.outlineVariant,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: context.colorScheme.outlineVariant,
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(AppSpacing.md),
                        ),
                      ),
                    ),
                  ],

                  // Correction fields
                  if (_showCorrectionFields(_selectedReason)) ...[
                    const SizedBox(height: AppSpacing.md),
                    _CorrectionFields(
                      phoneController: _phoneController,
                      addressController: _addressController,
                      notesController: _notesController,
                      isMoved: _selectedReason == 'moved',
                    ),
                  ],

                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ),

          // Submit button
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.md),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: _canSubmit ? _handleSubmit : null,
                style: FilledButton.styleFrom(
                  backgroundColor: _canSubmit ? _accentColor : null,
                  disabledBackgroundColor:
                      context.colorScheme.surfaceContainerHighest,
                  disabledForegroundColor:
                      context.colorScheme.outlineVariant,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(submitLabel),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSuccess(BuildContext context) {
    final msg = _getSuccessMessage(widget.claimStatus);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle,
              size: 32,
              color: AppColors.success,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            msg.title,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            msg.desc,
            style: TextStyle(
              fontSize: 13,
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─── Radio option row ───────────────────────────────────────

class _ReasonOption extends StatelessWidget {
  final _ReportReason reason;
  final bool isSelected;
  final Color accentColor;
  final Color accentBg;
  final VoidCallback onTap;

  const _ReasonOption({
    required this.reason,
    required this.isSelected,
    required this.accentColor,
    required this.accentBg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.xs),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: isSelected ? accentBg : null,
            borderRadius: AppRadius.cardInner,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Radio circle
              Container(
                width: 20,
                height: 20,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? accentColor : context.colorScheme.outline,
                    width: 2,
                  ),
                  color: isSelected ? accentColor : Colors.transparent,
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : null,
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reason.label,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: isSelected ? accentColor : null,
                      ),
                    ),
                    if (reason.desc.isNotEmpty)
                      Text(
                        reason.desc,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                          fontSize: 10,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Correction fields ──────────────────────────────────────

class _CorrectionFields extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController notesController;
  final bool isMoved;

  const _CorrectionFields({
    required this.phoneController,
    required this.addressController,
    required this.notesController,
    required this.isMoved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: AppRadius.cardInner,
        border: Border.all(
          color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '\u0647\u0644 \u062a\u0639\u0631\u0641 \u0627\u0644\u0645\u0639\u0644\u0648\u0645\u0627\u062a \u0627\u0644\u0635\u062d\u064a\u062d\u0629\u061f',
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2),
          Text(
            '\u0627\u062e\u062a\u064a\u0627\u0631\u064a \u2014 \u0625\u0630\u0627 \u062a\u0639\u0631\u0641\u060c \u0633\u0627\u0639\u062f\u0646\u0627 \u0646\u0635\u062d\u0651\u062d. \u0633\u0646\u0631\u0627\u062c\u0639\u0647\u0627 \u0642\u0628\u0644 \u0627\u0644\u062a\u062d\u062f\u064a\u062b.',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              fontSize: 10,
            ),
          ),
          SizedBox(height: AppSpacing.md),

          // Phone
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.colorScheme.outlineVariant,
                  ),
                ),
                child: Icon(
                  Icons.phone_outlined,
                  size: 13,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(width: AppSpacing.sm),
              Expanded(
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText:
                        '\u0631\u0642\u0645 \u0627\u0644\u0647\u0627\u062a\u0641 \u0627\u0644\u0635\u062d\u064a\u062d',
                    hintStyle: TextStyle(
                      color: context.colorScheme.outlineVariant,
                      fontSize: 14,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: context.colorScheme.outlineVariant,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: context.colorScheme.outlineVariant,
                      ),
                    ),
                    filled: true,
                    fillColor: context.colorScheme.surface,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),

          // Address
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.colorScheme.outlineVariant,
                  ),
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 13,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(width: AppSpacing.sm),
              Expanded(
                child: TextField(
                  controller: addressController,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: isMoved
                        ? '\u0627\u0644\u0639\u0646\u0648\u0627\u0646 \u0627\u0644\u062c\u062f\u064a\u062f'
                        : '\u0627\u0644\u0639\u0646\u0648\u0627\u0646 \u0627\u0644\u0635\u062d\u064a\u062d',
                    hintStyle: TextStyle(
                      color: context.colorScheme.outlineVariant,
                      fontSize: 14,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: context.colorScheme.outlineVariant,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: context.colorScheme.outlineVariant,
                      ),
                    ),
                    filled: true,
                    fillColor: context.colorScheme.surface,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),

          // Notes
          TextField(
            controller: notesController,
            maxLines: 2,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText:
                  '\u0645\u0644\u0627\u062d\u0638\u0627\u062a \u0625\u0636\u0627\u0641\u064a\u0629 (\u0627\u062e\u062a\u064a\u0627\u0631\u064a)',
              hintStyle: TextStyle(
                color: context.colorScheme.outlineVariant,
                fontSize: 14,
              ),
              isDense: true,
              contentPadding: EdgeInsets.all(AppSpacing.md),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: context.colorScheme.outlineVariant,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: context.colorScheme.outlineVariant,
                ),
              ),
              filled: true,
              fillColor: context.colorScheme.surface,
            ),
          ),
        ],
      ),
    );
  }
}
