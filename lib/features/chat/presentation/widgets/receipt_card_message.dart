import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/message.dart';
import 'package:honak/features/chat/domain/entities/power_chat_types.dart';
import 'package:honak/features/chat/presentation/widgets/chat_action_card_shell.dart';
import 'package:honak/shared/entities/money.dart';

class ReceiptCardMessage extends StatelessWidget {
  final Message message;

  const ReceiptCardMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final data = ReceiptCardData.fromMetadata(message.metadata);
    return ChatActionCardShell(
      message: message,
      icon: Icons.receipt_outlined,
      color: AppColors.warning,
      title: data.title,
      body: Padding(
        padding: const EdgeInsetsDirectional.all(AppSpacing.md),
        child: Column(
          children: [
            ...data.items.map(
              (item) => Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${item.label} x${item.quantity}',
                        style: TextStyle(
                          fontSize: 12,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Text(
                      Money(item.totalCents).toFormattedArabic(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: AppSpacing.lg),
            _totalRow(context, 'المجموع', data.subtotalCents),
            if (data.discountCents > 0)
              _totalRow(context, 'الخصم', -data.discountCents),
            if (data.deliveryFeeCents > 0)
              _totalRow(context, 'رسوم التوصيل', data.deliveryFeeCents),
            const SizedBox(height: 4),
            _totalRow(context, 'الإجمالي', data.totalCents, bold: true),
          ],
        ),
      ),
    );
  }

  Widget _totalRow(
    BuildContext context,
    String label,
    int amount, {
    bool bold = false,
  }) {
    final value = amount < 0
        ? '- ${Money(amount.abs()).toFormattedArabic()}'
        : Money(amount).toFormattedArabic();
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: bold ? 13 : 12,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: bold ? 14 : 12,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
              color: context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
