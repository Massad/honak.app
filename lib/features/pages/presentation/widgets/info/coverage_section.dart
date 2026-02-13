import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';

/// Coverage section: structured zones or flat chips fallback.
class CoverageSection extends StatelessWidget {
  final List<CoverageZone> structuredZones;
  final List<String> flatZones;

  const CoverageSection({
    super.key,
    this.structuredZones = const [],
    this.flatZones = const [],
  });

  @override
  Widget build(BuildContext context) {
    if (structuredZones.isEmpty && flatZones.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('مناطق التغطية', style: context.textTheme.titleSmall),
        SizedBox(height: AppSpacing.sm),
        if (structuredZones.isNotEmpty)
          ...structuredZones.map((zone) => _ZoneCard(zone: zone))
        else
          _FlatChips(zones: flatZones),
      ],
    );
  }
}

class _ZoneCard extends StatefulWidget {
  final CoverageZone zone;

  const _ZoneCard({required this.zone});

  @override
  State<_ZoneCard> createState() => _ZoneCardState();
}

class _ZoneCardState extends State<_ZoneCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: AppRadius.card,
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Icon(
                    Icons.location_city,
                    size: 20,
                    color: context.colorScheme.primary,
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      widget.zone.city,
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '${widget.zone.areas.length} مناطق',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(width: AppSpacing.xs),
                  Icon(
                    _expanded
                        ? Icons.expand_less
                        : Icons.expand_more,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          if (_expanded)
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                0,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.zone.areas.map((area) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: AppSpacing.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          area.name,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (area.neighbourhoods.isNotEmpty) ...[
                          SizedBox(height: AppSpacing.xs),
                          Wrap(
                            spacing: AppSpacing.xs,
                            runSpacing: AppSpacing.xs,
                            children: area.neighbourhoods.map((n) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm,
                                  vertical: AppSpacing.xxs,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.withValues(alpha: 0.1),
                                  borderRadius: AppRadius.pill,
                                ),
                                child: Text(
                                  n,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class _FlatChips extends StatelessWidget {
  final List<String> zones;

  const _FlatChips({required this.zones});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: zones.map((zone) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            borderRadius: AppRadius.pill,
          ),
          child: Text(
            zone,
            style: TextStyle(
              fontSize: 12,
              color: Colors.green.shade700,
            ),
          ),
        );
      }).toList(),
    );
  }
}
