import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/stories/domain/entities/my_story.dart';
import 'package:honak/features/stories/presentation/widgets/story_canvas.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:timeago/timeago.dart' as timeago;

/// Expandable story card matching Figma StoryManager.
/// Status-based actions as chip buttons, engagement rate bar,
/// scheduled info box, audience badge, detailed stats grid.
class StoryListItem extends StatefulWidget {
  final MyStory story;
  final VoidCallback? onPreview;
  final VoidCallback? onEdit;
  final VoidCallback? onPublishNow;
  final VoidCallback? onShare;
  final VoidCallback? onRepublish;
  final VoidCallback? onDelete;

  const StoryListItem({
    super.key,
    required this.story,
    this.onPreview,
    this.onEdit,
    this.onPublishNow,
    this.onShare,
    this.onRepublish,
    this.onDelete,
  });

  @override
  State<StoryListItem> createState() => _StoryListItemState();
}

class _StoryListItemState extends State<StoryListItem> {
  bool _expanded = false;
  bool _confirmingDelete = false;

  @override
  Widget build(BuildContext context) {
    final story = widget.story;
    final statusColor = switch (story.status) {
      'live' => const Color(0xFF43A047),
      'scheduled' => AppColors.primary,
      _ => const Color(0xFF9E9E9E),
    };
    final statusLabel = switch (story.status) {
      'live' => context.l10n.storyStatusLive,
      'scheduled' => context.l10n.storyStatusScheduled,
      _ => context.l10n.storyStatusExpired,
    };

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: _expanded
              ? const Color(0xFF1A73E8).withValues(alpha: 0.3)
              : context.colorScheme.outlineVariant,
        ),
        color: context.colorScheme.surface,
      ),
      child: Column(
        children: [
          // Main row
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  // Thumbnail with status ring
                  _StoryThumb(story: story, statusColor: statusColor),
                  SizedBox(width: AppSpacing.md),

                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text + status badge row
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                story.slide.text ??
                                    (story.slide.type == 'image'
                                        ? context.l10n.storyImage
                                        : context.l10n.storyText),
                                style:
                                    context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 6),
                            // Status badge
                            _StatusBadge(
                              label: statusLabel,
                              color: statusColor,
                              isLive: story.status == 'live',
                            ),
                          ],
                        ),
                        SizedBox(height: AppSpacing.xs),

                        // Time + audience
                        Row(
                          children: [
                            if (story.createdAt != null)
                              Text(
                                _formatTime(story.createdAt!),
                                style: context.textTheme.labelSmall
                                    ?.copyWith(
                                  color: context
                                      .colorScheme.onSurfaceVariant,
                                  fontSize: 10,
                                ),
                              ),
                            const SizedBox(width: 8),
                            Icon(
                              story.audience == 'all'
                                  ? Icons.public
                                  : Icons.people_outline,
                              size: 12,
                              color: story.audience == 'all'
                                  ? const Color(0xFFFF9800)
                                  : const Color(0xFF1A73E8),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              story.audience == 'all'
                                  ? context.l10n.storyAudienceAll
                                  : context.l10n.storyAudienceFollowers,
                              style: TextStyle(
                                fontSize: 10,
                                color: story.audience == 'all'
                                    ? const Color(0xFFFF9800)
                                    : const Color(0xFF1A73E8),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSpacing.xs),

                        // Quick stats
                        Row(
                          children: [
                            _MiniStat(
                                Icons.visibility, '${story.stats.views}'),
                            SizedBox(width: AppSpacing.md),
                            _MiniStat(
                                Icons.share, '${story.stats.shares}'),
                            SizedBox(width: AppSpacing.md),
                            _MiniStat(Icons.chat_bubble_outline,
                                '${story.stats.messages}'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Expand icon
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: context.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),

          // Expanded detail
          if (_expanded) ...[
            Divider(height: 1, color: context.colorScheme.outlineVariant),
            Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  // Stats grid (4 columns with icons)
                  _StatsGrid(story: story),
                  SizedBox(height: AppSpacing.md),

                  // Engagement rate bar
                  if (story.stats.views > 0)
                    _EngagementBar(story: story),
                  if (story.stats.views > 0)
                    SizedBox(height: AppSpacing.md),

                  // Scheduled info box
                  if (story.status == 'scheduled' &&
                      story.scheduledAt != null)
                    _ScheduledInfoBox(scheduledAt: story.scheduledAt!),

                  // Action buttons (chip-style)
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: _buildActions(context, story),
                  ),

                  // Live story note
                  if (story.status == 'live') ...[
                    SizedBox(height: AppSpacing.sm),
                    Text(
                      context.l10n.storyLiveNote,
                      style: TextStyle(
                        fontSize: 10,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context, MyStory story) {
    final actions = <Widget>[];

    // Preview — always
    actions.add(_ActionChip(
      icon: Icons.visibility_outlined,
      label: context.l10n.storyPreview,
      color: const Color(0xFF1A73E8),
      onTap: widget.onPreview ?? () {},
    ));

    switch (story.status) {
      case 'live':
        if (widget.onShare != null) {
          actions.add(_ActionChip(
            icon: Icons.open_in_new,
            label: context.l10n.storyShare,
            color: context.colorScheme.onSurfaceVariant,
            bgColor: context.colorScheme.surfaceContainerHighest,
            onTap: widget.onShare!,
          ));
        }
      case 'scheduled':
        if (widget.onEdit != null) {
          actions.add(_ActionChip(
            icon: Icons.edit_outlined,
            label: context.l10n.storyEdit,
            color: const Color(0xFF1A73E8),
            onTap: widget.onEdit!,
          ));
        }
        if (widget.onPublishNow != null) {
          actions.add(_ActionChip(
            icon: Icons.send,
            label: context.l10n.storyPublishNow,
            color: const Color(0xFF43A047),
            onTap: widget.onPublishNow!,
          ));
        }
      case 'expired':
        if (widget.onRepublish != null) {
          actions.add(_ActionChip(
            icon: Icons.replay,
            label: context.l10n.storyRepublish,
            color: const Color(0xFF1A73E8),
            onTap: widget.onRepublish!,
          ));
        }
    }

    // Delete — always (inline confirm, label changes for live)
    if (widget.onDelete != null) {
      if (_confirmingDelete) {
        // Inline confirm + cancel
        actions.add(
          _ActionChip(
            icon: Icons.delete_outline,
            label: context.l10n.storyConfirmAction,
            color: context.colorScheme.onError,
            bgColor: const Color(0xFFE53935),
            onTap: () {
              setState(() => _confirmingDelete = false);
              widget.onDelete?.call();
            },
          ),
        );
        actions.add(
          _ActionChip(
            icon: Icons.close,
            label: '',
            color: context.colorScheme.onSurfaceVariant,
            bgColor: context.colorScheme.surfaceContainerHighest,
            onTap: () => setState(() => _confirmingDelete = false),
          ),
        );
      } else {
        actions.add(_ActionChip(
          icon: Icons.delete_outline,
          label: story.status == 'live' ? context.l10n.storyRemove : context.l10n.storyDelete,
          color: const Color(0xFFE53935),
          onTap: () => setState(() => _confirmingDelete = true),
        ));
      }
    }

    return actions;
  }

  String _formatTime(String isoString) {
    try {
      final date = DateTime.parse(isoString);
      return timeago.format(date, locale: 'ar');
    } catch (_) {
      return '';
    }
  }
}

// ═══════════════════════════════════════════════════════════════
// Story thumbnail with status-colored ring
// ═══════════════════════════════════════════════════════════════

class _StoryThumb extends StatelessWidget {
  final MyStory story;
  final Color statusColor;

  const _StoryThumb({required this.story, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    final isExpired = story.status == 'expired';
    return Container(
      width: 48,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(
          color: statusColor.withValues(
            alpha: isExpired ? 0.25 : 0.35,
          ),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.sm - 1),
        child: Opacity(
          opacity: isExpired ? 0.6 : 1.0,
          child: StoryCanvas(
            slide: story.slide,
            interactive: false,
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Status badge with dot — pulse for live
// ═══════════════════════════════════════════════════════════════

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final bool isLive;

  const _StatusBadge({
    required this.label,
    required this.color,
    this.isLive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Stats grid — 4 columns with icons, matching Figma
// ═══════════════════════════════════════════════════════════════

class _StatsGrid extends StatelessWidget {
  final MyStory story;

  const _StatsGrid({required this.story});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _GridStat(
          icon: Icons.visibility_outlined,
          value: '${story.stats.views}',
          label: context.l10n.storyViews,
        ),
        _GridStat(
          icon: Icons.people_outline,
          value: '${story.stats.uniqueReach}',
          label: context.l10n.storyReach,
        ),
        _GridStat(
          icon: Icons.share_outlined,
          value: '${story.stats.shares}',
          label: context.l10n.storyShares,
        ),
        _GridStat(
          icon: Icons.chat_bubble_outline,
          value: '${story.stats.messages}',
          label: context.l10n.storyMessages,
        ),
      ],
    );
  }
}

class _GridStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _GridStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 14, color: context.colorScheme.onSurfaceVariant),
          const SizedBox(height: 2),
          Text(
            value,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Engagement rate bar — Figma style
// ═══════════════════════════════════════════════════════════════

class _EngagementBar extends StatelessWidget {
  final MyStory story;

  const _EngagementBar({required this.story});

  @override
  Widget build(BuildContext context) {
    final totalEngagement = story.stats.shares + story.stats.messages;
    final rate = story.stats.views > 0
        ? (totalEngagement / story.stats.views * 100)
        : 0.0;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.bar_chart,
                size: 14,
                color: Color(0xFF1A73E8),
              ),
              const SizedBox(width: 6),
              Text(
                context.l10n.storyEngagementRate,
                style: const TextStyle(fontSize: 11),
              ),
              const Spacer(),
              Text(
                '${rate.toStringAsFixed(1)}%',
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF1A73E8),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(1),
            child: LinearProgressIndicator(
              value: (rate / 100).clamp(0.0, 1.0),
              minHeight: 2,
              backgroundColor: context.colorScheme.outlineVariant,
              valueColor: const AlwaysStoppedAnimation(Color(0xFF1A73E8)),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                '${context.l10n.storyShares}: ${story.stats.shares}',
                style: TextStyle(
                  fontSize: 9,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${context.l10n.storyMessages}: ${story.stats.messages}',
                style: TextStyle(
                  fontSize: 9,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Scheduled info box
// ═══════════════════════════════════════════════════════════════

class _ScheduledInfoBox extends StatelessWidget {
  final String scheduledAt;

  const _ScheduledInfoBox({required this.scheduledAt});

  @override
  Widget build(BuildContext context) {
    String formatted;
    try {
      final date = DateTime.parse(scheduledAt);
      final dateFmt = DateFormat('yyyy/MM/dd', 'ar');
      final timeFmt = DateFormat('HH:mm', 'ar');
      formatted = '${dateFmt.format(date)} — ${timeFmt.format(date)}';
    } catch (_) {
      formatted = scheduledAt;
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A73E8).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(
          color: const Color(0xFF1A73E8).withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.schedule, size: 14, color: Color(0xFF1A73E8)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.storyScheduledAtLabel,
                  style: TextStyle(
                    fontSize: 10,
                    color: const Color(0xFF1A73E8).withValues(alpha: 0.7),
                  ),
                ),
                Text(
                  formatted,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF1A73E8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Chip-style action button — Figma: bg-color/10, text-color
// ═══════════════════════════════════════════════════════════════

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color? bgColor;
  final VoidCallback onTap;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.color,
    this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: bgColor ?? color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13, color: color),
            if (label.isNotEmpty) ...[
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(fontSize: 11, color: color),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Mini stat (collapsed row)
// ═══════════════════════════════════════════════════════════════

class _MiniStat extends StatelessWidget {
  final IconData icon;
  final String value;

  const _MiniStat(this.icon, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: context.colorScheme.onSurfaceVariant),
        SizedBox(width: AppSpacing.xxs),
        Text(
          value,
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
