import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Orange gradient banner showing active specials/offers.
/// Used by both CatalogSection and MenuSection.
class SpecialsBanner extends StatelessWidget {
  final List<String> specials;

  const SpecialsBanner({super.key, required this.specials});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.xs,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange.shade300,
              Colors.yellow.shade600,
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.auto_awesome, color: Colors.white, size: 24),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\u0639\u0631\u0648\u0636 \u062e\u0627\u0635\u0629',
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    specials.first,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Filter button with active-count badge overlay.
class CatalogFilterButton extends StatelessWidget {
  final int activeCount;
  final VoidCallback onTap;

  const CatalogFilterButton({
    super.key,
    required this.activeCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHighest
                  .withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.tune,
              size: 18,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          if (activeCount > 0)
            PositionedDirectional(
              top: -4,
              start: -4,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$activeCount',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// "Show more" button with visible/total count.
class SectionShowMoreButton extends StatelessWidget {
  final int visibleCount;
  final int totalCount;
  final VoidCallback onPressed;

  const SectionShowMoreButton({
    super.key,
    required this.visibleCount,
    required this.totalCount,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      child: Column(
        children: [
          Text(
            '\u0639\u0631\u0636 $visibleCount \u0645\u0646 $totalCount \u0645\u0646\u062a\u062c',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            width: double.infinity,
            child: btn.Button(
              onPressed: onPressed,
              label: '\u0639\u0631\u0636 \u0627\u0644\u0645\u0632\u064a\u062f',
              variant: btn.Variant.outlined,
              expand: true,
              size: btn.ButtonSize.large,
            ),
          ),
        ],
      ),
    );
  }
}

/// Empty search results state with icon.
class SectionEmptySearch extends StatelessWidget {
  const SectionEmptySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off,
            size: 48,
            color: context.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '\u0644\u0627 \u062a\u0648\u062c\u062f \u0646\u062a\u0627\u0626\u062c',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
