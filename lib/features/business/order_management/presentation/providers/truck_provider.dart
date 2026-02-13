import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/order_management/domain/entities/truck.dart';
import 'package:honak/shared/providers/api_provider.dart';

/// Fetches full truck delivery data for a business page by its slug.
final truckDeliveryDataProvider =
    FutureProvider.family<TruckDeliveryData?, String>((ref, pageSlug) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get<TruckDeliveryData>(
    '/v1/biz/pages/$pageSlug/trucks',
    fromJson: (json) =>
        TruckDeliveryData.fromJson(json as Map<String, dynamic>),
  );
  return response.data;
});

/// Derived: just the trucks list for a page.
final trucksProvider =
    Provider.family<List<Truck>, String>((ref, pageSlug) {
  final data = ref.watch(truckDeliveryDataProvider(pageSlug)).valueOrNull;
  return data?.trucks ?? [];
});

/// Derived: route queue for a specific truck.
final truckRouteQueueProvider =
    Provider.family<RouteData?, ({String pageSlug, String truckId})>(
        (ref, params) {
  final data =
      ref.watch(truckDeliveryDataProvider(params.pageSlug)).valueOrNull;
  return data?.routeQueue[params.truckId];
});

/// Derived: delivery estimation config for a page.
final deliveryEstimationProvider =
    Provider.family<DeliveryEstimationConfig?, String>((ref, pageSlug) {
  final data = ref.watch(truckDeliveryDataProvider(pageSlug)).valueOrNull;
  return data?.deliveryEstimation;
});

/// Derived: recurring customers for tomorrow.
final recurringTomorrowProvider =
    Provider.family<List<RecurringCustomer>, String>((ref, pageSlug) {
  final data = ref.watch(truckDeliveryDataProvider(pageSlug)).valueOrNull;
  return data?.recurringTomorrow ?? [];
});

/// Derived: customer insights.
final customerInsightsProvider =
    Provider.family<List<CustomerInsight>, String>((ref, pageSlug) {
  final data = ref.watch(truckDeliveryDataProvider(pageSlug)).valueOrNull;
  return data?.customerInsights ?? [];
});

/// Derived: route history.
final routeHistoryProvider =
    Provider.family<List<RouteHistoryEntry>, String>((ref, pageSlug) {
  final data = ref.watch(truckDeliveryDataProvider(pageSlug)).valueOrNull;
  return data?.routeHistory ?? [];
});

/// Summary stats across all trucks for a page.
final truckSummaryProvider =
    Provider.family<TruckSummaryStats, String>((ref, pageSlug) {
  final trucks = ref.watch(trucksProvider(pageSlug));
  if (trucks.isEmpty) return const TruckSummaryStats();

  int active = 0;
  int totalDelivered = 0;
  int totalRemaining = 0;

  for (final truck in trucks) {
    if (truck.today.status == TruckStatus.onRoute) active++;
    totalDelivered += truck.today.deliveredCount;
    totalRemaining += truck.today.remainingCount;
  }

  return TruckSummaryStats(
    activeTrucks: active,
    totalDelivered: totalDelivered,
    totalRemaining: totalRemaining,
    totalTrucks: trucks.length,
  );
});

class TruckSummaryStats {
  final int activeTrucks;
  final int totalDelivered;
  final int totalRemaining;
  final int totalTrucks;

  const TruckSummaryStats({
    this.activeTrucks = 0,
    this.totalDelivered = 0,
    this.totalRemaining = 0,
    this.totalTrucks = 0,
  });
}
