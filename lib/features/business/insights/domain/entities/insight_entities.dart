import 'dart:ui';

import 'package:honak/core/l10n/arb/app_localizations.dart';

/// Trend direction for KPI change badges.
enum TrendDirection { up, down, neutral }

/// A single KPI card in the insights screen.
class InsightCardData {
  final String id;
  final String label;
  final String value;
  final String? change;
  final TrendDirection trend;
  final String? icon;

  const InsightCardData({
    required this.id,
    required this.label,
    required this.value,
    this.change,
    this.trend = TrendDirection.neutral,
    this.icon,
  });
}

/// A section of KPI cards grouped by title.
class InsightSectionData {
  final String title;
  final List<InsightCardData> cards;

  const InsightSectionData({
    required this.title,
    required this.cards,
  });
}

/// Labels for charts, resolved per business type.
class ChartLabels {
  final String revenueLabel;
  final String topItemsLabel;
  final String distributionLabel;
  final String revenueTooltip;
  final String summaryLabel;
  final String ordersTooltip;

  const ChartLabels({
    required this.revenueLabel,
    required this.topItemsLabel,
    required this.distributionLabel,
    required this.revenueTooltip,
    required this.summaryLabel,
    required this.ordersTooltip,
  });
}

/// A single data point on the revenue area chart.
class RevenueDataPoint {
  final String label;
  final double revenue;
  final double? subscriptionRevenue;
  final int orders;

  const RevenueDataPoint({
    required this.label,
    required this.revenue,
    this.subscriptionRevenue,
    required this.orders,
  });
}

/// Revenue chart wrapper with metadata.
class RevenueChartData {
  final String label;
  final String summaryLabel;
  final String ordersTooltip;
  final String comparison;
  final TrendDirection comparisonTrend;
  final List<RevenueDataPoint> data;

  const RevenueChartData({
    required this.label,
    required this.summaryLabel,
    required this.ordersTooltip,
    required this.comparison,
    required this.comparisonTrend,
    required this.data,
  });
}

/// A ranked item for the top-items list.
class TopItemDataPoint {
  final String name;
  final int count;
  final String unit;

  const TopItemDataPoint({
    required this.name,
    required this.count,
    required this.unit,
  });
}

/// Top items list wrapper.
class TopItemsData {
  final String label;
  final List<TopItemDataPoint> items;

  const TopItemsData({
    required this.label,
    required this.items,
  });
}

/// A segment of the distribution donut chart.
class DistributionDataPoint {
  final String name;
  final int value;
  final Color color;

  const DistributionDataPoint({
    required this.name,
    required this.value,
    required this.color,
  });
}

/// Distribution chart wrapper.
class DistributionData {
  final String label;
  final List<DistributionDataPoint> segments;

  const DistributionData({
    required this.label,
    required this.segments,
  });
}

/// The complete insights data for a business page + period.
class InsightsData {
  final String pageId;
  final String businessType;
  final String archetype;
  final String period;
  final String periodLabel;
  final List<InsightSectionData> kpiSections;
  final RevenueChartData? revenueChart;
  final TopItemsData? topItems;
  final DistributionData? distribution;
  final List<String> tips;

  const InsightsData({
    required this.pageId,
    required this.businessType,
    required this.archetype,
    required this.period,
    required this.periodLabel,
    required this.kpiSections,
    this.revenueChart,
    this.topItems,
    this.distribution,
    required this.tips,
  });
}

/// Period options for the insights screen.
enum InsightPeriod {
  week,
  month,
  year;

  String label(AppLocalizations l10n) => switch (this) {
        week => l10n.insightsPeriodWeekly,
        month => l10n.insightsPeriodMonthly,
        year => l10n.insightsPeriodYearly,
      };

  String periodLabel(AppLocalizations l10n) => switch (this) {
        week => l10n.insightsPeriodThisWeek,
        month => l10n.insightsPeriodThisMonth,
        year => l10n.insightsPeriodThisYear,
      };

  String comparisonLabel(AppLocalizations l10n) => switch (this) {
        week => l10n.insightsComparedToLastWeek,
        month => l10n.insightsComparedToLastMonth,
        year => l10n.insightsComparedToLastYear,
      };
}
