// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_sub_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PageHoursImpl _$$PageHoursImplFromJson(Map<String, dynamic> json) =>
    _$PageHoursImpl(
      openTime: json['open_time'] as String?,
      closeTime: json['close_time'] as String?,
      openDays:
          (json['open_days'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PageHoursImplToJson(_$PageHoursImpl instance) =>
    <String, dynamic>{
      'open_time': instance.openTime,
      'close_time': instance.closeTime,
      'open_days': instance.openDays,
    };

_$TemporarilyClosedImpl _$$TemporarilyClosedImplFromJson(
  Map<String, dynamic> json,
) => _$TemporarilyClosedImpl(
  reason: json['reason'] as String?,
  reopenDate: json['reopen_date'] as String?,
);

Map<String, dynamic> _$$TemporarilyClosedImplToJson(
  _$TemporarilyClosedImpl instance,
) => <String, dynamic>{
  'reason': instance.reason,
  'reopen_date': instance.reopenDate,
};

_$RelocatedImpl _$$RelocatedImplFromJson(Map<String, dynamic> json) =>
    _$RelocatedImpl(
      newAddress: json['new_address'] as String?,
      mapUrl: json['map_url'] as String?,
    );

Map<String, dynamic> _$$RelocatedImplToJson(_$RelocatedImpl instance) =>
    <String, dynamic>{
      'new_address': instance.newAddress,
      'map_url': instance.mapUrl,
    };

_$BranchImpl _$$BranchImplFromJson(Map<String, dynamic> json) => _$BranchImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  address: json['address'] as String?,
  phone: json['phone'] as String?,
  hours: json['hours'] as String?,
  city: json['city'] as String?,
  neighborhood: json['neighborhood'] as String?,
  coverage:
      (json['coverage'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  lat: (json['lat'] as num?)?.toDouble(),
  lng: (json['lng'] as num?)?.toDouble(),
  venueId: json['venue_id'] as String?,
  venueName: json['venue_name'] as String?,
  venueFloor: json['venue_floor'] as String?,
  venueUnit: json['venue_unit'] as String?,
);

Map<String, dynamic> _$$BranchImplToJson(_$BranchImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'hours': instance.hours,
      'city': instance.city,
      'neighborhood': instance.neighborhood,
      'coverage': instance.coverage,
      'lat': instance.lat,
      'lng': instance.lng,
      'venue_id': instance.venueId,
      'venue_name': instance.venueName,
      'venue_floor': instance.venueFloor,
      'venue_unit': instance.venueUnit,
    };

_$CoverageZoneImpl _$$CoverageZoneImplFromJson(Map<String, dynamic> json) =>
    _$CoverageZoneImpl(
      city: json['city'] as String,
      areas:
          (json['areas'] as List<dynamic>?)
              ?.map((e) => CoverageArea.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CoverageZoneImplToJson(_$CoverageZoneImpl instance) =>
    <String, dynamic>{'city': instance.city, 'areas': instance.areas};

_$CoverageAreaImpl _$$CoverageAreaImplFromJson(Map<String, dynamic> json) =>
    _$CoverageAreaImpl(
      name: json['name'] as String,
      neighbourhoods:
          (json['neighbourhoods'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CoverageAreaImplToJson(_$CoverageAreaImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'neighbourhoods': instance.neighbourhoods,
    };

_$ReturnPolicyImpl _$$ReturnPolicyImplFromJson(Map<String, dynamic> json) =>
    _$ReturnPolicyImpl(
      acceptsReturns: json['accepts_returns'] as bool? ?? false,
      windowDays: (json['window_days'] as num?)?.toInt(),
      type: json['type'] as String?,
      cost: json['cost'] as String?,
      conditionsAr:
          (json['conditions_ar'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ReturnPolicyImplToJson(_$ReturnPolicyImpl instance) =>
    <String, dynamic>{
      'accepts_returns': instance.acceptsReturns,
      'window_days': instance.windowDays,
      'type': instance.type,
      'cost': instance.cost,
      'conditions_ar': instance.conditionsAr,
    };

_$ExternalLinkImpl _$$ExternalLinkImplFromJson(Map<String, dynamic> json) =>
    _$ExternalLinkImpl(
      platform: json['platform'] as String,
      label: json['label'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$ExternalLinkImplToJson(_$ExternalLinkImpl instance) =>
    <String, dynamic>{
      'platform': instance.platform,
      'label': instance.label,
      'url': instance.url,
    };

_$PriceChangeImpl _$$PriceChangeImplFromJson(Map<String, dynamic> json) =>
    _$PriceChangeImpl(
      direction: json['direction'] as String,
      method: json['method'] as String,
      value: (json['value'] as num).toInt(),
      scope: json['scope'] as String?,
      reason: json['reason'] as String?,
      status: json['status'] as String? ?? 'active',
    );

Map<String, dynamic> _$$PriceChangeImplToJson(_$PriceChangeImpl instance) =>
    <String, dynamic>{
      'direction': instance.direction,
      'method': instance.method,
      'value': instance.value,
      'scope': instance.scope,
      'reason': instance.reason,
      'status': instance.status,
    };

_$PackageImpl _$$PackageImplFromJson(Map<String, dynamic> json) =>
    _$PackageImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      priceCents: (json['price_cents'] as num).toInt(),
      credits: (json['credits'] as num?)?.toInt() ?? 0,
      creditLabel: json['credit_label'] as String?,
      validityMonths: (json['validity_months'] as num?)?.toInt(),
      icon: json['icon'] as String? ?? 'package',
      compareSinglePrice: (json['compare_single_price'] as num?)?.toInt(),
      active: json['active'] as bool? ?? true,
      model: json['model'] as String? ?? 'visits_and_date',
      items:
          (json['items'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      category: json['category'] as String?,
    );

Map<String, dynamic> _$$PackageImplToJson(_$PackageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price_cents': instance.priceCents,
      'credits': instance.credits,
      'credit_label': instance.creditLabel,
      'validity_months': instance.validityMonths,
      'icon': instance.icon,
      'compare_single_price': instance.compareSinglePrice,
      'active': instance.active,
      'model': instance.model,
      'items': instance.items,
      'category': instance.category,
    };

_$AmenityImpl _$$AmenityImplFromJson(Map<String, dynamic> json) =>
    _$AmenityImpl(icon: json['icon'] as String, label: json['label'] as String);

Map<String, dynamic> _$$AmenityImplToJson(_$AmenityImpl instance) =>
    <String, dynamic>{'icon': instance.icon, 'label': instance.label};

_$VillaPricingImpl _$$VillaPricingImplFromJson(Map<String, dynamic> json) =>
    _$VillaPricingImpl(
      weekdayCents: (json['weekday_cents'] as num).toInt(),
      weekendCents: (json['weekend_cents'] as num).toInt(),
      currency: json['currency'] as String? ?? 'JOD',
    );

Map<String, dynamic> _$$VillaPricingImplToJson(_$VillaPricingImpl instance) =>
    <String, dynamic>{
      'weekday_cents': instance.weekdayCents,
      'weekend_cents': instance.weekendCents,
      'currency': instance.currency,
    };

_$ServiceOfferedImpl _$$ServiceOfferedImplFromJson(Map<String, dynamic> json) =>
    _$ServiceOfferedImpl(
      name: json['name'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$ServiceOfferedImplToJson(
  _$ServiceOfferedImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
};

_$PriceRangeImpl _$$PriceRangeImplFromJson(Map<String, dynamic> json) =>
    _$PriceRangeImpl(
      minCents: (json['min_cents'] as num).toInt(),
      maxCents: (json['max_cents'] as num).toInt(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$PriceRangeImplToJson(_$PriceRangeImpl instance) =>
    <String, dynamic>{
      'min_cents': instance.minCents,
      'max_cents': instance.maxCents,
      'note': instance.note,
    };

_$PageAlertImpl _$$PageAlertImplFromJson(Map<String, dynamic> json) =>
    _$PageAlertImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      priority: json['priority'] as String? ?? 'info',
      areas:
          (json['areas'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
    );

Map<String, dynamic> _$$PageAlertImplToJson(_$PageAlertImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'priority': instance.priority,
      'areas': instance.areas,
    };

_$ServiceLinkImpl _$$ServiceLinkImplFromJson(Map<String, dynamic> json) =>
    _$ServiceLinkImpl(
      label: json['label'] as String,
      url: json['url'] as String,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$$ServiceLinkImplToJson(_$ServiceLinkImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'url': instance.url,
      'type': instance.type,
    };

_$PageStoryImpl _$$PageStoryImplFromJson(Map<String, dynamic> json) =>
    _$PageStoryImpl(
      id: json['id'] as String,
      imageUrl: json['image_url'] as String,
      duration: (json['duration'] as num?)?.toInt() ?? 5,
      createdAt: (json['created_at'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PageStoryImplToJson(_$PageStoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image_url': instance.imageUrl,
      'duration': instance.duration,
      'created_at': instance.createdAt,
    };

_$BlockedDateImpl _$$BlockedDateImplFromJson(Map<String, dynamic> json) =>
    _$BlockedDateImpl(
      date: json['date'] as String,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$$BlockedDateImplToJson(_$BlockedDateImpl instance) =>
    <String, dynamic>{'date': instance.date, 'reason': instance.reason};

_$MallAnnouncementImpl _$$MallAnnouncementImplFromJson(
  Map<String, dynamic> json,
) => _$MallAnnouncementImpl(
  id: json['id'] as String,
  type: json['type'] as String,
  title: json['title'] as String,
  body: json['body'] as String,
  badge: json['badge'] as String?,
  validUntil: json['valid_until'] as String?,
);

Map<String, dynamic> _$$MallAnnouncementImplToJson(
  _$MallAnnouncementImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'title': instance.title,
  'body': instance.body,
  'badge': instance.badge,
  'valid_until': instance.validUntil,
};

_$DirectoryStatsImpl _$$DirectoryStatsImplFromJson(Map<String, dynamic> json) =>
    _$DirectoryStatsImpl(
      totalTenants: (json['total_tenants'] as num?)?.toInt() ?? 0,
      onHonak: (json['on_honak'] as num?)?.toInt() ?? 0,
      openNow: (json['open_now'] as num?)?.toInt() ?? 0,
      floors: (json['floors'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DirectoryStatsImplToJson(
  _$DirectoryStatsImpl instance,
) => <String, dynamic>{
  'total_tenants': instance.totalTenants,
  'on_honak': instance.onHonak,
  'open_now': instance.openNow,
  'floors': instance.floors,
};
