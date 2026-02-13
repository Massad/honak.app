import 'package:flutter/material.dart';

/// Animated progress bars showing the current position across slides.
class StoryProgressBar extends StatelessWidget {
  final int count;
  final int current;
  final double progress;

  const StoryProgressBar({
    super.key,
    required this.count,
    required this.current,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: List.generate(count, (index) {
          final double value;
          if (index < current) {
            value = 1.0;
          } else if (index == current) {
            value = progress;
          } else {
            value = 0.0;
          }

          return Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                end: index < count - 1 ? 4 : 0,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 2.5,
                  backgroundColor: Colors.white.withValues(alpha: 0.3),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
