import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/message.dart';
import 'package:honak/features/chat/presentation/widgets/modification_card_actions.dart';
import 'package:honak/features/chat/presentation/widgets/modification_item_row.dart';
import 'package:honak/shared/entities/money.dart';

class ModificationCard extends StatefulWidget {
  final Message message;
  final bool isBusinessMode;

  const ModificationCard({
    super.key,
    required this.message,
    this.isBusinessMode = false,
  });

  @override
  State<ModificationCard> createState() => _ModificationCardState();
}

class _ModificationCardState extends State<ModificationCard> {
  late String _status;

  @override
  void initState() {
    super.initState();
    _status = widget.message.metadata['status'] as String? ?? 'pending';
  }

  Map<String, dynamic> get _meta => widget.message.metadata;
  String get _orderId => _meta['order_id'] as String? ?? '';
  List<Map<String, dynamic>> get _itemChanges =>
      (_meta['item_changes'] as List?)?.cast<Map<String, dynamic>>() ?? [];
  String? get _note => _meta['note'] as String?;
  int get _originalTotal => _meta['original_total'] as int? ?? 0;
  int get _newTotal => _meta['new_total'] as int? ?? 0;
  String? get _rejectReason => _meta['reject_reason'] as String?;

  Color get _borderColor {
    return switch (_status) {
      'approved' => AppColors.success,
      'rejected' || 'expired' => AppColors.textHint,
      _ => AppColors.warning,
    };
  }

  Color get _bgColor {
    return switch (_status) {
      'approved' => AppColors.success.withValues(alpha: 0.05),
      'rejected' || 'expired' => AppColors.background,
      _ => AppColors.warning.withValues(alpha: 0.05),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: (_status == 'rejected' || _status == 'expired') ? 0.7 : 1.0,
      child: Container(
        margin: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: _bgColor,
          border: Border.all(color: _borderColor, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            if (_itemChanges.isNotEmpty) _buildChangesList(),
            if (_note != null && _note!.isNotEmpty) _buildNote(),
            _buildPriceDiff(),
            if (_status == 'pending')
              ModificationPendingFooter(
                isBusinessMode: widget.isBusinessMode,
                onReject: () => setState(() => _status = 'rejected'),
                onApprove: () => setState(() => _status = 'approved'),
              ),
            if (_status != 'pending')
              ModificationStatusBadge(
                status: _status,
                rejectReason: _rejectReason,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.md,
        end: AppSpacing.md,
        top: AppSpacing.md,
        bottom: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _borderColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.edit_outlined,
              size: 18,
              color: _borderColor,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'طلب تعديل',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _borderColor,
                  ),
                ),
                if (_orderId.isNotEmpty)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 2),
                    child: Text(
                      'الطلب #$_orderId',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChangesList() {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.md,
      ),
      child: Column(
        children: _itemChanges
            .map((change) => ModificationItemRow(change: change))
            .toList(),
      ),
    );
  }

  Widget _buildNote() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.md,
        end: AppSpacing.md,
        bottom: AppSpacing.sm,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.warning.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.info_outline,
              size: 14,
              color: AppColors.warning,
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                _note!,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceDiff() {
    final diff = _newTotal - _originalTotal;
    final diffColor = diff > 0 ? AppColors.warning : AppColors.success;

    return Padding(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'الإجمالي',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          Row(
            children: [
              Text(
                _formatPrice(_originalTotal),
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textHint,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                _formatPrice(_newTotal),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _borderColor,
                ),
              ),
              if (diff != 0) ...[
                const SizedBox(width: AppSpacing.xs),
                Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: diffColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${diff > 0 ? '+' : ''}${_formatPrice(diff)}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: diffColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _formatPrice(int piasters) {
    return Money(piasters).toFormattedArabic();
  }
}
