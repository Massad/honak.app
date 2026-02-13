import 'dart:math';

import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/stories/domain/entities/my_story.dart';
import 'package:honak/features/stories/presentation/widgets/story_canvas.dart';

/// Horizontal scroll of story thumbnails with a "create" button at the start.
/// Matches Figma: gradient ring borders (green=live, blue=scheduled),
/// progress ring for live stories, view count, status labels.
class StoryPreviewStrip extends StatelessWidget {
  final List<MyStory> stories;
  final VoidCallback onCreateTap;
  final ValueChanged<MyStory>? onStoryTap;

  const StoryPreviewStrip({
    super.key,
    required this.stories,
    required this.onCreateTap,
    this.onStoryTap,
  });

  @override
  Widget build(BuildContext context) {
    final liveCount =
        stories.where((s) => s.status == 'live').length;
    final scheduledCount =
        stories.where((s) => s.status == 'scheduled').length;

    // Max views among live stories for progress normalization
    final maxViews = stories
        .where((s) => s.status == 'live' && s.stats.views > 0)
        .fold<int>(1, (max, s) => s.stats.views > max ? s.stats.views : max);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Status summary badges
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (liveCount > 0)
              _StatusCount(
                count: liveCount,
                label: '$liveCount ${context.l10n.storyStatusLive}',
                color: const Color(0xFF43A047),
              ),
            if (liveCount > 0 && scheduledCount > 0)
              const SizedBox(width: 12),
            if (scheduledCount > 0)
              _StatusCount(
                count: scheduledCount,
                label: '$scheduledCount ${context.l10n.storyStatusScheduled}',
                color: const Color(0xFF1A73E8),
              ),
          ],
        ),
        const SizedBox(height: 6),

        // Subtitle
        Text(
          context.l10n.storyPreviewSubtitle,
          style: TextStyle(
            fontSize: 10,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 10),

        // Thumbnail strip
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: AppSpacing.paddingH(AppSpacing.lg),
            itemCount: stories.length + 1,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              if (index == 0) return _CreateButton(onTap: onCreateTap);
              final story = stories[index - 1];
              return _StoryThumbnail(
                story: story,
                maxViews: maxViews,
                onTap: onStoryTap != null ? () => onStoryTap!(story) : null,
              );
            },
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Status count badge — "● 3 قصة حالية" / "● 4 مجدولة"
// ═══════════════════════════════════════════════════════════════

class _StatusCount extends StatelessWidget {
  final int count;
  final String label;
  final Color color;

