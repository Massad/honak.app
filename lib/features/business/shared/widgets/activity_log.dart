import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/l10n/arb/app_localizations.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/entities/money.dart';

// ═══════════════════════════════════════════════════════════════
// Activity Log — Shared Components
//
// Generic activity log UI used by both dropoff tickets and queue
// entries. Domain-specific code converts its own entries to
// [ActivityLogEntry] before passing to these widgets.
// ═══════════════════════════════════════════════════════════════

/// A UI-ready activity log entry. Domain code converts from its own
/// entity (e.g. TicketActivityEntry, QueueActivityEntry) to this.
class ActivityLogEntry {
  const ActivityLogEntry({
    required this.id,
    required this.timestamp,
    required this.label,
    required this.icon,
    required this.color,
    required this.actorName,
    this.actorRole,
    this.from,
    this.to,
    this.note,
    this.amount,
    this.method,
  });

  final String id;
  final String timestamp; // ISO 8601
  final String label;
  final IconData icon;
  final Color color;
  final String actorName;
  final String? actorRole;
  final String? from;
  final String? to;
  final String? note;
  final int? amount; // piasters
  final String? method;
}

// ═══════════════════════════════════════════════════════════════
// Public API — show the full activity log sheet
// ═══════════════════════════════════════════════════════════════

