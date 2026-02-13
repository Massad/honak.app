import 'dart:math';

import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';

class LoadMoreButton extends StatelessWidget {
  final int remaining;
  final int pageSize;
  final VoidCallback onLoadMore;

  const LoadMoreButton({
    super.key,
    required this.remaining,
    required this.pageSize,
    required this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    if (remaining <= 0) return const SizedBox.shrink();

    final nextBatch = min(remaining, pageSize);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: GestureDetector(
          onTap: onLoadMore,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'عرض المزيد ($nextBatch من $remaining متبقي)',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