  const _StatusCount({
    required this.count,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Create button — dashed blue circle, plus icon (Figma)
// ═══════════════════════════════════════════════════════════════

class _CreateButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CreateButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 68,
        child: Column(
          children: [
            CustomPaint(
              painter: _DashedCirclePainter(
                color: const Color(0xFF1A73E8).withValues(alpha: 0.4),
                strokeWidth: 1,
                dashCount: 28,
                gapRatio: 0.5,
              ),
              child: Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                child: Icon(
                  Icons.add,
                  color: const Color(0xFF1A73E8).withValues(alpha: 0.6),
                  size: 20,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              context.l10n.storyCreateNew,
              style: const TextStyle(
                fontSize: 9,
                color: Color(0xFF1A73E8),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Story thumbnail with progress ring + gradient border
// ═══════════════════════════════════════════════════════════════

const _liveGradient = [Color(0xFF43A047), Color(0xFF66BB6A)];
const _scheduledGradient = [Color(0xFF1A73E8), Color(0xFF4DA3FF)];

class _StoryThumbnail extends StatelessWidget {
  final MyStory story;
  final int maxViews;
  final VoidCallback? onTap;

  const _StoryThumbnail({
    required this.story,
    required this.maxViews,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isLive = story.status == 'live';
    final isScheduled = story.status == 'scheduled';
    final isExpired = story.status == 'expired';
    final gradientColors = isLive
        ? _liveGradient
        : isScheduled
            ? _scheduledGradient
            : [const Color(0xFFBDBDBD), const Color(0xFFE0E0E0)];
    final ringColor = gradientColors[0];

    // View progress: 0–1 normalized to max views
    final viewProgress =
        isLive && story.stats.views > 0 && maxViews > 0
            ? (story.stats.views / maxViews).clamp(0.0, 1.0)
            : 0.0;

    // Ring opacity: live = 0.7, scheduled = 0.5, expired = 0.3
    final ringOpacity = isLive ? 0.7 : isScheduled ? 0.5 : 0.3;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 68,
        child: Column(
          children: [
            // Thumbnail with rings
            SizedBox(
              width: 60,
              height: 60,
              child: CustomPaint(
                painter: _GradientRingPainter(
                  colors: gradientColors,
                  strokeWidth: isExpired ? 1.0 : 1.8,
                  opacity: ringOpacity,
                  progress: isLive ? viewProgress : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.5),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colorScheme.surface,
                    ),
                    padding: const EdgeInsets.all(1.5),
                    child: ClipOval(
                      child: Opacity(
                        opacity: isExpired ? 0.55 : 1.0,
                        child: StoryCanvas(
                          slide: story.slide,
                          interactive: false,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 3),

            // Status label
            Text(
              isLive
                  ? context.l10n.storyStatusLive
                  : isScheduled
                      ? context.l10n.storyStatusScheduled
                      : context.l10n.storyStatusExpired,
              style: TextStyle(
                fontSize: 9,
                color: ringColor,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            // View count (live) or text preview
            if (isLive && story.stats.views > 0)
              Text(
                '${_formatNumber(story.stats.views)} ${context.l10n.storyViews}',
                style: const TextStyle(
                  fontSize: 8,
                  color: Color(0xFF43A047),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            else
              Text(
                story.slide.text ?? '',
                style: TextStyle(
                  fontSize: 8,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }

  static String _formatNumber(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }
}

// ═══════════════════════════════════════════════════════════════
// Custom painters
// ═══════════════════════════════════════════════════════════════

/// Combined gradient ring + optional progress overlay.
/// Draws a thin gradient circle border with configurable opacity,
/// and for live stories an additional progress arc on top.
class _GradientRingPainter extends CustomPainter {
  final List<Color> colors;
  final double strokeWidth;
  final double opacity;
  final double? progress; // null = no progress arc

  _GradientRingPainter({
    required this.colors,
    this.strokeWidth = 1.8,
    this.opacity = 0.7,
    this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (min(size.width, size.height) - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Gradient ring
    final ringPaint = Paint()
      ..shader = SweepGradient(
        colors: [
          colors.first.withValues(alpha: opacity),
          colors.last.withValues(alpha: opacity),
          colors.first.withValues(alpha: opacity),
        ],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, ringPaint);

    // Progress arc (brighter overlay on top of the ring)
    if (progress != null && progress! > 0) {
      final progressPaint = Paint()
        ..shader = SweepGradient(
          startAngle: -pi / 2,
          endAngle: -pi / 2 + 2 * pi,
          colors: [colors.first, colors.last],
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth + 0.8
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
        rect,
        -pi / 2,
        2 * pi * progress!,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_GradientRingPainter old) =>
      opacity != old.opacity ||
      progress != old.progress ||
      strokeWidth != old.strokeWidth;
}

/// Dashed circle border for the create button.
class _DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final int dashCount;
  final double gapRatio;

  _DashedCirclePainter({
    required this.color,
    this.strokeWidth = 1,
    this.dashCount = 28,
    this.gapRatio = 0.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (min(size.width, size.height) - strokeWidth) / 2;

    final dashAngle = (2 * pi) / dashCount;
    final arcAngle = dashAngle * (1 - gapRatio);

    for (var i = 0; i < dashCount; i++) {
      final startAngle = i * dashAngle - pi / 2;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        arcAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_DashedCirclePainter old) => color != old.color;
}
