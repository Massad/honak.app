import 'package:flutter/material.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';

/// Row showing location label (with optional "covers you" pill) and hours chip.
class LocationHoursRow extends StatelessWidget {
  final PageDetail page;
  final Archetype archetype;

  const LocationHoursRow({
    super.key,
    required this.page,
    required this.archetype,
  });

  /// Build venue location text like "City Mall، الأرضي G-01"
  String _venueLocationText() {
    final name = page.venueName ?? page.venueId ?? '';
    final parts = <String>[];
    if (page.venueFloor != null) parts.add(page.venueFloor!);
    if (page.venueUnit != null) parts.add(page.venueUnit!);
    if (parts.isEmpty) return name;
    return '$name\u060c ${parts.join(' ')}';
  }

  @override
  Widget build(BuildContext context) {
    // When page is inside a venue, show venue + floor + unit instead of address
    final locationText = page.venueId != null
        ? _venueLocationText()
        : page.location?.label ?? page.location?.area ?? page.address ?? '';
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
        if (hasHours) HoursChip(page: page, archetype: archetype),
      ],
    );
  }
}

/// Displays open/closed status from weekly schedule or static hours data.
class HoursChip extends StatelessWidget {
  final PageDetail page;
  final Archetype archetype;

  const HoursChip({super.key, required this.page, required this.archetype});

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
          Icon(Icons.access_time_outlined, size: 12, color: context.colorScheme.onSurfaceVariant),
          SizedBox(width: AppSpacing.xxs),
          Text(
            hoursText,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
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
