import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/config/archetype.dart';
import 'package:honak/config/business_type_config.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/account_tab.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/availability_manager.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/branch_manager.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/cancellation_policy.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/catalog_strategy.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/engagement_settings.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/page_info_editor.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/page_preview_card.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/page_status_settings.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/post_booking_steps.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/quick_stats_card.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/return_policy.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/safety_disclaimers.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/settings_item.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/settings_section.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/share_section.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/alert_manager.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/calendar_sync_settings.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/catalog_sync_settings.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/coverage_settings.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/intake_questions.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/packages_manager.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/qr_code_section.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/relocation_settings.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/team_management.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/tenant_manager.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/venue_settings.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/villa_settings.dart';
import 'package:honak/shared/providers/business_page_provider.dart';

enum _SubScreen {
  main,
  team,
  availability,
  branches,
  pageInfo,
  engagement,
  cancellation,
  returnPolicy,
  catalogStrategy,
  safety,
  postBooking,
  pageStatus,
  // ─── New sub-screens ────────────────────────
  coverage,
  intakeQuestions,
  quoteFormQuestions,
  packages,
  villaSettings,
  venueSettings,
  tenantDirectory,
  alerts,
  qrCode,
  relocation,
  calendarSync,
  catalogSync,
}

class BusinessSettingsPage extends ConsumerStatefulWidget {
  const BusinessSettingsPage({super.key});

  @override
  ConsumerState<BusinessSettingsPage> createState() =>
      _BusinessSettingsPageState();
}

