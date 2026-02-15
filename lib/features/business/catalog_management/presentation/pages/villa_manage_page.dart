import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/catalog_management/presentation/providers/price_change_provider.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/price_change/price_change_banner.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/villa_manage_sections.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/availability_overlay.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/property_features_overlay.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/villa_seasonal_pricing.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/features/pages/presentation/providers/page_detail_providers.dart';
import 'package:honak/shared/providers/business_page_provider.dart';

/// Villa / farm-rental Manage tab — property management matching
/// Figma VillaManage.tsx pixel-for-pixel.
///
/// 6 sections:
/// 1. Price Change Banner (always visible)
/// 2. Pricing (sub-tabbed: base + seasonal)
/// 3. Property Description (button → overlay)
/// 4. House Rules (collapsible)
/// 5. Check-in / Check-out (collapsible)
/// 6. Gallery (collapsible)
/// 7. Availability (button → overlay)
class VillaManagePage extends ConsumerWidget {
  const VillaManagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bizContext = ref.watch(businessContextProvider);
    if (bizContext == null) return const SizedBox.shrink();

    final pageAsync = ref.watch(pageDetailProvider(bizContext.page.slug));

    return pageAsync.when(
      data: (page) => _VillaManageBody(page: page),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('خطأ في تحميل البيانات')),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// Active overlay enum
// ═══════════════════════════════════════════════════════════════════

enum _ActiveOverlay { none, propertyFeatures, availability }

// ═══════════════════════════════════════════════════════════════════
// Pricing sub-tab
// ═══════════════════════════════════════════════════════════════════

enum _PricingTab { base, seasonal }

// ═══════════════════════════════════════════════════════════════════
// Body — owns local editing state
// ═══════════════════════════════════════════════════════════════════

class _VillaManageBody extends ConsumerStatefulWidget {
  final PageDetail page;
  const _VillaManageBody({required this.page});

  @override
  ConsumerState<_VillaManageBody> createState() => _VillaManageBodyState();
}

class _VillaManageBodyState extends ConsumerState<_VillaManageBody> {
  _ActiveOverlay _activeOverlay = _ActiveOverlay.none;
  String? _expandedSection = 'pricing';
  _PricingTab _pricingTab = _PricingTab.base;

  // Pricing
  late int _weekdayCents;
  late int _weekendCents;
  bool _editingPricing = false;
  late TextEditingController _weekdayCtrl;
  late TextEditingController _weekendCtrl;

  // House rules
  late List<String> _rules;
  final _ruleCtrl = TextEditingController();

  // Check-in / out
  late String _checkIn;
  late String _checkOut;
  bool _editingTimes = false;
  late TextEditingController _checkInCtrl;
  late TextEditingController _checkOutCtrl;

  PageDetail get _pg => widget.page;

  @override
  void initState() {
    super.initState();
    _weekdayCents = _pg.pricing?.weekdayCents ?? 15000;
    _weekendCents = _pg.pricing?.weekendCents ?? 20000;
    _weekdayCtrl = TextEditingController(
        text: (_weekdayCents / 100).toStringAsFixed(0));
    _weekendCtrl = TextEditingController(
        text: (_weekendCents / 100).toStringAsFixed(0));

    _rules = List.of(_pg.houseRules);
    _checkIn = _pg.checkIn ?? '14:00';
    _checkOut = _pg.checkOut ?? '12:00';
    _checkInCtrl = TextEditingController(text: _checkIn);
    _checkOutCtrl = TextEditingController(text: _checkOut);
  }

  @override
  void dispose() {
    _weekdayCtrl.dispose();
    _weekendCtrl.dispose();
    _ruleCtrl.dispose();
    _checkInCtrl.dispose();
    _checkOutCtrl.dispose();
    super.dispose();
  }

  void _toggle(String id) {
    setState(() => _expandedSection = _expandedSection == id ? null : id);
  }

