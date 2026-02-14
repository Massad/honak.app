import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/branch.dart';
import 'package:honak/features/business/page_settings/presentation/providers/branch_provider.dart';
import 'package:honak/features/business/page_settings/presentation/providers/venue_search_provider.dart';
import 'package:honak/features/explore/domain/entities/page_summary.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

class BranchCard extends ConsumerStatefulWidget {
  final Branch branch;
  final bool initiallyExpanded;
  final List<Map<String, dynamic>> cities;

  const BranchCard({
    super.key,
    required this.branch,
    this.initiallyExpanded = false,
    this.cities = const [],
  });

  @override
  ConsumerState<BranchCard> createState() => _BranchCardState();
}

class _BranchCardState extends ConsumerState<BranchCard> {
  late bool _expanded;
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _floorController;
  late TextEditingController _unitController;
  String? _selectedCity;
  String? _selectedNeighborhood;
  late String _locationType;
  String? _selectedVenueId;
  String? _selectedVenueName;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
    _nameController = TextEditingController(text: widget.branch.name);
    _addressController =
        TextEditingController(text: widget.branch.address ?? '');
    _phoneController =
        TextEditingController(text: widget.branch.phone ?? '');
    _floorController =
        TextEditingController(text: widget.branch.venueFloor ?? '');
    _unitController =
        TextEditingController(text: widget.branch.venueUnit ?? '');
    _selectedCity = widget.branch.city;
    _selectedNeighborhood = widget.branch.neighborhood;
    _locationType = widget.branch.locationType;
    _selectedVenueId = widget.branch.venueId;
    _selectedVenueName = widget.branch.venueName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _floorController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  List<String> get _neighborhoodsForCity {
    if (_selectedCity == null) return [];
    final city = widget.cities.firstWhere(
      (c) => c['name'] == _selectedCity,
      orElse: () => <String, dynamic>{},
    );
    final neighborhoods = city['neighborhoods'];
    if (neighborhoods is List) {
      return neighborhoods.cast<String>();
    }
    return [];
  }

  void _saveChanges() {
    final isInVenue = _locationType == 'in_venue';
    final floor = _floorController.text.trim();
    final unit = _unitController.text.trim();
    final updated = widget.branch.copyWith(
      name: _nameController.text.trim(),
      address: _addressController.text.trim().isNotEmpty
          ? _addressController.text.trim()
          : null,
      phone: _phoneController.text.trim().isNotEmpty
          ? _phoneController.text.trim()
          : null,
      city: _selectedCity,
      neighborhood: _selectedNeighborhood,
      locationType: _locationType,
      venueId: isInVenue ? _selectedVenueId : null,
      venueName: isInVenue ? _selectedVenueName : null,
      venueFloor: isInVenue && floor.isNotEmpty ? floor : null,
      venueUnit: isInVenue && unit.isNotEmpty ? unit : null,
    );
    ref.read(branchProvider.notifier).updateBranch(updated);
  }

  void _toggleStatus(String status) {
    ref
        .read(branchProvider.notifier)
        .toggleBranchStatus(widget.branch.id, status);
  }

