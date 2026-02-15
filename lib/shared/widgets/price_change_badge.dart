import 'package:flutter/material.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';

/// Small colored badge showing price increase/decrease overlay on item images.
/// Used by OfferingItemCard.
class PriceChangeBadge extends StatelessWidget {
  final PriceChange priceChange;

  const PriceChangeBadge({super.key, required this.priceChange});

  @override
  Widget build(BuildContext context) {
    final isDecrease = priceChange.direction == 'decrease';
    final bgColor = isDecrease
        ? const Color(0xFF16A34A) // green-600
        : const Color(0xFFDC2626); // red-600
    final arrow = isDecrease ? '\u2193' : '\u2191';
    // "فلس"
    final unit =
        priceChange.method == 'percentage' ? '%' : ' \u0641\u0644\u0633';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        '$arrow ${priceChange.value}$unit',
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
