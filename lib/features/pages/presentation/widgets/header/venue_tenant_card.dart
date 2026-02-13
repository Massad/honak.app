import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Small card showing the venue location for tenant pages.
/// Displays floor + unit info and navigates to the venue page on tap.
class VenueTenantCard extends StatelessWidget {
  final String venueId;
  final String? venueFloor;
  final String? venueUnit;

  const VenueTenantCard({
    super.key,
    required this.venueId,
    this.venueFloor,
    this.venueUnit,
  });

  @override
  Widget build(BuildContext context) {
    // Build label: "في {floor} — وحدة {unit}" or partial
    final parts = <String>[];
    // "في" = in
    if (venueFloor != null) parts.add('\u0641\u064a $venueFloor');
    // "وحدة" = unit
    if (venueUnit != null) parts.add('\u0648\u062d\u062f\u0629 $venueUnit');
    final label = parts.isNotEmpty
        ? parts.join(' \u2014 ')
        // fallback: "داخل المبنى" = inside the building
        : '\u062f\u0627\u062e\u0644 \u0627\u0644\u0645\u0628\u0646\u0649';

    return Padding(
      padding: EdgeInsetsDirectional.only(top: AppSpacing.sm),
      child: GestureDetector(
        onTap: () => context.push(Routes.pagePath(venueId)),
        child: Container(
          padding: EdgeInsetsDirectional.fromSTEB(
            AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF), // blue-50
            border: Border.all(color: const Color(0xFFBFDBFE)), // blue-100
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 14,
                color: context.colorScheme.primary,
              ),
              SizedBox(width: AppSpacing.xs),
              Flexible(
                child: Text(
                  label,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(width: AppSpacing.xs),
              Icon(
                Icons.chevron_right,
                size: 14,
                color: context.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
