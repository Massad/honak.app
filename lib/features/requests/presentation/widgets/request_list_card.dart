import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/domain/entities/entities.dart';
import 'package:honak/features/requests/presentation/widgets/request_status_config.dart';
import 'package:honak/shared/widgets/app_image.dart';

/// Reusable request card for the customer's orders page.
///
/// Layout (RTL): Avatar (start) → Business info (middle) → Status chip (end)
/// Optional: delivery tracking banner, progress bar, subscription badge.
class RequestListCard extends StatelessWidget {
  final CustomerRequest request;
  final VoidCallback? onTap;

  const RequestListCard({
    super.key,
    required this.request,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final style =
        requestStatusStyles[request.status] ?? requestStatusStyles['pending']!;
    final isCancelled = request.status.startsWith('cancelled');
    final hasDelivery = request.status == 'in_progress' &&
        request.deliveryTracking != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: AppRadius.card,
          border: Border.all(
            color: isCancelled
                ? AppColors.error.withValues(alpha: 0.15)
                : context.colorScheme.outlineVariant,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Main content
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row: avatar + business info + status
                  _BusinessRow(request: request, statusStyle: style),
                  const SizedBox(height: AppSpacing.sm),

                  // Summary line
                  if (_summaryText.isNotEmpty)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 52, // avatar (40) + gap (12)
                      ),
                      child: Text(
                        _summaryText,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                  // Cancel reason
                  if (isCancelled && request.declineReason != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    _CancelReasonChip(reason: request.declineReason!),
                  ],

                  const SizedBox(height: AppSpacing.sm),

                  // Bottom row: total + subscription badge (start), chat + chevron (end)
                  _BottomRow(request: request),
                ],
              ),
            ),

            // Delivery tracking banner
            if (hasDelivery)
              _DeliveryTrackingBanner(tracking: request.deliveryTracking!),

            // Progress bar
            if (request.timeline.length > 1) _ProgressBar(request: request),
          ],
        ),
      ),
    );
  }

  String get _summaryText {
    // For queue_service, build a summary with position + wait time
    if (request.isQueueType) {
      final parts = <String>[];
      if (request.queuePosition != null) {
        parts.add('رقمك ${request.queuePosition}');
      }
      if (request.estimatedWaitMin != null && request.estimatedWaitMin! > 0) {
        parts.add('~${request.estimatedWaitMin} دقيقة');
      }
      if (parts.isNotEmpty) return parts.join(' — ');
      return 'في الدور';
    }
    if (request.summary != null && request.summary!.isNotEmpty) {
      return request.summary!;
    }
    return request.summaryText;
  }
}

// -- Private sub-widgets --

class _BusinessRow extends StatelessWidget {
  final CustomerRequest request;
  final StatusStyle statusStyle;

  const _BusinessRow({required this.request, required this.statusStyle});

  @override
  Widget build(BuildContext context) {
    final typeIcon =
        requestTypeIcons[request.type] ?? Icons.shopping_bag_outlined;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar with type icon badge
        Stack(
          clipBehavior: Clip.none,
          children: [
            AppImage.avatar(
              url: request.businessAvatarUrl,
              name: request.businessName,
              radius: 20,
            ),
            PositionedDirectional(
              bottom: -2,
              end: -2,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: statusStyle.background,
                  shape: BoxShape.circle,
                  border: Border.all(color: context.colorScheme.surface, width: 1.5),
                ),
                child: Icon(typeIcon, size: 10, color: statusStyle.foreground),
              ),
            ),
          ],
        ),
        const SizedBox(width: AppSpacing.md),
        // Business name + date
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                request.businessName,
                style: context.textTheme.titleSmall,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                _formatTimeAgo(request.createdAt),
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        // Status badge
        _StatusBadge(style: statusStyle),
      ],
    );
  }

  static String _formatTimeAgo(int timestamp) {
    final now = DateTime.now();
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'الآن';
    if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} د';
    if (diff.inHours < 24) return 'منذ ${diff.inHours} س';
    if (diff.inDays < 7) return 'منذ ${diff.inDays} ي';
    return 'منذ ${(diff.inDays / 7).floor()} أ';
  }
}

class _StatusBadge extends StatelessWidget {
  final StatusStyle style;

  const _StatusBadge({required this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 3),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: AppRadius.pill,
      ),
      child: Text(
        style.label,
        style: TextStyle(
          color: style.foreground,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _BottomRow extends StatelessWidget {
  final CustomerRequest request;

  const _BottomRow({required this.request});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 52),
      child: Row(
        children: [
          // Total
          if (request.total != null)
            Text(
              request.total!.toFormattedArabic(),
              style: context.textTheme.titleSmall?.copyWith(
                color: AppColors.primary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          // Subscription badge
          if (request.paidBySubscription != null) ...[
            const SizedBox(width: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.card_membership,
                    size: 10,
                    color: Color(0xFF388E3C),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    'اشتراك',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF388E3C),
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const Spacer(),
          // Chat + chevron
          Icon(Icons.chat_bubble_outline, size: 16, color: context.colorScheme.onSurfaceVariant),
          const SizedBox(width: AppSpacing.sm),
          Icon(Icons.chevron_left, size: 18, color: context.colorScheme.outline),
        ],
      ),
    );
  }
}

class _CancelReasonChip extends StatelessWidget {
  final String reason;

  const _CancelReasonChip({required this.reason});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 52),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(AppRadius.xxs),
        ),
        child: Row(
          children: [
            const Icon(Icons.cancel_outlined, size: 11, color: AppColors.error),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                reason,
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.error,
                  fontSize: 10,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeliveryTrackingBanner extends StatelessWidget {
  final DeliveryTracking tracking;

  const _DeliveryTrackingBanner({required this.tracking});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_shipping, size: 16, color: Color(0xFF1565C0)),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              _trackingText,
              style: context.textTheme.bodySmall?.copyWith(
                color: const Color(0xFF1565C0),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (tracking.driverName != null)
            Text(
              tracking.driverName!,
              style: context.textTheme.bodySmall?.copyWith(
                color: const Color(0xFF1565C0),
                fontSize: 11,
              ),
            ),
        ],
      ),
    );
  }

  String get _trackingText {
    if (tracking.estimatedMinutes != null) {
      return 'التوصيل خلال ${tracking.estimatedMinutes} د';
    }
    switch (tracking.status) {
      case 'dispatched':
        return 'تم تكليف سائق';
      case 'en_route':
        return 'في الطريق إليك';
      case 'arriving':
        return 'على وشك الوصول';
      default:
        return 'قيد التوصيل';
    }
  }
}

class _ProgressBar extends StatelessWidget {
  final CustomerRequest request;

  const _ProgressBar({required this.request});

  @override
  Widget build(BuildContext context) {
    final events = request.timeline;
    if (events.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: SizedBox(
        height: 3,
        child: Row(
          children: List.generate(events.length, (i) {
            final isDone = events[i].done;
            final isLast = i == events.length - 1;
            return Expanded(
              child: Container(
                margin: EdgeInsetsDirectional.only(
                  end: isLast ? 0 : 1,
                ),
                decoration: BoxDecoration(
                  color: isDone
                      ? AppColors.primary
                      : context.colorScheme.outlineVariant,
                  borderRadius: BorderRadius.only(
                    bottomLeft: i == 0
                        ? const Radius.circular(16)
                        : Radius.zero,
                    bottomRight: isLast
                        ? const Radius.circular(16)
                        : Radius.zero,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
