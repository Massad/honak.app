import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_shadows.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/home/domain/entities/post.dart';
import 'package:honak/features/home/presentation/widgets/post_card_bodies/post_card_helpers.dart';

/// Uniform activity post card for the page detail ActivityTab.
///
/// Unlike the home feed [PostCard] which renders different layouts per type,
/// this card renders ALL post types in the same simple structure matching
/// the Figma ActivityTab design.
class ActivityPostCard extends StatelessWidget {
  final Post post;
  final bool isPinned;
  final VoidCallback? onTap;

  const ActivityPostCard({
    super.key,
    required this.post,
    this.isPinned = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: AppRadius.card,
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: AppShadows.sm,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pinned indicator
            if (isPinned)
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.md, 10, AppSpacing.md, 0,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.push_pin,
                      size: 11,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: AppSpacing.xs + 2),
                    Text(
                      '\u0645\u062b\u0628\u0651\u062a',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),

            // Main content
            Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Type badge + timestamp
                  Row(
                    children: [
                      _TypeBadge(type: post.type),
                      const Spacer(),
                      Text(
                        timeAgo(post.createdAt),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.sm),

                  // Content text
                  Text(
                    post.content,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade800,
                      height: 1.625,
                    ),
                  ),

                  // Price (if applicable)
                  if (post.metadata?['price'] != null)
                    Padding(
                      padding: EdgeInsetsDirectional.only(top: AppSpacing.xs),
                      child: Text(
                        post.metadata!['price'].toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Image (if applicable)
            if (post.media.isNotEmpty)
              SizedBox(
                height: 176,
                width: double.infinity,
                child: Image.network(
                  post.media.first.url,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey.shade100,
                    child: Icon(
                      Icons.image_outlined,
                      color: Colors.grey.shade300,
                      size: 32,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Small colored pill badge showing the post type.
class _TypeBadge extends StatelessWidget {
  final String type;

  const _TypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    final config = _badgeConfig(type);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: config.bg,
        borderRadius: AppRadius.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(config.icon, size: 9, color: config.color),
          const SizedBox(width: 4),
          Text(
            config.label,
            style: TextStyle(
              fontSize: 10,
              color: config.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

({String label, Color color, Color bg, IconData icon}) _badgeConfig(
  String type,
) {
  return switch (type) {
    'product' => (
      label: '\u0645\u0646\u062a\u062c',
      color: AppColors.primary,
      bg: const Color(0xFFE3F2FD),
      icon: Icons.sell_outlined,
    ),
    'offer' => (
      label: '\u0639\u0631\u0636',
      color: const Color(0xFFFF9800),
      bg: const Color(0xFFFFF3E0),
      icon: Icons.percent,
    ),
    'update' => (
      label: '\u062a\u062d\u062f\u064a\u062b',
      color: const Color(0xFF43A047),
      bg: const Color(0xFFE8F5E9),
      icon: Icons.refresh,
    ),
    'photo' => (
      label: '\u0635\u0648\u0631\u0629',
      color: Colors.purple.shade600,
      bg: const Color(0xFFF3E5F5),
      icon: Icons.image_outlined,
    ),
    _ => (
      label: '\u062d\u0627\u0644\u0629',
      color: Colors.grey.shade600,
      bg: Colors.grey.shade100,
      icon: Icons.description_outlined,
    ),
  };
}
