import 'package:flutter/material.dart';

/// Gradient card showing 2-3 smart tips per business type.
class SmartTipsSection extends StatelessWidget {
  final List<String> tips;

  const SmartTipsSection({super.key, required this.tips});

  @override
  Widget build(BuildContext context) {
    if (tips.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: AlignmentDirectional.centerEnd,
          end: AlignmentDirectional.centerStart,
          colors: [Color(0xFFEFF6FF), Colors.white],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDBEAFE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          const Row(
            children: [
              Icon(Icons.star, size: 14, color: Color(0xFFFF9800)),
              SizedBox(width: 6),
              Text(
                'نصائح ذكية',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Tips list
          ...tips.map((tip) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tip,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF374151)),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
