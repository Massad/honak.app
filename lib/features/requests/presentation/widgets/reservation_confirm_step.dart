import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/entities/money.dart';

/// Confirm step: summary card, price estimation (FG7), deposit notice (FG8),
/// payment methods, safety disclaimers (FG5).
class ReservationConfirmStep extends StatelessWidget {
  final DateTime? checkIn;
  final DateTime? checkOut;
  final int? nightCount;
  final int guestCount;
  final String occasion;
  final String? activeSpaceId;
  final List<Map<String, dynamic>> spaces;
  final List<String> paymentMethods;
  final int? pricePerNightCents;
  final int? depositCents;
  final List<String>? disclaimers;
  final Set<String> acceptedDisclaimers;
  final ValueChanged<String> onDisclaimerToggle;

  const ReservationConfirmStep({
    super.key,
    required this.checkIn,
    required this.checkOut,
    required this.nightCount,
    required this.guestCount,
    required this.occasion,
    required this.activeSpaceId,
    required this.spaces,
    required this.paymentMethods,
    this.pricePerNightCents,
    this.depositCents,
    this.disclaimers,
    required this.acceptedDisclaimers,
    required this.onDisclaimerToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final space = spaces.cast<Map<String, dynamic>?>().firstWhere(
          (s) => s?['id']?.toString() == activeSpaceId,
          orElse: () => null,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSummaryCard(theme, space),
        // FG7: Price estimation
        if (pricePerNightCents != null &&
            nightCount != null &&
            nightCount! > 0) ...[
          const SizedBox(height: AppSpacing.md),
          _buildPriceEstimation(theme),
        ],
        // FG8: Deposit notice
        if (depositCents != null && depositCents! > 0) ...[
          const SizedBox(height: AppSpacing.md),
          _buildDepositNotice(theme),
        ],
        const SizedBox(height: AppSpacing.xl),
        // Payment methods
        if (paymentMethods.isNotEmpty) _buildPaymentMethods(theme),
        // FG5: Safety disclaimers
        if (disclaimers != null && disclaimers!.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xl),
          ...disclaimers!.map(
            (d) => CheckboxListTile(
              value: acceptedDisclaimers.contains(d),
              onChanged: (_) => onDisclaimerToggle(d),
              title: Text(d, style: const TextStyle(fontSize: 12)),
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              contentPadding: EdgeInsetsDirectional.zero,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSummaryCard(ThemeData theme, Map<String, dynamic>? space) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: AppRadius.cardInner,
        border:
            Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.description, size: 12, color: AppColors.primary),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'ملخص الحجز',
                style: theme.textTheme.labelSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (space != null)
            _summaryRow(
                theme, 'المكان', space['name'] as String? ?? ''),
          if (checkIn != null)
            _summaryRow(
              theme,
              'الوصول',
              '${checkIn!.day}/${checkIn!.month}/${checkIn!.year}',
            ),
          if (checkOut != null)
            _summaryRow(
              theme,
              'المغادرة',
              '${checkOut!.day}/${checkOut!.month}/${checkOut!.year}',
            ),
          if (nightCount != null && nightCount! > 0)
            _summaryRow(
              theme,
              'المدة',
              '$nightCount ${nightCount == 1 ? 'ليلة' : nightCount == 2 ? 'ليلتين' : 'ليالي'}',
              valueColor: AppColors.primary,
            ),
          _summaryRow(theme, 'الضيوف', '$guestCount'),
          if (occasion.isNotEmpty)
            _summaryRow(theme, 'المناسبة', occasion),
        ],
      ),
    );
  }

  Widget _buildPriceEstimation(ThemeData theme) {
    final total = Money(pricePerNightCents! * nightCount!);
    final perNight = Money(pricePerNightCents!);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${perNight.toFormattedArabic()} × $nightCount ${nightCount == 1 ? 'ليلة' : 'ليالي'}',
            style: theme.textTheme.labelSmall
                ?.copyWith(color: AppColors.textSecondary),
          ),
          Text(
            total.toFormattedArabic(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepositNotice(ThemeData theme) {
    final deposit = Money(depositCents!);

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: AppRadius.cardInner,
        border: Border.all(
            color: const Color(0xFFFF9800).withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline,
              size: 14, color: Color(0xFFFF9800)),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              'يُطلب تحويل عربون بقيمة ${deposit.toFormattedArabic()} لتأكيد الحجز',
              style: const TextStyle(
                  fontSize: 11, color: Color(0xFF795548)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.payment, size: 12, color: AppColors.textHint),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'طرق الدفع المتاحة',
                style: theme.textTheme.labelSmall
                    ?.copyWith(color: AppColors.textHint),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: paymentMethods.map((m) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Text(
                  m,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    ThemeData theme,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall
                ?.copyWith(color: AppColors.textHint),
          ),
          Text(
            value,
            style:
                theme.textTheme.labelSmall?.copyWith(color: valueColor),
          ),
        ],
      ),
    );
  }
}
