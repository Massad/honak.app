import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/insights/data/insights_mock_data.dart';
import 'package:honak/features/business/insights/domain/entities/insight_entities.dart';
import 'package:honak/shared/providers/business_page_provider.dart';

/// Current period selection for the insights screen.
final insightsPeriodProvider = StateProvider<InsightPeriod>((ref) {
  return InsightPeriod.week;
});

/// Provides insights data for a given page, reading the current period
/// and business context to resolve the type/archetype.
final insightsDataProvider =
    FutureProvider.family<InsightsData, String>((ref, pageId) async {
  final period = ref.watch(insightsPeriodProvider);
  final bizCtx = ref.watch(businessContextProvider);

  // Simulate API delay
  await Future.delayed(const Duration(milliseconds: 300));

  final businessType = bizCtx?.config?.id ?? 'water_delivery';
  final archetype = bizCtx?.archetype.key ?? 'catalog_order';

  return generateMockInsights(
    pageId: pageId,
    businessType: businessType,
    archetype: archetype,
    period: period,
  );
});
