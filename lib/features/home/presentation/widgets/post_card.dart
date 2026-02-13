import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_card_style.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/home/domain/entities/post.dart';
import 'package:honak/features/home/presentation/widgets/post_card_bodies.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback? onPageTap;
  final VoidCallback? onPostTap;
  final VoidCallback? onProductTap;

  const PostCard({
    super.key,
    required this.post,
    this.onPageTap,
    this.onPostTap,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return switch (post.postType) {
      PostType.status => _buildStatusCard(context),
      PostType.product => _buildProductCard(context),
      PostType.offer => _buildOfferCard(context),
      PostType.photo => _buildPhotoCard(context),
      PostType.update => _buildUpdateCard(context),
    };
  }

  /// Product: horizontal card — image on one side, content on other.
  Widget _buildProductCard(BuildContext context) {
    if (post.isPromoted) return _buildPromotedCard(context);

    return GestureDetector(
      onTap: onPostTap,
      child: Container(
        height: 140,
        decoration: AppCardStyle.standard(context.colorScheme),
        clipBehavior: Clip.antiAlias,
        child: ProductCardBody(
          post: post,
          onPageTap: onPageTap,
          onProductTap: onProductTap,
        ),
      ),
    );
  }

  /// Offer: full-width gradient red banner with image side.
  Widget _buildOfferCard(BuildContext context) {
    final feed = context.feedColors;

    return GestureDetector(
      onTap: onPostTap,
      child: Container(
        decoration: AppCardStyle.offerGradient(
          gradientStart: feed.offerGradientStart,
          gradientEnd: feed.offerGradientEnd,
        ),
        clipBehavior: Clip.antiAlias,
        child: OfferCardBody(post: post, onPageTap: onPageTap),
      ),
    );
  }

  /// Status: notification-style card with warning/info variants.
  Widget _buildStatusCard(BuildContext context) {
    final feed = context.feedColors;
    final isWarning = _isWarningStatus(post.content);

    return GestureDetector(
      onTap: onPostTap,
      child: Container(
        decoration: AppCardStyle.statusCard(
          background: isWarning ? feed.statusWarningBg : feed.statusInfoBg,
          borderColor:
              isWarning ? feed.statusWarningBorder : feed.statusInfoBorder,
        ),
        clipBehavior: Clip.antiAlias,
        child: StatusCardBody(
          post: post,
          onPageTap: onPageTap,
          isWarning: isWarning,
        ),
      ),
    );
  }

  /// Photo: full-bleed immersive image with overlays.
  Widget _buildPhotoCard(BuildContext context) {
    final hasImage = post.media.isNotEmpty;

    return GestureDetector(
      onTap: onPostTap,
      child: hasImage
          ? Container(
              decoration: BoxDecoration(
                borderRadius: AppRadius.card,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: PhotoCardBody(post: post, onPageTap: onPageTap),
            )
          : Container(
              decoration: BoxDecoration(
                color: context.feedColors.photoBadge.withValues(alpha: 0.08),
                borderRadius: AppRadius.card,
              ),
              padding: EdgeInsets.all(AppSpacing.lg),
              child: PhotoCardBody(post: post, onPageTap: onPageTap),
            ),
    );
  }

  /// Update: white card with blue gradient accent stripe at top.
  Widget _buildUpdateCard(BuildContext context) {
    if (post.isPromoted) return _buildPromotedCard(context);

    return GestureDetector(
      onTap: onPostTap,
      child: Container(
        decoration: AppCardStyle.standard(context.colorScheme),
        clipBehavior: Clip.antiAlias,
        child: UpdateCardBody(post: post, onPageTap: onPageTap),
      ),
    );
  }

  /// Promoted card (for both product and update).
  Widget _buildPromotedCard(BuildContext context) {
    return GestureDetector(
      onTap: onPostTap,
      child: Container(
        decoration: AppCardStyle.promoted(
          background: context.feedColors.promotedBg,
          border: context.feedColors.promotedBorder,
        ),
        padding: EdgeInsets.all(AppSpacing.md),
        child: PromotedCardBody(
          post: post,
          onPageTap: onPageTap,
          onProductTap: onProductTap,
        ),
      ),
    );
  }

  /// Check if status content contains warning keywords.
  static bool _isWarningStatus(String content) {
    const warningKeywords = ['مغلق', 'صيانة', 'تأخير'];
    return warningKeywords.any((kw) => content.contains(kw));
  }
}
