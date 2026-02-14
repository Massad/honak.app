import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/business_hours.dart';
import 'package:honak/features/business/page_settings/presentation/providers/hours_provider.dart';

/// Per-employee schedule tab inside [MemberDetailScreen].
/// Currently displays the page-level schedule as read-only reference.
class MemberScheduleTab extends ConsumerWidget {
  final String memberId;

  const MemberScheduleTab({super.key, required this.memberId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoursAsync = ref.watch(hoursProvider);

    return hoursAsync.when(
      loading: () => const _ScheduleSkeleton(),
      error: (_, __) => Center(
        child: Text(
          'تعذر تحميل الجدول',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ),
      data: (hours) => ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border:
                  Border.all(color: AppColors.info.withValues(alpha: 0.15)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'يستخدم حالياً جدول الصفحة الرئيسي. يمكنك لاحقاً تخصيص جدول منفصل لهذا العضو.',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.info.withValues(alpha: 0.8),
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Icon(
                  Icons.info_outline,
                  size: 18,
                  color: AppColors.info.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // 7-day schedule
          for (final day in hours) ...[
            _DayRow(hours: day),
            Divider(height: 1, color: Theme.of(context).colorScheme.outlineVariant),
          ],

          const SizedBox(height: AppSpacing.lg),

          // Placeholder button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: null,
              icon: const Icon(Icons.edit_calendar_outlined, size: 18),
              label: const Text('تخصيص جدول — قريباً'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                padding:
                    const EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DayRow extends StatelessWidget {
  final BusinessHours hours;

  const _DayRow({required this.hours});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          // Status
          if (hours.open && hours.shifts.isNotEmpty)
            Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                hours.shifts
                    .map((s) => '${s.open} - ${s.close}')
                    .join('  ·  '),
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          else
            Text(
              'مغلق',
              style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          const Spacer(),
          // Day name
          Text(
            hours.day,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleSkeleton extends StatelessWidget {
  const _ScheduleSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // Info banner placeholder
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.shimmerBase,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        // 7 day row placeholders
        for (var i = 0; i < 7; i++) ...[
          Container(
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.shimmerBase,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
      ],
    );
  }
}
