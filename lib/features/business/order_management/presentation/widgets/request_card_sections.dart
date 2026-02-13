import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/shared/domain/entities/entities.dart';
import 'package:honak/shared/widgets/app_image.dart';

// ===============================================================
// Status helpers
// ===============================================================

String requestStatusLabel(String status) {
  return switch (status) {
    'pending' => 'معلق',
    'accepted' => 'مقبول',
    'in_progress' => 'قيد التنفيذ',
    'preparing' => 'قيد التحضير',
    'ready' => 'جاهز',
    'delivered' => 'تم التسليم',
    'completed' => 'مكتمل',
    'declined' => 'مرفوض',
    _ => status,
  };
}

Color requestStatusBgColor(String status) {
  return switch (status) {
    'pending' => const Color(0xFFFFF8E1),
    'accepted' => const Color(0xFFE8F5E9),
    'in_progress' => const Color(0xFFE3F2FD),
    'preparing' => const Color(0xFFFFF3E0),
    'ready' => const Color(0xFFE8F5E9),
    'delivered' => const Color(0xFFE8F5E9),
    'completed' => const Color(0xFFE8F5E9),
    'declined' => const Color(0xFFFFEBEE),
    _ => Colors.grey.shade100,
  };
}

Color requestStatusTextColor(String status) {
  return switch (status) {
    'pending' => const Color(0xFFFF9800),
    'accepted' => const Color(0xFF43A047),
    'in_progress' => AppColors.primary,
    'preparing' => const Color(0xFFFF9800),
    'ready' => const Color(0xFF43A047),
    'delivered' => const Color(0xFF43A047),
    'completed' => const Color(0xFF43A047),
    'declined' => AppColors.error,
    _ => Colors.grey,
  };
}

String requestTimeAgo(int createdAt) {
  final now = DateTime.now();
  final created = DateTime.fromMillisecondsSinceEpoch(createdAt * 1000);
  final diff = now.difference(created);

  if (diff.inMinutes < 1) return 'الآن';
  if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} د';
  if (diff.inHours < 24) return 'منذ ${diff.inHours} س';
  if (diff.inDays < 7) return 'منذ ${diff.inDays} يوم';
  return 'منذ ${(diff.inDays / 7).floor()} أسبوع';
}

// ===============================================================
// Header section -- status badge, time, customer info + avatar
// ===============================================================

class RequestCardHeader extends StatelessWidget {
  final BizRequest request;

  const RequestCardHeader({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          // Time + status
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: requestStatusBgColor(request.status),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  requestStatusLabel(request.status),
                  style: TextStyle(
                    fontSize: 10,
                    color: requestStatusTextColor(request.status),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                requestTimeAgo(request.createdAt),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Customer info
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                request.customer.name,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${request.itemsCount} أصناف',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          // Avatar
          AppImage.avatar(
            url: request.customer.avatarUrl,
            name: request.customer.name,
            radius: 20,
          ),
        ],
      ),
    );
  }
}

// ===============================================================
// Note preview -- single-line italic note with icon
// ===============================================================

class RequestCardNotePreview extends StatelessWidget {
  final String note;

  const RequestCardNotePreview({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                note,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.note_outlined,
              size: 12,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
