import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/config/business_type_config.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:honak/features/business/dashboard/presentation/widgets/dashboard_section_content.dart';
import 'package:honak/features/business/dashboard/presentation/widgets/sections/recurring_section.dart';
import 'package:honak/shared/providers/business_page_provider.dart';

class BusinessDashboardPage extends ConsumerWidget {
  const BusinessDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bizContext = ref.watch(businessContextProvider);
    if (bizContext == null) return const SizedBox.shrink();

    final config = bizContext.config;
    final dashboard = config?.dashboard;
    final dashData = ref.watch(dashboardStatsProvider(bizContext.page.id));
    final statsMap =
        dashData.valueOrNull?['stats'] as Map<String, dynamic>?;

    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      children: [
        // Stats row
        if (dashboard != null && dashboard.statsLabels.isNotEmpty)
          _StatsRow(
            stats: dashboard.statsLabels,
            statsData: statsMap,
          ),

        // Quick actions
        if (dashboard != null && dashboard.quickActions.isNotEmpty) ...[
          _SectionTitle(
            title: 'إجراءات سريعة',
            icon: Icons.auto_awesome,
            iconColor: AppColors.secondary,
          ),
          _QuickActionsGrid(actions: dashboard.quickActions),
        ],

        // Dashboard sections
        if (dashboard != null)
          ...dashboard.sections
              .where(
                (s) =>
                    s.type != DashboardSectionType.quickActions,
              )
              .map(
                (section) => _SectionCard(
                  section: section,
                  data: dashData.valueOrNull,
                ),
              ),

        // Recurring customers section
        if (bizContext.archetype.supportsRequests)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
              ),
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: const RecurringCustomersSection(),
            ),
          ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Stat cards with colored backgrounds — matches Figma
// ═══════════════════════════════════════════════════════════════

const _statStyles = [
  (fg: Color(0xFFFF9800), icon: Icons.calendar_today),
  (fg: Color(0xFF1A73E8), icon: Icons.people_alt),
  (fg: Color(0xFF43A047), icon: Icons.visibility),
  (fg: Color(0xFF9C27B0), icon: Icons.trending_up),
];

class _StatsRow extends StatelessWidget {
  final List<DashboardStatLabel> stats;
  final Map<String, dynamic>? statsData;

  const _StatsRow({required this.stats, this.statsData});

