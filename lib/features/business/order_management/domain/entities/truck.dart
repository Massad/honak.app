import 'package:freezed_annotation/freezed_annotation.dart';

part 'truck.freezed.dart';
part 'truck.g.dart';

// ═══════════════════════════════════════════════════════════════
// Enums
// ═══════════════════════════════════════════════════════════════

enum TruckStatus {
  @JsonValue('not_started')
  notStarted,
  @JsonValue('on_route')
  onRoute,
  @JsonValue('route_complete')
  routeComplete,
}

enum QueueItemStatus {
  delivered,
  current,
  pending,
  skipped,
  failed,
}

enum OrderSource {
  @JsonValue('recurring_auto')
  recurringAuto,
  @JsonValue('app_order')
  appOrder,
  @JsonValue('walk_up')
  walkUp,
  @JsonValue('phone_call')
  phoneCall,
  balcony,
  whatsapp,
  @JsonValue('ad_hoc')
  adHoc,
}

enum PaymentType {
  credits,
  cash,
  @JsonValue('on_account')
  onAccount,
}

// ═══════════════════════════════════════════════════════════════
// Truck
// ═══════════════════════════════════════════════════════════════

@freezed
class Truck with _$Truck {
  const factory Truck({
    required String id,
    required String name,
    @JsonKey(name: 'driver_name') required String driverName,
    @JsonKey(name: 'driver_phone') required String driverPhone,
    @JsonKey(name: 'assigned_driver_ids')
    @Default([])
    List<String> assignedDriverIds,
    required String color,
    @JsonKey(name: 'capacity_full') required int capacityFull,
    @JsonKey(name: 'capacity_empty') required int capacityEmpty,
    @JsonKey(name: 'delivery_days') @Default([]) List<String> deliveryDays,
    @JsonKey(name: 'route_window') RouteWindow? routeWindow,
    @Default([]) List<TruckZone> zones,
    required TruckToday today,
  }) = _Truck;

  factory Truck.fromJson(Map<String, dynamic> json) => _$TruckFromJson(json);
}

// ═══════════════════════════════════════════════════════════════
// TruckToday
// ═══════════════════════════════════════════════════════════════

@freezed
class TruckToday with _$TruckToday {
  const factory TruckToday({
    required TruckStatus status,
    @JsonKey(name: 'started_at') String? startedAt,
    @JsonKey(name: 'ended_at') String? endedAt,
    @JsonKey(name: 'current_full') @Default(0) int currentFull,
    @JsonKey(name: 'current_empty') @Default(0) int currentEmpty,
    @JsonKey(name: 'delivered_count') @Default(0) int deliveredCount,
    @JsonKey(name: 'remaining_count') @Default(0) int remainingCount,
    @Default(0) int reloads,
  }) = _TruckToday;

  factory TruckToday.fromJson(Map<String, dynamic> json) =>
      _$TruckTodayFromJson(json);
}

// ═══════════════════════════════════════════════════════════════
// RouteWindow
// ═══════════════════════════════════════════════════════════════

@freezed
class RouteWindow with _$RouteWindow {
  const factory RouteWindow({
    required String start,
    required String end,
  }) = _RouteWindow;

  factory RouteWindow.fromJson(Map<String, dynamic> json) =>
      _$RouteWindowFromJson(json);
}

// ═══════════════════════════════════════════════════════════════
// TruckZone
// ═══════════════════════════════════════════════════════════════

@freezed
class TruckZone with _$TruckZone {
  const factory TruckZone({
    required String id,
    required String name,
    @Default([]) List<LatLng> polygon,
    @JsonKey(name: 'approximate_area_km2') @Default(0) double approximateAreaKm2,
    @Default('') String label,
  }) = _TruckZone;

  factory TruckZone.fromJson(Map<String, dynamic> json) =>
      _$TruckZoneFromJson(json);
}

// ═══════════════════════════════════════════════════════════════
// LatLng
// ═══════════════════════════════════════════════════════════════

@freezed
class LatLng with _$LatLng {
  const factory LatLng({
    required double lat,
    required double lng,
  }) = _LatLng;

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
}

// ═══════════════════════════════════════════════════════════════
// QueueItem
// ═══════════════════════════════════════════════════════════════

