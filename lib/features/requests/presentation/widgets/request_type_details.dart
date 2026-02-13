import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/domain/entities/customer_request.dart';
import 'package:honak/features/requests/presentation/widgets/request_info_sections.dart';

/// Config-driven detail section factory — maps request type → widget.
/// Centralizes the type→section mapping so widgets don't switch on type.
Widget buildDetailSectionFor(CustomerRequest request) {
  if (request.isOrderType) return OrderDetailsSection(request: request);
  if (request.isSchedulable && !request.isReservation) {
    return BookingDetailsSection(request: request);
  }
  if (request.isManualApprovalOnly) {
    return QuoteDetailsSection(request: request);
  }
  if (request.isReservation) {
    return ReservationDetailsSection(request: request);
  }
  return const SizedBox.shrink();
}

/// Quote / inquiry details — for type == 'quote' or 'inquiry'.
class QuoteDetailsSection extends StatelessWidget {
  final CustomerRequest request;

  const QuoteDetailsSection({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (request.description != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: AppRadius.cardInner,
            ),
            child: Text(
              request.description!,
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        if (request.urgency != null) ...[
          const SizedBox(height: AppSpacing.sm),
          _UrgencyBadge(urgency: request.urgency!),
        ],
        if (request.serviceLocation != null) ...[
          const SizedBox(height: AppSpacing.sm),
          InfoIconLabel(
            icon: Icons.location_on_outlined,
            text: request.serviceLocation!,
          ),
        ],
        if (request.preferredDate != null) ...[
          const SizedBox(height: AppSpacing.sm),
          InfoIconLabel(
            icon: Icons.access_time,
            text: '\u0627\u0644\u062a\u0627\u0631\u064a\u062e \u0627\u0644\u0645\u0641\u0636\u0644: ${request.preferredDate}',
          ),
        ],
      ],
    );
  }
}

/// Reservation details — for type == 'reservation'.
class ReservationDetailsSection extends StatelessWidget {
  final CustomerRequest request;

  const ReservationDetailsSection({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (request.description != null)
          InfoDetailRow(
              icon: Icons.calendar_today, text: request.description!),
        if (request.dateRange != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              borderRadius: AppRadius.cardInner,
            ),
            child: Text(
              request.dateRange!,
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        if (request.guestCount != null || request.total != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              if (request.guestCount != null)
                Expanded(
                    child: _ReservationStatCard(
                  icon: Icons.people_outline,
                  value: '${request.guestCount}',
                  label: '\u0636\u064a\u0648\u0641',
                )),
              if (request.guestCount != null && request.total != null)
                const SizedBox(width: AppSpacing.sm),
              if (request.total != null)
                Expanded(
                    child: _ReservationStatCard(
                  icon: Icons.credit_card_outlined,
                  value: request.total!.toFormattedArabic(),
                  label: '\u0627\u0644\u0645\u062c\u0645\u0648\u0639',
                )),
            ],
          ),
        ],
        if (request.timeSlot != null) ...[
          const SizedBox(height: AppSpacing.sm),
          InfoDetailRow(icon: Icons.access_time, text: request.timeSlot!),
        ],
        if (request.paymentMethod != null) ...[
          const SizedBox(height: AppSpacing.sm),
          InfoIconLabel(
            icon: Icons.payments_outlined,
            text: '\u0627\u0644\u062f\u0641\u0639: ${request.paymentMethod}',
          ),
        ],
      ],
    );
  }
}

// -- Private helpers --

class _UrgencyBadge extends StatelessWidget {
  final String urgency;

  const _UrgencyBadge({required this.urgency});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (urgency) {
      'asap' => ('\u0637\u0627\u0631\u0626', AppColors.error),
      'soon' => ('\u0642\u0631\u064a\u0628\u0627\u064b', const Color(0xFFFF8F00)),
      _ => ('\u063a\u064a\u0631 \u0645\u0633\u062a\u0639\u062c\u0644', AppColors.textSecondary),
    };

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '\u0627\u0644\u0627\u0633\u062a\u0639\u062c\u0627\u0644: $label',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
            ),
      ),
    );
  }
}

class _ReservationStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _ReservationStatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: AppRadius.cardInner,
      ),
      child: Column(
        children: [
          Icon(icon, size: 14, color: AppColors.textHint),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textPrimary,
                ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textHint,
                  fontSize: 9,
                ),
          ),
        ],
      ),
    );
  }
}