  /// Format stat value — handles nested maps and fraction format.
  String _formatStatValue(String key, Map<String, dynamic>? data) {
    if (data == null) return '0';
    final raw = data[key];
    // Fraction: "claimed_tenants" → "18/25" using "total_tenants"
    if (key == 'claimed_tenants' && data.containsKey('total_tenants')) {
      return '${raw ?? 0}/${data['total_tenants'] ?? 0}';
    }
    // Nested map: extract 'value' field
    if (raw is Map) return '${raw['value'] ?? 0}';
    return '${raw ?? 0}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Row(
        children: List.generate(stats.length, (i) {
          final stat = stats[i];
          final style = _statStyles[i % _statStyles.length];

          return Expanded(
            child: Container(
              margin: EdgeInsetsDirectional.only(
                start: i > 0 ? AppSpacing.sm : 0,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.md,
                horizontal: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: style.fg.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Icon(style.icon, size: 18, color: style.fg),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    _formatStatValue(stat.key, statsData),
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: style.fg,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    stat.label,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Quick actions grid — 4 columns, white cards, blue icons
// ═══════════════════════════════════════════════════════════════

class _QuickActionsGrid extends StatelessWidget {
  final List<DashboardAction> actions;

  const _QuickActionsGrid({required this.actions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: AppSpacing.sm,
        crossAxisSpacing: AppSpacing.sm,
        childAspectRatio: 0.95,
        children: actions.map((action) {
          return _QuickActionCard(action: action);
        }).toList(),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final DashboardAction action;

  const _QuickActionCard({required this.action});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => context.showSnackBar('قريباً: ${action.labelAr}'),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _resolveActionIcon(action.icon),
                size: 18,
                color: AppColors.primary,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                action.labelAr,
                style: context.textTheme.labelSmall?.copyWith(
                  fontSize: 9,
                  color: Theme.of(context).colorScheme.onSurface,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _resolveActionIcon(String iconKey) {
    return switch (iconKey) {
      'package' => Icons.inventory_2_outlined,
      'plus' => Icons.add,
      'edit' || 'edit-3' => Icons.edit_outlined,
      'tag' => Icons.label_outlined,
      'camera' => Icons.camera_alt_outlined,
      'user_plus' || 'user-plus' => Icons.person_add_outlined,
      'map-pin' || 'mappin' => Icons.location_on_outlined,
      'message' || 'message-circle' => Icons.chat_outlined,
      'wrench' => Icons.build_outlined,
      'calendar' => Icons.calendar_today_outlined,
      'clock' => Icons.access_time_outlined,
      'bell' => Icons.notifications_outlined,
      'sparkles' => Icons.auto_awesome_outlined,
      'store' => Icons.store_outlined,
      'refresh' => Icons.refresh,
      'eye' => Icons.visibility_outlined,
      _ => Icons.touch_app_outlined,
    };
  }
}

// ═══════════════════════════════════════════════════════════════
// Section card — white card with title + placeholder content
// ═══════════════════════════════════════════════════════════════

class _SectionCard extends StatelessWidget {
  final DashboardSection section;
  final Map<String, dynamic>? data;

  const _SectionCard({required this.section, this.data});

  @override
  Widget build(BuildContext context) {
    final hasData = data != null;
    final customBg = hasCustomBackground(section.type);

    // Sections with custom background render directly without white card
    if (customBg && hasData) {
      return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          0,
        ),
        child: DashboardSectionContent(
          type: section.type,
          data: data!,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    section.titleAr,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  _sectionIcon(section.type),
                  size: 16,
                  color: AppColors.secondary,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            if (hasData)
              DashboardSectionContent(
                type: section.type,
                data: data!,
              )
            else
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.inbox_outlined,
                      size: 28,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'لا توجد بيانات بعد',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 11,
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

  IconData _sectionIcon(DashboardSectionType type) {
    return switch (type) {
      DashboardSectionType.todayRevenue => Icons.payments_outlined,
      DashboardSectionType.pendingOrders => Icons.receipt_long_outlined,
      DashboardSectionType.todaySchedule => Icons.calendar_today_outlined,
      DashboardSectionType.nextAppointment => Icons.event_outlined,
      DashboardSectionType.activeQuotes => Icons.request_quote_outlined,
      DashboardSectionType.deliveryRoute => Icons.route_outlined,
      DashboardSectionType.lowStock => Icons.warning_amber_outlined,
      DashboardSectionType.activeQueue => Icons.queue_outlined,
      DashboardSectionType.liveQueue => Icons.queue_outlined,
      DashboardSectionType.liveDropoff => Icons.receipt_long_outlined,
      DashboardSectionType.occupancy => Icons.meeting_room_outlined,
      DashboardSectionType.bestSellers => Icons.star_outline,
      DashboardSectionType.upcomingReservations => Icons.book_online_outlined,
      DashboardSectionType.recurringTomorrow => Icons.repeat_outlined,
      DashboardSectionType.customerInsights => Icons.person_search_outlined,
      DashboardSectionType.unavailableItems => Icons.cancel_outlined,
      DashboardSectionType.recentlyLinked => Icons.store_outlined,
      _ => Icons.dashboard_outlined,
    };
  }
}

// ═══════════════════════════════════════════════════════════════
// Section title with icon
// ═══════════════════════════════════════════════════════════════

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;

  const _SectionTitle({
    required this.title,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Icon(icon, size: 14, color: iconColor),
        ],
      ),
    );
  }
}
