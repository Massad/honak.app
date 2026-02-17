import 'package:flutter/material.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';
import 'package:honak/features/pages/presentation/pages/branches_page.dart';
import 'package:honak/features/pages/presentation/widgets/header/branch_selector.dart';
import 'package:honak/shared/widgets/app_direction.dart';

/// Compact nearest-branch banner shown in the page header for all archetypes
/// with 2+ branches. Replaces the old `BranchSelector` (order/booking only)
/// and the `VenueBanner` (venue-only).
///
/// Layout: single row —  📍 أقرب فرع: الشميساني  ·  عرض الكل (24) ←
///
/// - For order/booking: tapping the card opens the branch picker sheet
/// - For follow_only/directory: tapping opens [BranchesPage] directly
class NearestBranchCard extends StatelessWidget {
  final List<Branch> branches;
  final Archetype archetype;
  final int selectedBranchIndex;
  final ValueChanged<int> onBranchChanged;
  final String pageName;

  const NearestBranchCard({
    super.key,
    required this.branches,
    required this.archetype,
    required this.selectedBranchIndex,
    required this.onBranchChanged,
    required this.pageName,
  });

  /// Whether tapping the card opens the branch picker (for ordering).
  bool get _isOrderArchetype =>
      archetype != Archetype.followOnly && archetype != Archetype.directory;

  @override
  Widget build(BuildContext context) {
    if (branches.length < 2) return const SizedBox.shrink();

    final branch = branches[selectedBranchIndex];

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.xs,
        AppSpacing.lg,
        AppSpacing.xs,
      ),
      child: GestureDetector(
        onTap: () => _isOrderArchetype
            ? _showBranchPicker(context)
            : _openBranchesPage(context),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: context.colorScheme.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                size: 18,
                color: context.colorScheme.primary,
              ),
              SizedBox(width: AppSpacing.sm),

              // Branch name — compact
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        // "أقرب فرع: "
                        text: '\u0623\u0642\u0631\u0628 \u0641\u0631\u0639: ',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      TextSpan(
                        text: branch.name,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Venue badge inline
                      if (branch.venueId != null && branch.venueName != null)
                        TextSpan(
                          text:
                              ' \u00b7 ${branch.venueName}',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              SizedBox(width: AppSpacing.sm),

              // "عرض الكل (N)" link
              GestureDetector(
                onTap: () => _openBranchesPage(context),
                child: Text(
                  '\u0639\u0631\u0636 \u0627\u0644\u0643\u0644 (${branches.length})',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(width: AppSpacing.xxs),

              // Arrow or dropdown
              Icon(
                _isOrderArchetype
                    ? Icons.keyboard_arrow_down
                    : AppDirection.chevronStartIcon(context),
                size: 16,
                color: context.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBranchPicker(BuildContext context) {
    BranchSelector(
      branches: branches,
      selectedIndex: selectedBranchIndex,
      onBranchChanged: onBranchChanged,
    ).showPicker(context);
  }

  void _openBranchesPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BranchesPage(
          branches: branches,
          pageName: pageName,
        ),
      ),
    );
  }
}
