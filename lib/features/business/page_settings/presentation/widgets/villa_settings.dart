import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';
import 'package:honak/shared/entities/money.dart';

class VillaSettings extends ConsumerStatefulWidget {
  final VoidCallback onClose;
  const VillaSettings({super.key, required this.onClose});

  @override
  ConsumerState<VillaSettings> createState() => _VillaSettingsState();
}

class _VillaSettingsState extends ConsumerState<VillaSettings> {
  // ── Expand / collapse ──────────────────────────────────────
  String? _expandedSection = 'pricing';

  // ── 1. Pricing ─────────────────────────────────────────────
  int _weekdayPiasters = 80000; // 80 JOD
  int _weekendPiasters = 120000; // 120 JOD
  bool _editingPricing = false;
  late final TextEditingController _weekdayController;
  late final TextEditingController _weekendController;

  // ── 2. Property Specs ──────────────────────────────────────
  int _maxGuests = 8;
  int _bedrooms = 3;
  int _bathrooms = 2;
  bool _editingSpecs = false;
  late final TextEditingController _guestsController;
  late final TextEditingController _bedroomsController;
  late final TextEditingController _bathroomsController;

  // ── 3. Amenities ───────────────────────────────────────────
  final Set<String> _selectedAmenities = {
    'pool',
    'wifi',
    'kitchen',
    'parking',
    'ac',
  };

  static const _amenities = <String, (IconData, String)>{
    'pool': (Icons.pool, 'مسبح'),
    'wifi': (Icons.wifi, 'واي فاي'),
    'kitchen': (Icons.kitchen, 'مطبخ'),
    'parking': (Icons.local_parking, 'موقف سيارات'),
    'garden': (Icons.yard, 'حديقة'),
    'bbq': (Icons.outdoor_grill, 'شواء'),
    'ac': (Icons.ac_unit, 'تكييف'),
    'washer': (Icons.local_laundry_service, 'غسالة'),
    'tv': (Icons.tv, 'تلفزيون'),
    'jacuzzi': (Icons.hot_tub, 'جاكوزي'),
    'playground': (Icons.child_care, 'ملعب أطفال'),
    'view': (Icons.landscape, 'إطلالة'),
  };

  // ── 4. House Rules ─────────────────────────────────────────
  final _ruleController = TextEditingController();
  final List<String> _rules = [
    'ممنوع التدخين داخل المبنى',
    'ممنوع الحيوانات الأليفة',
    'ممنوع الحفلات أو الإزعاج',
    'يرجى المحافظة على نظافة المكان',
  ];

  // ── 5. Check-in / Check-out ────────────────────────────────
  String _checkIn = '2:00 م';
  String _checkOut = '12:00 م';
  bool _editingTimes = false;
  late final TextEditingController _checkInController;
  late final TextEditingController _checkOutController;

  @override
  void initState() {
    super.initState();
    _weekdayController = TextEditingController(
      text: Money(_weekdayPiasters).toJodString(),
    );
    _weekendController = TextEditingController(
      text: Money(_weekendPiasters).toJodString(),
    );
    _guestsController = TextEditingController(text: '$_maxGuests');
    _bedroomsController = TextEditingController(text: '$_bedrooms');
    _bathroomsController = TextEditingController(text: '$_bathrooms');
    _checkInController = TextEditingController(text: _checkIn);
    _checkOutController = TextEditingController(text: _checkOut);
  }

  @override
  void dispose() {
    _ruleController.dispose();
    _weekdayController.dispose();
    _weekendController.dispose();
    _guestsController.dispose();
    _bedroomsController.dispose();
    _bathroomsController.dispose();
    _checkInController.dispose();
    _checkOutController.dispose();
    super.dispose();
  }

  void _toggleSection(String id) {
    setState(() {
      _expandedSection = _expandedSection == id ? null : id;
    });
  }

  // ─────────────────────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubScreenAppBar(title: 'إعدادات المكان', onClose: widget.onClose),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              // 1. Pricing
              _buildSectionToggle(
                id: 'pricing',
                icon: Icons.edit_outlined,
                title: 'التسعير',
              ),
              if (_expandedSection == 'pricing') ...[
                const SizedBox(height: AppSpacing.xs),
                _buildPricingContent(),
              ],
              const SizedBox(height: AppSpacing.md),