@freezed
class QueueItem with _$QueueItem {
  const factory QueueItem({
    required int position,
    required QueueItemStatus status,
    @JsonKey(name: 'customer_name') required String customerName,
    @JsonKey(name: 'customer_phone') required String customerPhone,
    required String address,
    LatLng? coordinates,
    @Default([]) List<QueueOrderItem> items,
    required OrderSource source,
    required PaymentType payment,
    @JsonKey(name: 'delivered_at') String? deliveredAt,
    @JsonKey(name: 'full_delivered') int? fullDelivered,
    @JsonKey(name: 'empties_collected') int? emptiesCollected,
    @JsonKey(name: 'credits_before') int? creditsBefore,
    @JsonKey(name: 'credits_after') int? creditsAfter,
    @JsonKey(name: 'cash_collected') double? cashCollected,
    @JsonKey(name: 'skip_reason') String? skipReason,
    @JsonKey(name: 'rescheduled_to') String? rescheduledTo,
    String? notes,
    @JsonKey(name: 'credits_remaining') int? creditsRemaining,
    @JsonKey(name: 'recurring_label') String? recurringLabel,
    @JsonKey(name: 'is_new_customer') @Default(false) bool isNewCustomer,
    @JsonKey(name: 'actual_payment') PaymentType? actualPayment,
    @JsonKey(name: 'delivery_note') String? deliveryNote,
  }) = _QueueItem;

  factory QueueItem.fromJson(Map<String, dynamic> json) =>
      _$QueueItemFromJson(json);
}

// ═══════════════════════════════════════════════════════════════
// QueueOrderItem (items within a queue entry)
// ═══════════════════════════════════════════════════════════════

@freezed
class QueueOrderItem with _$QueueOrderItem {
  const factory QueueOrderItem({
    required String name,
    required int qty,
  }) = _QueueOrderItem;

  factory QueueOrderItem.fromJson(Map<String, dynamic> json) =>
      _$QueueOrderItemFromJson(json);
}

// ═══════════════════════════════════════════════════════════════
// RouteData (a day's queue for one truck)
// ═══════════════════════════════════════════════════════════════

@freezed
class RouteData with _$RouteData {
  const factory RouteData({
    @JsonKey(name: 'truck_id') @Default('') String truckId,
    required String date,
    @Default([]) List<QueueItem> queue,
  }) = _RouteData;

  factory RouteData.fromJson(Map<String, dynamic> json) =>
      _$RouteDataFromJson(json);
}

// ═══════════════════════════════════════════════════════════════
// RouteSummary (end-of-day stats)
// ═══════════════════════════════════════════════════════════════

@freezed
class RouteSummary with _$RouteSummary {
  const factory RouteSummary({
    @JsonKey(name: 'duration_minutes') @Default(0) int durationMinutes,
    @JsonKey(name: 'loaded_full') @Default(0) int loadedFull,
    @Default(0) int reloads,
    @JsonKey(name: 'total_delivered') @Default(0) int totalDelivered,
    @JsonKey(name: 'total_skipped') @Default(0) int totalSkipped,
    @JsonKey(name: 'total_failed') @Default(0) int totalFailed,
    @JsonKey(name: 'empties_collected') @Default(0) int emptiesCollected,
    RouteSummaryRevenue? revenue,
    @Default({}) Map<String, int> sources,
  }) = _RouteSummary;

  factory RouteSummary.fromJson(Map<String, dynamic> json) =>
      _$RouteSummaryFromJson(json);
}

@freezed
class RouteSummaryRevenue with _$RouteSummaryRevenue {
  const factory RouteSummaryRevenue({
    @JsonKey(name: 'prepaid_units') @Default(0) int prepaidUnits,
    @JsonKey(name: 'cash_jod') @Default(0) double cashJod,
    @JsonKey(name: 'cash_units') @Default(0) int cashUnits,
    @JsonKey(name: 'on_account_units') @Default(0) int onAccountUnits,
  }) = _RouteSummaryRevenue;

  factory RouteSummaryRevenue.fromJson(Map<String, dynamic> json) =>
      _$RouteSummaryRevenueFromJson(json);
}

// ═══════════════════════════════════════════════════════════════
// RouteHistoryEntry
// ═══════════════════════════════════════════════════════════════

@freezed
class RouteHistoryEntry with _$RouteHistoryEntry {
  const factory RouteHistoryEntry({
    required String date,
    @JsonKey(name: 'truck_id') required String truckId,
    required String driver,
    @JsonKey(name: 'started_at') required String startedAt,
    @JsonKey(name: 'ended_at') required String endedAt,
    @JsonKey(name: 'duration_minutes') @Default(0) int durationMinutes,
    @JsonKey(name: 'loaded_full') @Default(0) int loadedFull,
    @Default(0) int reloads,
    @JsonKey(name: 'total_delivered') @Default(0) int totalDelivered,
    @JsonKey(name: 'total_skipped') @Default(0) int totalSkipped,
    @JsonKey(name: 'total_failed') @Default(0) int totalFailed,
    @JsonKey(name: 'empties_collected') @Default(0) int emptiesCollected,
    RouteSummaryRevenue? revenue,
    @Default({}) Map<String, int> sources,
  }) = _RouteHistoryEntry;

