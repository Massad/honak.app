// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'truck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TruckImpl _$$TruckImplFromJson(Map<String, dynamic> json) => _$TruckImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  driverName: json['driver_name'] as String,
  driverPhone: json['driver_phone'] as String,
  assignedDriverIds:
      (json['assigned_driver_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  color: json['color'] as String,
  capacityFull: (json['capacity_full'] as num).toInt(),
  capacityEmpty: (json['capacity_empty'] as num).toInt(),
  deliveryDays:
      (json['delivery_days'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  routeWindow: json['route_window'] == null
      ? null
      : RouteWindow.fromJson(json['route_window'] as Map<String, dynamic>),
  zones:
      (json['zones'] as List<dynamic>?)
          ?.map((e) => TruckZone.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  today: TruckToday.fromJson(json['today'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$TruckImplToJson(_$TruckImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'driver_name': instance.driverName,
      'driver_phone': instance.driverPhone,
      'assigned_driver_ids': instance.assignedDriverIds,
      'color': instance.color,
      'capacity_full': instance.capacityFull,
      'capacity_empty': instance.capacityEmpty,
      'delivery_days': instance.deliveryDays,
      'route_window': instance.routeWindow,
      'zones': instance.zones,
      'today': instance.today,
    };

_$TruckTodayImpl _$$TruckTodayImplFromJson(Map<String, dynamic> json) =>
    _$TruckTodayImpl(
      status: $enumDecode(_$TruckStatusEnumMap, json['status']),
      startedAt: json['started_at'] as String?,
      endedAt: json['ended_at'] as String?,
      currentFull: (json['current_full'] as num?)?.toInt() ?? 0,
      currentEmpty: (json['current_empty'] as num?)?.toInt() ?? 0,
      deliveredCount: (json['delivered_count'] as num?)?.toInt() ?? 0,
      remainingCount: (json['remaining_count'] as num?)?.toInt() ?? 0,
      reloads: (json['reloads'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$TruckTodayImplToJson(_$TruckTodayImpl instance) =>
    <String, dynamic>{
      'status': _$TruckStatusEnumMap[instance.status]!,
      'started_at': instance.startedAt,
      'ended_at': instance.endedAt,
      'current_full': instance.currentFull,
      'current_empty': instance.currentEmpty,
      'delivered_count': instance.deliveredCount,
      'remaining_count': instance.remainingCount,
      'reloads': instance.reloads,
    };

const _$TruckStatusEnumMap = {
  TruckStatus.notStarted: 'not_started',
  TruckStatus.onRoute: 'on_route',
  TruckStatus.routeComplete: 'route_complete',
};

_$RouteWindowImpl _$$RouteWindowImplFromJson(Map<String, dynamic> json) =>
    _$RouteWindowImpl(
      start: json['start'] as String,
      end: json['end'] as String,
    );

Map<String, dynamic> _$$RouteWindowImplToJson(_$RouteWindowImpl instance) =>
    <String, dynamic>{'start': instance.start, 'end': instance.end};

_$TruckZoneImpl _$$TruckZoneImplFromJson(Map<String, dynamic> json) =>
    _$TruckZoneImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      polygon:
          (json['polygon'] as List<dynamic>?)
              ?.map((e) => LatLng.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      approximateAreaKm2:
          (json['approximate_area_km2'] as num?)?.toDouble() ?? 0,
      label: json['label'] as String? ?? '',
    );

Map<String, dynamic> _$$TruckZoneImplToJson(_$TruckZoneImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'polygon': instance.polygon,
      'approximate_area_km2': instance.approximateAreaKm2,
      'label': instance.label,
    };

_$LatLngImpl _$$LatLngImplFromJson(Map<String, dynamic> json) => _$LatLngImpl(
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
);

Map<String, dynamic> _$$LatLngImplToJson(_$LatLngImpl instance) =>
    <String, dynamic>{'lat': instance.lat, 'lng': instance.lng};

_$QueueItemImpl _$$QueueItemImplFromJson(Map<String, dynamic> json) =>
    _$QueueItemImpl(
      position: (json['position'] as num).toInt(),
      status: $enumDecode(_$QueueItemStatusEnumMap, json['status']),
      customerName: json['customer_name'] as String,
      customerPhone: json['customer_phone'] as String,
      address: json['address'] as String,
      coordinates: json['coordinates'] == null
          ? null
          : LatLng.fromJson(json['coordinates'] as Map<String, dynamic>),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => QueueOrderItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      source: $enumDecode(_$OrderSourceEnumMap, json['source']),
      payment: $enumDecode(_$PaymentTypeEnumMap, json['payment']),
      deliveredAt: json['delivered_at'] as String?,
      fullDelivered: (json['full_delivered'] as num?)?.toInt(),
      emptiesCollected: (json['empties_collected'] as num?)?.toInt(),
      creditsBefore: (json['credits_before'] as num?)?.toInt(),
      creditsAfter: (json['credits_after'] as num?)?.toInt(),
      cashCollected: (json['cash_collected'] as num?)?.toDouble(),
      skipReason: json['skip_reason'] as String?,
      rescheduledTo: json['rescheduled_to'] as String?,
      notes: json['notes'] as String?,
      creditsRemaining: (json['credits_remaining'] as num?)?.toInt(),
      recurringLabel: json['recurring_label'] as String?,
      isNewCustomer: json['is_new_customer'] as bool? ?? false,
      actualPayment: $enumDecodeNullable(
        _$PaymentTypeEnumMap,
        json['actual_payment'],
      ),
      deliveryNote: json['delivery_note'] as String?,
    );

Map<String, dynamic> _$$QueueItemImplToJson(_$QueueItemImpl instance) =>
    <String, dynamic>{
      'position': instance.position,
      'status': _$QueueItemStatusEnumMap[instance.status]!,
      'customer_name': instance.customerName,
      'customer_phone': instance.customerPhone,
      'address': instance.address,
      'coordinates': instance.coordinates,
      'items': instance.items,
      'source': _$OrderSourceEnumMap[instance.source]!,
      'payment': _$PaymentTypeEnumMap[instance.payment]!,
      'delivered_at': instance.deliveredAt,
      'full_delivered': instance.fullDelivered,
      'empties_collected': instance.emptiesCollected,
      'credits_before': instance.creditsBefore,
      'credits_after': instance.creditsAfter,
      'cash_collected': instance.cashCollected,
      'skip_reason': instance.skipReason,
      'rescheduled_to': instance.rescheduledTo,
      'notes': instance.notes,
      'credits_remaining': instance.creditsRemaining,
      'recurring_label': instance.recurringLabel,
      'is_new_customer': instance.isNewCustomer,
      'actual_payment': _$PaymentTypeEnumMap[instance.actualPayment],
      'delivery_note': instance.deliveryNote,
    };

const _$QueueItemStatusEnumMap = {
  QueueItemStatus.delivered: 'delivered',
  QueueItemStatus.current: 'current',
  QueueItemStatus.pending: 'pending',
  QueueItemStatus.skipped: 'skipped',
  QueueItemStatus.failed: 'failed',
};

const _$OrderSourceEnumMap = {
  OrderSource.recurringAuto: 'recurring_auto',
  OrderSource.appOrder: 'app_order',
  OrderSource.walkUp: 'walk_up',
  OrderSource.phoneCall: 'phone_call',
  OrderSource.whatsapp: 'whatsapp',
  OrderSource.adHoc: 'ad_hoc',
};

const _$PaymentTypeEnumMap = {
  PaymentType.credits: 'credits',
  PaymentType.cash: 'cash',
  PaymentType.onAccount: 'on_account',
};

_$QueueOrderItemImpl _$$QueueOrderItemImplFromJson(Map<String, dynamic> json) =>
    _$QueueOrderItemImpl(
      name: json['name'] as String,
      qty: (json['qty'] as num).toInt(),
    );

Map<String, dynamic> _$$QueueOrderItemImplToJson(
  _$QueueOrderItemImpl instance,
) => <String, dynamic>{'name': instance.name, 'qty': instance.qty};

_$RouteDataImpl _$$RouteDataImplFromJson(Map<String, dynamic> json) =>
    _$RouteDataImpl(
      truckId: json['truck_id'] as String? ?? '',
      date: json['date'] as String,
      queue:
          (json['queue'] as List<dynamic>?)
              ?.map((e) => QueueItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$RouteDataImplToJson(_$RouteDataImpl instance) =>
    <String, dynamic>{
      'truck_id': instance.truckId,
      'date': instance.date,
      'queue': instance.queue,
    };

_$RouteSummaryImpl _$$RouteSummaryImplFromJson(Map<String, dynamic> json) =>
    _$RouteSummaryImpl(
      durationMinutes: (json['duration_minutes'] as num?)?.toInt() ?? 0,
      loadedFull: (json['loaded_full'] as num?)?.toInt() ?? 0,
      reloads: (json['reloads'] as num?)?.toInt() ?? 0,
      totalDelivered: (json['total_delivered'] as num?)?.toInt() ?? 0,
      totalSkipped: (json['total_skipped'] as num?)?.toInt() ?? 0,
      totalFailed: (json['total_failed'] as num?)?.toInt() ?? 0,
      emptiesCollected: (json['empties_collected'] as num?)?.toInt() ?? 0,
      revenue: json['revenue'] == null
          ? null
          : RouteSummaryRevenue.fromJson(
              json['revenue'] as Map<String, dynamic>,
            ),
      sources:
          (json['sources'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
    );

Map<String, dynamic> _$$RouteSummaryImplToJson(_$RouteSummaryImpl instance) =>
    <String, dynamic>{
      'duration_minutes': instance.durationMinutes,
      'loaded_full': instance.loadedFull,
      'reloads': instance.reloads,
      'total_delivered': instance.totalDelivered,
      'total_skipped': instance.totalSkipped,
      'total_failed': instance.totalFailed,
      'empties_collected': instance.emptiesCollected,
      'revenue': instance.revenue,
      'sources': instance.sources,
    };

_$RouteSummaryRevenueImpl _$$RouteSummaryRevenueImplFromJson(
  Map<String, dynamic> json,
) => _$RouteSummaryRevenueImpl(
  prepaidUnits: (json['prepaid_units'] as num?)?.toInt() ?? 0,
  cashJod: (json['cash_jod'] as num?)?.toDouble() ?? 0,
  cashUnits: (json['cash_units'] as num?)?.toInt() ?? 0,
  onAccountUnits: (json['on_account_units'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$RouteSummaryRevenueImplToJson(
  _$RouteSummaryRevenueImpl instance,
) => <String, dynamic>{
  'prepaid_units': instance.prepaidUnits,
  'cash_jod': instance.cashJod,
  'cash_units': instance.cashUnits,
  'on_account_units': instance.onAccountUnits,
};

_$RouteHistoryEntryImpl _$$RouteHistoryEntryImplFromJson(
  Map<String, dynamic> json,
) => _$RouteHistoryEntryImpl(
  date: json['date'] as String,
  truckId: json['truck_id'] as String,
  driver: json['driver'] as String,
  startedAt: json['started_at'] as String,
  endedAt: json['ended_at'] as String,
  durationMinutes: (json['duration_minutes'] as num?)?.toInt() ?? 0,
  loadedFull: (json['loaded_full'] as num?)?.toInt() ?? 0,
  reloads: (json['reloads'] as num?)?.toInt() ?? 0,
  totalDelivered: (json['total_delivered'] as num?)?.toInt() ?? 0,
  totalSkipped: (json['total_skipped'] as num?)?.toInt() ?? 0,
  totalFailed: (json['total_failed'] as num?)?.toInt() ?? 0,
  emptiesCollected: (json['empties_collected'] as num?)?.toInt() ?? 0,
  revenue: json['revenue'] == null
      ? null
      : RouteSummaryRevenue.fromJson(json['revenue'] as Map<String, dynamic>),
  sources:
      (json['sources'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const {},
);

Map<String, dynamic> _$$RouteHistoryEntryImplToJson(
  _$RouteHistoryEntryImpl instance,
) => <String, dynamic>{
  'date': instance.date,
  'truck_id': instance.truckId,
  'driver': instance.driver,
  'started_at': instance.startedAt,
  'ended_at': instance.endedAt,
  'duration_minutes': instance.durationMinutes,
  'loaded_full': instance.loadedFull,
  'reloads': instance.reloads,
  'total_delivered': instance.totalDelivered,
  'total_skipped': instance.totalSkipped,
  'total_failed': instance.totalFailed,
  'empties_collected': instance.emptiesCollected,
  'revenue': instance.revenue,
  'sources': instance.sources,
};

_$DeliveryEstimationConfigImpl _$$DeliveryEstimationConfigImplFromJson(
  Map<String, dynamic> json,
) => _$DeliveryEstimationConfigImpl(
  mode: $enumDecode(_$EstimationModeEnumMap, json['mode']),
  showQueuePosition: json['show_queue_position'] as bool? ?? false,
  showDriverContact: json['show_driver_contact'] as bool? ?? false,
  showLiveTracking: json['show_live_tracking'] as bool? ?? false,
  typicalDeliveryWindow: json['typical_delivery_window'] as String? ?? '',
  routeDaysLabel: json['route_days_label'] as String? ?? '',
  offDayMessage: json['off_day_message'] as String? ?? '',
);

Map<String, dynamic> _$$DeliveryEstimationConfigImplToJson(
  _$DeliveryEstimationConfigImpl instance,
) => <String, dynamic>{
  'mode': _$EstimationModeEnumMap[instance.mode]!,
  'show_queue_position': instance.showQueuePosition,
  'show_driver_contact': instance.showDriverContact,
  'show_live_tracking': instance.showLiveTracking,
  'typical_delivery_window': instance.typicalDeliveryWindow,
  'route_days_label': instance.routeDaysLabel,
  'off_day_message': instance.offDayMessage,
};

const _$EstimationModeEnumMap = {
  EstimationMode.routeBased: 'route_based',
  EstimationMode.timeEstimate: 'time_estimate',
  EstimationMode.nextRouteDay: 'next_route_day',
};

_$RecurringCustomerImpl _$$RecurringCustomerImplFromJson(
  Map<String, dynamic> json,
) => _$RecurringCustomerImpl(
  customerName: json['customer_name'] as String,
  phone: json['phone'] as String,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => QueueOrderItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  schedule: json['schedule'] as String,
  area: json['area'] as String,
);

Map<String, dynamic> _$$RecurringCustomerImplToJson(
  _$RecurringCustomerImpl instance,
) => <String, dynamic>{
  'customer_name': instance.customerName,
  'phone': instance.phone,
  'items': instance.items,
  'schedule': instance.schedule,
  'area': instance.area,
};

_$CustomerInsightImpl _$$CustomerInsightImplFromJson(
  Map<String, dynamic> json,
) => _$CustomerInsightImpl(
  type: json['type'] as String,
  customerName: json['customer_name'] as String,
  message: json['message'] as String,
  severity: json['severity'] as String,
);

Map<String, dynamic> _$$CustomerInsightImplToJson(
  _$CustomerInsightImpl instance,
) => <String, dynamic>{
  'type': instance.type,
  'customer_name': instance.customerName,
  'message': instance.message,
  'severity': instance.severity,
};

_$TruckDeliveryDataImpl _$$TruckDeliveryDataImplFromJson(
  Map<String, dynamic> json,
) => _$TruckDeliveryDataImpl(
  trucks:
      (json['trucks'] as List<dynamic>?)
          ?.map((e) => Truck.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  routeQueue:
      (json['route_queue'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, RouteData.fromJson(e as Map<String, dynamic>)),
      ) ??
      const {},
  deliveryEstimation: json['delivery_estimation'] == null
      ? null
      : DeliveryEstimationConfig.fromJson(
          json['delivery_estimation'] as Map<String, dynamic>,
        ),
  recurringTomorrow:
      (json['recurring_tomorrow'] as List<dynamic>?)
          ?.map((e) => RecurringCustomer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  customerInsights:
      (json['customer_insights'] as List<dynamic>?)
          ?.map((e) => CustomerInsight.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  routeHistory:
      (json['route_history'] as List<dynamic>?)
          ?.map((e) => RouteHistoryEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$TruckDeliveryDataImplToJson(
  _$TruckDeliveryDataImpl instance,
) => <String, dynamic>{
  'trucks': instance.trucks,
  'route_queue': instance.routeQueue,
  'delivery_estimation': instance.deliveryEstimation,
  'recurring_tomorrow': instance.recurringTomorrow,
  'customer_insights': instance.customerInsights,
  'route_history': instance.routeHistory,
};
