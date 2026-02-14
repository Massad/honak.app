import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/message.dart';
import 'package:honak/features/chat/domain/entities/power_chat_types.dart';
import 'package:honak/shared/entities/money.dart';

class QuoteCardMessage extends StatefulWidget {
  final Message message;
  final bool isBusinessMode;

  const QuoteCardMessage({
    super.key,
    required this.message,
    this.isBusinessMode = false,
  });

  @override
  State<QuoteCardMessage> createState() => _QuoteCardMessageState();
}

class _QuoteCardMessageState extends State<QuoteCardMessage> {
  late String _status;

  @override
  void initState() {
    super.initState();
    final data = QuoteData.fromMetadata(widget.message.metadata);
    _status = data.status;
  }

  QuoteData get _quote => QuoteData.fromMetadata(widget.message.metadata);

  Color get _borderColor => switch (_status) {
        'accepted' => AppColors.success,
        'declined' || 'expired' => context.colorScheme.onSurfaceVariant,
        _ => AppColors.warning,
      };

  Color get _bgColor => switch (_status) {
        'accepted' => AppColors.success.withValues(alpha: 0.04),
        'declined' || 'expired' => context.colorScheme.surfaceContainerLowest,
        _ => AppColors.warning.withValues(alpha: 0.04),
      };

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: (_status == 'declined' || _status == 'expired') ? 0.7 : 1.0,
      child: Container(
        margin: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          color: _bgColor,
          border: Border.all(
            color: _borderColor.withValues(alpha: 0.3),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildLineItems(),
            _buildTotals(),
            if (_quote.notes != null && _quote.notes!.isNotEmpty)
              _buildNotes(),
            if (_quote.validDays != null && _status == 'pending')
              _buildValidity(),
            if (_status != 'pending') _buildStatusBadge(),
            if (_status == 'pending' && !widget.isBusinessMode)
              _buildActions(),
            _buildTimestamp(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final label = widget.isBusinessMode
        ? 'تم إرسال عرض سعر'
        : 'عرض سعر';

    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: _borderColor.withValues(alpha: 0.06),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.receipt_long_outlined, size: 16, color: _borderColor),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _borderColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLineItems() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.md,
        end: AppSpacing.md,
        top: AppSpacing.sm,
      ),
      child: Column(
        children: _quote.items.map((item) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.xs),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
                if (item.quantity > 1) ...[
                  Text(
                    '×${item.quantity}',
                    style: TextStyle(
                      fontSize: 12,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                ],
                Text(
                  Money(item.totalCents).toFormattedArabic(),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTotals() {
    return Padding(
      padding: EdgeInsetsDirectional.all(AppSpacing.md),
      child: Column(
        children: [
          Divider(height: 1, color: context.colorScheme.outlineVariant),
          const SizedBox(height: AppSpacing.sm),
          if (_quote.discountCents != null && _quote.discountCents! > 0) ...[
            _totalRow(
              'المجموع الفرعي',
              Money(_quote.subtotalCents).toFormattedArabic(),
              isBold: false,
            ),
            const SizedBox(height: 2),
            _totalRow(
              'خصم',
              '- ${Money(_quote.discountCents!).toFormattedArabic()}',
              color: AppColors.success,
              isBold: false,
            ),
            const SizedBox(height: 4),
          ],
          _totalRow(
            'الإجمالي',
            Money(_quote.totalCents).toFormattedArabic(),
            color: _borderColor,
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _totalRow(
    String label,
    String value, {
    Color? color,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 14 : 12,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 15 : 12,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: color ?? context.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildNotes() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.md,
        end: AppSpacing.md,
        bottom: AppSpacing.sm,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          _quote.notes!,
          style: TextStyle(
            fontSize: 12,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildValidity() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.md,
        end: AppSpacing.md,
        bottom: AppSpacing.sm,
      ),
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 8,
          vertical: 3,
        ),
        decoration: BoxDecoration(
          color: AppColors.warning.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.timer_outlined, size: 12, color: AppColors.warning),
            const SizedBox(width: 3),
            Text(
              'صالح لمدة ${_quote.validDays} أيام',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.warning,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    final (icon, label, color) = switch (_status) {
      'accepted' => (Icons.check_circle_outline, 'مقبول', AppColors.success),
      'expired' => (Icons.timer_off_outlined, 'منتهي', context.colorScheme.onSurfaceVariant),
      _ => (Icons.cancel_outlined, 'مرفوض', context.colorScheme.onSurfaceVariant),
    };
    final bgColor = _status == 'accepted'
        ? AppColors.success.withValues(alpha: 0.1)
        : context.colorScheme.onSurfaceVariant.withValues(alpha: 0.1);

    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(color: bgColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.md,
        end: AppSpacing.md,
        bottom: AppSpacing.sm,
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => setState(() => _status = 'declined'),
              style: OutlinedButton.styleFrom(
                foregroundColor: context.colorScheme.onSurfaceVariant,
                side: BorderSide(color: context.colorScheme.outlineVariant),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.md),
                ),
                padding: const EdgeInsetsDirectional.symmetric(
                  vertical: AppSpacing.sm,
                ),
              ),
              child: const Text('رفض'),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: FilledButton(
              onPressed: () => setState(() => _status = 'accepted'),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.success,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.md),
                ),
                padding: const EdgeInsetsDirectional.symmetric(
                  vertical: AppSpacing.sm,
                ),
              ),
              child: const Text('قبول'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimestamp() {
    final date =
        DateTime.fromMillisecondsSinceEpoch(widget.message.createdAt * 1000);
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final period = date.hour < 12 ? 'ص' : 'م';
    final time =
        '$hour:${date.minute.toString().padLeft(2, '0')} $period';

    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.md,
        end: AppSpacing.md,
        bottom: AppSpacing.sm,
      ),
      child: Text(
        time,
        style: TextStyle(
          fontSize: 10,
          color: context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
