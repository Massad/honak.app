import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/entities/money.dart';

/// Step 3: Confirmation summary with notes.
class ConfirmStepContent extends StatelessWidget {
  final String serviceName;
  final int priceCents;
  final int durationMinutes;
  final String? memberName;
  final DateTime? selectedDate;
  final String? selectedTime;
  final TextEditingController notesController;

  const ConfirmStepContent({
    super.key,
    required this.serviceName,
    required this.priceCents,
    required this.durationMinutes,
    this.memberName,
    this.selectedDate,
    this.selectedTime,
    required this.notesController,
  });

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final price = Money(priceCents);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                _SummaryRow(
                  // \u0627\u0644\u062e\u062f\u0645\u0629 = "Service"
                  label: '\u0627\u0644\u062e\u062f\u0645\u0629',
                  value: serviceName,
                ),
                const SizedBox(height: AppSpacing.md),
                _SummaryRow(
                  // \u0627\u0644\u0645\u0648\u0638\u0641 = "Team member"
                  label: '\u0627\u0644\u0645\u0648\u0638\u0641',
                  value: memberName ??
                      '\u0623\u064a \u0634\u062e\u0635 \u0645\u062a\u0627\u062d',
                ),
                const SizedBox(height: AppSpacing.md),
                _SummaryRow(
                  // \u0627\u0644\u062a\u0627\u0631\u064a\u062e = "Date"
                  label: '\u0627\u0644\u062a\u0627\u0631\u064a\u062e',
                  value: _formatDate(selectedDate),
                ),
                const SizedBox(height: AppSpacing.md),
                _SummaryRow(
                  // \u0627\u0644\u0648\u0642\u062a = "Time"
                  label: '\u0627\u0644\u0648\u0642\u062a',
                  value: selectedTime ?? '-',
                ),
                const SizedBox(height: AppSpacing.md),
                _SummaryRow(
                  // \u0627\u0644\u0645\u062f\u0629 = "Duration"
                  label: '\u0627\u0644\u0645\u062f\u0629',
                  // \u062f\u0642\u064a\u0642\u0629 = "minutes"
                  value: '$durationMinutes \u062f\u0642\u064a\u0642\u0629',
                ),
                const Divider(height: AppSpacing.xxl),
                _SummaryRow(
                  // \u0627\u0644\u0633\u0639\u0631 = "Price"
                  label: '\u0627\u0644\u0633\u0639\u0631',
                  value: price.toFormattedArabic(),
                  isBold: true,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          // \u0645\u0644\u0627\u062d\u0638\u0627\u062a = "Notes"
          '\u0645\u0644\u0627\u062d\u0638\u0627\u062a',
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: notesController,
          maxLines: 3,
          decoration: InputDecoration(
            // \u0623\u0636\u0641 \u0645\u0644\u0627\u062d\u0638\u0627\u062a... = "Add notes..."
            hintText:
                '\u0623\u0636\u0641 \u0645\u0644\u0627\u062d\u0638\u0627\u062a...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: isBold ? context.colorScheme.primary : null,
          ),
        ),
      ],
    );
  }
}
