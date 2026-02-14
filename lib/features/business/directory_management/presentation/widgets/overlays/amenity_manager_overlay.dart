import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

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

  static const _amenities = [
    _AmenityDef('مواقف سيارات', Icons.local_parking),
    _AmenityDef('واي فاي', Icons.wifi),
    _AmenityDef('مصلى', Icons.mosque),
    _AmenityDef('دورات مياه', Icons.wc),
    _AmenityDef('مصعد', Icons.elevator),
    _AmenityDef('تكييف', Icons.ac_unit),
    _AmenityDef('منطقة أطفال', Icons.child_care),
    _AmenityDef('كراسي متحركة', Icons.accessible),
    _AmenityDef('صراف آلي', Icons.atm),
    _AmenityDef('أمن وحراسة', Icons.security),
    _AmenityDef('كاميرات مراقبة', Icons.videocam),
    _AmenityDef('خدمة عملاء', Icons.support_agent),
    _AmenityDef('منطقة تدخين', Icons.smoking_rooms),
    _AmenityDef('شحن كهربائي', Icons.ev_station),
    _AmenityDef('صيدلية', Icons.local_pharmacy),
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
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: widget.onClose,
        ),
        title: const Text(
          'مرافق المول',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => widget.onSave(_selected.toList()),
            child: const Text('حفظ'),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(
              '${_selected.length} مرفق محدد',
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
              itemCount: _amenities.length,
              itemBuilder: (_, i) {
                final amenity = _amenities[i];
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
