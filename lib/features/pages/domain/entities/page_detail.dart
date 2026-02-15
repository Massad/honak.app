import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';
import 'package:honak/features/pages/domain/entities/seasonal_pricing.dart';
import 'package:honak/features/pages/domain/entities/trust_metric.dart';
import 'package:honak/shared/entities/location.dart';

part 'page_detail.freezed.dart';
part 'page_detail.g.dart';

@freezed
class PageDetail with _$PageDetail {
  const factory PageDetail({
    // Core
    required String id,
    required String name,
    @JsonKey(name: 'name_en') String? nameEn,
    required String slug,
    String? handle,
    String? description,
    @JsonKey(name: 'description_en') String? descriptionEn,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'cover_url') String? coverUrl,

    // Business
    String? archetype,
    @JsonKey(name: 'business_type_id') String? businessTypeId,
    @JsonKey(name: 'business_type_name') String? businessTypeName,
    @JsonKey(name: 'category_id') String? categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'explore_category') String? exploreCategory,
    @JsonKey(name: 'items_label_ar') String? itemsLabelAr,
    @JsonKey(name: 'items_label_en') String? itemsLabelEn,
    @JsonKey(name: 'store_type') String? storeType,
    @JsonKey(name: 'engagement_level') String? engagementLevel,
    @JsonKey(name: 'requires_approval') @Default(false) bool requiresApproval,

    // Trust
    @JsonKey(name: 'trust_score') @Default(0) int trustScore,
    @JsonKey(name: 'trust_metrics') @Default([]) List<TrustMetric> trustMetrics,
    @JsonKey(name: 'response_time') String? responseTime,
    @JsonKey(name: 'completion_rate') double? completionRate,
    @JsonKey(name: 'total_orders') @Default(0) int totalOrders,
    @JsonKey(name: 'member_since') String? memberSince,

    // Status
    @JsonKey(name: 'is_verified') @Default(false) bool isVerified,
    @JsonKey(name: 'is_open') @Default(true) bool isOpen,
    @JsonKey(name: 'page_status') @Default('active') String pageStatus,
    @JsonKey(name: 'claim_status') @Default('claimed') String claimStatus,
    @JsonKey(name: 'temporarily_closed') TemporarilyClosed? temporarilyClosed,
    Relocated? relocated,
    @JsonKey(name: 'permanently_closed') @Default(false) bool permanentlyClosed,

    // Operations
    @JsonKey(name: 'operating_hours') String? operatingHours,
    @JsonKey(name: 'working_hours') Map<String, dynamic>? workingHours,
    @JsonKey(name: 'payment_methods') @Default([]) List<String> paymentMethods,
    @JsonKey(name: 'cliq_alias') String? cliqAlias,
    @JsonKey(name: 'bank_info') Map<String, dynamic>? bankInfo,
    @JsonKey(name: 'coverage_zones') @Default([]) List<String> coverageZones,

    // Enhanced operations
    @Default([]) List<Branch> branches,
    @JsonKey(name: 'coverage_zones_structured')
    @Default([])
    List<CoverageZone> coverageZonesStructured,
    @JsonKey(name: 'return_policy') ReturnPolicy? returnPolicy,
    @JsonKey(name: 'cancellation_policy') String? cancellationPolicy,
    @JsonKey(name: 'external_links')
    @Default([])
    List<ExternalLink> externalLinks,

    // Delivery
    @JsonKey(name: 'delivery_available') @Default(false) bool deliveryAvailable,
    @JsonKey(name: 'pickup_available') @Default(false) bool pickupAvailable,
    @JsonKey(name: 'booking_available') @Default(false) bool bookingAvailable,
    @JsonKey(name: 'minimum_order_cents') int? minimumOrderCents,
    @JsonKey(name: 'delivery_fee_cents') int? deliveryFeeCents,
    @JsonKey(name: 'estimated_delivery_minutes') int? estimatedDeliveryMinutes,

    // Social
    @JsonKey(name: 'followers_count') @Default(0) int followersCount,
    @JsonKey(name: 'posts_count') @Default(0) int postsCount,
    @JsonKey(name: 'items_count') @Default(0) int itemsCount,
    @JsonKey(name: 'is_following') @Default(false) bool isFollowing,

    // Team
    @JsonKey(name: 'team_members_count') @Default(0) int teamMembersCount,

