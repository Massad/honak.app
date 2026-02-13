import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/widgets/app_image.dart';

class AlternativeItemRow extends StatelessWidget {
  final Map<String, dynamic> item;

  const AlternativeItemRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final name = item['name'] as String? ?? '';
    final price = item['price'] as int? ?? 0;
    final quantity = item['quantity'] as int? ?? 1;
    final imageUrl = item['image_url'] as String?;

    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          if (imageUrl != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AppImage(
                url: imageUrl,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (quantity > 1)
                  Text(
                    'الكمية: $quantity',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            Money(price).toFormattedArabic(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
