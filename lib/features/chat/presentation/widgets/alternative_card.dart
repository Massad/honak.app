import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/message.dart';
import 'package:honak/features/chat/presentation/widgets/alternative_item_row.dart';
import 'package:honak/shared/entities/money.dart';

class AlternativeCard extends StatefulWidget {
  final Message message;

  const AlternativeCard({super.key, required this.message});

  @override
  State<AlternativeCard> createState() => _AlternativeCardState();
}

class _AlternativeCardState extends State<AlternativeCard> {
  late String _status;

  @override
  void initState() {
    super.initState();
    _status = widget.message.metadata['status'] as String? ?? 'pending';
  }

  Map<String, dynamic> get _meta => widget.message.metadata;
  String get _reason => _meta['reason'] as String? ?? '';
  List<Map<String, dynamic>> get _items =>
      (_meta['items'] as List?)?.cast<Map<String, dynamic>>() ?? [];
  int get _originalTotal => _meta['original_total'] as int? ?? 0;
  int get _suggestedTotal => _meta['suggested_total'] as int? ?? 0;

  Color get _borderColor {
    return switch (_status) {
      'accepted' => AppColors.success,
      'declined' || 'expired' => context.colorScheme.onSurfaceVariant,
      _ => AppColors.primary,
    };
  }

  Color get _bgColor {
    return switch (_status) {
      'accepted' => AppColors.success.withValues(alpha: 0.05),
      'declined' || 'expired' => context.colorScheme.surfaceContainerLowest,
      _ => AppColors.primary.withValues(alpha: 0.05),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: (_status == 'declined' || _status == 'expired') ? 0.7 : 1.0,
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
            if (_items.isNotEmpty) _buildItemList(),
            _buildPriceComparison(),
            if (_status != 'pending') _buildStatusBadge(),
            if (_status == 'pending') _buildActions(),
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
              Icons.swap_horiz_rounded,
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
                  'اقتراح بديل من ${widget.message.senderName ?? 'المتجر'}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _borderColor,
                  ),
                ),
                if (_reason.isNotEmpty)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 2),
                    child: Text(
                      _reason,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colorScheme.onSurfaceVariant,
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

  Widget _buildItemList() {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.md,
      ),
      child: Column(
        children:
            _items.map((item) => AlternativeItemRow(item: item)).toList(),
      ),
    );
  }

  Widget _buildPriceComparison() {
    final diff = _suggestedTotal - _originalTotal;
    final diffColor = diff > 0 ? AppColors.warning : AppColors.success;

    return Padding(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'الإجمالي',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onSurface,
            ),
          ),
          Row(
            children: [
              Text(
                _formatPrice(_originalTotal),
                style: TextStyle(
                  fontSize: 13,
                  color: context.colorScheme.onSurfaceVariant,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                _formatPrice(_suggestedTotal),
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

  Widget _buildStatusBadge() {
    final (icon, label, color) = switch (_status) {
      'accepted' => (Icons.check_circle_outline, 'تم القبول', AppColors.success),
      'expired' => (Icons.timer_off_outlined, 'منتهي', context.colorScheme.onSurfaceVariant),
      _ => (Icons.cancel_outlined, 'تم الرفض', context.colorScheme.onSurfaceVariant),
    };
    final bgColor = _status == 'accepted'
        ? AppColors.success.withValues(alpha: 0.1)
        : context.colorScheme.onSurfaceVariant.withValues(alpha: 0.1);

    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
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
        bottom: AppSpacing.md,
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => setState(() => _status = 'declined'),
              icon: const Icon(Icons.close, size: 16),
              label: const Text('رفض'),
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
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: FilledButton.icon(
              onPressed: () => setState(() => _status = 'accepted'),
              icon: const Icon(Icons.check, size: 16),
              label: const Text('قبول'),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.success,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.md),
                ),
                padding: const EdgeInsetsDirectional.symmetric(
                  vertical: AppSpacing.sm,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(int piasters) {
    return Money(piasters).toFormattedArabic();
  }
}
