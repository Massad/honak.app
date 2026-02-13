import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/domain/entities/customer_request.dart';

/// Bottom sheet for rescheduling a booking or reservation.
class RescheduleSheet extends StatefulWidget {
  final CustomerRequest request;
  final void Function(String newTime, String reason) onSubmit;

  const RescheduleSheet({
    super.key,
    required this.request,
    required this.onSubmit,
  });

  @override
  State<RescheduleSheet> createState() => _RescheduleSheetState();
}

class _RescheduleSheetState extends State<RescheduleSheet> {
  final _newTimeController = TextEditingController();
  final _reasonController = TextEditingController();
  bool get _isValid => _newTimeController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _newTimeController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isReservation = widget.request.isReservation;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppRadius.xxl)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: AppSpacing.md),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: AppSpacing.xl,
              end: AppSpacing.sm,
              top: AppSpacing.md,
              bottom: AppSpacing.md,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\u0625\u0639\u0627\u062f\u0629 \u062c\u062f\u0648\u0644\u0629 \u0627\u0644\u062d\u062c\u0632',
                  style: textTheme.titleSmall,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, size: 20),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),
          // Content
          Flexible(
            child: ListView(
              padding: const EdgeInsetsDirectional.all(AppSpacing.xl),
              shrinkWrap: true,
              children: [
                _CurrentBookingCard(request: widget.request),
                const SizedBox(height: AppSpacing.xl),
                _buildFieldLabel(textTheme, '\u0627\u0644\u0645\u0648\u0639\u062f \u0627\u0644\u062c\u062f\u064a\u062f \u0627\u0644\u0645\u0641\u0636\u0644'),
                const SizedBox(height: AppSpacing.sm),
                _buildTextField(
                  controller: _newTimeController,
                  maxLines: 3,
                  hint: isReservation
                      ? '\u0645\u062b\u0627\u0644: \u0627\u0644\u0633\u0628\u062a \u0627\u0644\u0642\u0627\u062f\u0645 \u0645\u0646 \u0663 \u0625\u0644\u0649 \u0666 \u0645\u0633\u0627\u0621\u064b'
                      : '\u0645\u062b\u0627\u0644: \u0627\u0644\u0623\u062d\u062f \u0664 \u0645\u0633\u0627\u0621\u064b \u0623\u0648 \u0623\u064a \u064a\u0648\u0645 \u0628\u0639\u062f \u0627\u0644\u0638\u0647\u0631',
                  textTheme: textTheme,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: AppSpacing.xl),
                _buildFieldLabel(textTheme, '\u0633\u0628\u0628 \u0627\u0644\u062a\u063a\u064a\u064a\u0631 (\u0627\u062e\u062a\u064a\u0627\u0631\u064a)'),
                const SizedBox(height: AppSpacing.sm),
                _buildTextField(
                  controller: _reasonController,
                  maxLines: 2,
                  hint: '\u0645\u062b\u0627\u0644: \u0639\u0646\u062f\u064a \u0627\u0644\u062a\u0632\u0627\u0645 \u064a\u0648\u0645 \u0627\u0644\u0633\u0628\u062a',
                  textTheme: textTheme,
                ),
                const SizedBox(height: AppSpacing.xl),
                // Info note
                Container(
                  padding: const EdgeInsetsDirectional.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.05),
                    borderRadius: AppRadius.cardInner,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 12, color: AppColors.primary),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          '\u0633\u064a\u062a\u0645 \u0625\u0639\u0644\u0627\u0645 \u0627\u0644\u0645\u062a\u062c\u0631 \u0648\u0627\u0646\u062a\u0638\u0627\u0631 \u0627\u0644\u0645\u0648\u0627\u0641\u0642\u0629 \u0639\u0644\u0649 \u0627\u0644\u0645\u0648\u0639\u062f \u0627\u0644\u062c\u062f\u064a\u062f',
                          style: textTheme.labelSmall?.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Submit button
          Container(
            padding: const EdgeInsetsDirectional.only(
              start: AppSpacing.xl,
              end: AppSpacing.xl,
              top: AppSpacing.md,
              bottom: AppSpacing.lg,
            ),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(
                  top: BorderSide(color: AppColors.divider, width: 0.5)),
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _isValid ? _handleSubmit : null,
                  icon: const Icon(Icons.send, size: 16),
                  label: const Text('\u0625\u0631\u0633\u0627\u0644 \u0637\u0644\u0628 \u0627\u0644\u062a\u0639\u062f\u064a\u0644'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.divider,
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(TextTheme textTheme, String text) {
    return Text(
      text,
      style: textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required int maxLines,
    required String hint,
    required TextTheme textTheme,
    ValueChanged<String>? onChanged,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      textDirection: TextDirection.rtl,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: textTheme.bodySmall?.copyWith(color: AppColors.textHint),
        filled: true,
        fillColor: AppColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: AppRadius.cardInner,
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.cardInner,
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.cardInner,
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        contentPadding: const EdgeInsetsDirectional.all(AppSpacing.md),
      ),
    );
  }

  void _handleSubmit() {
    widget.onSubmit(
      _newTimeController.text.trim(),
      _reasonController.text.trim(),
    );
  }
}

class _CurrentBookingCard extends StatelessWidget {
  final CustomerRequest request;
  const _CurrentBookingCard({required this.request});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isReservation = request.isReservation;
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '\u0627\u0644\u062d\u062c\u0632 \u0627\u0644\u062d\u0627\u0644\u064a',
            style: textTheme.labelSmall?.copyWith(color: AppColors.textHint),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (request.description != null)
            _InfoRow(
              icon: isReservation ? Icons.apartment : Icons.content_cut,
              text: request.description!,
            ),
          if (request.timeSlot != null)
            _InfoRow(icon: Icons.access_time, text: request.timeSlot!),
          if (request.preferredDate != null)
            _InfoRow(icon: Icons.calendar_today, text: request.preferredDate!),
          if (request.teamMember != null)
            _InfoRow(
                icon: Icons.person_outline,
                text: '\u0645\u0639: ${request.teamMember}'),
          if (request.dateRange != null)
            _InfoRow(icon: Icons.date_range, text: request.dateRange!),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.textHint),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
