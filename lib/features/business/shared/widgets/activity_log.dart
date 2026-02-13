import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
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
              'آخر الإجراءات',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade400,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onViewFull,
              child: const Text(
                'عرض السجل الكامل',
                style: TextStyle(
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
          color: Colors.grey.shade50,
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
                  color: Colors.grey.shade700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              entry.actorName,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              formatTimeAgo(entry.timestamp),
              style: TextStyle(
                fontSize: 9,
                color: Colors.grey.shade300,
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
    final grouped = <String, List<ActivityLogEntry>>{};
    for (final e in sorted) {
      final dateKey = formatDate(e.timestamp);
      (grouped[dateKey] ??= []).add(e);
    }

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
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
                color: Colors.grey.shade200,
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
                            color: Colors.grey.shade400,
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
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Divider(height: 1, color: Colors.grey.shade100),

            // Activity timeline
            if (sorted.isEmpty)
              Padding(
                padding: const EdgeInsetsDirectional.all(AppSpacing.xxl),
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long_rounded,
                      size: 40,
                      color: Colors.grey.shade200,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'لا يوجد نشاط بعد',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade400,
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
              color: Colors.grey.shade50,
              borderRadius: AppRadius.pill,
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade400,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Divider(height: 1, color: Colors.grey.shade100),
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
    final detail = _getDetailText(entry);

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
                  color: Colors.grey.shade100,
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
                      formatTimeAgo(entry.timestamp),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade400,
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
                        color: Colors.grey.shade500,
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
                          color: Colors.grey.shade100,
                          borderRadius: AppRadius.pill,
                        ),
                        child: Text(
                          entry.actorRole!,
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ],
                    const Spacer(),
                    Text(
                      formatTime(entry.timestamp),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade300,
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
            color: Colors.grey.shade400,
            bgColor: Colors.grey.shade100,
          ),
          const Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.xs,
            ),
            child: Icon(
              Icons.arrow_forward_rounded,
              size: 10,
              color: AppColors.textHint,
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
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: Colors.grey.shade400,
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

String? _getDetailText(ActivityLogEntry entry) {
  // Status change
  if (entry.from != null && entry.to != null) {
    return '${entry.from} → ${entry.to}'; // used for semantic, UI uses pills
  }
  // Payment
  if (entry.amount != null && entry.amount! > 0) {
    final display = Money(entry.amount!).toFormattedArabic();
    return '$display — ${entry.method ?? 'كاش'}';
  }
  // Note or generic detail
  return entry.note;
}

/// Formats an ISO 8601 timestamp as a relative time string in Arabic.
String formatTimeAgo(String iso) {
  final dt = DateTime.tryParse(iso);
  if (dt == null) return iso;
  final diff = DateTime.now().difference(dt);
  if (diff.inMinutes < 1) return 'الآن';
  if (diff.inMinutes < 60) return 'قبل ${diff.inMinutes} د';
  if (diff.inHours < 24) return 'قبل ${diff.inHours} س';
  if (diff.inDays == 1) return 'أمس';
  return 'قبل ${diff.inDays} يوم';
}

/// Formats an ISO 8601 timestamp as HH:mm.
String formatTime(String iso) {
  final dt = DateTime.tryParse(iso);
  if (dt == null) return '';
  final h = dt.hour.toString().padLeft(2, '0');
  final m = dt.minute.toString().padLeft(2, '0');
  return '$h:$m';
}

/// Formats an ISO 8601 timestamp as "day month" in Arabic.
String formatDate(String iso) {
  final dt = DateTime.tryParse(iso);
  if (dt == null) return '';
  const months = [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];
  return '${dt.day} ${months[dt.month - 1]}';
}
