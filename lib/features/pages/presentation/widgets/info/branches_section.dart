import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';
import 'package:honak/shared/entities/location.dart';

/// Displays location info: single address or multiple branch cards.
class BranchesSection extends StatelessWidget {
  final Location? location;
  final List<Branch> branches;
  final String? address;

  const BranchesSection({
    super.key,
    this.location,
    this.branches = const [],
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    if (branches.isEmpty) {
      return _singleLocation(context);
    }
    return _multipleBranches(context);
  }

  Widget _singleLocation(BuildContext context) {
    final locationText =
        location?.label ?? location?.area ?? address ?? '';
    if (locationText.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('الموقع', style: context.textTheme.titleSmall),
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
                TextButton(
                  onPressed: () {},
                  child: const Text('فتح في الخرائط'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _multipleBranches(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الفروع (${branches.length})',
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
            Text(
              branch.name,
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
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
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map_outlined, size: 16),
                label: const Text('فتح في الخرائط'),
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
