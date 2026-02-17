import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/presentation/widgets/request_activity_utils.dart';
import 'package:honak/features/business/shared/domain/entities/entities.dart';
import 'package:honak/features/business/shared/widgets/activity_log.dart';

// ═══════════════════════════════════════════════════════════════
// Status Context Banner
// ═══════════════════════════════════════════════════════════════

class RequestStatusContextBanner extends StatelessWidget {
  final String status;

  const RequestStatusContextBanner({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == 'pending') {
      return Padding(
        padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.lg),
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.lg,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBEB), // amber-50
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: const Color(0xFFFDE68A)), // amber-200
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.only(top: 2),
                child: Icon(
                  Icons.access_time_rounded,
                  size: 14,
                  color: Color(0xFFD97706), // amber-600
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.bizReqPendingBanner,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF92400E), // amber-800
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      context.l10n.bizReqPendingBannerHint,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFFD97706), // amber-600
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (status == 'accepted') {
      return Padding(
        padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.lg),
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.lg,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF0FDF4), // green-50
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: const Color(0xFFDCFCE7)), // green-100
          ),
          child: Row(
            children: [
              const Icon(
                Icons.check_circle_outline_rounded,
                size: 14,
                color: Color(0xFF43A047),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  context.l10n.bizReqAcceptedBanner,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF166534), // green-800
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // No banner for terminal or in-progress statuses
    return const SizedBox.shrink();
  }
}

// ═══════════════════════════════════════════════════════════════
// Activity Log Tab
// ═══════════════════════════════════════════════════════════════

class RequestActivityLogTab extends StatelessWidget {
  final BizRequest request;

  const RequestActivityLogTab({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final entries = generateRequestActivity(request, context.l10n);

    if (entries.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.access_time_rounded,
              size: 40,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              context.l10n.bizReqNoLogYet,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    // Sort newest first
    final sorted = List.of(entries)
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    // Group by date
    final grouped = <String, List<ActivityLogEntry>>{};
    for (final e in sorted) {
      final dateKey = formatDate(e.timestamp, context.l10n);
      (grouped[dateKey] ??= []).add(e);
    }

    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      children: [
        for (final MapEntry(key: dateLabel, value: dayEntries)
            in grouped.entries) ...[
          _DateSeparator(label: dateLabel),
          for (var i = 0; i < dayEntries.length; i++)
            _TimelineEntry(
              entry: dayEntries[i],
              isLast: i == dayEntries.length - 1,
            ),
        ],
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Inline Timeline Widgets
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
            child: Divider(
              height: 1,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({
    required this.entry,
    required this.isLast,
  });

  final ActivityLogEntry entry;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline dot + connector line
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

                // Actor name + role + time
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
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerLow,
                          borderRadius: AppRadius.pill,
                        ),
                        child: Text(
                          entry.actorRole!,
                          style: TextStyle(
                            fontSize: 9,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
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

                // Detail: status from→to, payment, or note
                if (entry.from != null && entry.to != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  _StatusTransition(from: entry.from!, to: entry.to!),
                ] else if (entry.amount != null && entry.amount! > 0) ...[
                  const SizedBox(height: AppSpacing.xs),
                  _DetailNote(
                    text:
                        '${_formatMoney(entry.amount!, currency: context.l10n.jod)} — ${entry.method ?? context.l10n.bizReqActivityCash}',
                  ),
                ] else if (entry.note != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  _DetailNote(text: entry.note!),
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

String _formatMoney(int cents, {String currency = 'د.أ'}) {
  final jd = cents ~/ 100;
  final q = cents % 100;
  if (q == 0) return '$jd $currency';
  return '$jd.${q.toString().padLeft(2, '0')} $currency';
}

class _StatusTransition extends StatelessWidget {
  final String from;
  final String to;

  const _StatusTransition({required this.from, required this.to});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatusPill(
          label: from,
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
          label: to,
          color: const Color(0xFF1A73E8),
          bgColor: const Color(0xFFEFF6FF),
        ),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String label;
  final Color color;
  final Color bgColor;

  const _StatusPill({
    required this.label,
    required this.color,
    required this.bgColor,
  });

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

class _DetailNote extends StatelessWidget {
  final String text;

  const _DetailNote({required this.text});

  @override
  Widget build(BuildContext context) {
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
