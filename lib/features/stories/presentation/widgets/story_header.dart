import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/story_ring_avatar.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Header overlay for the story viewer: avatar, name, time ago, close button.
class StoryHeader extends StatelessWidget {
  final String name;
  final String? avatarUrl;
  final String? createdAt;
  final VoidCallback onClose;

  const StoryHeader({
    super.key,
    required this.name,
    this.avatarUrl,
    this.createdAt,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: AppSpacing.md,
        end: AppSpacing.xs,
        top: AppSpacing.xs,
      ),
      child: Row(
        children: [
          StoryRingAvatar(
            imageUrl: avatarUrl,
            name: name,
            radius: 16,
            hasStories: false,
          ),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (createdAt != null)
                  Text(
                    _formatTime(createdAt!),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: onClose,
          ),
        ],
      ),
    );
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
