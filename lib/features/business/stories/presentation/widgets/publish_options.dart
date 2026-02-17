import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/features/business/stories/domain/entities/my_story.dart';
import 'package:honak/features/business/stories/domain/entities/story_stats.dart';
import 'package:honak/features/business/stories/presentation/providers/my_stories_provider.dart';
import 'package:honak/features/business/stories/presentation/providers/story_creator_provider.dart';
import 'package:honak/features/stories/domain/entities/story_slide.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/button.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:uuid/uuid.dart';

/// Publish options as a bottom sheet.
/// Audience (followers / all) + schedule (now / later) + publish button.
class PublishSheet {
  static Future<bool> show(BuildContext context) async {
    final result = await showAppSheet<bool>(
      context,
      builder: (_) => const _PublishContent(),
    );
    return result ?? false;
  }
}

class _PublishContent extends ConsumerStatefulWidget {
  const _PublishContent();

  @override
  ConsumerState<_PublishContent> createState() => _PublishContentState();
}

class _PublishContentState extends ConsumerState<_PublishContent> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(storyCreatorProvider);
    final notifier = ref.read(storyCreatorProvider.notifier);
    final isScheduled = state.scheduledAt != null;

    return Container(
      color: const Color(0xFF1F2937),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          Center(
            child: Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Audience
          Text(
            context.l10n.storyWhoSees,
            style: const TextStyle(color: Colors.white60, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _OptionCard(
                  icon: Icons.people_outline,
                  label: context.l10n.storyAudienceFollowers,
                  selected: state.audience == 'followers',
                  color: const Color(0xFF1A73E8),
                  onTap: () => notifier.setAudience('followers'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _OptionCard(
                  icon: Icons.public,
                  label: context.l10n.storyAudienceAll,
                  selected: state.audience == 'all',
                  color: const Color(0xFFFF9800),
                  onTap: () => notifier.setAudience('all'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Timing
          Text(
            context.l10n.storyPublishTime,
            style: const TextStyle(color: Colors.white60, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _OptionCard(
                  icon: Icons.send,
                  label: context.l10n.storyNow,
                  selected: !isScheduled,
                  color: const Color(0xFF43A047),
                  onTap: () => notifier.setSchedule(null),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _OptionCard(
                  icon: Icons.calendar_today,
                  label: context.l10n.storySchedule,
                  selected: isScheduled,
                  color: const Color(0xFF1A73E8),
                  onTap: () => _pickDateTime(context, notifier),
                ),
              ),
            ],
          ),

          // Scheduled date display
          if (isScheduled && state.scheduledAt != null) ...[
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _pickDateTime(context, notifier),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.edit_calendar,
                        size: 14, color: Colors.white54),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('yyyy/MM/dd — HH:mm')
                          .format(state.scheduledAt!),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 12),

          // Info text
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline, size: 14, color: Colors.white24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isScheduled
                      ? context.l10n.storyScheduledInfo
                      : context.l10n.storyNowInfo,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 10,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Publish button
          Button(
            onPressed: () {
              _publishStory(ref);
              context.showSnackBar(context.l10n.storyPublished);
              Navigator.of(context).pop(true);
            },
            label: isScheduled ? context.l10n.storyScheduleAction : context.l10n.storyPublishNow,
            icon: ButtonIcon(
              isScheduled ? Icons.schedule : Icons.send,
              size: 16,
            ),
            style: isScheduled ? Style.primary : Style.success,
            size: ButtonSize.large,
            expand: true,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _publishStory(WidgetRef ref) {
    const uuid = Uuid();
    final creator = ref.read(storyCreatorProvider);
    final now = DateTime.now();
    final isScheduled = creator.scheduledAt != null;

    // Build a StorySlide from creator state
    final slide = StorySlide(
      id: uuid.v4(),
      type: 'text',
      textLayers: creator.textLayers,
      bgGradient:
          creator.bgType == BgType.gradient ? creator.bgGradient : null,
      bgColor: creator.bgType == BgType.solid ? creator.bgColor : null,
      image: creator.bgType == BgType.image ? creator.bgImage : null,
      text: creator.textLayers.isNotEmpty
          ? creator.textLayers.first.text
          : null,
      createdAt: now.toIso8601String(),
    );

    final story = MyStory(
      id: uuid.v4(),
      slide: slide,
      status: isScheduled ? 'scheduled' : 'live',
      audience: creator.audience,
      createdAt: now.toIso8601String(),
      expiresAt: isScheduled
          ? null
          : now.add(const Duration(hours: 24)).toIso8601String(),
      scheduledAt: creator.scheduledAt?.toIso8601String(),
      stats: const StoryStats(),
    );

    ref.read(myStoriesProvider.notifier).addStory(story);
  }

  Future<void> _pickDateTime(
    BuildContext context,
    StoryCreatorNotifier notifier,
  ) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(hours: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
    );
    if (date == null || !context.mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        now.add(const Duration(hours: 1)),
      ),
    );
    if (time == null) return;

    notifier.setSchedule(
      DateTime(date.year, date.month, date.day, time.hour, time.minute),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Option card — dark translucent pill with icon + label
// ═══════════════════════════════════════════════════════════════

class _OptionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _OptionCard({
    required this.icon,
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? color.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? color : Colors.white10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: selected ? color : Colors.white54),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : Colors.white54,
                fontSize: 12,
                fontWeight: selected ? FontWeight.w600 : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
