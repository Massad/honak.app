import 'package:flutter/material.dart';

import 'skeleton_box.dart';

class SkeletonText extends StatelessWidget {
  final double? width;
  final double height;
  final int lines;
  final double lineSpacing;

  const SkeletonText({
    super.key,
    this.width,
    this.height = 14,
    this.lines = 1,
    this.lineSpacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    if (lines == 1) {
      return _buildLine(0);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < lines; i++) ...[
          if (i > 0) SizedBox(height: lineSpacing),
          _buildLine(i),
        ],
      ],
    );
  }

  Widget _buildLine(int index) {
    if (width != null) {
      // Last line is shorter when multiple lines
      final lineWidth =
          (lines > 1 && index == lines - 1) ? width! * 0.6 : width;
      return SkeletonBox(width: lineWidth, height: height);
    }
    // Use fractional width based on seed for consistent layout
    final fraction = _fractionForLine(index);
    return FractionallySizedBox(
      alignment: AlignmentDirectional.centerStart,
      widthFactor: fraction,
      child: SkeletonBox(height: height),
    );
  }

  /// Returns a consistent fraction (0.6-1.0) for a given line index.
  /// Last line is always shorter.
  double _fractionForLine(int index) {
    if (lines > 1 && index == lines - 1) {
      return 0.45 + (index.hashCode.abs() % 20) / 100;
    }
    // Pseudo-random but deterministic widths between 0.7 and 1.0
    const widths = [1.0, 0.85, 0.92, 0.78, 0.88, 0.95, 0.73, 0.82];
    return widths[index % widths.length];
  }
}
