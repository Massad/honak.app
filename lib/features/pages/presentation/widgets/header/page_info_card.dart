import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';
import 'package:honak/features/pages/presentation/widgets/header/action_bar.dart';
import 'package:honak/features/pages/presentation/widgets/header/badge_pills.dart';
import 'package:honak/features/pages/presentation/widgets/header/status_banner.dart';
import 'package:honak/features/pages/presentation/widgets/header/trust_metrics_row.dart';
import 'package:honak/features/pages/presentation/widgets/shared/follow_button.dart';
import 'package:honak/shared/widgets/data_sync_badge.dart';
import 'package:honak/shared/widgets/story_viewer.dart';

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

  void _openStories(BuildContext context, List<PageStory> stories) {
    StoryViewer.show(
      context,
      stories: stories
          .map((s) => StoryItem(
                id: s.id,
                imageUrl: s.imageUrl,
                duration: s.duration,
              ))
          .toList(),
    );
  }

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
            child: _AvatarWithStoryRing(
              avatarUrl: page.avatarUrl,
              stories: page.stories,
              onOpenStories: page.stories.isNotEmpty
                  ? () => _openStories(context, page.stories)
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

          // Data sync badge — shown when data may be stale
          DataSyncBadge(show: !page.dataSynced),

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
          _LocationHoursRow(page: page, archetype: archetype),

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

          // Venue tenant card — when page is inside a venue (mall, building)
          if (page.venueId != null)
            _VenueTenantCard(
              venueId: page.venueId!,
              venueFloor: page.venueFloor,
              venueUnit: page.venueUnit,
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

/// Square avatar (64px, rounded-2xl) with optional story-ring gradient border.
class _AvatarWithStoryRing extends StatelessWidget {
  final String? avatarUrl;
  final List<PageStory> stories;
  final VoidCallback? onOpenStories;

  const _AvatarWithStoryRing({
    this.avatarUrl,
    this.stories = const [],
    this.onOpenStories,
  });

  @override
  Widget build(BuildContext context) {
    final hasStories = stories.isNotEmpty;

    Widget avatar = Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        color: context.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: avatarUrl != null
            ? Image.network(
                avatarUrl!,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _placeholder(context),
              )
            : _placeholder(context),
      ),
    );

    if (!hasStories) return avatar;

    // Gradient border wrapper for stories
    return GestureDetector(
      onTap: onOpenStories,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.lg + 2),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              context.feedColors.storyRingStart,
              context.feedColors.storyRingEnd,
            ],
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            color: context.colorScheme.surface,
          ),
          child: avatar,
        ),
      ),
    );
  }

  Widget _placeholder(BuildContext context) {
    return Container(
      color: context.colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.storefront,
        color: context.colorScheme.outline,
        size: 28,
      ),
    );
  }
}

/// Small card showing the venue location for tenant pages.
class _VenueTenantCard extends StatelessWidget {
  final String venueId;
  final String? venueFloor;
  final String? venueUnit;

  const _VenueTenantCard({
    required this.venueId,
    this.venueFloor,
    this.venueUnit,
  });

