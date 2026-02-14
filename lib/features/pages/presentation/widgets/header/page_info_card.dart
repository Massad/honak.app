import 'package:flutter/material.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/features/pages/presentation/widgets/header/action_bar.dart';
import 'package:honak/features/pages/presentation/widgets/header/badge_pills.dart';
import 'package:honak/features/pages/presentation/widgets/header/location_hours_row.dart';
import 'package:honak/features/pages/presentation/widgets/header/page_avatar.dart';
import 'package:honak/features/pages/presentation/widgets/header/status_banner.dart';
import 'package:honak/features/pages/presentation/widgets/header/trust_metrics_row.dart';
import 'package:honak/features/pages/presentation/widgets/shared/follow_button.dart';

/// Full-width white section containing avatar, name, badges, description,
/// location, hours, trust metrics, status banner, and action bar.
/// Matches Figma: `bg-white mx-0 relative` with everything inside `px-4 pb-4`.
class PageInfoCard extends StatelessWidget {
  final PageDetail page;
  final Archetype archetype;
  final bool hasMiddleElements;
  final bool isFollowing;
  final ValueChanged<FollowLevel?> onFollowChanged;
  final ValueChanged<String>? onSearchType;
  final ValueChanged<String>? onSearchCategory;
  final VoidCallback? onClaimPage;

  const PageInfoCard({
    super.key,
    required this.page,
    required this.archetype,
    this.hasMiddleElements = false,
    required this.isFollowing,
    required this.onFollowChanged,
    this.onSearchType,
    this.onSearchCategory,
    this.onClaimPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.surface,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar — with story ring gradient when stories exist
          Padding(
            padding: EdgeInsets.only(top: AppSpacing.md),
            child: PageAvatar(
              avatarUrl: page.avatarUrl,
              stories: page.stories,
              onOpenStories: page.stories.isNotEmpty
                  ? () => PageAvatar.openStories(context, page.stories)
                  : null,
            ),
          ),

          const SizedBox(height: 8),

          // Name + verified badge
          Row(
            children: [
              Flexible(
                child: Text(
                  page.name,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (page.isVerified) ...[
                const SizedBox(width: 6),
                Icon(
                  Icons.verified,
                  size: 18,
                  color: context.colorScheme.primary,
                ),
              ],
            ],
          ),

          // Handle
          if (page.handle != null) ...[
            const SizedBox(height: 4),
            Text(
              '@${page.handle}',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ],

          // Badge pills + engagement level showcase badge
          SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: BadgePills(
                  businessTypeName: page.businessTypeName,
                  categoryName: page.categoryName,
                  requiresApproval: page.requiresApproval,
                  storeType: page.storeType,
                  onSearchType: onSearchType,
                  onSearchCategory: onSearchCategory,
                ),
              ),
              if (page.engagementLevel == 'showcase') ...[
                SizedBox(width: AppSpacing.xs),
                Container(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.sm, 2, AppSpacing.sm, 2,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.tertiaryContainer,
                    borderRadius: AppRadius.pill,
                  ),
                  child: Text(
                    // "عرض فقط"
                    '\u0639\u0631\u0636 \u0641\u0642\u0637',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.onTertiaryContainer,
                    ),
                  ),
                ),
              ],
            ],
          ),

          // Description — hidden for 'visibility' engagement level
          if (page.engagementLevel != 'visibility' &&
              page.description != null &&
              page.description!.isNotEmpty) ...[
            SizedBox(height: AppSpacing.sm),
            Text(
              page.description!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                height: 1.625,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],

          SizedBox(height: AppSpacing.md),

          // Location + Hours row
          LocationHoursRow(page: page, archetype: archetype),

          // Trust metrics (inside white section)
          if (page.trustMetrics.isNotEmpty) ...[
            SizedBox(height: AppSpacing.lg),
            TrustMetricsRow(
              metrics: page.trustMetrics,
              trustScore: page.trustScore,
            ),
          ],

          // Status banner (inside white section, after trust metrics)
          StatusBanner(
            temporarilyClosed: page.temporarilyClosed,
            relocated: page.relocated,
            permanentlyClosed: page.permanentlyClosed,
          ),

          // Action bar (inside white section)
          SizedBox(height: AppSpacing.sm),
          ActionBar(
            page: page,
            archetype: archetype,
            isFollowing: isFollowing,
            onFollowChanged: onFollowChanged,
            onClaimPage: onClaimPage,
          ),
        ],
      ),
    );
  }
}
