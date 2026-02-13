import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Aggregate analytics display card for StoryManager.
class StoryStatsCard extends StatelessWidget {
  final Map<String, dynamic> stats;

  const StoryStatsCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final totalViews = stats['total_views_this_month'] ?? 0;
    final totalShares = stats['total_shares_this_month'] ?? 0;
    final totalMessages = stats['total_messages_this_month'] ?? 0;
    final avgViews = stats['avg_views_per_story'] ?? 0;
    final bestTime = stats['best_posting_time'] ?? '';
    final bestDay = stats['best_posting_day'] ?? '';
    final growth = stats['growth_vs_last_month'] ?? 0;
    final storiesThisMonth = stats['total_stories_this_month'] ?? 0;
    final followers = stats['followers_count'] ?? 0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        color: context.colorScheme.surfaceContainerLow,
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.storyStats,
                style: context.textTheme.titleSmall,
              ),
              if (growth > 0)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF43A047).withValues(alpha: 0.1),
                    borderRadius: AppRadius.pill,
                  ),
                  child: Text(
                    context.l10n.storyGrowth(growth as int),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: const Color(0xFF43A047),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: AppSpacing.md),

          // Stats grid
          Row(
            children: [
              _StatItem(
                label: context.l10n.storyTotalViews,
                value: _formatNumber(totalViews as int),
                icon: Icons.visibility,
              ),
              _StatItem(
                label: context.l10n.storyTotalShares,
                value: '$totalShares',
                icon: Icons.share,
              ),
              _StatItem(
                label: context.l10n.storyMessages,
                value: '$totalMessages',
                icon: Icons.chat_bubble_outline,
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          Divider(color: context.colorScheme.outlineVariant),
          SizedBox(height: AppSpacing.md),

          // Bottom row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _InfoChip(
                icon: Icons.bar_chart,
                label: '${context.l10n.storyAvgViews}: $avgViews',
              ),
              _InfoChip(
                icon: Icons.article_outlined,
                label:
                    '${context.l10n.storyThisMonth}: $storiesThisMonth',
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _InfoChip(
                icon: Icons.schedule,
                label:
                    '${context.l10n.storyBestTime}: $bestDay $bestTime',
              ),
              _InfoChip(
                icon: Icons.people_outline,
                label: '${_formatNumber(followers as int)} ${context.l10n.storyFollowerCount}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String _formatNumber(int n) {
  if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
  return '$n';
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 20, color: context.colorScheme.primary),
          SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: context.colorScheme.onSurfaceVariant),
        SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