  @override
  Widget build(BuildContext context) {
    // Build label: "في {floor} — وحدة {unit}" or partial
    final parts = <String>[];
    // "في" = in
    if (venueFloor != null) parts.add('\u0641\u064a $venueFloor');
    // "وحدة" = unit
    if (venueUnit != null) parts.add('\u0648\u062d\u062f\u0629 $venueUnit');
    final label = parts.isNotEmpty
        ? parts.join(' \u2014 ')
        // fallback: "داخل المبنى" = inside the building
        : '\u062f\u0627\u062e\u0644 \u0627\u0644\u0645\u0628\u0646\u0649';

    return Padding(
      padding: EdgeInsetsDirectional.only(top: AppSpacing.sm),
      child: GestureDetector(
        onTap: () => context.push(Routes.pagePath(venueId)),
        child: Container(
          padding: EdgeInsetsDirectional.fromSTEB(
            AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF), // blue-50
            border: Border.all(color: const Color(0xFFBFDBFE)), // blue-100
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 14,
                color: context.colorScheme.primary,
              ),
              SizedBox(width: AppSpacing.xs),
              Flexible(
                child: Text(
                  label,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(width: AppSpacing.xs),
              Icon(
                Icons.chevron_right,
                size: 14,
                color: context.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationHoursRow extends StatelessWidget {
  final PageDetail page;
  final Archetype archetype;

  const _LocationHoursRow({required this.page, required this.archetype});

  @override
  Widget build(BuildContext context) {
    final locationText =
        page.location?.label ?? page.location?.area ?? page.address ?? '';
    final hasLocation = locationText.isNotEmpty;
    final hasHours = page.hours != null ||
        page.operatingHours != null ||
        page.weeklySchedule != null;

    if (!hasLocation && !hasHours) return const SizedBox.shrink();

    return Wrap(
      spacing: AppSpacing.lg,
      runSpacing: AppSpacing.sm,
      children: [
        // Location
        if (hasLocation)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 12,
                color: context.colorScheme.primary,
              ),
              SizedBox(width: AppSpacing.xxs),
              Flexible(
                child: Text(
                  locationText,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (page.coverageZones.isNotEmpty ||
                  page.coverageZonesStructured.isNotEmpty) ...[
                SizedBox(width: AppSpacing.xs),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.08),
                    borderRadius: AppRadius.pill,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check,
                        size: 9,
                        color: Colors.green.shade700,
                      ),
                      SizedBox(width: 2),
                      Text(
                        '\u064a\u063a\u0637\u064a\u0643',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),

        // Hours
        if (hasHours) _HoursChip(page: page, archetype: archetype),
      ],
    );
  }
}

class _HoursChip extends StatelessWidget {
  final PageDetail page;
  final Archetype archetype;

  const _HoursChip({required this.page, required this.archetype});

  /// Compute open/closed status from weekly schedule using Jordan time (UTC+3).
  _ScheduleStatus? _computeFromSchedule() {
    final schedule = page.weeklySchedule;
    if (schedule == null) return null;

    // Jordan is UTC+3
    final jordanNow = DateTime.now().toUtc().add(const Duration(hours: 3));
    const dayNames = [
      'monday', 'tuesday', 'wednesday', 'thursday',
      'friday', 'saturday', 'sunday',
    ];
    final dayName = dayNames[jordanNow.weekday - 1];
    final dayData = schedule[dayName];
    if (dayData == null) return null;

    final enabled = dayData['enabled'] as bool? ?? false;
    if (!enabled) {
      // "مغلق اليوم"
      return _ScheduleStatus(
        isOpen: false,
        label: '\u0645\u063a\u0644\u0642 \u0627\u0644\u064a\u0648\u0645',
      );
    }

    final openStr = dayData['open'] as String?;
    final closeStr = dayData['close'] as String?;
    if (openStr == null || closeStr == null) return null;

    final nowMinutes = jordanNow.hour * 60 + jordanNow.minute;
    final openMinutes = _parseTime(openStr);
    final closeMinutes = _parseTime(closeStr);

    // Handle overnight hours (e.g. 09:00 - 02:00)
    final isOpen = closeMinutes > openMinutes
        ? nowMinutes >= openMinutes && nowMinutes < closeMinutes
        : nowMinutes >= openMinutes || nowMinutes < closeMinutes;

    if (isOpen) {
      // "متاح الآن · يغلق {close}"
      return _ScheduleStatus(
        isOpen: true,
        label: '\u0645\u062a\u0627\u062d \u0627\u0644\u0622\u0646 \u00b7 \u064a\u063a\u0644\u0642 $closeStr',
      );
    } else {
      // "غير متاح · يفتح {open}"
      return _ScheduleStatus(
        isOpen: false,
        label: '\u063a\u064a\u0631 \u0645\u062a\u0627\u062d \u00b7 \u064a\u0641\u062a\u062d $openStr',
      );
    }
  }

  int _parseTime(String time) {
    final parts = time.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  @override
  Widget build(BuildContext context) {
    final hoursText = page.operatingHours ??
        (page.hours != null
            ? '${page.hours!.openTime ?? ''} - ${page.hours!.closeTime ?? ''}'
            : '');

    // follow_only / directory just show hours text
    final isFollowType =
        archetype == Archetype.followOnly || archetype == Archetype.directory;

    if (isFollowType) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.access_time_outlined,
            size: 12,
            color: context.colorScheme.primary,
          ),
          SizedBox(width: AppSpacing.xxs),
          Text(
            hoursText.isNotEmpty ? hoursText : '\u062f\u0648\u0627\u0645 \u0631\u0633\u0645\u064a',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
        ],
      );
    }

    // Closed/temp closed pages
    if (page.permanentlyClosed || page.temporarilyClosed != null) {
      if (hoursText.isEmpty) return const SizedBox.shrink();
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.access_time_outlined, size: 12, color: Colors.grey),
          SizedBox(width: AppSpacing.xxs),
          Text(
            hoursText,
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      );
    }

    // Dynamic schedule overrides static isOpen when available
    final scheduleStatus = _computeFromSchedule();
    final isOpen = scheduleStatus?.isOpen ?? page.isOpen;
    final statusColor = isOpen ? Colors.green.shade600 : Colors.red.shade500;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.access_time_outlined, size: 12, color: statusColor),
        SizedBox(width: AppSpacing.xxs),
        if (scheduleStatus != null)
          Text(
            scheduleStatus.label,
            style: TextStyle(fontSize: 12, color: statusColor),
          )
        else ...[
          Text(
            isOpen
                ? '\u0645\u062a\u0627\u062d \u0627\u0644\u0622\u0646'
                : '\u063a\u064a\u0631 \u0645\u062a\u0627\u062d',
            style: TextStyle(fontSize: 12, color: statusColor),
          ),
          if (hoursText.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              child: Text(
                '\u00b7',
                style: TextStyle(
                  color: context.colorScheme.outlineVariant,
                  fontSize: 12,
                ),
              ),
            ),
            Text(
              hoursText,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ],
    );
  }
}

/// Internal model for computed schedule status.
class _ScheduleStatus {
  final bool isOpen;
  final String label;
  const _ScheduleStatus({required this.isOpen, required this.label});
}
