import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';
import 'package:honak/features/pages/presentation/pages/branches_page.dart';
import 'package:honak/shared/entities/location.dart';
import 'package:honak/shared/widgets/app_direction.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Displays location info: single address or multiple branch cards.
/// For pages with many branches (>5), shows city filter chips.
class BranchesSection extends StatelessWidget {
  final Location? location;
  final List<Branch> branches;
  final String? address;
  final String pageName;

  const BranchesSection({
    super.key,
    this.location,
    this.branches = const [],
    this.address,
    this.pageName = '',
  });

  @override
  Widget build(BuildContext context) {
    if (branches.isEmpty) {
      return _buildSingleLocation(context);
    }
    return _buildMultipleBranches(context);
  }

  Widget _buildSingleLocation(BuildContext context) {
    final locationText =
        location?.label ?? location?.area ?? address ?? '';
    if (locationText.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('\u0627\u0644\u0645\u0648\u0642\u0639', style: context.textTheme.titleSmall),
        SizedBox(height: AppSpacing.sm),
        Card(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: context.colorScheme.primary,
                  size: 20,
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    locationText,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                btn.Button(
                  onPressed: () {},
                  label: '\u0641\u062a\u062d \u0641\u064a \u0627\u0644\u062e\u0631\u0627\u0626\u0637',
                  variant: btn.Variant.text,
                  size: btn.ButtonSize.small,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMultipleBranches(BuildContext context) {
    // For >3 branches, show a summary card that opens the full-screen page
    if (branches.length > 3) {
      return _BranchesSummaryCard(
        branches: branches,
        pageName: pageName,
      );
    }

    // 2-3 branches: show inline
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // "الفروع (N)"
          '\u0627\u0644\u0641\u0631\u0648\u0639 (${branches.length})',
          style: context.textTheme.titleSmall,
        ),
        SizedBox(height: AppSpacing.sm),
        ...branches.map((branch) => _BranchCard(branch: branch)),
      ],
    );
  }
}

class _BranchCard extends StatelessWidget {
  final Branch branch;

  const _BranchCard({required this.branch});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: AppSpacing.sm),
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    branch.name,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Venue badge — when branch is inside a mall
                if (branch.venueId != null)
                  _VenueBadge(branch: branch),
              ],
            ),
            if (branch.address != null) ...[
              SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      branch.address!,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            if (branch.hours != null) ...[
              SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    size: 14,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  SizedBox(width: AppSpacing.xs),
                  Text(
                    branch.hours!,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
            if (branch.phone != null) ...[
              SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Icon(
                    Icons.phone_outlined,
                    size: 14,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  SizedBox(width: AppSpacing.xs),
                  Text(
                    branch.phone!,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(height: AppSpacing.sm),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: btn.Button(
                onPressed: () {},
                label: '\u0641\u062a\u062d \u0641\u064a \u0627\u0644\u062e\u0631\u0627\u0626\u0637',
                icon: const btn.ButtonIcon(Icons.map_outlined),
                variant: btn.Variant.text,
                size: btn.ButtonSize.small,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Summary card for pages with >3 branches. Shows count + city count,
/// tapping opens [BranchesPage].
class _BranchesSummaryCard extends StatelessWidget {
  final List<Branch> branches;
  final String pageName;

  const _BranchesSummaryCard({
    required this.branches,
    required this.pageName,
  });

  @override
  Widget build(BuildContext context) {
    final cityCount = branches
        .map((b) => b.city)
        .where((c) => c != null)
        .toSet()
        .length;

    // "٢٣ فرعاً في ٥ مدن" or "٤ فروع" if single city
    final branchText = '${branches.length} '
        '\u0641\u0631\u0639\u0627\u064b';
    final cityText = cityCount > 1
        ? ' \u0641\u064a $cityCount \u0645\u062f\u0646'
        : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '\u0627\u0644\u0641\u0631\u0648\u0639 (${branches.length})',
          style: context.textTheme.titleSmall,
        ),
        SizedBox(height: AppSpacing.sm),
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => BranchesPage(
                branches: branches,
                pageName: pageName,
              ),
            ),
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppSpacing.lg),
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
                  Icons.location_on_outlined,
                  color: context.colorScheme.primary,
                  size: 20,
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    '$branchText$cityText',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  // "عرض جميع الفروع"
                  '\u0639\u0631\u0636 \u062c\u0645\u064a\u0639 \u0627\u0644\u0641\u0631\u0648\u0639',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: AppSpacing.xs),
                Icon(
                  AppDirection.chevronStartIcon(context),
                  size: 18,
                  color: context.colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Small blue pill badge showing venue info on a branch card.
class _VenueBadge extends StatelessWidget {
  final Branch branch;

  const _VenueBadge({required this.branch});

  @override
  Widget build(BuildContext context) {
    final parts = <String>[];
    if (branch.venueName != null) {
      parts.add('\u0641\u064a ${branch.venueName}');
    }
    if (branch.venueUnit != null) parts.add(branch.venueUnit!);
    if (parts.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: AppRadius.pill,
      ),
      child: Text(
        parts.join(' \u00b7 '),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: context.colorScheme.primary,
        ),
      ),
    );
  }
}
