import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:honak/features/business/insights/domain/entities/insight_entities.dart';
import 'package:honak/features/business/insights/domain/insight_chart_config.dart';
import 'package:honak/features/business/insights/presentation/providers/insights_provider.dart';
import 'package:honak/features/business/insights/presentation/widgets/booking_calendar.dart';
import 'package:honak/features/business/insights/presentation/widgets/directory_dashboard_section.dart';
import 'package:honak/features/business/insights/presentation/widgets/directory_insights_cards.dart';
import 'package:honak/features/business/insights/presentation/widgets/distribution_chart.dart';
import 'package:honak/features/business/insights/presentation/widgets/insight_section_block.dart';
import 'package:honak/features/business/insights/presentation/widgets/modifier_analytics.dart';
import 'package:honak/features/business/insights/presentation/widgets/ranked_list.dart';
import 'package:honak/features/business/insights/presentation/widgets/revenue_chart.dart';
import 'package:honak/features/business/insights/presentation/widgets/smart_tips_section.dart';
import 'package:honak/shared/providers/business_page_provider.dart';
import 'package:shimmer/shimmer.dart';

class BusinessInsightsPage extends ConsumerWidget {
  const BusinessInsightsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bizContext = ref.watch(businessContextProvider);

    // Directory archetype keeps existing specialized insights
    if (bizContext != null && bizContext.archetype == Archetype.directory) {
      return _DirectoryInsightsContent(pageId: bizContext.page.id);
    }

    // All other archetypes get the full insights screen
    if (bizContext == null) return const SizedBox.shrink();

    return _FullInsightsScreen(
      pageId: bizContext.page.id,
      archetypeKey: bizContext.archetype.key,
      typeNameAr: bizContext.config?.nameAr ?? '',
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Full Insights Screen (replaces placeholder for non-directory)
// ═══════════════════════════════════════════════════════════════

class _FullInsightsScreen extends ConsumerWidget {
  final String pageId;
  final String archetypeKey;
  final String typeNameAr;

  const _FullInsightsScreen({
    required this.pageId,
    required this.archetypeKey,
    required this.typeNameAr,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(insightsPeriodProvider);
    final insightsAsync = ref.watch(insightsDataProvider(pageId));

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Sticky header
          _StickyHeader(
            typeNameAr: typeNameAr,
            period: period,
            onPeriodChanged: (p) =>
                ref.read(insightsPeriodProvider.notifier).state = p,
          ),
          // Content
          Expanded(
            child: insightsAsync.when(
              loading: () => const _InsightsSkeleton(),
              error: (_, __) => Center(
                child: Text(context.l10n.insightsLoadError),
              ),
              data: (data) => _InsightsContent(
                data: data,
                archetypeKey: archetypeKey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Sticky Header
// ═══════════════════════════════════════════════════════════════

class _StickyHeader extends StatelessWidget {
  final String typeNameAr;
  final InsightPeriod period;
  final ValueChanged<InsightPeriod> onPeriodChanged;

  const _StickyHeader({
    required this.typeNameAr,
    required this.period,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        bottom: 12,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
      ),
      child: Column(
        children: [
          // Title row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.insightsTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.bar_chart_rounded, size: 16, color: Color(0xFF1A73E8)),
                  const SizedBox(width: 6),
                  Text(
                    typeNameAr,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Period tabs
          Row(
            children: InsightPeriod.values.map((p) {
              final isSelected = p == period;
              return Padding(
                padding: const EdgeInsetsDirectional.only(end: 8),
                child: GestureDetector(
                  onTap: () => onPeriodChanged(p),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF1A73E8)
                          : const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      p.label(context.l10n),
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? Colors.white : const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Insights Content — renders all sections based on data + archetype
// ═══════════════════════════════════════════════════════════════

class _InsightsContent extends StatelessWidget {
  final InsightsData data;
  final String archetypeKey;

  const _InsightsContent({
    required this.data,
    required this.archetypeKey,
  });

  @override
  Widget build(BuildContext context) {
    final visibility = getChartVisibility(archetypeKey);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      children: [
        // 1. First KPI section (overview — always first)
        if (data.kpiSections.isNotEmpty)
          InsightSectionBlock(section: data.kpiSections.first),

        // 2. Revenue chart (conditional)
        if (visibility.showRevenueChart && data.revenueChart != null) ...[
          const SizedBox(height: 20),
          RevenueChart(data: data.revenueChart!),
        ],

        // 3. Ranked list (conditional)
        if (visibility.showRankedList && data.topItems != null) ...[
          const SizedBox(height: 20),
          RankedList(data: data.topItems!),
        ],

        // 4. Remaining KPI sections (index 1+)
        for (var i = 1; i < data.kpiSections.length; i++) ...[
          const SizedBox(height: 20),
          InsightSectionBlock(section: data.kpiSections[i]),
        ],

        // 5. Distribution chart (conditional)
        if (visibility.showDistribution && data.distribution != null) ...[
          const SizedBox(height: 20),
          DistributionChart(data: data.distribution!),
        ],

        // 6. Smart tips
        if (data.tips.isNotEmpty) ...[
          const SizedBox(height: 20),
          SmartTipsSection(tips: data.tips),
        ],

        // 7. Modifier Analytics (menu_order only)
        if (archetypeKey == 'menu_order') ...[
          const SizedBox(height: 20),
          const ModifierAnalytics(),
        ],

        // 8. Booking Calendar (service_booking + reservation)
        if (archetypeKey == 'service_booking' || archetypeKey == 'reservation') ...[
          const SizedBox(height: 20),
          const BookingCalendar(),
        ],

        // Bottom clearance for nav
        const SizedBox(height: 100),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Skeleton loading
// ═══════════════════════════════════════════════════════════════

class _InsightsSkeleton extends StatelessWidget {
  const _InsightsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE5E7EB),
      highlightColor: const Color(0xFFF9FAFB),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          // KPI grid skeleton (2x2)
          _shimmerBox(height: 14, width: 80),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: _shimmerBox(height: 90)),
            const SizedBox(width: 8),
            Expanded(child: _shimmerBox(height: 90)),
          ]),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: _shimmerBox(height: 90)),
            const SizedBox(width: 8),
            Expanded(child: _shimmerBox(height: 90)),
          ]),
          const SizedBox(height: 20),
          // Chart skeleton
          _shimmerBox(height: 260),
          const SizedBox(height: 20),
          // Ranked list skeleton
          _shimmerBox(height: 200),
          const SizedBox(height: 20),
          // More KPI skeleton
          _shimmerBox(height: 14, width: 100),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: _shimmerBox(height: 90)),
            const SizedBox(width: 8),
            Expanded(child: _shimmerBox(height: 90)),
          ]),
        ],
      ),
    );
  }

  Widget _shimmerBox({required double height, double? width}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Directory Insights (preserved from original)
// ═══════════════════════════════════════════════════════════════

class _DirectoryInsightsContent extends ConsumerWidget {
  final String pageId;

  const _DirectoryInsightsContent({required this.pageId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashData = ref.watch(dashboardStatsProvider(pageId));

    return dashData.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => Center(
        child: Text(context.l10n.insightsDataLoadError),
      ),
      data: (data) {
        return ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            DirectoryDashboardSection(data: data),
            const SizedBox(height: AppSpacing.xl),
            if (data['insights'] != null)
              DirectoryInsightsCards(
                insights: data['insights'] as Map<String, dynamic>,
              ),
          ],
        );
      },
    );
  }
}
