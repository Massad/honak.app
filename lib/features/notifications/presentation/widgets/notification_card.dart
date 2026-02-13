import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/notifications/domain/entities/app_notification.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationCard extends StatelessWidget {
  final AppNotification notification;
  final bool isRead;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.isRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final unreadBg = const Color(0xFFEBF2FD);
    final unreadBorder = AppColors.primary.withValues(alpha: 0.2);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isRead ? AppColors.surface : unreadBg,
          borderRadius: AppRadius.cardInner,
          border: Border.all(
            color: isRead ? const Color(0xFFE5E7EB) : unreadBorder,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NotificationAvatar(
              imageUrl: notification.imageUrl,
              type: notification.type,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (notification.pageName != null)
                    Text(
                      notification.pageName!,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight:
                            isRead ? FontWeight.w500 : FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  if (notification.pageName != null)
                    const SizedBox(height: 2),
                  Text(
                    notification.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    _formatTime(notification.createdAt),
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),
            if (!isRead) ...[
              const SizedBox(width: AppSpacing.sm),
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsetsDirectional.only(
                  top: AppSpacing.xs,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return timeago.format(date, locale: 'ar');
  }
}

class _NotificationAvatar extends StatelessWidget {
  final String? imageUrl;
  final String type;

  const _NotificationAvatar({
    required this.imageUrl,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFFE5E7EB),
            backgroundImage:
                imageUrl != null ? NetworkImage(imageUrl!) : null,
            child: imageUrl == null
                ? Icon(
                    Icons.storefront,
                    size: 20,
                    color: AppColors.textHint,
                  )
                : null,
          ),
          PositionedDirectional(
            bottom: -2,
            start: -2,
            child: _TypeIconBadge(type: type),
          ),
        ],
      ),
    );
  }
}

class _TypeIconBadge extends StatelessWidget {
  final String type;

  const _TypeIconBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    final (icon, color) = _iconAndColor;

    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Icon(icon, size: 11, color: Colors.white),
    );
  }

  (IconData, Color) get _iconAndColor => switch (type) {
        'request_status' => (Icons.check_circle, AppColors.success),
        'new_message' => (Icons.message, AppColors.primary),
        'new_follower' => (Icons.person_add, AppColors.success),
        'new_post' => (Icons.description, const Color(0xFF7C3AED)),
        'promotion' => (Icons.local_offer, AppColors.warning),
        _ => (Icons.notifications, AppColors.textHint),
      };
}
