import 'dart:math';

import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';

/// Shows popular menu modifiers. Only for menu_order archetype.
class ModifierAnalytics extends StatelessWidget {
  const ModifierAnalytics({super.key});

  // Mock modifier data
  static const _modifiers = [
    ('بدون بصل', 120),
    ('ثومية زيادة', 95),
    ('حار', 78),
    ('بدون ملح', 45),
    ('خبز إضافي', 38),
  ];

  @override
  Widget build(BuildContext context) {
    final maxCount = _modifiers.map((m) => m.$2).reduce(max);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: const [
          BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 1)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.insightsModifierAnalysis,
            style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 4),
          Text(
            context.l10n.insightsModifierSubtitle,
            style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
          ),
          const SizedBox(height: 12),
          ..._modifiers.map((m) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _ModifierRow(
                  name: m.$1,
                  count: m.$2,
                  maxCount: maxCount,
                ),
              )),
        ],
      ),
    );
  }
}

class _ModifierRow extends StatelessWidget {
  final String name;
  final int count;
  final int maxCount;

  const _ModifierRow({
    required this.name,
    required this.count,
    required this.maxCount,
  });

  @override
  Widget build(BuildContext context) {
    final fillRatio = maxCount > 0 ? count / maxCount : 0.0;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: const TextStyle(fontSize: 12, color: Color(0xFF374151))),
            Text(
              context.l10n.insightsTimesCount(count),
              style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280)),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: FractionallySizedBox(
              widthFactor: fillRatio.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9800),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