    // Contact
    String? phone,
    String? whatsapp,
    String? address,
    Location? location,
    PageHours? hours,

    // Catalog
    @JsonKey(name: 'catalog_strategy') String? catalogStrategy,
    @JsonKey(name: 'featured_items_count') @Default(0) int featuredItemsCount,

    // Contact methods
    @JsonKey(name: 'contact_methods') @Default([]) List<String> contactMethods,

    // Catalog / Menu enhancements
    @Default([]) List<String> specials,
    @JsonKey(name: 'modifiers_note') String? modifiersNote,
    @JsonKey(name: 'active_price_change') PriceChange? activePriceChange,
    @Default([]) List<Package> packages,

    // Villa / Reservation enhancements
    @JsonKey(name: 'gallery_images') @Default([]) List<String> galleryImages,
    @Default([]) List<Amenity> amenities,
    VillaPricing? pricing,
    @JsonKey(name: 'seasonal_pricing') SeasonalPricing? seasonalPricing,
    @JsonKey(name: 'house_rules') @Default([]) List<String> houseRules,
    @JsonKey(name: 'check_in') String? checkIn,
    @JsonKey(name: 'check_out') String? checkOut,
    @JsonKey(name: 'max_guests') int? maxGuests,
    int? bedrooms,
    int? bathrooms,

    // Quote enhancements
    @JsonKey(name: 'services_offered')
    @Default([])
    List<ServiceOffered> servicesOffered,
    @JsonKey(name: 'price_range') PriceRange? priceRange,
    @JsonKey(name: 'service_areas') @Default([]) List<String> serviceAreas,

    // Follow-only enhancements
    @Default([]) List<PageAlert> alerts,
    @JsonKey(name: 'about_extended') String? aboutExtended,
    @JsonKey(name: 'services_links') @Default([]) List<ServiceLink> servicesLinks,

    // Activity enhancements
    @JsonKey(name: 'pinned_posts') @Default([]) List<String> pinnedPosts,

    // Stories
    @Default([]) List<PageStory> stories,

    // Weekly schedule
    @JsonKey(name: 'weekly_schedule') Map<String, dynamic>? weeklySchedule,

    // Blocked dates
    @JsonKey(name: 'blocked_dates') @Default([]) List<BlockedDate> blockedDates,

    // Data sync flag
    @JsonKey(name: 'data_synced') @Default(true) bool dataSynced,

    // Venue tenant fields
    @JsonKey(name: 'venue_id') String? venueId,
    @JsonKey(name: 'venue_name') String? venueName,
    @JsonKey(name: 'venue_unit') String? venueUnit,
    @JsonKey(name: 'venue_floor') String? venueFloor,

    // Directory-specific
    @JsonKey(name: 'mall_announcements')
    @Default([])
    List<MallAnnouncement> mallAnnouncements,
    @JsonKey(name: 'featured_tenant_ids')
    @Default([])
    List<String> featuredTenantIds,
    @JsonKey(name: 'directory_stats') DirectoryStats? directoryStats,
    @JsonKey(name: 'parking_info') String? parkingInfo,

    // Catalog highlights
    @JsonKey(name: 'carry_categories') @Default([]) List<String> carryCategories,
  }) = _PageDetail;

  factory PageDetail.fromJson(Map<String, dynamic> json) =>
      _$PageDetailFromJson(json);
}

/// Lightweight venue info resolved from page-level or branch-level fields.
class VenueInfo {
  final String id;
  final String? name;
  final String? floor;
  final String? unit;
  const VenueInfo({required this.id, this.name, this.floor, this.unit});
}

extension PageDetailVenues on PageDetail {
  /// Collects all venue references: page-level (single-location) or
  /// branch-level (multi-location like Arab Bank in multiple malls).
  List<VenueInfo> get venues {
    final result = <VenueInfo>[];
    // Page-level venue (single-location businesses with no branches)
    if (venueId != null && branches.isEmpty) {
      result.add(VenueInfo(
        id: venueId!,
        name: venueName,
        floor: venueFloor,
        unit: venueUnit,
      ));
    }
    // Branch-level venues (multi-location businesses)
    for (final b in branches) {
      if (b.venueId != null) {
        result.add(VenueInfo(
          id: b.venueId!,
          name: b.venueName,
          floor: b.venueFloor,
          unit: b.venueUnit,
        ));
      }
    }
    return result;
  }
}