class _BusinessSettingsPageState
    extends ConsumerState<BusinessSettingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  _SubScreen _activeSubScreen = _SubScreen.main;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openSubScreen(_SubScreen screen) {
    setState(() => _activeSubScreen = screen);
  }

  void _closeSubScreen() {
    setState(() => _activeSubScreen = _SubScreen.main);
  }

  @override
  Widget build(BuildContext context) {
    final bizContext = ref.watch(businessContextProvider);
    final page = bizContext?.page;
    final config = bizContext?.config;
    final archetype = config?.archetype ?? Archetype.followOnly;

    // Sub-screen overlay
    if (_activeSubScreen != _SubScreen.main && page != null) {
      return _buildSubScreen(archetype, config: config);
    }

    return Column(
      children: [
        // Tab bar
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.grey.shade400,
            indicatorColor: AppColors.primary,
            labelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(fontSize: 13),
            tabs: const [
              Tab(text: 'صفحتي'),
              Tab(text: 'حسابي'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _MyPageTab(
                bizContext: bizContext,
                config: config,
                archetype: archetype,
                onOpenSubScreen: _openSubScreen,
              ),
              const AccountTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubScreen(Archetype archetype, {BusinessTypeConfig? config}) {
    final bizContext = ref.watch(businessContextProvider);
    final page = bizContext?.page;
    return switch (_activeSubScreen) {
      _SubScreen.pageInfo => PageInfoEditor(onClose: _closeSubScreen),
      _SubScreen.team => TeamManagement(
          config: config,
          onClose: _closeSubScreen,
        ),
      _SubScreen.availability => AvailabilityManager(
          onClose: _closeSubScreen,
        ),
      _SubScreen.branches => BranchManager(
          onClose: _closeSubScreen,
        ),
      _SubScreen.engagement =>
        EngagementSettings(onClose: _closeSubScreen),
      _SubScreen.cancellation =>
        CancellationPolicy(onClose: _closeSubScreen),
      _SubScreen.returnPolicy =>
        ReturnPolicy(onClose: _closeSubScreen),
      _SubScreen.catalogStrategy =>
        CatalogStrategy(onClose: _closeSubScreen),
      _SubScreen.safety =>
        SafetyDisclaimers(onClose: _closeSubScreen),
      _SubScreen.postBooking =>
        PostBookingSteps(onClose: _closeSubScreen),
      _SubScreen.pageStatus =>
        PageStatusSettings(onClose: _closeSubScreen),
      // ─── New sub-screens ────────────────────────
      _SubScreen.coverage =>
        CoverageSettings(onClose: _closeSubScreen),
      _SubScreen.intakeQuestions => IntakeQuestions(
          onClose: _closeSubScreen,
          title: 'أسئلة ما قبل الحجز',
          questionType: 'service',
        ),
      _SubScreen.quoteFormQuestions => IntakeQuestions(
          onClose: _closeSubScreen,
          title: 'نموذج طلب عرض السعر',
          questionType: 'quote',
        ),
      _SubScreen.packages =>
        PackagesManager(onClose: _closeSubScreen),
      _SubScreen.villaSettings =>
        VillaSettings(onClose: _closeSubScreen),
      _SubScreen.venueSettings =>
        VenueSettings(onClose: _closeSubScreen),
      _SubScreen.tenantDirectory =>
        TenantManager(onClose: _closeSubScreen),
      _SubScreen.alerts =>
        AlertManager(onClose: _closeSubScreen),
      _SubScreen.qrCode => QrCodeSection(
          onClose: _closeSubScreen,
          targets: config?.qrTargets ?? [],
          pageHandle: page?.slug ?? '',
        ),
      _SubScreen.relocation =>
        RelocationSettings(onClose: _closeSubScreen),
      _SubScreen.calendarSync =>
        CalendarSyncSettings(onClose: _closeSubScreen),
      _SubScreen.catalogSync =>
        CatalogSyncSettings(onClose: _closeSubScreen),
      _SubScreen.main => const SizedBox.shrink(),
    };
  }
}

// ═══════════════════════════════════════════════════════════════
// Tab 1: My Page (صفحتي)
// ═══════════════════════════════════════════════════════════════

class _MyPageTab extends StatelessWidget {
  final BusinessContext? bizContext;
  final BusinessTypeConfig? config;
  final Archetype archetype;
  final void Function(_SubScreen) onOpenSubScreen;

  const _MyPageTab({
    required this.bizContext,
    required this.config,
    required this.archetype,
    required this.onOpenSubScreen,
  });

  // ─── Config-driven visibility ─────────────────────────────
  bool get _showOperations => archetype.supportsRequests;
  bool get _showCancellation =>
      config?.dateSelection != DateSelection.none &&
      archetype != Archetype.followOnly &&
      archetype != Archetype.directory;
  bool get _showReturnPolicy =>
      archetype == Archetype.catalogOrder ||
      archetype == Archetype.menuOrder;
  bool get _showCatalogStrategy =>
      archetype == Archetype.catalogOrder ||
      archetype == Archetype.menuOrder;
  bool get _showAvailability =>
      config?.dateSelection != DateSelection.none;
  bool get _showSafety => archetype == Archetype.reservation;
  bool get _showPostBooking => archetype == Archetype.reservation;
  // ─── New visibility conditions ──────────────────────────
  bool get _showCoverage =>
      config?.coverageModel != CoverageModel.none;
  bool get _showIntakeQuestions =>
      archetype == Archetype.serviceBooking;
  bool get _showQuoteFormQuestions =>
      archetype == Archetype.quoteRequest;
  bool get _showPackages =>
      config?.features.any((f) => [
            'subscriptions',
            'punch_cards',
            'recurring_orders',
          ].contains(f)) ??
      false;
  bool get _showVillaSettings =>
      config?.id == 'villa_rental' || config?.id == 'farm_rental';
  bool get _showVenueSettings => config?.id == 'event_venue';
  bool get _showTenantDirectory => archetype == Archetype.directory;
  bool get _showAlerts => archetype == Archetype.followOnly;
  bool get _showQrCode =>
      config?.qrTargets.isNotEmpty ?? false;
  bool get _showCalendarSync =>
      archetype == Archetype.serviceBooking ||
      archetype == Archetype.reservation;
  bool get _showCatalogSync =>
      archetype == Archetype.catalogOrder ||
      archetype == Archetype.menuOrder;

  @override
  Widget build(BuildContext context) {
    final page = bizContext?.page;

    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      children: [
        const SizedBox(height: AppSpacing.lg),

        // ── 1. Page preview card ─────────────────────────────
        if (page != null)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg),
            child: PagePreviewCard(
              page: page,
              archetypeBadge: archetype.displayNameAr,
              onEdit: () => onOpenSubScreen(_SubScreen.pageInfo),
            ),
          ),
        const SizedBox(height: AppSpacing.md),

        // ── 2. حالة الصفحة — Status + Relocation ────────────
        SettingsSection(
          label: 'حالة الصفحة',
          child: Column(
            children: [
              SettingsItem(
                icon: Icons.toggle_on_outlined,
                label: 'حالة الصفحة',
                desc: 'نشطة، مغلقة مؤقتاً، أو مغلقة نهائياً',
                badge: 'نشط',
                badgeColor: AppColors.success,
                onTap: () => onOpenSubScreen(_SubScreen.pageStatus),
              ),
              const SizedBox(height: 6),
              SettingsItem(
                icon: Icons.moving_outlined,
                label: 'الانتقال',
                desc: 'أبلغ متابعيك في حال غيّرت موقعك',
                onTap: () => onOpenSubScreen(_SubScreen.relocation),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // ── 3. معلومات الصفحة — Info, Branches, Payment ─────
        SettingsSection(
          label: 'معلومات الصفحة',
          child: Column(
            children: [
              SettingsItem(
                icon: Icons.edit_outlined,
                label: 'الاسم والشعار والوصف',
                desc: page?.name ?? '',
                onTap: () => onOpenSubScreen(_SubScreen.pageInfo),
              ),
              const SizedBox(height: 6),
              SettingsItem(
                icon: Icons.location_on_outlined,
                label: 'الفروع والمواقع',
                desc: 'إدارة الفروع والتغطية',
                onTap: () => onOpenSubScreen(_SubScreen.branches),
              ),
              const SizedBox(height: 6),
              SettingsItem(
                icon: Icons.payment_outlined,
                label: 'طرق الدفع',
                desc: 'كاش، كليك، أو تحويل بنكي',
                onTap: () => onOpenSubScreen(_SubScreen.pageInfo),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // ── 4. التشغيل — Operations ─────────────────────────
        if (_showOperations) ...[
          SettingsSection(
            label: 'التشغيل',
            child: Column(
              children: [
                SettingsItem(
                  icon: Icons.tune_outlined,
                  label: 'نوع التواجد',
                  desc: 'طلبات مفعّلة — تلقائي',
                  onTap: () =>
                      onOpenSubScreen(_SubScreen.engagement),
                ),
                if (_showCancellation) ...[
                  const SizedBox(height: 6),
                  SettingsItem(
                    icon: Icons.event_busy_outlined,
                    label: 'سياسة الإلغاء',
                    desc: 'يمكن إلغاء الطلبات خلال 24 ساعة',
                    badge: 'مفعّلة',
                    badgeColor: AppColors.success,
                    onTap: () =>
                        onOpenSubScreen(_SubScreen.cancellation),
                  ),
                ],
                if (_showReturnPolicy) ...[
                  const SizedBox(height: 6),
                  SettingsItem(
                    icon: Icons.assignment_return_outlined,
                    label: 'سياسة الإرجاع',
                    desc: 'إرجاع خلال 3 يوم — استبدال فقط',
                    badge: 'مفعّلة',
                    badgeColor: AppColors.success,
                    onTap: () =>
                        onOpenSubScreen(_SubScreen.returnPolicy),
                  ),
                ],
                if (_showCoverage) ...[
                  const SizedBox(height: 6),
                  SettingsItem(
                    icon: Icons.local_shipping_outlined,
                    label: 'مناطق التغطية',
                    desc: 'مناطق التوصيل ورسوم التوصيل',
                    onTap: () =>
                        onOpenSubScreen(_SubScreen.coverage),
                  ),
                ],
                if (_showCatalogStrategy) ...[
                  const SizedBox(height: 6),
                  SettingsItem(
                    icon: Icons.view_list_outlined,
                    label: 'عرض المنتجات',
                    desc: 'كل ما أبيعه مدرج في الصفحة',
                    badge: 'كامل',
                    badgeColor: AppColors.primary,
                    onTap: () =>
                        onOpenSubScreen(_SubScreen.catalogStrategy),
                  ),
                ],
                if (_showPackages) ...[
                  const SizedBox(height: 6),
                  SettingsItem(
                    icon: Icons.card_giftcard_outlined,
                    label: 'الباقات',
                    desc: 'باقات الاشتراك والعروض المجمعة',
                    onTap: () =>
                        onOpenSubScreen(_SubScreen.packages),
                  ),
                ],
                if (_showIntakeQuestions) ...[
                  const SizedBox(height: 6),
                  SettingsItem(
                    icon: Icons.quiz_outlined,
                    label: 'أسئلة ما قبل الحجز',
                    desc: 'أسئلة يجيب عليها العميل عند الحجز',
                    onTap: () =>
                        onOpenSubScreen(_SubScreen.intakeQuestions),
                  ),
                ],
                if (_showQuoteFormQuestions) ...[
                  const SizedBox(height: 6),
                  SettingsItem(
                    icon: Icons.description_outlined,
                    label: 'نموذج طلب عرض السعر',
                    desc: 'أسئلة لفهم احتياج العميل',
                    onTap: () =>
                        onOpenSubScreen(_SubScreen.quoteFormQuestions),
                  ),
                ],
                if (_showVillaSettings) ...[
                  const SizedBox(height: 6),
                  SettingsItem(
                    icon: Icons.villa_outlined,
                    label: 'إعدادات المكان',
                    desc: 'المرافق وقواعد الإقامة والمعرض',
                    onTap: () =>
                        onOpenSubScreen(_SubScreen.villaSettings),
                  ),
                ],
                if (_showVenueSettings) ...[
                  const SizedBox(height: 6),
                  SettingsItem(
                    icon: Icons.event_outlined,
                    label: 'إعدادات القاعة',
                    desc: 'السعة وخيارات التنظيم والعربون',
                    onTap: () =>
                        onOpenSubScreen(_SubScreen.venueSettings),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // ── 5. السلامة — Safety (reservation only) ──────────
        if (_showSafety || _showPostBooking) ...[
          SettingsSection(
            label: 'السلامة',
            child: Column(
              children: [
                if (_showSafety)
                  SettingsItem(
                    icon: Icons.shield_outlined,
                    label: 'تنبيهات السلامة',
                    desc: 'إخلاء مسؤولية وتعليمات السلامة',
                    onTap: () =>
                        onOpenSubScreen(_SubScreen.safety),
                  ),
                if (_showSafety && _showPostBooking)
                  const SizedBox(height: 6),
                if (_showPostBooking)
                  SettingsItem(
                    icon: Icons.checklist_outlined,
                    label: 'خطوات ما بعد الحجز',
                    desc: 'تعليمات للعميل بعد تأكيد الحجز',
                    onTap: () =>
                        onOpenSubScreen(_SubScreen.postBooking),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // ── 6. الفريق — Team ────────────────────────────────
        if (config != null && config!.suggestedRoles.isNotEmpty) ...[
          SettingsSection(
            label: 'الفريق',
            child: SettingsItem(
              icon: Icons.people_outline,
              label: 'إدارة الفريق',
              desc: 'إدارة الأدوار والصلاحيات',
              onTap: () => onOpenSubScreen(_SubScreen.team),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // ── 7. الجدول والمواعيد — Availability ──────────────
        if (_showAvailability) ...[
          SettingsSection(
            label: 'الجدول والمواعيد',
            child: SettingsItem(
              icon: Icons.access_time_outlined,
              label: 'ساعات العمل والمواعيد',
              desc: 'الجدول الأسبوعي والأيام المحظورة',
              onTap: () =>
                  onOpenSubScreen(_SubScreen.availability),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // ── 8. Archetype-specific (directory, follow_only) ──
        if (_showTenantDirectory) ...[
          SettingsSection(
            label: 'إدارة الدليل',
            child: SettingsItem(
              icon: Icons.store_mall_directory_outlined,
              label: 'المستأجرون',
              desc: 'إدارة المحلات والمستأجرين',
              onTap: () =>
                  onOpenSubScreen(_SubScreen.tenantDirectory),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        if (_showAlerts) ...[
          SettingsSection(
            label: 'التنبيهات والإعلانات',
            child: SettingsItem(
              icon: Icons.campaign_outlined,
              label: 'إدارة التنبيهات',
              desc: 'إنشاء ونشر التنبيهات والإعلانات',
              onTap: () => onOpenSubScreen(_SubScreen.alerts),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // ── 9. التسويق والمشاركة — Marketing ────────────────
        SettingsSection(
          label: 'التسويق والمشاركة',
          child: Column(
            children: [
              // Share / Page Link card (inline)
              if (page != null)
                ShareSection(
                  page: page,
                  onOpenQrCode: _showQrCode
                      ? () => onOpenSubScreen(_SubScreen.qrCode)
                      : null,
                ),
              const SizedBox(height: 6),
              SettingsItem(
                icon: Icons.palette_outlined,
                label: 'مظهر الصفحة',
                desc: 'تخصيص الألوان والتصميم',
                onTap: () =>
                    context.showSnackBar('قريباً: مظهر الصفحة'),
              ),
              const SizedBox(height: 6),
              _VerificationCard(page: page),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // ── 10. أدوات — Tools (sync only) ───────────────────
        if (_showCalendarSync || _showCatalogSync) ...[
          SettingsSection(
            label: 'أدوات',
            child: Column(
              children: [
                if (_showCalendarSync)
                  SettingsItem(
                    icon: Icons.sync_outlined,
                    label: 'مزامنة التقويم',
                    desc: 'Google Calendar أو Outlook',
                    onTap: () =>
                        onOpenSubScreen(_SubScreen.calendarSync),
                  ),
                if (_showCalendarSync && _showCatalogSync)
                  const SizedBox(height: 6),
                if (_showCatalogSync)
                  SettingsItem(
                    icon: Icons.cloud_sync_outlined,
                    label: 'مزامنة المنتجات',
                    desc: 'Shopify أو WooCommerce أو API',
                    onTap: () =>
                        onOpenSubScreen(_SubScreen.catalogSync),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // ── 11. إحصائيات سريعة ──────────────────────────────
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: const QuickStatsCard(),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Verification Card (standalone)
// ═══════════════════════════════════════════════════════════════

class _VerificationCard extends StatelessWidget {
  final dynamic page;

  const _VerificationCard({this.page});

  @override
  Widget build(BuildContext context) {
    final isVerified = (page?.isVerified as bool?) ?? false;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isVerified
            ? AppColors.primary.withValues(alpha: 0.05)
            : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isVerified
              ? AppColors.primary.withValues(alpha: 0.15)
              : Colors.grey.shade100,
        ),
      ),
      child: Row(
        children: [
          if (!isVerified)
            TextButton(
              onPressed: () =>
                  context.showSnackBar('قريباً: طلب التوثيق'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor:
                    AppColors.primary.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'توثيق الآن',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          if (isVerified)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'موثّقة',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'التوثيق',
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                isVerified
                    ? 'صفحتك تحمل شارة التوثيق'
                    : 'احصل على شارة التوثيق لزيادة الثقة',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.sm),
          Icon(
            Icons.verified,
            size: 22,
            color: isVerified ? AppColors.primary : Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
