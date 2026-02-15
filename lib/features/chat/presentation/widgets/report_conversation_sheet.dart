import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

// ─── Report reason model ────────────────────────────────────

class _ReportReason {
  final String id;
  final String label;
  final IconData icon;
  final Color iconColor;
  const _ReportReason(this.id, this.label, this.icon, this.iconColor);
}

const _reportReasons = [
  _ReportReason('inappropriate', 'محتوى غير لائق', Icons.warning_amber_rounded, Color(0xFFF87171)), // red-400
  _ReportReason('harassment', 'مضايقة أو تنمر', Icons.shield_outlined, Color(0xFFFB923C)), // orange-400
  _ReportReason('fraud', 'احتيال أو خداع', Icons.warning_amber_rounded, Color(0xFFF59E0B)), // amber-500
  _ReportReason('impersonation', 'انتحال هوية', Icons.shield_outlined, Color(0xFFC084FC)), // purple-400
  _ReportReason('spam', 'محتوى مزعج أو غير مرغوب', Icons.message_outlined, Color(0xFF9CA3AF)), // gray-400
  _ReportReason('threats', 'تهديد أو محتوى خطير', Icons.warning_amber_rounded, Color(0xFFDC2626)), // red-600
  _ReportReason('other', 'أخرى', Icons.flag_outlined, Color(0xFF9CA3AF)), // gray-400
];

// ─── Report data ────────────────────────────────────────────

class ChatReportData {
  final String scope; // 'all' or 'specific'
  final Set<String> selectedMessageIds;
  final String reasonId;
  final String reasonLabel;
  final String? customReason;
  final bool allowReadAccess;

  const ChatReportData({
    required this.scope,
    required this.selectedMessageIds,
    required this.reasonId,
    required this.reasonLabel,
    this.customReason,
    required this.allowReadAccess,
  });
}

// ─── Sheet ──────────────────────────────────────────────────

/// 3-step report conversation sheet matching Figma ReportConversationSheet.tsx.
///
/// Step 1: Choose scope (entire conversation / specific messages)
/// Step 2: Select reason
/// Step 3: Permission + summary + submit
class ReportConversationSheet extends StatefulWidget {
  final String conversationName;
  final Set<String> preSelectedIds;
  final void Function(ChatReportData report) onSubmit;
  final VoidCallback? onSelectInChat;

  const ReportConversationSheet._({
    required this.conversationName,
    required this.preSelectedIds,
    required this.onSubmit,
    this.onSelectInChat,
  });

  static void show({
    required BuildContext context,
    required String conversationName,
    Set<String> preSelectedIds = const {},
    required void Function(ChatReportData report) onSubmit,
    VoidCallback? onSelectInChat,
  }) {
    showAppSheet<void>(
      context,
      builder: (_) => ReportConversationSheet._(
        conversationName: conversationName,
        preSelectedIds: preSelectedIds,
        onSubmit: onSubmit,
        onSelectInChat: onSelectInChat,
      ),
    );
  }

  @override
  State<ReportConversationSheet> createState() =>
      _ReportConversationSheetState();
}

