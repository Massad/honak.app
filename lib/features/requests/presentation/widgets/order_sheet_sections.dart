import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/domain/entities/cart.dart';
import 'package:honak/core/extensions/context_ext.dart';

export 'order_delivery_sections.dart';

/// Cart items summary with line totals and subtotal.
class OrderCartSummary extends StatelessWidget {
  final Cart cart;

  const OrderCartSummary({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المنتجات',
          style: theme.textTheme.bodySmall
              ?.copyWith(color: context.colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerLow,
            borderRadius: AppRadius.cardInner,
          ),
          child: Column(
            children: [
              ...cart.items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: Row(
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius:
                                BorderRadius.circular(AppRadius.xxs),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${item.quantity}',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                item.name,
                                style: theme.textTheme.bodySmall,
                              ),
                              if (item.variation != null)
                                Text(
                                  item.variation!,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: context.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Text(
                          item.lineTotal.toFormattedArabic(),
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: context.colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  )),
              const Divider(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('المجموع', style: theme.textTheme.bodyMedium),
                  Text(
                    cart.subtotal.toFormattedArabic(),
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Delivery/pickup toggle with two buttons.
class DeliveryToggle extends StatelessWidget {
  final bool isDelivery;
  final ValueChanged<bool> onChanged;

  const DeliveryToggle({
    super.key,
    required this.isDelivery,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'طريقة الاستلام',
          style: theme.textTheme.bodySmall
              ?.copyWith(color: context.colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _ToggleButton(
                label: 'توصيل',
                selected: isDelivery,
                onTap: () => onChanged(true),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _ToggleButton(
                label: 'استلام من المحل',
                selected: !isDelivery,
                onTap: () => onChanged(false),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ToggleButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.cardInner,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : context.colorScheme.surface,
          borderRadius: AppRadius.cardInner,
          border: Border.all(
            color: selected ? AppColors.primary : context.colorScheme.outlineVariant,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: selected ? Colors.white : context.colorScheme.onSurfaceVariant,
              ),
        ),
      ),
    );
  }
}

/// Note text field section.
class OrderNoteField extends StatelessWidget {
  final TextEditingController controller;

  const OrderNoteField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ملاحظة (اختياري)',
          style: theme.textTheme.bodySmall
              ?.copyWith(color: context.colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: controller,
          maxLines: 3,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: 'مثال: الرجاء التوصيل الصباح...',
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
