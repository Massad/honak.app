import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

export 'booking_branch_selector.dart';
export 'booking_time_preference.dart';

/// Service radio list for the booking sheet.
class BookingServiceSelector extends StatelessWidget {
  final List<Map<String, dynamic>> services;
  final String? activeServiceId;
  final ValueChanged<String?> onChanged;

  const BookingServiceSelector({
    super.key,
    required this.services,
    required this.activeServiceId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الخدمة',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ...services.map((service) {
          final id = service['id']?.toString();
          final selected = activeServiceId == id;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: InkWell(
              onTap: () => onChanged(id),
              borderRadius: AppRadius.cardInner,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.primary.withValues(alpha: 0.05)
                      : Colors.white,
                  borderRadius: AppRadius.cardInner,
                  border: Border.all(
                    color:
                        selected ? AppColors.primary : AppColors.divider,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service['name'] as String? ?? '',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: selected ? AppColors.primary : null,
                            ),
                          ),
                          if (service['duration'] != null) ...[
                            const SizedBox(height: AppSpacing.xxs),
                            Row(
                              children: [
                                Icon(Icons.access_time,
                                    size: 10, color: AppColors.textHint),
                                const SizedBox(width: AppSpacing.xxs),
                                Text(
                                  '${service['duration']}',
                                  style: theme.textTheme.labelSmall
                                      ?.copyWith(color: AppColors.textHint),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (service['price'] != null)
                      Text(
                        '${service['price']} د.أ',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: selected
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

/// Team member chips for the booking sheet.
class BookingTeamSelector extends StatelessWidget {
  final List<Map<String, dynamic>> team;
  final String? selectedTeam;
  final ValueChanged<String?> onChanged;

  const BookingTeamSelector({
    super.key,
    required this.team,
    required this.selectedTeam,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مع (اختياري)',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 38,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _TeamChip(
                id: null,
                label: 'أي شخص',
                selected: selectedTeam == null,
                onTap: () => onChanged(null),
              ),
              ...team.map(
                (member) => _TeamChip(
                  id: member['name'] as String?,
                  label: member['name'] as String? ?? '',
                  selected: selectedTeam == member['name'],
                  onTap: () => onChanged(member['name'] as String?),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TeamChip extends StatelessWidget {
  final String? id;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TeamChip({
    required this.id,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.cardInner,
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.white,
            borderRadius: AppRadius.cardInner,
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.divider,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (id != null) ...[
                Icon(Icons.person,
                    size: 12,
                    color: selected
                        ? Colors.white
                        : AppColors.textSecondary),
                const SizedBox(width: AppSpacing.xs),
              ],
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color:
                      selected ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
