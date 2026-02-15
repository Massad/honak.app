import 'package:flutter/material.dart';
import 'package:honak/features/business/insights/domain/entities/insight_entities.dart';
import 'package:honak/features/business/insights/domain/insight_icon_map.dart';

/// A single KPI card with icon, value, label, and optional change badge.
class InsightCardView extends StatelessWidget {
  final InsightCardData card;

  const InsightCardView({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: icon + change badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon container
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  resolveInsightIcon(card.icon),
                  size: 16,
                  color: const Color(0xFF1A73E8),
                ),
              ),
              // Change badge
              if (card.change != null) _ChangeBadge(card: card),
            ],
          ),
          const SizedBox(height: 8),
          // Value
          Text(
            card.value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 2),
          // Label
          Text(
            card.label,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF6B7280),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ChangeBadge extends StatelessWidget {
  final InsightCardData card;

  const _ChangeBadge({required this.card});

  @override
  Widget build(BuildContext context) {
    final (bgColor, textColor, icon) = switch (card.trend) {
      TrendDirection.up => (
          const Color(0xFFF0FDF4),
          const Color(0xFF43A047),
          Icons.arrow_outward,
        ),
      TrendDirection.down => (
          const Color(0xFFFEF2F2),
          const Color(0xFFE53935),
          Icons.south_east,
        ),
      TrendDirection.neutral => (
          const Color(0xFFF9FAFB),
          const Color(0xFF9CA3AF),
          Icons.remove,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: textColor),
          const SizedBox(width: 2),
          Text(
            card.change!,
            style: TextStyle(fontSize: 10, color: textColor),
          ),
        ],
      ),
    );
  }
}
