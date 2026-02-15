import 'package:flutter/material.dart';
import 'package:honak/features/business/insights/domain/entities/insight_entities.dart';
import 'package:honak/features/business/insights/presentation/widgets/insight_card_view.dart';

/// Renders a section title + 2-column grid of KPI cards.
class InsightSectionBlock extends StatelessWidget {
  final InsightSectionData section;

  const InsightSectionBlock({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 8),
        _CardGrid(cards: section.cards),
      ],
    );
  }
}

class _CardGrid extends StatelessWidget {
  final List<InsightCardData> cards;

  const _CardGrid({required this.cards});

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < cards.length; i += 2) {
      final hasSecond = i + 1 < cards.length;
      rows.add(Row(
        children: [
          Expanded(child: InsightCardView(card: cards[i])),
          const SizedBox(width: 8),
          Expanded(
            child: hasSecond
                ? InsightCardView(card: cards[i + 1])
                : const SizedBox.shrink(),
          ),
        ],
      ));
      if (i + 2 < cards.length) {
        rows.add(const SizedBox(height: 8));
      }
    }
    return Column(children: rows);
  }
}
