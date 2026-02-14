import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_sub_entities.freezed.dart';
part 'page_sub_entities.g.dart';

/// Hours when a business is open (moved from PageDetail for reuse).
@freezed
class PageHours with _$PageHours {
  const factory PageHours({
    @JsonKey(name: 'open_time') String? openTime,
    @JsonKey(name: 'close_time') String? closeTime,
    @JsonKey(name: 'open_days') @Default([]) List<String> openDays,
  }) = _PageHours;

  factory PageHours.fromJson(Map<String, dynamic> json) =>
      _$PageHoursFromJson(json);
}

/// Temporary closure info.
@freezed
class TemporarilyClosed with _$TemporarilyClosed {
  const factory TemporarilyClosed({
    String? reason,
    @JsonKey(name: 'reopen_date') String? reopenDate,
  }) = _TemporarilyClosed;

  factory TemporarilyClosed.fromJson(Map<String, dynamic> json) =>
      _$TemporarilyClosedFromJson(json);
}

/// Business relocation info with optional map link.
@freezed
class Relocated with _$Relocated {
  const factory Relocated({
    @JsonKey(name: 'new_address') String? newAddress,
    @JsonKey(name: 'map_url') String? mapUrl,
  }) = _Relocated;

  factory Relocated.fromJson(Map<String, dynamic> json) =>
      _$RelocatedFromJson(json);
}

/// Physical branch of a multi-location business.
@freezed
class Branch with _$Branch {
  const factory Branch({
    required String id,
    required String name,
    String? address,
    String? phone,
    String? hours,
    String? city,
    String? neighborhood,
    @Default([]) List<String> coverage,
    double? lat,
    double? lng,
    @JsonKey(name: 'venue_id') String? venueId,
    @JsonKey(name: 'venue_name') String? venueName,
    @JsonKey(name: 'venue_floor') String? venueFloor,
    @JsonKey(name: 'venue_unit') String? venueUnit,
  }) = _Branch;

  factory Branch.fromJson(Map<String, dynamic> json) =>
      _$BranchFromJson(json);
}

/// Structured coverage: city → list of areas.
@freezed
class CoverageZone with _$CoverageZone {
  const factory CoverageZone({
    required String city,
    @Default([]) List<CoverageArea> areas,
  }) = _CoverageZone;

  factory CoverageZone.fromJson(Map<String, dynamic> json) =>
      _$CoverageZoneFromJson(json);
}

/// A named area within a coverage zone.
@freezed
class CoverageArea with _$CoverageArea {
  const factory CoverageArea({
    required String name,
    @Default([]) List<String> neighbourhoods,
  }) = _CoverageArea;

  factory CoverageArea.fromJson(Map<String, dynamic> json) =>
      _$CoverageAreaFromJson(json);
}

/// Return / exchange policy.
@freezed
class ReturnPolicy with _$ReturnPolicy {
  const factory ReturnPolicy({
    @JsonKey(name: 'accepts_returns') @Default(false) bool acceptsReturns,
    @JsonKey(name: 'window_days') int? windowDays,
    String? type,
    String? cost,
    @JsonKey(name: 'conditions_ar') @Default([]) List<String> conditionsAr,
  }) = _ReturnPolicy;

  factory ReturnPolicy.fromJson(Map<String, dynamic> json) =>
      _$ReturnPolicyFromJson(json);
}

/// External link to social media or website.
@freezed
class ExternalLink with _$ExternalLink {
  const factory ExternalLink({
    required String platform,
    required String label,
    required String url,
  }) = _ExternalLink;

  factory ExternalLink.fromJson(Map<String, dynamic> json) =>
      _$ExternalLinkFromJson(json);
}

/// Active price change / seasonal adjustment.
@freezed
class PriceChange with _$PriceChange {
  const factory PriceChange({
    required String direction,
    required String method,
    required int value,
    String? scope,
    String? reason,
    @Default('active') String status,
  }) = _PriceChange;

  factory PriceChange.fromJson(Map<String, dynamic> json) =>
      _$PriceChangeFromJson(json);
}

