import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Drag handle, title ("طلب حجز"), page name, and close button.
class ReservationSheetHeader extends StatelessWidget {
  final String pageName;
  final VoidCallback onClose;

  const ReservationSheetHeader({
    super.key,
    required this.pageName,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xl, AppSpacing.md, AppSpacing.xl, AppSpacing.sm,
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('طلب حجز', style: theme.textTheme.bodySmall),
                  Text(
                    pageName,
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: context.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close, size: 20),
                style: IconButton.styleFrom(
                  foregroundColor: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Navigation footer: back/next buttons on intermediate steps,
/// submit button on the final step, plus validation hints.
class ReservationSheetFooter extends StatelessWidget {
  final bool isLast;
  final bool isFirst;
  final bool canAdvance;
  final String currentStepId;
  final int guestNum;
  final VoidCallback onSubmit;
  final VoidCallback onNext;
  final VoidCallback onBack;

  /// Whether the entire form satisfies the minimum to submit
  /// (date selected + at least 1 guest).
  final bool canSubmitAll;

  const ReservationSheetFooter({
    super.key,
    required this.isLast,
    required this.isFirst,
    required this.canAdvance,
    required this.currentStepId,
    required this.guestNum,
    required this.onSubmit,
    required this.onNext,
    required this.onBack,
    required this.canSubmitAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.xl, AppSpacing.sm, AppSpacing.xl, AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLast) ...[
              _submitButton(),
            ] else ...[
              _navigationRow(),
            ],
            if (!isLast && !canAdvance) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                _hintText(),
                style: theme.textTheme.labelSmall
                    ?.copyWith(color: context.colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return btn.Button(
      onPressed: canSubmitAll ? onSubmit : null,
      label: 'إرسال طلب الحجز',
      icon: const btn.ButtonIcon(Icons.send),
      size: btn.ButtonSize.large,
      expand: true,
    );
  }

  Widget _navigationRow() {
    return Row(
      children: [
        if (!isFirst)
          Padding(
            padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
            child: btn.Button(
              onPressed: onBack,
              label: 'رجوع',
              icon: btn.ButtonIcon.backArrow(),
              variant: btn.Variant.outlined,
              size: btn.ButtonSize.large,
            ),
          ),
        Expanded(
          child: btn.Button(
            onPressed: canAdvance ? onNext : null,
            label: 'التالي',
            icon: btn.ButtonIcon.forwardArrow(),
            size: btn.ButtonSize.large,
          ),
        ),
      ],
    );
  }

  String _hintText() {
    return switch (currentStepId) {
      'date' => 'اختر تاريخ الوصول والمغادرة',
      'details' =>
        guestNum < 1 ? 'أدخل عدد الضيوف' : 'تجاوزت الحد الأقصى للضيوف',
      'questions' => 'أجب على الأسئلة المطلوبة (*)',
      _ => '',
    };
  }
}
