import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/l10n/arb/app_localizations.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Amenity checklist overlay — checkbox grid of ~15 common amenities.
class AmenityManagerOverlay extends StatefulWidget {
  final List<String> selected;
  final VoidCallback onClose;
  final ValueChanged<List<String>> onSave;

  const AmenityManagerOverlay({
    super.key,
    required this.selected,
    required this.onClose,
    required this.onSave,
  });

  @override
  State<AmenityManagerOverlay> createState() => _AmenityManagerOverlayState();
}

class _AmenityManagerOverlayState extends State<AmenityManagerOverlay> {
  late Set<String> _selected;

  static List<_AmenityDef> _amenities(AppLocalizations l10n) => [
        _AmenityDef(l10n.dirAmenityParking, Icons.local_parking),
        _AmenityDef(l10n.dirAmenityWifi, Icons.wifi),
        _AmenityDef(l10n.dirAmenityPrayerRoom, Icons.mosque),
        _AmenityDef(l10n.dirAmenityRestrooms, Icons.wc),
        _AmenityDef(l10n.dirAmenityElevator, Icons.elevator),
        _AmenityDef(l10n.dirAmenityAC, Icons.ac_unit),
        _AmenityDef(l10n.dirAmenityKidsArea, Icons.child_care),
        _AmenityDef(l10n.dirAmenityWheelchair, Icons.accessible),
        _AmenityDef(l10n.dirAmenityATM, Icons.atm),
        _AmenityDef(l10n.dirAmenitySecurity, Icons.security),
        _AmenityDef(l10n.dirAmenityCCTV, Icons.videocam),
        _AmenityDef(l10n.dirAmenityCustomerService, Icons.support_agent),
        _AmenityDef(l10n.dirAmenitySmokingArea, Icons.smoking_rooms),
        _AmenityDef(l10n.dirAmenityEVCharging, Icons.ev_station),
        _AmenityDef(l10n.dirAmenityPharmacy, Icons.local_pharmacy),
      ];

  @override
  void initState() {
    super.initState();
    _selected = Set.from(widget.selected);
  }

  void _toggle(String amenity) {
    setState(() {
      if (_selected.contains(amenity)) {
        _selected.remove(amenity);
      } else {
        _selected.add(amenity);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final amenities = _amenities(context.l10n);

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: widget.onClose,
        ),
        title: Text(
          context.l10n.dirAmenityTitle,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          btn.Button(
            onPressed: () => widget.onSave(_selected.toList()),
            label: context.l10n.save,
            variant: btn.Variant.text,
            size: btn.ButtonSize.small,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(
              context.l10n.dirAmenitySelectedCount(_selected.length),
              style: context.textTheme.titleSmall?.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.2,
                mainAxisSpacing: AppSpacing.sm,
                crossAxisSpacing: AppSpacing.sm,
              ),
              itemCount: amenities.length,
              itemBuilder: (_, i) {
                final amenity = amenities[i];
                final isSelected = _selected.contains(amenity.label);

                return GestureDetector(
                  onTap: () => _toggle(amenity.label),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.08)
                          : context.colorScheme.surfaceContainerHighest,
                      borderRadius: AppRadius.cardInner,
                      border: isSelected
                          ? Border.all(
                              color:
                                  AppColors.primary.withValues(alpha: 0.3),
                            )
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          amenity.icon,
                          size: 24,
                          color: isSelected
                              ? AppColors.primary
                              : context.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          amenity.label,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color: isSelected
                                ? AppColors.primary
                                : context.colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AmenityDef {
  final String label;
  final IconData icon;

  const _AmenityDef(this.label, this.icon);
}
