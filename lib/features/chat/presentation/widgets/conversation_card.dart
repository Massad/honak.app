import 'package:flutter/material.dart';
import 'package:honak/core/extensions/date_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/conversation.dart';
import 'package:honak/shared/widgets/story_ring_avatar.dart';

class ConversationCard extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback? onTap;
  final VoidCallback? onAvatarTap;
  final bool isBusinessMode;

  const ConversationCard({
    super.key,
    required this.conversation,
    this.onTap,
    this.onAvatarTap,
    this.isBusinessMode = false,
  });

  bool get _isUnread => conversation.unreadCount > 0;

  DateTime get _lastMessageTime =>
      DateTime.fromMillisecondsSinceEpoch(conversation.lastMessageAt * 1000);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        color: _isUnread
            ? AppColors.primary.withValues(alpha: 0.04)
            : null,
        padding: EdgeInsetsDirectional.only(
          start: AppSpacing.lg,
          end: AppSpacing.lg,
          top: AppSpacing.md,
          bottom: AppSpacing.md,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAvatar(theme),
            SizedBox(width: AppSpacing.md),
            Expanded(child: _buildContent(theme)),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(ThemeData theme) {
    final avatarUrl = conversation.displayAvatar(isBusinessMode: isBusinessMode);
    final displayName =
        conversation.displayName(isBusinessMode: isBusinessMode);

    // Stories belong to business pages, not customers
    final showStories = !isBusinessMode && conversation.hasActiveStory;

    Widget avatar = StoryRingAvatar(
      imageUrl: avatarUrl,
      name: displayName,
      radius: 24,
      hasStories: showStories,
      onTap: showStories ? onAvatarTap : null,
    );

    if (_isUnread) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          PositionedDirectional(
            top: -2,
            end: -2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: AppRadius.pill,
                border: Border.all(
                  color: AppColors.white,
                  width: 1.5,
                ),
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Center(
                child: Text(
                  conversation.unreadCount > 9
                      ? '+9'
                      : '${conversation.unreadCount}',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return avatar;
  }

  Widget _buildContent(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNameRow(theme),
        SizedBox(height: AppSpacing.xs),
        _buildMessagePreview(theme),
        if (conversation.needsInfo) ...[
          SizedBox(height: AppSpacing.xs),
          _buildNeedsInfoIndicator(theme),
        ],
      ],
    );
  }

  Widget _buildNameRow(ThemeData theme) {
    final displayName =
        conversation.displayName(isBusinessMode: isBusinessMode);
    final isExpired = conversation.isExpired;

    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Flexible(
                child: Text(
                  displayName,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: _isUnread ? FontWeight.w700 : FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (conversation.requestId != null) ...[
                SizedBox(width: AppSpacing.sm),
                Container(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: isExpired
                        ? AppColors.textHint.withValues(alpha: 0.12)
                        : AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: AppRadius.pill,
                  ),
                  child: Text(
                    isExpired
                        ? 'منتهي'
                        : 'طلب #${conversation.requestId!.replaceAll('req_', '')}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: isExpired ? AppColors.textHint : AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(width: AppSpacing.sm),
        Text(
          _lastMessageTime.toRelative(),
          style: theme.textTheme.bodySmall?.copyWith(
            color: _isUnread ? AppColors.primary : AppColors.textHint,
            fontWeight: _isUnread ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildMessagePreview(ThemeData theme) {
    final prefix = isBusinessMode
        ? (conversation.lastMessageFrom != 'business' ? 'العميل: ' : '')
        : (conversation.lastMessageFrom == 'business' ? 'الرد: ' : '');
    final message = conversation.lastMessage ?? '';

    return Text(
      '$prefix$message',
      style: theme.textTheme.bodyMedium?.copyWith(
        color: _isUnread ? AppColors.textPrimary : AppColors.textSecondary,
        fontWeight: _isUnread ? FontWeight.w500 : FontWeight.w400,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildNeedsInfoIndicator(ThemeData theme) {
    return Row(
      children: [
        Icon(
          Icons.info_outline,
          size: 14,
          color: AppColors.warning,
        ),
        SizedBox(width: AppSpacing.xs),
        Text(
          'يحتاج معلومات إضافية',
          style: theme.textTheme.labelSmall?.copyWith(
            color: AppColors.warning,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