  @override
  Widget build(BuildContext context) {
    // Full-screen overlays replace the entire manage content
    if (_activeOverlay == _ActiveOverlay.propertyFeatures) {
      return PropertyFeaturesOverlay(
        onClose: () => setState(
            () => _activeOverlay = _ActiveOverlay.none),
        maxGuests: _pg.maxGuests ?? 10,
        bedrooms: _pg.bedrooms ?? 4,
        bathrooms: _pg.bathrooms ?? 3,
        amenities: _pg.amenities.map((a) => a.label).toList(),
      );
    }
    if (_activeOverlay == _ActiveOverlay.availability) {
      return AvailabilityOverlay(
        onClose: () => setState(
            () => _activeOverlay = _ActiveOverlay.none),
      );
    }

    final pcState = ref.watch(priceChangeProvider);
    final pcNotifier = ref.read(priceChangeProvider.notifier);
    final activeChange = pcState.valueOrNull?.active;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.xxxl,
      ),
      children: [
        // ═══ Price Change Banner ═══
        PriceChangeBanner(
          activePriceChange: activeChange,
          historyCount: pcState.valueOrNull?.history.length ?? 0,
          onCreateNew: () =>
              context.showSnackBar('معالج تغيير الأسعار — قريباً'),
          onEdit: () =>
              context.showSnackBar('تعديل تغيير الأسعار — قريباً'),
          onStop: () => pcNotifier.stopActive(),
          onViewHistory: () =>
              context.showSnackBar('سجل التغييرات — قريباً'),
        ),
        const SizedBox(height: AppSpacing.md),

        // ═══ 1. Pricing (sub-tabbed) ═══
        VillaSectionToggle(
          id: 'pricing',
          icon: Icons.attach_money,
          title: 'التسعير',
          expandedSection: _expandedSection,
          onTap: _toggle,
        ),
        if (_expandedSection == 'pricing') ...[
          const SizedBox(height: AppSpacing.md),
          _buildPricingPanel(),
        ],
        const SizedBox(height: AppSpacing.md),

        // ═══ 2. Property Description (button → overlay) ═══
        _buildOverlayButton(
          icon: Icons.home_outlined,
          title: 'وصف العقار',
          subtitle: 'التصنيفات · المرافق · المواصفات',
          onTap: () => setState(
              () => _activeOverlay = _ActiveOverlay.propertyFeatures),
        ),
        const SizedBox(height: AppSpacing.md),

        // ═══ 3. House Rules ═══
        VillaSectionToggle(
          id: 'rules',
          icon: Icons.shield_outlined,
          title: 'قوانين المنزل',
          iconColor: Colors.amber.shade700,
          count: _rules.length,
          expandedSection: _expandedSection,
          onTap: _toggle,
        ),
        if (_expandedSection == 'rules') ...[
          const SizedBox(height: AppSpacing.md),
          VillaRulesSection(
            rules: _rules,
            ruleCtrl: _ruleCtrl,
            onAdd: () {
              final t = _ruleCtrl.text.trim();
              if (t.isEmpty) return;
              setState(() {
                _rules.add(t);
                _ruleCtrl.clear();
              });
            },
            onRemove: (i) => setState(() => _rules.removeAt(i)),
            onEdit: (entry) => setState(() {
              if (entry.key < _rules.length) {
                _rules[entry.key] = entry.value;
              }
            }),
          ),
        ],
        const SizedBox(height: AppSpacing.md),

        // ═══ 4. Check-in / Check-out ═══
        VillaSectionToggle(
          id: 'times',
          icon: Icons.access_time_outlined,
          title: 'مواعيد الوصول والمغادرة',
          expandedSection: _expandedSection,
          onTap: _toggle,
        ),
        if (_expandedSection == 'times') ...[
          const SizedBox(height: AppSpacing.md),
          _buildTimesContent(),
        ],
        const SizedBox(height: AppSpacing.md),

        // ═══ 5. Gallery ═══
        VillaSectionToggle(
          id: 'gallery',
          icon: Icons.photo_library_outlined,
          title: 'معرض الصور',
          count: _pg.galleryImages.length,
          expandedSection: _expandedSection,
          onTap: _toggle,
        ),
        if (_expandedSection == 'gallery') ...[
          const SizedBox(height: AppSpacing.md),
          VillaGallerySection(
            images: _pg.galleryImages,
            onReorder: (newOrder) {
              // TODO: persist reordered gallery
            },
          ),
        ],
        const SizedBox(height: AppSpacing.md),

        // ═══ 6. Availability (button → overlay) ═══
        _buildOverlayButton(
          icon: Icons.calendar_month_outlined,
          title: 'الجدول والتوفر',
          subtitle: 'الجدول الأسبوعي · حظر مواعيد · أيام محجوزة',
          onTap: () =>
              setState(() => _activeOverlay = _ActiveOverlay.availability),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────
  // PRICING PANEL (with sub-tabs)
  // ─────────────────────────────────────────────────────────────────
  Widget _buildPricingPanel() {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: context.colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Sub-tab bar
          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: context.colorScheme.outlineVariant)),
            ),
            child: Row(
              children: [
                _pricingTabButton('المواسم والعروض', _PricingTab.seasonal),
                _pricingTabButton('الأساسي', _PricingTab.base),
              ],
            ),
          ),
          // Tab content
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: _pricingTab == _PricingTab.base
                ? _buildBasePricingContent()
                : VillaSeasonalPricing(initialData: _pg.seasonalPricing),
          ),
        ],
      ),
    );
  }

  Widget _pricingTabButton(String label, _PricingTab tab) {
    final isActive = _pricingTab == tab;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _pricingTab = tab),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary.withValues(alpha: 0.03)
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: isActive ? AppColors.primary : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? AppColors.primary : AppColors.textHint,
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────
  // BASE PRICING (view/edit)
  // ─────────────────────────────────────────────────────────────────
  Widget _buildBasePricingContent() {
    if (_editingPricing) return _basePricingEdit();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: VillaPriceCard(
                label: 'نهاية الأسبوع',
                cents: _weekendCents,
                bg: const Color(0xFFFFF3E0),
                border: const Color(0xFFFFE0B2),
                textColor: AppColors.secondary,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: VillaPriceCard(
                label: 'أيام الأسبوع',
                cents: _weekdayCents,
                bg: const Color(0xFFE3F2FD),
                border: const Color(0xFFBBDEFB),
                textColor: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        villaEditButton(context, 'تعديل الأسعار',
            () => setState(() => _editingPricing = true)),
        const SizedBox(height: AppSpacing.md),
        // Blue info hint matching Figma
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: const Text(
            'هذه الأسعار الأساسية — يمكنك إضافة أسعار موسمية وعروض من تبويب "المواسم والعروض"',
            style: TextStyle(fontSize: 9, color: AppColors.primary),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _basePricingEdit() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: villaLabeledInput(
                    'نهاية الأسبوع', _weekendCtrl, context)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
                child:
                    villaLabeledInput('أيام الأسبوع', _weekdayCtrl, context)),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        villaSaveCancelRow(
          context: context,
          onSave: () {
            final wd = (double.tryParse(_weekdayCtrl.text) ?? 150) * 100;
            final we = (double.tryParse(_weekendCtrl.text) ?? 200) * 100;
            setState(() {
              _weekdayCents = wd.toInt();
              _weekendCents = we.toInt();
              _editingPricing = false;
            });
          },
          onCancel: () {
            _weekdayCtrl.text = (_weekdayCents / 100).toStringAsFixed(0);
            _weekendCtrl.text = (_weekendCents / 100).toStringAsFixed(0);
            setState(() => _editingPricing = false);
          },
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────
  // CHECK-IN / CHECK-OUT
  // ─────────────────────────────────────────────────────────────────
  Widget _buildTimesContent() {
    return VillaSectionBox(
      child: _editingTimes
          ? _timesEdit()
          : Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: VillaTimeCard(
                        icon: Icons.logout,
                        iconColor: AppColors.error,
                        label: 'المغادرة (Check-out)',
                        time: _checkOut,
                        bg: const Color(0xFFFFEBEE),
                        border: const Color(0xFFFFCDD2),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: VillaTimeCard(
                        icon: Icons.login,
                        iconColor: AppColors.success,
                        label: 'الوصول (Check-in)',
                        time: _checkIn,
                        bg: const Color(0xFFE8F5E9),
                        border: const Color(0xFFC8E6C9),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                villaEditButton(context, 'تعديل المواعيد',
                    () => setState(() => _editingTimes = true)),
              ],
            ),
    );
  }

  Widget _timesEdit() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: villaLabeledInput(
                    'وقت المغادرة', _checkOutCtrl, context,
                    isText: true)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
                child: villaLabeledInput(
                    'وقت الوصول', _checkInCtrl, context,
                    isText: true)),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        villaSaveCancelRow(
          context: context,
          onSave: () => setState(() {
            _checkIn = _checkInCtrl.text.trim().isNotEmpty
                ? _checkInCtrl.text.trim()
                : _checkIn;
            _checkOut = _checkOutCtrl.text.trim().isNotEmpty
                ? _checkOutCtrl.text.trim()
                : _checkOut;
            _editingTimes = false;
          }),
          onCancel: () {
            _checkInCtrl.text = _checkIn;
            _checkOutCtrl.text = _checkOut;
            setState(() => _editingTimes = false);
          },
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────
  // OVERLAY BUTTON (property features / availability)
  // ─────────────────────────────────────────────────────────────────
  Widget _buildOverlayButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: context.colorScheme.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.arrow_back_ios, size: 14,
                color: AppColors.textHint),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(title, style: TextStyle(
                  fontSize: 14, color: context.colorScheme.onSurface,
                )),
                Text(subtitle, style: const TextStyle(
                  fontSize: 10, color: AppColors.textHint,
                )),
              ],
            ),
            const SizedBox(width: AppSpacing.md),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Icon(icon, size: 16, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }

}
