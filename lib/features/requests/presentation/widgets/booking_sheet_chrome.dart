import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Drag handle bar at the top of the booking bottom sheet.
class BookingSheetDragHandle extends StatelessWidget {
  const BookingSheetDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: AppSpacing.md, bottom: AppSpacing.sm),
      child: Center(
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: context.colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

/// Header row with title and close button.
class BookingSheetHeader extends StatelessWidget {
  final VoidCallback onClose;

  const BookingSheetHeader({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xl, 0, AppSpacing.xl, AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'طلب حجز',
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
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
    );
  }
}

/// Label showing "حجز في [pageName]".
class BookingBusinessLabel extends StatelessWidget {
  final String pageName;

  const BookingBusinessLabel({super.key, required this.pageName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          'حجز في',
          style: theme.textTheme.bodySmall
              ?.copyWith(color: context.colorScheme.onSurfaceVariant),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          pageName,
          style: theme.textTheme.bodySmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

/// Optional note text field.
class BookingNoteField extends StatelessWidget {
  final TextEditingController controller;

  const BookingNoteField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ملاحظة (اختياري)',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: controller,
          maxLines: 2,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: 'أي ملاحظات إضافية...',
            hintStyle: theme.textTheme.bodySmall
                ?.copyWith(color: context.colorScheme.onSurfaceVariant),
            filled: true,
            fillColor: context.colorScheme.surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: AppRadius.cardInner,
              borderSide: BorderSide(color: context.colorScheme.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.cardInner,
              borderSide: BorderSide(color: context.colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.cardInner,
              borderSide: BorderSide(color: AppColors.primary),
            ),
            contentPadding: const EdgeInsets.all(AppSpacing.md),
          ),
        ),
      ],
    );
  }
}

/// Bottom submit button with price and validation.
class BookingSubmitButton extends StatelessWidget {
  final bool questionsValid;
  final String servicePriceStr;
  final VoidCallback onSubmit;

  const BookingSubmitButton({
    super.key,
    required this.questionsValid,
    required this.servicePriceStr,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.xl, AppSpacing.sm, AppSpacing.xl, AppSpacing.lg,
        ),
        child: SizedBox(
          width: double.infinity,
          child: btn.Button(
            onPressed: questionsValid ? onSubmit : null,
            label: 'إرسال طلب الحجز$servicePriceStr',
            icon: const btn.ButtonIcon(Icons.calendar_today),
            size: btn.ButtonSize.large,
            expand: true,
          ),
        ),
      ),
    );
  }
}