              // 2. Property Specs
              _buildSectionToggle(
                id: 'specs',
                icon: Icons.bed_outlined,
                title: 'مواصفات العقار',
              ),
              if (_expandedSection == 'specs') ...[
                const SizedBox(height: AppSpacing.xs),
                _buildSpecsContent(),
              ],
              const SizedBox(height: AppSpacing.md),

              // 3. Amenities
              _buildSectionToggle(
                id: 'amenities',
                icon: Icons.wifi,
                title: 'المرافق والخدمات',
                count: _selectedAmenities.length,
              ),
              if (_expandedSection == 'amenities') ...[
                const SizedBox(height: AppSpacing.xs),
                _buildAmenitiesContent(),
              ],
              const SizedBox(height: AppSpacing.md),

              // 4. House Rules
              _buildSectionToggle(
                id: 'rules',
                icon: Icons.shield_outlined,
                title: 'قوانين المنزل',
                iconColor: Colors.amber.shade700,
                count: _rules.length,
              ),
              if (_expandedSection == 'rules') ...[
                const SizedBox(height: AppSpacing.xs),
                _buildRulesContent(),
              ],
              const SizedBox(height: AppSpacing.md),

              // 5. Check-in / Check-out
              _buildSectionToggle(
                id: 'times',
                icon: Icons.access_time_outlined,
                title: 'مواعيد الوصول والمغادرة',
              ),
              if (_expandedSection == 'times') ...[
                const SizedBox(height: AppSpacing.xs),
                _buildTimesContent(),
              ],
              const SizedBox(height: AppSpacing.md),

              // 6. Gallery
              _buildSectionToggle(
                id: 'gallery',
                icon: Icons.photo_library_outlined,
                title: 'معرض الصور',
              ),
              if (_expandedSection == 'gallery') ...[
                const SizedBox(height: AppSpacing.xs),
                _buildGalleryContent(),
              ],
              const SizedBox(height: AppSpacing.md),

              // 7. Availability link
              _buildAvailabilityLink(),

              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // SECTION TOGGLE HEADER
  // ─────────────────────────────────────────────────────────────
  Widget _buildSectionToggle({
    required String id,
    required IconData icon,
    required String title,
    Color? iconColor,
    int? count,
  }) {
    final isExpanded = _expandedSection == id;
    return GestureDetector(
      onTap: () => _toggleSection(id),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          children: [
            Icon(
              isExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              size: 18,
              color: Colors.grey.shade400,
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (count != null)
                  Text(
                    '$count عنصر',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade400,
                    ),
                  ),
              ],
            ),
            const SizedBox(width: AppSpacing.md),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Icon(
                icon,
                size: 16,
                color: iconColor ?? AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // 1. PRICING
  // ─────────────────────────────────────────────────────────────
  Widget _buildPricingContent() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: _editingPricing
          ? _buildPricingEditMode()
          : _buildPricingViewMode(),
    );
  }

