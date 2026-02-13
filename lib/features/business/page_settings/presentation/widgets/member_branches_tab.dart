import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/presentation/providers/branch_provider.dart';
import 'package:honak/features/business/page_settings/presentation/providers/team_provider.dart';

/// Branch assignment tab inside [MemberDetailScreen].
class MemberBranchesTab extends ConsumerWidget {
  final String memberId;

  const MemberBranchesTab({super.key, required this.memberId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branchesAsync = ref.watch(branchProvider);
    final members = ref.watch(teamProvider).valueOrNull ?? [];
    final member = members.where((m) => m.id == memberId).firstOrNull;
    if (member == null) return const SizedBox.shrink();

    return branchesAsync.when(
      loading: () => const _BranchesSkeleton(),
      error: (_, __) => Center(
        child: Text(
          'تعذر تحميل الفروع',
          style: TextStyle(color: Colors.grey.shade400),
        ),
      ),
      data: (branches) {
        if (branches.isEmpty) {
          return Center(
            child: Text(
              'لا توجد فروع',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            for (final branch in branches) ...[
              _BranchRow(
                name: branch.name,
                subtitle: [branch.city, branch.neighborhood]
                    .whereType<String>()
                    .join(' — '),
                isMain: branch.isMain,
                assigned: member.locationIds.contains(branch.id),
                onToggle: () {
                  final updated = List<String>.from(member.locationIds);
                  if (updated.contains(branch.id)) {
                    updated.remove(branch.id);
                  } else {
                    updated.add(branch.id);
                  }
                  ref
                      .read(teamProvider.notifier)
                      .updateLocationIds(memberId, updated);
                },
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ],
        );
      },
    );
  }
}

class _BranchRow extends StatelessWidget {
  final String name;
  final String subtitle;
  final bool isMain;
  final bool assigned;
  final VoidCallback onToggle;

  const _BranchRow({
    required this.name,
    required this.subtitle,
    required this.isMain,
    required this.assigned,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onToggle,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: assigned
              ? AppColors.primary.withValues(alpha: 0.04)
              : Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: assigned
                ? AppColors.primary.withValues(alpha: 0.2)
                : Colors.grey.shade100,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: assigned,
                onChanged: (_) => onToggle(),
                activeColor: AppColors.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isMain) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(AppRadius.xxs),
                          ),
                          child: Text(
                            'رئيسي',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                      Flexible(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade400,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Icon(
              Icons.location_on_outlined,
              size: 20,
              color: assigned
                  ? AppColors.primary.withValues(alpha: 0.6)
                  : Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }
}

class _BranchesSkeleton extends StatelessWidget {
  const _BranchesSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: List.generate(3, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.shimmerBase,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
          ),
        );
      }),
    );
  }
}
