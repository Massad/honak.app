import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/dropoff/domain/entities/ticket_activity.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/activity_log_utils.dart';
import 'package:honak/shared/entities/money.dart';

/// Displays a vertical timeline of [TicketActivityEntry] items.
///
/// In preview mode ([isPreview] = true), shows only the last 3 entries
/// as compact pills. In full mode, shows the complete timeline with date
/// grouping, colored dots, and detailed action descriptions.
class TicketActivityLog extends StatelessWidget {
  final List<TicketActivityEntry> entries;
  final bool isPreview;

  const TicketActivityLog({
    super.key,
    required this.entries,
    this.isPreview = false,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Center(
        child: Text(
          'لا يوجد نشاط بعد',
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade400,
            fontSize: 12,
          ),
        ),
      );
    }

    if (isPreview) return _buildPreview(context);
    return _buildFullTimeline(context);
  }

  // ── Preview mode — last 3 entries as compact pills ──

  Widget _buildPreview(BuildContext context) {
    final preview = entries.length > 3
        ? entries.sublist(entries.length - 3)
        : entries;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: preview.map((e) => _PreviewPill(entry: e)).toList(),
    );
  }

  // ── Full timeline ──

  Widget _buildFullTimeline(BuildContext context) {
    final sorted = List.of(entries)
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < sorted.length; i++)
          _TimelineRow(
            entry: sorted[i],
            isFirst: i == 0,
            isLast: i == sorted.length - 1,
          ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Preview Pill
// ═══════════════════════════════════════════════════════════════

class _PreviewPill extends StatelessWidget {
  final TicketActivityEntry entry;

  const _PreviewPill({required this.entry});

  @override
  Widget build(BuildContext context) {
    final color = activityActionColor(entry.action);
    final icon = activityActionIcon(entry.action);
    final time = _formatTime(entry.timestamp);

    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 10, color: color),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              entry.action.labelAr,
              style: context.textTheme.labelSmall?.copyWith(
                color: Colors.grey.shade600,
                fontSize: 10,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            time,
            style: context.textTheme.labelSmall?.copyWith(
              color: Colors.grey.shade400,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Timeline Row
// ═══════════════════════════════════════════════════════════════

class _TimelineRow extends StatelessWidget {
  final TicketActivityEntry entry;
  final bool isFirst;
  final bool isLast;

  const _TimelineRow({
    required this.entry,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final color = activityActionColor(entry.action);
    final icon = activityActionIcon(entry.action);
    final time = _formatTime(entry.timestamp);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline column — dot + line
          SizedBox(
            width: 28,
            child: Column(
              children: [
                if (!isFirst)
                  Expanded(child: Container(width: 1, color: Colors.grey.shade200)),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 12, color: color),
                ),
                if (!isLast)
                  Expanded(child: Container(width: 1, color: Colors.grey.shade200)),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),

          // Content
          Expanded(
            child: Container(
              margin: const EdgeInsetsDirectional.only(bottom: AppSpacing.md),
              padding: const EdgeInsetsDirectional.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: AppRadius.cardInner,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Action label + time
                  Row(
                    children: [
                      Text(
                        entry.action.labelAr,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurface,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        time,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: Colors.grey.shade400,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),

                  // Actor
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    entry.actorName,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Colors.grey.shade500,
                      fontSize: 10,
                    ),
                  ),

                  // Status change from → to
                  if (entry.from != null && entry.to != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        _StatusChip(label: entry.from!, faded: true),
                        const Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: AppSpacing.xs,
                          ),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            size: 12,
                            color: AppColors.textHint,
                          ),
                        ),
                        _StatusChip(label: entry.to!, faded: false),
                      ],
                    ),
                  ],

                  // Note
                  if (entry.note != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      entry.note!,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: Colors.grey.shade600,
                        fontSize: 10,
                      ),
                    ),
                  ],

                  // Payment amount
                  if (entry.amount != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${Money(entry.amount!).toFormattedArabic()} (${entry.method ?? ''})',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: AppColors.success,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Status Chip (for from→to)
// ═══════════════════════════════════════════════════════════════

class _StatusChip extends StatelessWidget {
  final String label;
  final bool faded;

  const _StatusChip({required this.label, required this.faded});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: faded ? Colors.grey.shade100 : const Color(0xFFEFF6FF),
        borderRadius: AppRadius.pill,
      ),
      child: Text(
        label,
        style: context.textTheme.labelSmall?.copyWith(
          color: faded ? Colors.grey.shade400 : AppColors.primary,
          fontSize: 9,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Helpers
// ═══════════════════════════════════════════════════════════════

String _formatTime(String timestamp) {
  final dt = DateTime.tryParse(timestamp);
  if (dt == null) return timestamp;
  return DateFormat.jm('ar').format(dt);
}