/// Subscription / credit package offered by a business.
@freezed
class Package with _$Package {
  const factory Package({
    required String id,
    required String name,
    String? description,
    @JsonKey(name: 'price_cents') required int priceCents,
    @Default(0) int credits,
    @JsonKey(name: 'credit_label') String? creditLabel,
    @JsonKey(name: 'validity_months') int? validityMonths,
    @Default('package') String icon,
    @JsonKey(name: 'compare_single_price') int? compareSinglePrice,
    @Default(true) bool active,
    @Default('visits_and_date') String model,
    @Default([]) List<String> items,
    String? category,
  }) = _Package;

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);
}

/// Single amenity with icon name and label.
@freezed
class Amenity with _$Amenity {
  const factory Amenity({
    required String icon,
    required String label,
  }) = _Amenity;

  factory Amenity.fromJson(Map<String, dynamic> json) =>
      _$AmenityFromJson(json);
}

/// Villa / chalet pricing (weekday vs weekend).
@freezed
class VillaPricing with _$VillaPricing {
  const factory VillaPricing({
    @JsonKey(name: 'weekday_cents') required int weekdayCents,
    @JsonKey(name: 'weekend_cents') required int weekendCents,
    @Default('JOD') String currency,
  }) = _VillaPricing;

  factory VillaPricing.fromJson(Map<String, dynamic> json) =>
      _$VillaPricingFromJson(json);
}

/// Service offered by a quote-request business.
@freezed
class ServiceOffered with _$ServiceOffered {
  const factory ServiceOffered({
    required String name,
    String? description,
  }) = _ServiceOffered;

  factory ServiceOffered.fromJson(Map<String, dynamic> json) =>
      _$ServiceOfferedFromJson(json);
}

/// Price range for quote-request businesses.
@freezed
class PriceRange with _$PriceRange {
  const factory PriceRange({
    @JsonKey(name: 'min_cents') required int minCents,
    @JsonKey(name: 'max_cents') required int maxCents,
    String? note,
  }) = _PriceRange;

  factory PriceRange.fromJson(Map<String, dynamic> json) =>
      _$PriceRangeFromJson(json);
}

/// Alert / announcement for follow-only pages.
@freezed
class PageAlert with _$PageAlert {
  const factory PageAlert({
    required String id,
    required String title,
    required String body,
    @Default('info') String priority,
    @Default([]) List<String> areas,
  }) = _PageAlert;

  factory PageAlert.fromJson(Map<String, dynamic> json) =>
      _$PageAlertFromJson(json);
}

/// Service link for follow-only pages (e-services, portals).
@freezed
class ServiceLink with _$ServiceLink {
  const factory ServiceLink({
    required String label,
    required String url,
    String? type,
  }) = _ServiceLink;

  factory ServiceLink.fromJson(Map<String, dynamic> json) =>
      _$ServiceLinkFromJson(json);
}

/// A single story (image + duration) on a page.
@freezed
class PageStory with _$PageStory {
  const factory PageStory({
    required String id,
    @JsonKey(name: 'image_url') required String imageUrl,
    @Default(5) int duration,
    @JsonKey(name: 'created_at') int? createdAt,
  }) = _PageStory;

  factory PageStory.fromJson(Map<String, dynamic> json) =>
      _$PageStoryFromJson(json);
}

/// A date when the business is unavailable.
@freezed
class BlockedDate with _$BlockedDate {
  const factory BlockedDate({
    required String date,
    String? reason,
  }) = _BlockedDate;

  factory BlockedDate.fromJson(Map<String, dynamic> json) =>
      _$BlockedDateFromJson(json);
}

/// Announcement for a mall / directory page.
@freezed
class MallAnnouncement with _$MallAnnouncement {
  const factory MallAnnouncement({
    required String id,
    required String type,
    required String title,
    required String body,
    String? badge,
    @JsonKey(name: 'valid_until') String? validUntil,
  }) = _MallAnnouncement;

  factory MallAnnouncement.fromJson(Map<String, dynamic> json) =>
      _$MallAnnouncementFromJson(json);
}

/// Aggregate stats for a directory page (mall, market, etc.).
@freezed
class DirectoryStats with _$DirectoryStats {
  const factory DirectoryStats({
    @JsonKey(name: 'total_tenants') @Default(0) int totalTenants,
    @JsonKey(name: 'on_honak') @Default(0) int onHonak,
    @JsonKey(name: 'open_now') @Default(0) int openNow,
    @Default(0) int floors,
  }) = _DirectoryStats;

  factory DirectoryStats.fromJson(Map<String, dynamic> json) =>
      _$DirectoryStatsFromJson(json);
}