/// Shows a full-screen activity log bottom sheet.
void showActivityLogSheet(
  BuildContext context, {
  required String title,
  required String subtitle,
  required List<ActivityLogEntry> entries,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _ActivityLogSheet(
      title: title,
      subtitle: subtitle,
      entries: entries,
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Compact Preview — last N entries as inline rows
// ═══════════════════════════════════════════════════════════════

/// Shows the last few activity entries as compact rows with a
/// "عرض السجل الكامل" link.
class ActivityLogPreview extends StatelessWidget {
  const ActivityLogPreview({
    super.key,
    required this.entries,
    this.maxEntries = 3,
    required this.onViewFull,
  });

  final List<ActivityLogEntry> entries;
  final int maxEntries;
  final VoidCallback onViewFull;

  @override
  Widget build(BuildContext context) {
    final recent = entries.take(maxEntries).toList();
    if (recent.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row
        Row(
          children: [
            Text(
              context.l10n.bizRecentActions,
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onViewFull,
              child: Text(
                context.l10n.bizViewFullLog,
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF1A73E8),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        // Compact entries
        ...recent.map((entry) => _CompactRow(entry: entry)),
      ],
    );
  }
}

class _CompactRow extends StatelessWidget {
  const _CompactRow({required this.entry});
  final ActivityLogEntry entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.xs),
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: entry.color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(entry.icon, size: 10, color: entry.color),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                entry.label,
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              entry.actorName,
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              formatTimeAgo(entry.timestamp, context.l10n),
              style: TextStyle(
                fontSize: 9,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Full Activity Log Sheet
// ═══════════════════════════════════════════════════════════════

class _ActivityLogSheet extends StatelessWidget {
  const _ActivityLogSheet({
    required this.title,
    required this.subtitle,
    required this.entries,
  });

  final String title;
  final String subtitle;
  final List<ActivityLogEntry> entries;

  @override
  Widget build(BuildContext context) {
    final sorted = List.of(entries)
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    // Group by date
    final l10n = context.l10n;
    final grouped = <String, List<ActivityLogEntry>>{};
    for (final e in sorted) {
      final dateKey = formatDate(e.timestamp, l10n);
      (grouped[dateKey] ??= []).add(e);
    }

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xxl),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: AppSpacing.sm),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: Row(
                children: [
                  // Icon
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEFF6FF), // blue-50
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.receipt_long_rounded,
                      size: 16,
                      color: Color(0xFF1A73E8),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: context.textTheme.titleSmall?.copyWith(
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerLow,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Divider(height: 1, color: Theme.of(context).colorScheme.outlineVariant),

            // Activity timeline
            if (sorted.isEmpty)
              Padding(
                padding: const EdgeInsetsDirectional.all(AppSpacing.xxl),
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long_rounded,
                      size: 40,
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      context.l10n.bizNoActivityYet,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              )
            else
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
                  children: [
                    for (final MapEntry(key: dateLabel, value: dayEntries)
                        in grouped.entries) ...[
                      // Date separator
                      _DateSeparator(label: dateLabel),
                      // Timeline entries for this date
                      for (var i = 0; i < dayEntries.length; i++)
                        _TimelineEntry(
                          entry: dayEntries[i],
                          isLast: i == dayEntries.length - 1,
                        ),
                    ],
                  ],
                ),
              ),

            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Date Separator
// ═══════════════════════════════════════════════════════════════

class _DateSeparator extends StatelessWidget {
  const _DateSeparator({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerLowest,
              borderRadius: AppRadius.pill,
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Divider(height: 1, color: Theme.of(context).colorScheme.outlineVariant),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Timeline Entry Row
// ═══════════════════════════════════════════════════════════════

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({
    required this.entry,
    required this.isLast,
  });

  final ActivityLogEntry entry;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final detail = _getDetailText(entry, context.l10n);

    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline dot + connecting line
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: entry.color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(entry.icon, size: 14, color: entry.color),
              ),
              if (!isLast)
                Container(
                  width: 1.5,
                  height: 24,
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label + timeAgo
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        entry.label,
                        style: TextStyle(
                          fontSize: 12,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Text(
                      formatTimeAgo(entry.timestamp, context.l10n),
                      style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxs),

                // Actor name + role badge + time
                Row(
                  children: [
                    Text(
                      entry.actorName,
                      style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (entry.actorRole != null) ...[
                      const SizedBox(width: AppSpacing.xs),
                      Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerLow,
                          borderRadius: AppRadius.pill,
                        ),
                        child: Text(
                          entry.actorRole!,
                          style: TextStyle(
                            fontSize: 9,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                    const Spacer(),
                    Text(
                      formatTime(entry.timestamp),
                      style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ],
                ),

                // Detail text (status from→to, payment, note)
                if (detail != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  _DetailBox(entry: entry, text: detail),
                ],

                const SizedBox(height: AppSpacing.sm),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Detail Box — status transitions, payment, notes
// ═══════════════════════════════════════════════════════════════

class _DetailBox extends StatelessWidget {
  const _DetailBox({required this.entry, required this.text});
  final ActivityLogEntry entry;
  final String text;

  @override
  Widget build(BuildContext context) {
    // Status change → show from/to pills with arrow
    if (entry.from != null && entry.to != null) {
      return Row(
        children: [
          _StatusPill(
            label: entry.from!,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            bgColor: Theme.of(context).colorScheme.surfaceContainerLow,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.xs,
            ),
            child: Icon(
              Icons.arrow_forward_rounded,
              size: 10,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          _StatusPill(
            label: entry.to!,
            color: const Color(0xFF1A73E8),
            bgColor: const Color(0xFFEFF6FF),
          ),
        ],
      );
    }

    // Generic detail text
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({
    required this.label,
    required this.color,
    required this.bgColor,
  });
  final String label;
  final Color color;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.pill,
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 9, color: color),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Helpers — time formatting (shared across all activity logs)
// ═══════════════════════════════════════════════════════════════

String? _getDetailText(ActivityLogEntry entry, AppLocalizations l10n) {
  // Status change
  if (entry.from != null && entry.to != null) {
    return '${entry.from} → ${entry.to}'; // used for semantic, UI uses pills
  }
  // Payment
  if (entry.amount != null && entry.amount! > 0) {
    final display = Money(entry.amount!).toFormattedArabic();
    return '$display — ${entry.method ?? l10n.bizPaymentCash}';
  }
  // Note or generic detail
  return entry.note;
}

/// Formats an ISO 8601 timestamp as a localized relative time string.
String formatTimeAgo(String iso, AppLocalizations l10n) {
  final dt = DateTime.tryParse(iso);
  if (dt == null) return iso;
  final diff = DateTime.now().difference(dt);
  if (diff.inMinutes < 1) return l10n.bizTimeNow;
  if (diff.inMinutes < 60) return l10n.bizTimeMinutesAgo(diff.inMinutes);
  if (diff.inHours < 24) return l10n.bizTimeHoursAgo(diff.inHours);
  if (diff.inDays == 1) return l10n.bizTimeYesterday;
  return l10n.bizTimeDaysAgo(diff.inDays);
}

/// Formats an ISO 8601 timestamp as HH:mm.
String formatTime(String iso) {
  final dt = DateTime.tryParse(iso);
  if (dt == null) return '';
  final h = dt.hour.toString().padLeft(2, '0');
  final m = dt.minute.toString().padLeft(2, '0');
  return '$h:$m';
}

/// Formats an ISO 8601 timestamp as localized "day month".
String formatDate(String iso, AppLocalizations l10n) {
  final dt = DateTime.tryParse(iso);
  if (dt == null) return '';
  final months = [
    l10n.bizDateMonth1,
    l10n.bizDateMonth2,
    l10n.bizDateMonth3,
    l10n.bizDateMonth4,
    l10n.bizDateMonth5,
    l10n.bizDateMonth6,
    l10n.bizDateMonth7,
    l10n.bizDateMonth8,
    l10n.bizDateMonth9,
    l10n.bizDateMonth10,
    l10n.bizDateMonth11,
    l10n.bizDateMonth12,
  ];
  return l10n.bizDateDayMonth(dt.day, months[dt.month - 1]);
}
