import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';

/// Grid showing amenities/facilities for a directory page (mall/complex).
/// Matches Figma: 3-column grid with icon + label per amenity.
class DirectoryAmenitiesGrid extends StatelessWidget {
  final List<Amenity> amenities;

  const DirectoryAmenitiesGrid({super.key, required this.amenities});

  static const _iconMap = <String, IconData>{
    'local_parking': Icons.local_parking,
    'wifi': Icons.wifi,
    'elevator': Icons.elevator,
    'mosque': Icons.mosque,
    'atm': Icons.local_atm,
    'baby_changing_station': Icons.baby_changing_station,
    'restaurant': Icons.restaurant,
    'wheelchair': Icons.accessible,
    'security': Icons.security,
    'escalator': Icons.escalator,
    'restroom': Icons.wc,
    'pharmacy': Icons.local_pharmacy,
    'info': Icons.info_outline,
    'ac': Icons.ac_unit,
    'prayer': Icons.mosque,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header — "المرافق والخدمات"
          Text(
            '\u0627\u0644\u0645\u0631\u0627\u0641\u0642 \u0648\u0627\u0644\u062e\u062f\u0645\u0627\u062a',
            style: context.textTheme.titleSmall,
          ),
          SizedBox(height: AppSpacing.md),
          // 3-column grid
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: amenities.map((a) {
              final icon = _iconMap[a.icon] ?? Icons.check_circle_outline;
              // Truncate label to just the name (before " — " details)
              final shortLabel = a.label.contains('\u2014')
                  ? a.label.split('\u2014').first.trim()
                  : a.label.contains(' — ')
                      ? a.label.split(' — ').first.trim()
                      : a.label;
              return SizedBox(
                width: (MediaQuery.of(context).size.width - 2 * AppSpacing.lg -
                        2 * AppSpacing.sm) /
                    3,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.md,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer
                        .withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        icon,
                        size: 24,
                        color: context.colorScheme.primary,
                      ),
                      SizedBox(height: AppSpacing.xs),
                      Text(
                        shortLabel,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
