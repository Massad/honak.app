import 'dart:math';

import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/features/business/insights/domain/entities/insight_entities.dart';

/// Ranked list with medals, progress bars, and count+unit labels.
/// Pure Flutter — no charting library.
class RankedList extends StatelessWidget {
  final TopItemsData data;

  const RankedList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
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
            data.label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 12),
          if (data.items.isEmpty)
            const _EmptyState()
          else
            ...data.items.asMap().entries.map((e) => Padding(
                  padding: EdgeInsets.only(bottom: e.key < data.items.length - 1 ? 10 : 0),
                  child: _RankedRow(
                    index: e.key,
                    item: e.value,
                    maxCount: data.items.map((i) => i.count).reduce(max),
                  ),
                )),
        ],
      ),
    );
  }
}

class _RankedRow extends StatelessWidget {
  final int index;
  final TopItemDataPoint item;
  final int maxCount;

  const _RankedRow({
    required this.index,
    required this.item,
    required this.maxCount,
  });

  static const _rankColors = [
    Color(0xFF1A73E8),
    Color(0xFF4DA3FF),
    Color(0xFF93C5FD),
  ];

  @override
  Widget build(BuildContext context) {
    final color = index < _rankColors.length ? _rankColors[index] : const Color(0xFF93C5FD);
    final fillRatio = maxCount > 0 ? item.count / maxCount : 0.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Rank indicator
        SizedBox(
          width: 24,
          child: Center(
            child: index < 3
                ? Text(
                    ['🥇', '🥈', '🥉'][index],
                    style: const TextStyle(fontSize: 14),
                  )
                : Text(
                    '${index + 1}',
                    style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
                  ),
          ),
        ),
        const SizedBox(width: 10),
        // Name + count + progress bar
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      item.name,
                      style: const TextStyle(fontSize: 12, color: Color(0xFF374151)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${item.count} ${item.unit}',
                    style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Progress bar
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: AnimatedFractionallySizedBox(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                    widthFactor: fillRatio.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.inventory_2_outlined, size: 32, color: Color(0xFFD1D5DB)),
            const SizedBox(height: 8),
            Text(
              context.l10n.insightsInsufficientData,
              style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
            ),
          ],
        ),
      ),
    );
  }
}

/// Animated fraction box that transitions width.
class AnimatedFractionallySizedBox extends ImplicitlyAnimatedWidget {
  final double widthFactor;
  final Widget child;

  const AnimatedFractionallySizedBox({
    super.key,
    required this.widthFactor,
    required this.child,
    required super.duration,
    super.curve,
  });

  @override
  AnimatedFractionallySizedBoxState createState() =>
      AnimatedFractionallySizedBoxState();
}

class AnimatedFractionallySizedBoxState
    extends AnimatedWidgetBaseState<AnimatedFractionallySizedBox> {
  Tween<double>? _widthFactor;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _widthFactor = visitor(
      _widthFactor,
      widget.widthFactor,
      (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>?;
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: _widthFactor?.evaluate(animation) ?? widget.widthFactor,
      child: widget.child,
    );
  }
}
