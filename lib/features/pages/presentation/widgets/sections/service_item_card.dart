import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/shared/widgets/money_text.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Card for a service item in the service booking section.
/// Compact row layout: name + description + duration + price + book button.
/// Matches Figma queue/service page design.
class ServiceItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback? onBook;

  /// Optional badge widget shown in place of the book button
  /// (e.g. "✓ اختيارك" when customer is in queue).
  final Widget? trailingBadge;

  const ServiceItemCard({
    super.key,
    required this.item,
    this.onBook,
    this.trailingBadge,
  });

  @override
  Widget build(BuildContext context) {
    final durationMinutes = item.sortOrder > 0 ? item.sortOrder : 30;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Book button or trailing badge (leading in RTL) ──
            if (trailingBadge != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: AppSpacing.md),
                child: trailingBadge!,
              )
            else if (item.inStock && onBook != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: AppSpacing.md),
                child: _CompactBookButton(onPressed: onBook!),
              ),

            // ── Content ──
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Service name
                  Text(
                    item.nameAr,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                  if (item.descriptionAr != null &&
                      item.descriptionAr!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      item.descriptionAr!,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ],
                  const SizedBox(height: AppSpacing.xs),
                  // Price + duration row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Duration badge
                      _DurationBadge(
                        minutes: durationMinutes,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      // Price
                      MoneyText(
                        money: item.price,
                        style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  if (!item.inStock) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xxs,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'غير متاح',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact "حجز" button matching Figma design — small filled button
/// with calendar icon, aligned at the start of the card.
class _CompactBookButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _CompactBookButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return btn.Button(
      onPressed: onPressed,
      label: 'حجز',
      icon: const btn.ButtonIcon(Icons.calendar_today, size: 14),
      size: btn.ButtonSize.small,
    );
  }
}

/// Duration badge using neutral surface colors (not yellow/amber).
class _DurationBadge extends StatelessWidget {
  final int minutes;

  const _DurationBadge({required this.minutes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.schedule,
            size: 12,
            color: context.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: AppSpacing.xxs),
          Text(
            '$minutes د',
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
