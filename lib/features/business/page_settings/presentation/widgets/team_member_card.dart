import 'package:flutter/material.dart';

import 'package:honak/config/business_type_config.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/team_member.dart';
import 'package:honak/shared/widgets/app_direction.dart';

/// Tappable summary card for a non-owner team member.
/// Navigates to [MemberDetailScreen] on tap.
class TeamMemberCard extends StatelessWidget {
  final TeamMember member;
  final BusinessTypeConfig? config;
  final VoidCallback onTap;

  const TeamMemberCard({
    super.key,
    required this.member,
    this.config,
    required this.onTap,
  });

  Color get _avatarColor {
    const colors = [
      AppColors.primary,
      Colors.teal,
      Colors.orange,
      Colors.purple,
      Colors.pink,
    ];
    return colors[member.name.hashCode.abs() % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.card,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              // Chevron + active dot
              Icon(
                AppDirection.chevronStartIcon(context),
                size: 20,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: AppSpacing.xs),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: member.active
                      ? AppColors.success
                      : Theme.of(context).colorScheme.outline,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),

              // Summary badges
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: _buildBadges(),
                ),
              ),

              const SizedBox(width: AppSpacing.sm),

              // Name + role + phone
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (member.role != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(AppRadius.xs),
                          ),
                          child: Text(
                            member.role!,
                            style: TextStyle(
                              fontSize: 9,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                      Text(
                        member.name,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  if (member.phone != null)
                    Directionality(
                      textDirection: Directionality.of(context),
                      child: Text(
                        member.phone!,
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: AppSpacing.sm),

              // Avatar
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _avatarColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Center(
                  child: Text(
                    member.name.isNotEmpty ? member.name[0] : '?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _avatarColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBadges() {
    final badges = <Widget>[];

    // Always show permission count
    badges.add(_Badge(label: '${member.permissions.length} صلاحيات'));

    // Service count — only if config has providerAssignment
    if (config?.itemManagement?.providerAssignment == true) {
      badges.add(_Badge(label: '${member.serviceIds.length} خدمات'));
    }

    // Branch count — only if multi_location feature
    if (config?.features.contains('multi_location') == true) {
      badges.add(_Badge(label: '${member.locationIds.length} فروع'));
    }

    return badges;
  }
}

class _Badge extends StatelessWidget {
  final String label;

  const _Badge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 9, color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Skeleton loader for team list
// ═══════════════════════════════════════════════════════════════

class TeamSkeleton extends StatelessWidget {
  const TeamSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: List.generate(3, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.shimmerBase,
              borderRadius: AppRadius.card,
            ),
          ),
        );
      }),
    );
  }
}
