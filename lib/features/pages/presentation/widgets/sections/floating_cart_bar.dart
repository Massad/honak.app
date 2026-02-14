import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/entities/money.dart';

/// Sticky bottom bar showing cart summary and send order button.
/// Only shown when the cart has items.
class FloatingCartBar extends StatelessWidget {
  final int itemCount;
  final Money total;
  final VoidCallback onSendOrder;

  const FloatingCartBar({
    super.key,
    required this.itemCount,
    required this.total,
    required this.onSendOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colorScheme.primary,
            context.colorScheme.primary.withValues(alpha: 0.9),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Item count + total
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$itemCount عنصر',
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  Text(
                    total.toFormattedArabic(),
                    style: context.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Send order button
            FilledButton(
              onPressed: onSendOrder,
              style: FilledButton.styleFrom(
                backgroundColor: context.colorScheme.surface,
                foregroundColor: context.colorScheme.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.md,
                ),
              ),
              child: const Text('إرسال الطلب'),
            ),
          ],
        ),
      ),
    );
  }
}
