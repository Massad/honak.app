import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Info banner for businesses that only show curated/highlighted items.
/// Displays a message, category chips, and an "Ask about availability" CTA.
class HighlightsBanner extends StatelessWidget {
  final List<String> carryCategories;
  final VoidCallback? onAskAvailability;

  const HighlightsBanner({
    super.key,
    required this.carryCategories,
    this.onAskAvailability,
  });

  static const _bgColor = Color(0xFFEFF6FF);
  static const _borderColor = Color(0xFFDBEAFE);
  static const _chipBorderColor = Color(0xFFBFDBFE);
  static const _primaryBlue = Color(0xFF1A73E8);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: _bgColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.store_rounded,
                size: 20,
                color: _primaryBlue,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'نعرض المميز فقط \u2014 لدينا المزيد في المتجر',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: _primaryBlue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          if (carryCategories.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: carryCategories
                  .map(
                    (category) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: _chipBorderColor),
                      ),
                      child: Text(
                        category,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: _primaryBlue,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
          if (onAskAvailability != null) ...[
            const SizedBox(height: AppSpacing.md),
            GestureDetector(
              onTap: onAskAvailability,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 16,
                    color: _primaryBlue,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'اسأل عن توفر منتج',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: _primaryBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