class _ReportConversationSheetState extends State<ReportConversationSheet> {
  late int _step;
  String? _scope; // 'all' | 'specific'
  late Set<String> _selectedIds;
  String? _reasonId;
  final _customReasonController = TextEditingController();
  bool _allowRead = true;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    final hasPreSelected = widget.preSelectedIds.isNotEmpty;
    _step = hasPreSelected ? 2 : 1;
    _scope = hasPreSelected ? 'specific' : null;
    _selectedIds = Set.of(widget.preSelectedIds);
  }

  @override
  void dispose() {
    _customReasonController.dispose();
    super.dispose();
  }

  bool get _canProceedFromReason =>
      _reasonId != null &&
      (_reasonId != 'other' || _customReasonController.text.trim().isNotEmpty);

  bool get _canSubmit => _canProceedFromReason && _allowRead;

  // ── Step titles ─────────────────────────────────────────────
  static const _stepTitles = {
    1: 'الإبلاغ عن المحادثة',
    2: 'سبب الإبلاغ',
    3: 'تأكيد البلاغ',
  };

  // ── Navigation ──────────────────────────────────────────────

  void _handleScopeSelect(String scope) {
    setState(() => _scope = scope);
    if (scope == 'all') {
      setState(() => _step = 2);
    } else {
      // 'specific' → dismiss sheet, enter chat selection mode
      Navigator.pop(context);
      widget.onSelectInChat?.call();
    }
  }

  void _handleBack() {
    if (_step == 3) {
      setState(() => _step = 2);
    } else if (_step == 2 && widget.preSelectedIds.isEmpty) {
      setState(() {
        _scope = null;
        _selectedIds = {};
        _step = 1;
      });
    } else if (_step == 2 && widget.preSelectedIds.isNotEmpty) {
      Navigator.pop(context);
      widget.onSelectInChat?.call();
    }
  }

  void _handleSubmit() {
    if (_reasonId == null) return;
    final reason = _reportReasons.firstWhere((r) => r.id == _reasonId);
    widget.onSubmit(ChatReportData(
      scope: _scope ?? 'all',
      selectedMessageIds: _selectedIds,
      reasonId: _reasonId!,
      reasonLabel: reason.label,
      customReason:
          _reasonId == 'other' ? _customReasonController.text.trim() : null,
      allowReadAccess: _allowRead,
    ));
    setState(() => _submitted = true);
  }

  @override
  Widget build(BuildContext context) {
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
        _buildHeader(context),

        if (!_submitted) ...[
          // Step indicator
          _buildStepIndicator(context),

          Divider(
            height: 1,
            color: context.colorScheme.outlineVariant
                .withValues(alpha: 0.5),
          ),

          // Content — flexible, scrollable when needed
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: _step == 1
                  ? _buildScopeStep(context)
                  : _step == 2
                      ? _buildReasonStep(context)
                      : _buildConfirmStep(context),
            ),
          ),
        ] else
          _buildSuccess(context),
      ],
    );
  }

  // ── Header ──────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.sm,
      ),
      child: Row(
        children: [
          // Back button (step 2+ when not submitted)
          if (_step > 1 && !_submitted)
            GestureDetector(
              onTap: _handleBack,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),

          // Flag badge
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.flag_rounded,
              size: 14,
              color: Colors.red.shade500,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),

          // Title
          Expanded(
            child: Text(
              _submitted ? 'الإبلاغ عن المحادثة' : (_stepTitles[_step] ?? ''),
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Close button
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
    );
  }

  // ── Step indicator ──────────────────────────────────────────

  Widget _buildStepIndicator(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.sm,
      ),
      child: Row(
        children: List.generate(3, (i) {
          final stepNum = i + 1;
          final isActive = stepNum <= _step;
          return Expanded(
            child: Container(
              height: 4,
              margin: EdgeInsetsDirectional.only(
                end: i < 2 ? 6 : 0,
              ),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primary
                    : context.colorScheme.surfaceContainerHighest,
                borderRadius: AppRadius.pill,
              ),
            ),
          );
        }),
      ),
    );
  }

  // ── Step 1: Scope ───────────────────────────────────────────

  Widget _buildScopeStep(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: 'اختر ما تريد الإبلاغ عنه في محادثتك مع ',
            children: [
              TextSpan(
                text: widget.conversationName,
                style: TextStyle(color: context.colorScheme.onSurface),
              ),
            ],
          ),
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Entire conversation
        _ScopeOption(
          icon: Icons.message_outlined,
          iconBg: Colors.red.shade50,
          iconColor: Colors.red.shade400,
          title: 'المحادثة بالكامل',
          subtitle: 'الإبلاغ عن جميع الرسائل في هذه المحادثة',
          onTap: () => _handleScopeSelect('all'),
        ),
        const SizedBox(height: AppSpacing.md),

        // Specific messages
        _ScopeOption(
          icon: Icons.sms_outlined,
          iconBg: Colors.amber.shade50,
          iconColor: Colors.amber.shade500,
          title: 'رسائل محددة',
          subtitle: 'حدد الرسائل في المحادثة ثم عد للإبلاغ',
          onTap: () => _handleScopeSelect('specific'),
        ),
      ],
    );
  }

  // ── Step 2: Reason ──────────────────────────────────────────

  Widget _buildReasonStep(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pre-selected messages summary
        if (_scope == 'specific' && _selectedIds.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF), // blue-50
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Row(
              children: [
                const Icon(Icons.sms_outlined, size: 14, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  '${_selectedIds.length} رسالة محددة',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],

        // Section label
        Text(
          'ما سبب الإبلاغ؟',
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Reason options
        ...List.generate(_reportReasons.length, (i) {
          final reason = _reportReasons[i];
          final isSelected = _reasonId == reason.id;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _ReasonOption(
              reason: reason,
              isSelected: isSelected,
              onTap: () => setState(() => _reasonId = reason.id),
            ),
          );
        }),

        // Custom reason
        if (_reasonId == 'other') ...[
          const SizedBox(height: AppSpacing.xs),
          TextField(
            controller: _customReasonController,
            onChanged: (_) => setState(() {}),
            maxLength: 300,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'اذكر السبب...',
              hintStyle: TextStyle(
                color: context.colorScheme.outlineVariant,
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                borderSide: BorderSide(
                  color: context.colorScheme.outlineVariant,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                borderSide: BorderSide(
                  color: context.colorScheme.outlineVariant,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
              filled: true,
              fillColor: context.colorScheme.surfaceContainerHighest
                  .withValues(alpha: 0.3),
              contentPadding: const EdgeInsets.all(AppSpacing.md),
            ),
          ),
        ],

        const SizedBox(height: AppSpacing.lg),

        // Next button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: FilledButton(
            onPressed: _canProceedFromReason
                ? () => setState(() => _step = 3)
                : null,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              disabledBackgroundColor:
                  context.colorScheme.surfaceContainerHighest,
              disabledForegroundColor: context.colorScheme.outlineVariant,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
            child: const Text('متابعة'),
          ),
        ),
      ],
    );
  }

  // ── Step 3: Confirm ─────────────────────────────────────────

  Widget _buildConfirmStep(BuildContext context) {
    final reason = _reportReasons.firstWhere(
      (r) => r.id == _reasonId,
      orElse: () => _reportReasons.last,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Permission toggle
        GestureDetector(
          onTap: () => setState(() => _allowRead = !_allowRead),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: _allowRead
                  ? const Color(0xFFEFF6FF).withValues(alpha: 0.3)
                  : null,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: _allowRead
                    ? const Color(0xFFBFDBFE) // blue-200
                    : context.colorScheme.outlineVariant,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Checkbox
                Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.only(top: 2),
                  decoration: BoxDecoration(
                    color: _allowRead ? AppColors.primary : context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: _allowRead
                          ? AppColors.primary
                          : context.colorScheme.outline,
                      width: 2,
                    ),
                  ),
                  child: _allowRead
                      ? const Icon(Icons.check, size: 12, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: AppSpacing.md),

                // Label + description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.visibility_outlined,
                            size: 14,
                            color: _allowRead
                                ? AppColors.primary
                                : context.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'أسمح لفريق هناك.app بقراءة المحادثة',
                              style: context.textTheme.bodySmall?.copyWith(
                                color: _allowRead
                                    ? context.colorScheme.onSurface
                                    : context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'لكي نتمكن من مراجعة البلاغ واتخاذ الإجراء المناسب، نحتاج إذنك لقراءة'
                        '${_scope == 'specific' ? ' الرسائل المحددة' : ' المحادثة'}',
                        style: TextStyle(
                          fontSize: 10,
                          color: context.colorScheme.onSurfaceVariant,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Warning when not allowing read
        if (!_allowRead) ...[
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: Colors.amber.shade100),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 14,
                  color: Colors.amber.shade500,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'بدون إذن القراءة، لن يتمكن فريقنا من مراجعة المحتوى المُبلغ عنه واتخاذ إجراء فعّال',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.amber.shade800,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: AppSpacing.lg),

        // Summary
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest
                .withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ملخص البلاغ',
                style: TextStyle(
                  fontSize: 10,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 6),
              // Scope
              _SummaryRow(
                icon: Icons.message_outlined,
                iconColor: context.colorScheme.onSurfaceVariant,
                text: _scope == 'all'
                    ? 'المحادثة بالكامل'
                    : '${_selectedIds.length} رسالة محددة',
              ),
              const SizedBox(height: 6),
              // Reason
              _SummaryRow(
                icon: Icons.flag_outlined,
                iconColor: context.colorScheme.onSurfaceVariant,
                text: _reasonId == 'other' &&
                        _customReasonController.text.trim().isNotEmpty
                    ? '${reason.label}: ${_customReasonController.text.trim()}'
                    : reason.label,
              ),
              const SizedBox(height: 6),
              // Permission
              _SummaryRow(
                icon: Icons.visibility_outlined,
                iconColor:
                    _allowRead ? AppColors.primary : context.colorScheme.onSurfaceVariant,
                text: _allowRead ? 'مسموح بالقراءة' : 'غير مسموح بالقراءة',
                textColor: _allowRead ? AppColors.primary : context.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // Submit button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: FilledButton.icon(
            onPressed: _canSubmit ? _handleSubmit : null,
            icon: Transform.flip(
              flipX: true,
              child: const Icon(Icons.send, size: 14),
            ),
            label: const Text('إرسال البلاغ'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              disabledBackgroundColor:
                  context.colorScheme.surfaceContainerHighest,
              disabledForegroundColor: context.colorScheme.outlineVariant,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Success ─────────────────────────────────────────────────

  Widget _buildSuccess(BuildContext context) {
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
            'تم استلام بلاغك',
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'سنراجعه خلال ٢٤ ساعة واتخاذ الإجراء المناسب',
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

// ─── Scope option card ────────────────────────────────────────

class _ScopeOption extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ScopeOption({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: context.colorScheme.outlineVariant),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 10,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_left,
              size: 16,
              color: context.colorScheme.outlineVariant,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Reason option row ────────────────────────────────────────

class _ReasonOption extends StatelessWidget {
  final _ReportReason reason;
  final bool isSelected;
  final VoidCallback onTap;

  const _ReasonOption({
    required this.reason,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF6FF).withValues(alpha: 0.5) : null,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : context.colorScheme.surfaceContainerHighest,
          ),
        ),
        child: Row(
          children: [
            // Radio circle
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : context.colorScheme.outline,
                  width: 2,
                ),
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
            const SizedBox(width: AppSpacing.md),

            // Icon
            Icon(reason.icon, size: 16, color: reason.iconColor),
            const SizedBox(width: AppSpacing.md),

            // Label
            Expanded(
              child: Text(
                reason.label,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Summary row ──────────────────────────────────────────────

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  final Color? textColor;

  const _SummaryRow({
    required this.icon,
    required this.iconColor,
    required this.text,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 12, color: iconColor),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: textColor ?? context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
