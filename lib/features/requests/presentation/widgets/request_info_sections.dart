import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/domain/entities/customer_request.dart';

/// Order items list with subtotal — for type == 'order'.
class OrderDetailsSection extends StatelessWidget {
  final CustomerRequest request;

  const OrderDetailsSection({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Item rows
        ...request.items.map((item) {
          final lineTotal = item.price != null
              ? (item.price! * item.quantity).toFormattedArabic()
              : '';
          return Container(
            margin: const EdgeInsets.only(bottom: AppSpacing.sm),
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: AppRadius.cardInner,
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${item.quantity}',
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      if (item.variation != null)
                        Text(
                          item.variation!,
                          style: textTheme.labelSmall?.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  lineTotal,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }),
        // Total
        if (request.total != null) ...[
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\u0627\u0644\u0645\u062c\u0645\u0648\u0639',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                request.total!.toFormattedArabic(),
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
        // Delivery address
        if (request.deliveryAddress != null) ...[
          const SizedBox(height: AppSpacing.sm),
          InfoIconLabel(
            icon: Icons.location_on_outlined,
            text: request.deliveryAddress!,
          ),
        ],
        // Payment
        if (request.paymentMethod != null)
          InfoIconLabel(
            icon: Icons.payments_outlined,
            text: '\u0627\u0644\u062f\u0641\u0639: ${request.paymentMethod}',
          ),
      ],
    );
  }
}

/// Booking details — for type == 'booking'.
class BookingDetailsSection extends StatelessWidget {
  final CustomerRequest request;

  const BookingDetailsSection({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (request.description != null)
          InfoDetailRow(icon: Icons.content_cut, text: request.description!),
        if (request.teamMember != null)
          InfoDetailRow(
              icon: Icons.person_outline,
              text: '\u0645\u0639: ${request.teamMember}'),
        if (request.timeSlot != null)
          InfoDetailRow(icon: Icons.access_time, text: request.timeSlot!),
        if (request.preferredDate != null)
          InfoDetailRow(
              icon: Icons.calendar_today, text: request.preferredDate!),
      ],
    );
  }
}

// -- Shared helper widgets (used across request_info_sections & request_type_details) --

/// Row with icon + text inside a card-like container.
class InfoDetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoDetailRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: AppRadius.cardInner,
      ),
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

/// Compact icon + text label.
class InfoIconLabel extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoIconLabel({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: Row(
        children: [
          Icon(icon, size: 12, color: AppColors.textHint),
          const SizedBox(width: AppSpacing.xs),
          Text(
            text,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}
