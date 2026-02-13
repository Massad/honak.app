import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Amber warning banner shown when a business does NOT cover the user's area.
///
/// Displays the user's neighborhood name and up to 5 coverage area chips.
class CoverageBanner extends StatelessWidget {
  final String userNeighborhood;
  final List<String> coverageAreas;

  const CoverageBanner({
    super.key,
    required this.userNeighborhood,
    required this.coverageAreas,
  });

  static const _maxChips = 5;

  // Amber palette
  static const _bgColor = Color(0xFFFFF3E0);
  static const _iconColor = Color(0xFFFF9800);
  static const _textColor = Color(0xFFE65100);
  static const _overflowColor = Color(0xFFEF6C00);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
      ),
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: AppRadius.cardInner,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.only(top: 2),
            child: Icon(
              Icons.warning_amber_rounded,
              size: 16,
              color: _iconColor,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'لا يغطي منطقتك حالياً ($userNeighborhood)',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _textColor,
                      ),
                ),
                if (coverageAreas.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  _buildCoverageChips(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoverageChips() {
    final visible = coverageAreas.take(_maxChips).toList();
    final overflow = coverageAreas.length - _maxChips;

    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: [
        for (final area in visible) _CoverageChip(label: area),
        if (overflow > 0)
          Text(
            '+$overflow',
            style: const TextStyle(
              fontSize: 10,
              color: _overflowColor,
            ),
          ),
      ],
    );
  }
}

class _CoverageChip extends StatelessWidget {
  final String label;

  const _CoverageChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: AppRadius.pill,
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          color: Color(0xFFE65100),
        ),
      ),
    );
  }
}
