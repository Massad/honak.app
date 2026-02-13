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
import 'package:honak/features/business/page_settings/presentation/widgets/team_management.dart';
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

  @override
  Widget build(BuildContext context) {
    final page = bizContext?.page;

    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      children: [
        const SizedBox(height: AppSpacing.lg),

        // 1. Page preview card
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

        // 2. Share section
        if (page != null)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg),
            child: ShareSection(page: page),
          ),
        const SizedBox(height: AppSpacing.md),

        // 3. Page status (→ sub-screen)
        SettingsSection(
          label: 'حالة الصفحة',
          child: SettingsItem(
            icon: Icons.toggle_on_outlined,
            label: 'حالة الصفحة',
            desc: 'نشطة، مغلقة مؤقتاً، أو مغلقة نهائياً',
            badge: _statusBadge(context),
            badgeColor: _statusColor(),
            onTap: () => onOpenSubScreen(_SubScreen.pageStatus),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // 4. Page info (info, branches, payment)
        SettingsSection(
          label: 'معلومات الصفحة',
          child: Column(
            children: [
              SettingsItem(
                icon: Icons.edit_outlined,
                label: 'معلومات الصفحة',
                desc: 'الاسم، الشعار، الصورة، الوصف',
                onTap: () => onOpenSubScreen(_SubScreen.pageInfo),
              ),
              const SizedBox(height: 6),
              SettingsItem(
                icon: Icons.location_on_outlined,
                label: 'الفروع',
                desc: 'إدارة فروعك ومواقعك',
                onTap: () => onOpenSubScreen(_SubScreen.branches),
              ),
              const SizedBox(height: 6),
              SettingsItem(
                icon: Icons.payment_outlined,
                label: 'طرق الدفع',
                desc: 'كاش، كليك، أو تحويل بنكي',
                onTap: () =>
                    context.showSnackBar('قريباً: طرق الدفع'),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // 5. Operations (config-driven)
        if (_showOperations) ...[
          SettingsSection(
            label: 'التشغيل',
            child: Column(
              children: [
                SettingsItem(
                  icon: Icons.tune_outlined,
                  label: 'مستوى التواجد',
                  desc: 'تواجد كامل، عرض فقط، أو بسيط',
                  onTap: () =>
                      onOpenSubScreen(_SubScreen.engagement),
                ),
                if (_showCancellation) ...[
                  const SizedBox(height: 6),
                  SettingsItem(
                    icon: Icons.event_busy_outlined,
                    label: 'سياسة الإلغاء',
                    desc: 'نافذة الإلغاء ورسوم عدم الحضور',
                    onTap: () =>
                        onOpenSubScreen(_SubScreen.cancellation),
                  ),
                ],
                if (_showReturnPolicy) ...[
                  const SizedBox(height: 6),
                  SettingsItem(
                    icon: Icons.assignment_return_outlined,
                    label: 'سياسة الإرجاع',
                    desc: 'شروط الإرجاع والاستبدال',
                    onTap: () =>
                        onOpenSubScreen(_SubScreen.returnPolicy),
                  ),
                ],
                if (_showCatalogStrategy) ...[
                  const SizedBox(height: 6),
                  SettingsItem(
                    icon: Icons.view_list_outlined,
                    label: 'استراتيجية الكتالوج',
                    desc: 'كتالوج كامل أو أبرز المنتجات',
                    onTap: () =>
                        onOpenSubScreen(_SubScreen.catalogStrategy),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // 6. Safety (reservation only)
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

        // 7. Team (only when config has suggested roles)
        if (config != null && config!.suggestedRoles.isNotEmpty) ...[
          SettingsSection(
            label: 'الفريق',
            child: SettingsItem(
              icon: Icons.people_outline,
              label: 'فريق العمل',
              desc: 'إدارة أعضاء الفريق والصلاحيات',
              onTap: () => onOpenSubScreen(_SubScreen.team),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // 8. Availability (config-driven)
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

        // 9. Verification card
        if (page != null)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg),
            child: _VerificationCard(page: page),
          ),
        const SizedBox(height: AppSpacing.md),

        // 10. Quick stats
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: const QuickStatsCard(),
        ),
      ],
    );
  }

  String? _statusBadge(BuildContext context) {
    // We can't read the provider here (StatelessWidget), so return null.
    // The status badge could be derived from the page status if available.
    return null;
  }

  Color? _statusColor() {
    return null;
  }
}

// ═══════════════════════════════════════════════════════════════
// Verification Card (standalone)
// ═══════════════════════════════════════════════════════════════

class _VerificationCard extends StatelessWidget {
  final dynamic page;

  const _VerificationCard({required this.page});

  @override
  Widget build(BuildContext context) {
    final isVerified = page.isVerified as bool;

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