  Widget _buildPricingViewMode() {
    final weekdayJod = Money(_weekdayPiasters).toJodString();
    final weekendJod = Money(_weekendPiasters).toJodString();

    return Column(
      children: [
        Row(
          children: [
            // Weekend (orange) — left in RTL
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0), // orange-50
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: const Color(0xFFFFE0B2)),
                ),
                child: Column(
                  children: [
                    Text(
                      'نهاية الأسبوع',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      weekendJod,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondary,
                      ),
                    ),
                    Text(
                      'د.أ/ليلة',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Weekday (blue) — right in RTL
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD), // blue-50
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: const Color(0xFFBBDEFB)),
                ),
                child: Column(
                  children: [
                    Text(
                      'أيام الأسبوع',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      weekdayJod,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      'د.أ/ليلة',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _buildEditButton(
          label: 'تعديل الأسعار',
          onTap: () => setState(() => _editingPricing = true),
        ),
      ],
    );
  }

  Widget _buildPricingEditMode() {
    return Column(
      children: [
        Row(
          children: [
            // Weekend input
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'نهاية الأسبوع',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  _buildNumberInput(_weekendController),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Weekday input
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'أيام الأسبوع',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  _buildNumberInput(_weekdayController),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _buildSaveCancelRow(
          onSave: () {
            final weekday =
                (double.tryParse(_weekdayController.text) ?? 80) * 1000;
            final weekend =
                (double.tryParse(_weekendController.text) ?? 120) * 1000;
            setState(() {
              _weekdayPiasters = weekday.toInt();
              _weekendPiasters = weekend.toInt();
              _editingPricing = false;
            });
          },
          onCancel: () {
            _weekdayController.text = Money(_weekdayPiasters).toJodString();
            _weekendController.text = Money(_weekendPiasters).toJodString();
            setState(() => _editingPricing = false);
          },
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // 2. PROPERTY SPECS
  // ─────────────────────────────────────────────────────────────
  Widget _buildSpecsContent() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: _editingSpecs
          ? _buildSpecsEditMode()
          : _buildSpecsViewMode(),
    );
  }

  Widget _buildSpecsViewMode() {
    return Column(
      children: [
        Row(
          children: [
            _buildSpecBadge(Icons.bathtub_outlined, '$_bathrooms حمام'),
            const SizedBox(width: AppSpacing.sm),
            _buildSpecBadge(Icons.bed_outlined, '$_bedrooms غرف'),
            const SizedBox(width: AppSpacing.sm),
            _buildSpecBadge(Icons.people_outline, 'حتى $_maxGuests ضيف'),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _buildEditButton(
          label: 'تعديل المواصفات',
          onTap: () => setState(() => _editingSpecs = true),
        ),
      ],
    );
  }

  Widget _buildSpecBadge(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Icon(icon, size: 14, color: AppColors.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecsEditMode() {
    return Column(
      children: [
        _buildSpecEditRow(
          icon: Icons.people_outline,
          label: 'الحد الأقصى للضيوف',
          controller: _guestsController,
        ),
        const SizedBox(height: AppSpacing.md),
        _buildSpecEditRow(
          icon: Icons.bed_outlined,
          label: 'غرف النوم',
          controller: _bedroomsController,
        ),
        const SizedBox(height: AppSpacing.md),
        _buildSpecEditRow(
          icon: Icons.bathtub_outlined,
          label: 'الحمامات',
          controller: _bathroomsController,
        ),
        const SizedBox(height: AppSpacing.md),
        _buildSaveCancelRow(
          onSave: () {
            setState(() {
              _maxGuests = int.tryParse(_guestsController.text) ?? _maxGuests;
              _bedrooms =
                  int.tryParse(_bedroomsController.text) ?? _bedrooms;
              _bathrooms =
                  int.tryParse(_bathroomsController.text) ?? _bathrooms;
              _editingSpecs = false;
            });
          },
          onCancel: () {
            _guestsController.text = '$_maxGuests';
            _bedroomsController.text = '$_bedrooms';
            _bathroomsController.text = '$_bathrooms';
            setState(() => _editingSpecs = false);
          },
        ),
      ],
    );
  }

  Widget _buildSpecEditRow({
    required IconData icon,
    required String label,
    required TextEditingController controller,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 64,
          child: _buildNumberInput(controller),
        ),
        const Spacer(),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Icon(icon, size: 16, color: AppColors.primary),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // 3. AMENITIES
  // ─────────────────────────────────────────────────────────────
  Widget _buildAmenitiesContent() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'اختر المرافق المتوفرة في المكان',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.end,
            children: _amenities.entries.map((e) {
              final selected = _selectedAmenities.contains(e.key);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (selected) {
                      _selectedAmenities.remove(e.key);
                    } else {
                      _selectedAmenities.add(e.key);
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primary.withValues(alpha: 0.08)
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: selected
                          ? AppColors.primary.withValues(alpha: 0.3)
                          : Colors.grey.shade200,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        e.value.$2,
                        style: TextStyle(
                          fontSize: 12,
                          color: selected
                              ? AppColors.primary
                              : Colors.grey.shade700,
                          fontWeight:
                              selected ? FontWeight.w500 : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        e.value.$1,
                        size: 16,
                        color: selected
                            ? AppColors.primary
                            : Colors.grey.shade400,
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

  // ─────────────────────────────────────────────────────────────
  // 4. HOUSE RULES
  // ─────────────────────────────────────────────────────────────
  Widget _buildRulesContent() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (int i = 0; i < _rules.length; i++)
            Container(
              margin: const EdgeInsetsDirectional.only(bottom: 6),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E1), // amber-50
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFFFECB3)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _rules.removeAt(i)),
                    child: Icon(
                      Icons.delete_outline,
                      size: 14,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    child: Text(
                      _rules[i],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    '•',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.amber.shade700,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: AppSpacing.sm),
          // Add new rule input
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _addRule,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade500,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _ruleController,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 12),
                    decoration: const InputDecoration(
                      hintText: 'أضف قانوناً جديداً...',
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    onSubmitted: (_) => _addRule(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addRule() {
    final text = _ruleController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _rules.add(text);
      _ruleController.clear();
    });
  }

  // ─────────────────────────────────────────────────────────────
  // 5. CHECK-IN / CHECK-OUT
  // ─────────────────────────────────────────────────────────────
  Widget _buildTimesContent() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: _editingTimes
          ? _buildTimesEditMode()
          : _buildTimesViewMode(),
    );
  }

  Widget _buildTimesViewMode() {
    return Column(
      children: [
        Row(
          children: [
            // Check-out (red) — left in RTL
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEBEE), // red-50
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: const Color(0xFFFFCDD2)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.logout,
                      size: 16,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'المغادرة (Check-out)',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      _checkOut,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Check-in (green) — right in RTL
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9), // green-50
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: const Color(0xFFC8E6C9)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.login,
                      size: 16,
                      color: AppColors.success,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'الوصول (Check-in)',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      _checkIn,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _buildEditButton(
          label: 'تعديل المواعيد',
          onTap: () => setState(() => _editingTimes = true),
        ),
      ],
    );
  }

  Widget _buildTimesEditMode() {
    return Column(
      children: [
        Row(
          children: [
            // Check-out input
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'وقت المغادرة (Check-out)',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  _buildTextInput(_checkOutController),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Check-in input
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'وقت الوصول (Check-in)',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  _buildTextInput(_checkInController),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _buildSaveCancelRow(
          onSave: () {
            setState(() {
              _checkIn = _checkInController.text.trim().isEmpty
                  ? _checkIn
                  : _checkInController.text.trim();
              _checkOut = _checkOutController.text.trim().isEmpty
                  ? _checkOut
                  : _checkOutController.text.trim();
              _editingTimes = false;
            });
          },
          onCancel: () {
            _checkInController.text = _checkIn;
            _checkOutController.text = _checkOut;
            setState(() => _editingTimes = false);
          },
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // 6. GALLERY (placeholder)
  // ─────────────────────────────────────────────────────────────
  Widget _buildGalleryContent() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 32,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'معرض الصور',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'أضف صور للمكان لجذب العملاء',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextButton(
            onPressed: () => context.showSnackBar('قريباً'),
            child: const Text(
              'إدارة الصور',
              style: TextStyle(fontSize: 11, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // 7. AVAILABILITY LINK
  // ─────────────────────────────────────────────────────────────
  Widget _buildAvailabilityLink() {
    return GestureDetector(
      onTap: () => context.showSnackBar('إدارة التقويم — قريباً'),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios,
              size: 14,
              color: Colors.grey.shade400,
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'الجدول والتوفر',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'إدارة التقويم والتواريخ المحجوزة',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.md),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: const Icon(
                Icons.calendar_month_outlined,
                size: 16,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // SHARED HELPERS
  // ─────────────────────────────────────────────────────────────
  Widget _buildEditButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              Icons.edit_outlined,
              size: 12,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveCancelRow({
    required VoidCallback onSave,
    required VoidCallback onCancel,
  }) {
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        GestureDetector(
          onTap: onCancel,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Text(
              'إلغاء',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: GestureDetector(
            onTap: onSave,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'حفظ',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.check, size: 14, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberInput(TextEditingController controller) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        isDense: true,
      ),
    );
  }

  Widget _buildTextInput(TextEditingController controller) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        isDense: true,
      ),
    );
  }
}
