import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/cached_image.dart';

/// 3-column grid showing team member avatars, names, and roles.
class TeamMemberGrid extends StatelessWidget {
  final List<Map<String, dynamic>> members;

  const TeamMemberGrid({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Text(
            'فريق العمل',
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: 0.75,
          ),
          itemCount: members.length,
          itemBuilder: (context, index) {
            final member = members[index];
            return _TeamMemberTile(
              name: member['name'] as String? ?? '',
              role: member['role'] as String? ?? '',
              avatarUrl: member['avatar_url'] as String?,
              trustMetric: member['trust_metric'] as int?,
            );
          },
        ),
      ],
    );
  }
}

class _TeamMemberTile extends StatelessWidget {
  final String name;
  final String role;
  final String? avatarUrl;
  final int? trustMetric;

  const _TeamMemberTile({
    required this.name,
    required this.role,
    this.avatarUrl,
    this.trustMetric,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar
        SizedBox(
          width: 48,
          height: 48,
          child: CircleAvatar(
            radius: 24,
            backgroundColor: context.colorScheme.surfaceContainerHighest,
            child: avatarUrl != null
                ? ClipOval(
                    child: CachedImage(
                      imageUrl: avatarUrl,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(
                    Icons.person,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        // Name
        Text(
          name,
          style: context.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        // Role badge
        if (role.isNotEmpty) ...[
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
              vertical: 1,
            ),
            decoration: BoxDecoration(
              color: context.colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              role,
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 10,
                color: context.colorScheme.onSecondaryContainer,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
        // Trust metric
        if (trustMetric != null && trustMetric! > 0) ...[
          const SizedBox(height: 2),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.verified,
                size: 10,
                color: context.colorScheme.primary,
              ),
              const SizedBox(width: 2),
              Text(
                '$trustMetric',
                style: context.textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