  factory RouteHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$RouteHistoryEntryFromJson(json);
}

// ═══════════════════════════════════════════════════════════════
// DeliveryEstimationConfig
// ═══════════════════════════════════════════════════════════════

enum EstimationMode {
  @JsonValue('route_based')
  routeBased,
  @JsonValue('time_estimate')
  timeEstimate,
  @JsonValue('next_route_day')
  nextRouteDay,
}

@freezed
class DeliveryEstimationConfig with _$DeliveryEstimationConfig {
  const factory DeliveryEstimationConfig({
    required EstimationMode mode,
    @JsonKey(name: 'show_queue_position') @Default(false) bool showQueuePosition,
    @JsonKey(name: 'show_driver_contact') @Default(false) bool showDriverContact,
    @JsonKey(name: 'show_live_tracking') @Default(false) bool showLiveTracking,
    @JsonKey(name: 'typical_delivery_window')
    @Default('')
    String typicalDeliveryWindow,
    @JsonKey(name: 'route_days_label') @Default('') String routeDaysLabel,
    @JsonKey(name: 'off_day_message') @Default('') String offDayMessage,
  }) = _DeliveryEstimationConfig;

  factory DeliveryEstimationConfig.fromJson(Map<String, dynamic> json) =>
      _$DeliveryEstimationConfigFromJson(json);
}

// ═══════════════════════════════════════════════════════════════
// RecurringCustomer (for "recurring tomorrow" section)
// ═══════════════════════════════════════════════════════════════

@freezed
class RecurringCustomer with _$RecurringCustomer {
  const factory RecurringCustomer({
    @JsonKey(name: 'customer_name') required String customerName,
    required String phone,
    @Default([]) List<QueueOrderItem> items,
    required String schedule,
    required String area,
  }) = _RecurringCustomer;

  factory RecurringCustomer.fromJson(Map<String, dynamic> json) =>
      _$RecurringCustomerFromJson(json);
}

// ═══════════════════════════════════════════════════════════════
// CustomerInsight
// ═══════════════════════════════════════════════════════════════

@freezed
class CustomerInsight with _$CustomerInsight {
  const factory CustomerInsight({
    required String type,
    @JsonKey(name: 'customer_name') required String customerName,
    required String message,
    required String severity,
  }) = _CustomerInsight;

  factory CustomerInsight.fromJson(Map<String, dynamic> json) =>
      _$CustomerInsightFromJson(json);
}

// ═══════════════════════════════════════════════════════════════
// TruckDeliveryData (full response for a business)
// ═══════════════════════════════════════════════════════════════

@freezed
class TruckDeliveryData with _$TruckDeliveryData {
  const factory TruckDeliveryData({
    @Default([]) List<Truck> trucks,
    @JsonKey(name: 'route_queue') @Default({}) Map<String, RouteData> routeQueue,
    @JsonKey(name: 'delivery_estimation') DeliveryEstimationConfig? deliveryEstimation,
    @JsonKey(name: 'recurring_tomorrow')
    @Default([])
    List<RecurringCustomer> recurringTomorrow,
    @JsonKey(name: 'customer_insights')
    @Default([])
    List<CustomerInsight> customerInsights,
    @JsonKey(name: 'route_history')
    @Default([])
    List<RouteHistoryEntry> routeHistory,
  }) = _TruckDeliveryData;

  factory TruckDeliveryData.fromJson(Map<String, dynamic> json) =>
      _$TruckDeliveryDataFromJson(json);
}

// ═══════════════════════════════════════════════════════════════
// Constants
// ═══════════════════════════════════════════════════════════════

const truckColors = [
  '#1A73E8',
  '#E53935',
  '#43A047',
  '#FF9800',
  '#7B1FA2',
  '#00897B',
];

const sourceLabels = {
  OrderSource.recurringAuto: 'تلقائي',
  OrderSource.appOrder: 'طلب تطبيق',
  OrderSource.walkUp: 'طلب شارع',
  OrderSource.phoneCall: 'اتصال',
  OrderSource.balcony: 'بلكونة',
  OrderSource.whatsapp: 'واتساب',
  OrderSource.adHoc: 'يدوي',
};

const skipReasons = [
  ('customer_not_home', 'العميل غير موجود'),
  ('cant_access', 'لا يمكن الوصول للموقع'),
  ('customer_delay', 'العميل طلب تأجيل'),
  ('out_of_stock', 'نفاد المخزون'),
  ('other', 'سبب آخر'),
];

const skipDestinations = [
  ('end_of_queue', 'نهاية الدور اليوم'),
  ('tomorrow', 'دور الغد'),
  ('remove', 'إزالة من الدور'),
];
