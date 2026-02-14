import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/dashboard/presentation/widgets/sections/core_sections.dart';

// ═══════════════════════════════════════════════════════════════
// Occupancy — percentage + progress bar + details
// ═══════════════════════════════════════════════════════════════

class OccupancySection extends StatelessWidget {
  final Map<String, dynamic> data;
  const OccupancySection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final percentage = (data['percentage'] as num?)?.toInt() ?? 0;
    final period = data['period'] as String? ?? '';
    final booked = data['booked'] ?? 0;
    final total = data['total'] ?? 0;
    final checkinToday = (data['checkin_today'] as num?)?.toInt() ?? 0;
    final checkoutToday = (data['checkout_today'] as num?)?.toInt() ?? 0;
    final progress = total > 0 ? percentage / 100 : 0.0;

    final color = percentage >= 80
        ? AppColors.success
        : percentage >= 50
            ? Colors.orange
            : Theme.of(context).colorScheme.onSurfaceVariant;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Percentage + label
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        // Period details
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              period,
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              '$booked ليلة محجوزة من $total',
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        // Check-in/out today
        if (checkinToday > 0 || checkoutToday > 0) ...[
          const SizedBox(height: AppSpacing.md),
          Divider(height: 1, color: Theme.of(context).colorScheme.outlineVariant),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (checkoutToday > 0) ...[
                Text(
                  '$checkoutToday',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.error,
                  ),
                ),
                Text(
                  ' :مغادرة اليوم',
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
              ],
              if (checkinToday > 0) ...[
                Text(
                  '$checkinToday',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.success,
                  ),
                ),
                Text(
                  ' :وصول اليوم',
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Upcoming Reservations — cards with date range
// ═══════════════════════════════════════════════════════════════

class UpcomingReservationsSection extends StatelessWidget {
  final List<dynamic> items;
  const UpcomingReservationsSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    final display = items.take(3).toList();

    return Column(
      children: display.map((item) {
        final m = item as Map<String, dynamic>;
        final isSoon = m['is_soon'] == true;
        final total = m['total'];

        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSoon
                  ? Colors.amber.withValues(alpha: 0.5)
                  : Theme.of(context).colorScheme.outlineVariant,
              width: isSoon ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  if (total != null)
                    Text(
                      '${formatJod(total)} د.أ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  const Spacer(),
                  Text(
                    m['customer'] as String? ?? '',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  if (m['guests'] != null)
                    Row(
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${m['guests']}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        m['space'] as String? ?? '',
                        style: TextStyle(
                          fontSize: 11,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 12,
                        color: isSoon
                            ? Colors.amber.shade700
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        m['date_range'] as String? ?? '',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSoon ? FontWeight.w600 : null,
                          color: isSoon
                              ? Colors.amber.shade700
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Recently Linked — for directory/mall archetypes
// ═══════════════════════════════════════════════════════════════

class RecentlyLinkedSection extends StatelessWidget {
  final List<dynamic> items;
  const RecentlyLinkedSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    final unreviewed = items
        .where((i) => (i as Map)['status'] == 'unreviewed')
        .length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (unreviewed > 0) ...[
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$unreviewed',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'بحاجة مراجعة',
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        ...items.map((item) {
          final m = item as Map<String, dynamic>;
          final isUnreviewed = m['status'] == 'unreviewed';
          final dotColor =
              isUnreviewed ? AppColors.primary : AppColors.success;
          final borderColor = isUnreviewed
              ? const Color(0xFFBBDEFB) // blue-100
              : const Color(0xFFC8E6C9); // green-100

          return Container(
            margin: const EdgeInsets.only(bottom: AppSpacing.sm),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: isUnreviewed
                  ? AppColors.primary.withValues(alpha: 0.03)
                  : AppColors.success.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    // Status dot
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: dotColor,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    // Logo placeholder
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.surfaceContainerLow,
                      ),
                      child: Icon(
                        Icons.store_outlined,
                        size: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    // Name + details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            m['name'] as String? ?? '',
                            style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            [
                              m['unit'] as String? ?? '',
                              m['category'] as String? ?? '',
                              m['time'] as String? ?? '',
                            ].where((s) => s.isNotEmpty).join(' · '),
                            style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Action area
                if (isUnreviewed) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.sm),
                    child: Divider(
                      height: 1,
                      color: const Color(0xFFBBDEFB),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFBBDEFB),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.open_in_new,
                                size: 10,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'عرض الصفحة',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check,
                                size: 10,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'تمام',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.sm),
                    child: Divider(
                      height: 1,
                      color: const Color(0xFFC8E6C9),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.check,
                        size: 10,
                        color: AppColors.success,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'تمت المراجعة',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        }),
      ],
    );
  }
}
