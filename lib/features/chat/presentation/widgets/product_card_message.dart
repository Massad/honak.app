import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/message.dart';
import 'package:honak/features/chat/domain/entities/power_chat_types.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/widgets/app_image.dart';
import 'package:honak/shared/widgets/button.dart';

class ProductCardMessage extends StatefulWidget {
  final Message message;
  final bool isBusinessMode;

  const ProductCardMessage({
    super.key,
    required this.message,
    this.isBusinessMode = false,
  });

  @override
  State<ProductCardMessage> createState() => _ProductCardMessageState();
}

class _ProductCardMessageState extends State<ProductCardMessage> {
  late String _status;

  @override
  void initState() {
    super.initState();
    final data = ProductCardData.fromMetadata(widget.message.metadata);
    _status = data.status;
  }

  ProductCardData get _product =>
      ProductCardData.fromMetadata(widget.message.metadata);

  Color get _borderColor => AppColors.primary;

  Color get _bgColor => AppColors.primary.withValues(alpha: 0.04);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      constraints: const BoxConstraints(maxWidth: 300),
      decoration: BoxDecoration(
        color: _bgColor,
        border: Border.all(
          color: _borderColor.withValues(alpha: 0.25),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildProductInfo(context),
          if (_status == 'sent') _buildAction(),
          if (_status == 'added') _buildAddedBadge(),
          _buildTimestamp(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final label =
        widget.isBusinessMode ? 'تم إرسال منتج' : 'منتج مقترح';
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
          Icon(
            Icons.shopping_bag_outlined,
            size: 16,
            color: _borderColor,
          ),
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

  Widget _buildProductInfo(BuildContext context) {
    final cs = context.colorScheme;
    return Padding(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_product.image != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AppImage(
                url: _product.image,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                placeholderIcon: Icons.image_outlined,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _product.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: cs.onSurface,
                        ),
                      ),
                    ),
                    if (_product.quantity != null && _product.quantity! > 1)
                      Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 6,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '× ${_product.quantity}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _borderColor,
                          ),
                        ),
                      ),
                  ],
                ),
                if (_product.optionsSummary != null &&
                    _product.optionsSummary!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    _product.optionsSummary!,
                    style: TextStyle(
                      fontSize: 12,
                      color: cs.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                if (_product.category != null) ...[
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 6,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _product.category!,
                      style: TextStyle(
                        fontSize: 10,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
                if (_product.duration != null) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 12,
                        color: cs.onSurfaceVariant,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        _product.duration!,
                        style: TextStyle(
                          fontSize: 11,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
                if (_product.description != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    _product.description!,
                    style: TextStyle(
                      fontSize: 12,
                      color: cs.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  Money(_product.displayPriceCents).toFormattedArabic(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _borderColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAction() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.md,
        end: AppSpacing.md,
        bottom: AppSpacing.sm,
      ),
      child: Button(
        onPressed: widget.isBusinessMode
            ? null
            : () => setState(() => _status = 'added'),
        label: 'أضف للطلب',
        icon: ButtonIcon(Icons.add_shopping_cart, size: 16),
        size: ButtonSize.small,
        expand: true,
      ),
    );
  }

  Widget _buildAddedBadge() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline, size: 16, color: AppColors.success),
          SizedBox(width: AppSpacing.xs),
          Text(
            'تمت الإضافة',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimestamp(BuildContext context) {
    final cs = context.colorScheme;
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
          color: cs.onSurfaceVariant,
        ),
      ),
    );
  }
}
