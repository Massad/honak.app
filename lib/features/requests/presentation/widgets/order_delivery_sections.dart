import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Delivery address display with FG1 coverage zone info row.
class DeliveryAddressSection extends StatelessWidget {
  final String? deliveryFee;

  const DeliveryAddressSection({super.key, this.deliveryFee});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'عنوان التوصيل',
          style: theme.textTheme.bodySmall
              ?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: AppRadius.cardInner,
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            children: [
              const Icon(Icons.location_on,
                  size: 16, color: AppColors.primary),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'عبدون، شارع فيصل، بناية ٢٣',
                  style: theme.textTheme.bodySmall,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down,
                  size: 16, color: AppColors.textHint),
            ],
          ),
        ),
        // FG1: Coverage zone info
        const SizedBox(height: AppSpacing.xs),
        Container(
          padding: const EdgeInsetsDirectional.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: AppRadius.cardInner,
          ),
          child: Row(
            children: [
              Icon(Icons.delivery_dining,
                  size: 14, color: AppColors.primary),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'يتم التوصيل لمنطقتك',
                style: TextStyle(fontSize: 11, color: AppColors.primary),
              ),
            ],
          ),
        ),
        if (deliveryFee != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            'رسوم التوصيل: $deliveryFee',
            style: theme.textTheme.labelSmall
                ?.copyWith(color: AppColors.textHint),
          ),
        ],
      ],
    );
  }
}

/// Payment method selector list.
class OrderPaymentMethods extends StatelessWidget {
  final List<String> paymentMethods;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const OrderPaymentMethods({
    super.key,
    required this.paymentMethods,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'طريقة الدفع',
          style: theme.textTheme.bodySmall
              ?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),
        ...paymentMethods.asMap().entries.map((entry) {
          final i = entry.key;
          final method = entry.value;
          final selected = selectedIndex == i;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: InkWell(
              onTap: () => onChanged(i),
              borderRadius: AppRadius.cardInner,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.primary.withValues(alpha: 0.05)
                      : Colors.white,
                  borderRadius: AppRadius.cardInner,
                  border: Border.all(
                    color:
                        selected ? AppColors.primary : AppColors.divider,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.payment,
                        size: 16,
                        color: selected
                            ? AppColors.primary
                            : AppColors.textSecondary),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      method,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: selected ? AppColors.primary : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

/// Pickup branch selector (multiple branches).
class OrderBranchSelector extends StatelessWidget {
  final List<Map<String, dynamic>> locations;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const OrderBranchSelector({
    super.key,
    required this.locations,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اختر فرع الاستلام',
          style: theme.textTheme.bodySmall
              ?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),
        ...locations.asMap().entries.map((entry) {
          final i = entry.key;
          final loc = entry.value;
          final selected = selectedIndex == i;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: InkWell(
              onTap: () => onChanged(i),
              borderRadius: AppRadius.cardInner,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.primary.withValues(alpha: 0.05)
                      : Colors.white,
                  borderRadius: AppRadius.cardInner,
                  border: Border.all(
                    color:
                        selected ? AppColors.primary : AppColors.divider,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.store,
                        size: 14,
                        color: selected
                            ? AppColors.primary
                            : AppColors.textHint),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc['name'] as String? ?? '',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: selected ? AppColors.primary : null,
                            ),
                          ),
                          if (loc['address'] != null)
                            Text(
                              loc['address'] as String,
                              style: theme.textTheme.labelSmall
                                  ?.copyWith(color: AppColors.textHint),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

/// Single branch display (when only one pickup location).
class OrderSingleBranch extends StatelessWidget {
  final Map<String, dynamic> location;

  const OrderSingleBranch({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: AppRadius.cardInner,
      ),
      child: Row(
        children: [
          const Icon(Icons.store, size: 14, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(location['name'] as String? ?? '',
                    style: theme.textTheme.bodySmall),
                if (location['address'] != null)
                  Text(
                    location['address'] as String,
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: AppColors.textHint),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