  void _deleteBranch() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حذف الفرع', textAlign: TextAlign.end),
        content: Text(
          'هل تريد حذف فرع "${widget.branch.name}"؟',
          textAlign: TextAlign.end,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(branchProvider.notifier).removeBranch(widget.branch.id);
              context.showSnackBar('تم حذف الفرع');
            },
            child: Text('حذف', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final branch = widget.branch;
    final statusColor = branch.active ? AppColors.success : AppColors.warning;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Collapsed header — always visible
          Material(
            color: Theme.of(context).colorScheme.surface,
            child: InkWell(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    Icon(
                      _expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 20,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          branch.name,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (branch.city != null ||
                            branch.neighborhood != null)
                          Text(
                            [branch.neighborhood, branch.city]
                                .where((s) => s != null)
                                .join('، '),
                            style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    // Status-colored pin
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.place,
                        size: 16,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Expanded editing section
          if (_expanded) ...[
            Divider(height: 1, color: Theme.of(context).colorScheme.outlineVariant),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Name
                  _buildField(
                    controller: _nameController,
                    label: 'اسم الفرع',
                    onChanged: (_) => _saveChanges(),
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // City dropdown
                  _buildDropdown(
                    label: 'المدينة',
                    value: _selectedCity,
                    items: widget.cities
                        .map((c) => c['name'] as String)
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedCity = val;
                        _selectedNeighborhood = null;
                      });
                      _saveChanges();
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Neighborhood dropdown (cascading)
                  _buildDropdown(
                    label: 'الحي',
                    value: _selectedNeighborhood,
                    items: _neighborhoodsForCity,
                    onChanged: (val) {
                      setState(() => _selectedNeighborhood = val);
                      _saveChanges();
                    },
                    enabled: _selectedCity != null,
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Address
                  _buildField(
                    controller: _addressController,
                    label: 'العنوان التفصيلي',
                    onChanged: (_) => _saveChanges(),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Location type toggle
                  _buildLocationTypeSection(),
                  const SizedBox(height: AppSpacing.sm),

                  // Phone (LTR)
                  _buildField(
                    controller: _phoneController,
                    label: 'رقم الهاتف',
                    keyboardType: TextInputType.phone,
                    textDirection: TextDirection.ltr,
                    onChanged: (_) => _saveChanges(),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Status toggle
                  Text(
                    'حالة الفرع',
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      Expanded(
                        child: _StatusToggle(
                          label: 'مغلق مؤقتاً',
                          isSelected: !branch.active,
                          color: AppColors.warning,
                          onTap: () => _toggleStatus('temp_closed'),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _StatusToggle(
                          label: 'متاح',
                          isSelected: branch.active,
                          color: AppColors.success,
                          onTap: () => _toggleStatus('active'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Delete button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _deleteBranch,
                      icon: Icon(Icons.delete_outline,
                          size: 16, color: AppColors.error),
                      label: Text(
                        'حذف الفرع',
                        style: TextStyle(color: AppColors.error),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: AppColors.error.withValues(alpha: 0.3)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.sm),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLocationTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Label
        Text(
          // "نوع الموقع"
          '\u0646\u0648\u0639 \u0627\u0644\u0645\u0648\u0642\u0639',
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        // Toggle row
        Row(
          children: [
            Expanded(
              child: _StatusToggle(
                // "داخل مجمع"
                label: '\u062f\u0627\u062e\u0644 \u0645\u062c\u0645\u0639',
                isSelected: _locationType == 'in_venue',
                color: Theme.of(context).colorScheme.primary,
                onTap: () {
                  setState(() => _locationType = 'in_venue');
                  _saveChanges();
                },
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _StatusToggle(
                // "موقع مستقل"
                label: '\u0645\u0648\u0642\u0639 \u0645\u0633\u062a\u0642\u0644',
                isSelected: _locationType == 'standalone',
                color: Theme.of(context).colorScheme.primary,
                onTap: () {
                  setState(() {
                    _locationType = 'standalone';
                    _selectedVenueId = null;
                    _selectedVenueName = null;
                    _floorController.clear();
                    _unitController.clear();
                  });
                  _saveChanges();
                },
              ),
            ),
          ],
        ),
        // Venue fields — shown when "داخل مجمع" is selected
        if (_locationType == 'in_venue') ...[
          const SizedBox(height: AppSpacing.sm),
          // Venue selector
          GestureDetector(
            onTap: () => _showVenueSearchSheet(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const Spacer(),
                  Text(
                    _selectedVenueName ??
                        // "اختر المجمع"
                        '\u0627\u062e\u062a\u0631 \u0627\u0644\u0645\u062c\u0645\u0639',
                    style: TextStyle(
                      fontSize: 13,
                      color: _selectedVenueName != null
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Icon(
                    Icons.apartment_outlined,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          // Floor + Unit in a row
          Row(
            children: [
              Expanded(
                child: _buildField(
                  controller: _unitController,
                  // "رقم الوحدة"
                  label: '\u0631\u0642\u0645 \u0627\u0644\u0648\u062d\u062f\u0629',
                  onChanged: (_) => _saveChanges(),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _buildField(
                  controller: _floorController,
                  // "الطابق"
                  label: '\u0627\u0644\u0637\u0627\u0628\u0642',
                  onChanged: (_) => _saveChanges(),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  void _showVenueSearchSheet() {
    showAppSheet(
      context,
      builder: (ctx) => _VenueSearchSheet(
        onSelect: (id, name) {
          setState(() {
            _selectedVenueId = id;
            _selectedVenueName = name;
          });
          _saveChanges();
        },
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    TextDirection? textDirection,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          textAlign: textDirection == TextDirection.ltr
              ? TextAlign.left
              : TextAlign.end,
          textDirection: textDirection,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
            color: enabled ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.surfaceContainerLowest,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: items.contains(value) ? value : null,
              isExpanded: true,
              alignment: AlignmentDirectional.centerEnd,
              hint: Text(
                'اختر',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(item, style: const TextStyle(fontSize: 13)),
                );
              }).toList(),
              onChanged: enabled ? onChanged : null,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusToggle extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _StatusToggle({
    required this.label,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? color.withValues(alpha: 0.1) : Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color:
                  isSelected ? color.withValues(alpha: 0.3) : Colors.grey.shade200,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? color : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Bottom sheet for searching and selecting a venue (directory page).
class _VenueSearchSheet extends ConsumerStatefulWidget {
  final void Function(String id, String name) onSelect;

  const _VenueSearchSheet({required this.onSelect});

  @override
  ConsumerState<_VenueSearchSheet> createState() => _VenueSearchSheetState();
}

class _VenueSearchSheetState extends ConsumerState<_VenueSearchSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final venuesAsync = ref.watch(venueListProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSheetHeader(
          // "اختر المجمع"
          title: '\u0627\u062e\u062a\u0631 \u0627\u0644\u0645\u062c\u0645\u0639',
          onClose: () => Navigator.pop(context),
        ),
        // Search field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: TextField(
            textAlign: TextAlign.end,
            onChanged: (val) => setState(() => _query = val),
            decoration: InputDecoration(
              isDense: true,
              // "بحث..."
              hintText: '\u0628\u062d\u062b...',
              hintStyle: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              prefixIcon: Icon(Icons.search, size: 20),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        // Venue list
        venuesAsync.when(
          loading: () => Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Text('$e'),
          ),
          data: (venues) {
            final filtered = _query.isEmpty
                ? venues
                : venues.where((v) => v.name.contains(_query)).toList();
            if (filtered.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Text(
                  // "لا توجد نتائج"
                  '\u0644\u0627 \u062a\u0648\u062c\u062f \u0646\u062a\u0627\u0626\u062c',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              );
            }
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 300),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filtered.length,
                itemBuilder: (ctx, i) {
                  final venue = filtered[i];
                  return _VenueListTile(
                    venue: venue,
                    onTap: () {
                      Navigator.pop(context);
                      widget.onSelect(venue.slug, venue.name);
                    },
                  );
                },
              ),
            );
          },
        ),
        SizedBox(height: AppSpacing.md),
      ],
    );
  }
}

class _VenueListTile extends StatelessWidget {
  final PageSummary venue;
  final VoidCallback onTap;

  const _VenueListTile({required this.venue, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final location = venue.location;
    final area = location?.area ?? location?.city;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.sm,
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 18,
              backgroundImage: venue.avatarUrl != null
                  ? NetworkImage(venue.avatarUrl!)
                  : null,
              child: venue.avatarUrl == null
                  ? Icon(Icons.apartment, size: 18)
                  : null,
            ),
            const SizedBox(width: AppSpacing.sm),
            // Name + area
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    venue.name,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (area != null)
                    Text(
                      area,
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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
}
