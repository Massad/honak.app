import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_direction.dart';

/// Card showing the venue location for tenant pages.
/// Matches Figma: blue card with venue name, floor + unit, building icon.
class VenueTenantCard extends StatelessWidget {
  final String venueId;
  final String? venueName;
  final String? venueFloor;
  final String? venueUnit;

  const VenueTenantCard({
    super.key,
    required this.venueId,
    this.venueName,
    this.venueFloor,
    this.venueUnit,
  });

  @override
  Widget build(BuildContext context) {
    final displayName = venueName ?? venueId;

    // Second line: "الأرضي · G-01" style
    final details = <String>[];
    if (venueFloor != null) details.add(venueFloor!);
    if (venueUnit != null) details.add(venueUnit!);
    final detailLine = details.join(' \u00b7 ');

    return Padding(
      padding: EdgeInsetsDirectional.only(top: AppSpacing.sm),
      child: GestureDetector(
        onTap: () => context.push(Routes.pagePath(venueId)),
        child: Container(
          padding: EdgeInsetsDirectional.fromSTEB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.primary.withValues(alpha: 0.08),
            border: Border.all(color: context.colorScheme.primary.withValues(alpha: 0.2)),
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Row(
            children: [
              // Chevron (start side — right in RTL)
              Icon(
                AppDirection.chevronStartIcon(context),
                size: 18,
                color: context.colorScheme.primary,
              ),
              SizedBox(width: AppSpacing.xs),
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // "موقع في: {name}"
                      '\u0645\u0648\u0642\u0639 \u0641\u064a: $displayName',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    if (detailLine.isNotEmpty) ...[
                      SizedBox(height: 2),
                      Text(
                        detailLine,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.primary.withValues(
                            alpha: 0.7,
                          ),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: AppSpacing.xs),
              // Building icon (end side — left in RTL)
              Icon(
                Icons.apartment_outlined,
                size: 18,
                color: context.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
