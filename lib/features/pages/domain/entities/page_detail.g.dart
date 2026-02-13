// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PageDetailImpl _$$PageDetailImplFromJson(
  Map<String, dynamic> json,
) => _$PageDetailImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  nameEn: json['name_en'] as String?,
  slug: json['slug'] as String,
  handle: json['handle'] as String?,
  description: json['description'] as String?,
  descriptionEn: json['description_en'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  coverUrl: json['cover_url'] as String?,
  archetype: json['archetype'] as String?,
  businessTypeId: json['business_type_id'] as String?,
  businessTypeName: json['business_type_name'] as String?,
  categoryId: json['category_id'] as String?,
  categoryName: json['category_name'] as String?,
  exploreCategory: json['explore_category'] as String?,
  itemsLabelAr: json['items_label_ar'] as String?,
  itemsLabelEn: json['items_label_en'] as String?,
  storeType: json['store_type'] as String?,
  engagementLevel: json['engagement_level'] as String?,
  requiresApproval: json['requires_approval'] as bool? ?? false,
  trustScore: (json['trust_score'] as num?)?.toInt() ?? 0,
  trustMetrics:
      (json['trust_metrics'] as List<dynamic>?)
          ?.map((e) => TrustMetric.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  responseTime: json['response_time'] as String?,
  completionRate: (json['completion_rate'] as num?)?.toDouble(),
  totalOrders: (json['total_orders'] as num?)?.toInt() ?? 0,
  memberSince: json['member_since'] as String?,
  isVerified: json['is_verified'] as bool? ?? false,
  isOpen: json['is_open'] as bool? ?? true,
  pageStatus: json['page_status'] as String? ?? 'active',
  claimStatus: json['claim_status'] as String? ?? 'claimed',
  temporarilyClosed: json['temporarily_closed'] == null
      ? null
      : TemporarilyClosed.fromJson(
          json['temporarily_closed'] as Map<String, dynamic>,
        ),
  relocated: json['relocated'] == null
      ? null
      : Relocated.fromJson(json['relocated'] as Map<String, dynamic>),
  permanentlyClosed: json['permanently_closed'] as bool? ?? false,
  operatingHours: json['operating_hours'] as String?,
  workingHours: json['working_hours'] as Map<String, dynamic>?,
  paymentMethods:
      (json['payment_methods'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  cliqAlias: json['cliq_alias'] as String?,
  bankInfo: json['bank_info'] as Map<String, dynamic>?,
  coverageZones:
      (json['coverage_zones'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  branches:
      (json['branches'] as List<dynamic>?)
          ?.map((e) => Branch.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  coverageZonesStructured:
      (json['coverage_zones_structured'] as List<dynamic>?)
          ?.map((e) => CoverageZone.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  returnPolicy: json['return_policy'] == null
      ? null
      : ReturnPolicy.fromJson(json['return_policy'] as Map<String, dynamic>),
  cancellationPolicy: json['cancellation_policy'] as String?,
  externalLinks:
      (json['external_links'] as List<dynamic>?)
          ?.map((e) => ExternalLink.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  deliveryAvailable: json['delivery_available'] as bool? ?? false,
  pickupAvailable: json['pickup_available'] as bool? ?? false,
  bookingAvailable: json['booking_available'] as bool? ?? false,
  minimumOrderCents: (json['minimum_order_cents'] as num?)?.toInt(),
  deliveryFeeCents: (json['delivery_fee_cents'] as num?)?.toInt(),
  estimatedDeliveryMinutes: (json['estimated_delivery_minutes'] as num?)
      ?.toInt(),
  followersCount: (json['followers_count'] as num?)?.toInt() ?? 0,
  postsCount: (json['posts_count'] as num?)?.toInt() ?? 0,
  itemsCount: (json['items_count'] as num?)?.toInt() ?? 0,
  isFollowing: json['is_following'] as bool? ?? false,
  teamMembersCount: (json['team_members_count'] as num?)?.toInt() ?? 0,
  phone: json['phone'] as String?,
  whatsapp: json['whatsapp'] as String?,
  address: json['address'] as String?,
  location: json['location'] == null
      ? null
      : Location.fromJson(json['location'] as Map<String, dynamic>),
  hours: json['hours'] == null
      ? null
      : PageHours.fromJson(json['hours'] as Map<String, dynamic>),
  catalogStrategy: json['catalog_strategy'] as String?,
  featuredItemsCount: (json['featured_items_count'] as num?)?.toInt() ?? 0,
  contactMethods:
      (json['contact_methods'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  specials:
      (json['specials'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  modifiersNote: json['modifiers_note'] as String?,
  activePriceChange: json['active_price_change'] == null
      ? null
      : PriceChange.fromJson(
          json['active_price_change'] as Map<String, dynamic>,
        ),
  packages:
      (json['packages'] as List<dynamic>?)
          ?.map((e) => Package.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  galleryImages:
      (json['gallery_images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  amenities:
      (json['amenities'] as List<dynamic>?)
          ?.map((e) => Amenity.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  pricing: json['pricing'] == null
      ? null
      : VillaPricing.fromJson(json['pricing'] as Map<String, dynamic>),
  houseRules:
      (json['house_rules'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  checkIn: json['check_in'] as String?,
  checkOut: json['check_out'] as String?,
  maxGuests: (json['max_guests'] as num?)?.toInt(),
  bedrooms: (json['bedrooms'] as num?)?.toInt(),
  bathrooms: (json['bathrooms'] as num?)?.toInt(),
  servicesOffered:
      (json['services_offered'] as List<dynamic>?)
          ?.map((e) => ServiceOffered.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  priceRange: json['price_range'] == null
      ? null
      : PriceRange.fromJson(json['price_range'] as Map<String, dynamic>),
  serviceAreas:
      (json['service_areas'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  alerts:
      (json['alerts'] as List<dynamic>?)
          ?.map((e) => PageAlert.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  aboutExtended: json['about_extended'] as String?,
  servicesLinks:
      (json['services_links'] as List<dynamic>?)
          ?.map((e) => ServiceLink.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  pinnedPosts:
      (json['pinned_posts'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  stories:
      (json['stories'] as List<dynamic>?)
          ?.map((e) => PageStory.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  weeklySchedule: json['weekly_schedule'] as Map<String, dynamic>?,
  blockedDates:
      (json['blocked_dates'] as List<dynamic>?)
          ?.map((e) => BlockedDate.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  dataSynced: json['data_synced'] as bool? ?? true,
  venueId: json['venue_id'] as String?,
  venueUnit: json['venue_unit'] as String?,
  venueFloor: json['venue_floor'] as String?,
  mallAnnouncements:
      (json['mall_announcements'] as List<dynamic>?)
          ?.map((e) => MallAnnouncement.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  featuredTenantIds:
      (json['featured_tenant_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  directoryStats: json['directory_stats'] == null
      ? null
      : DirectoryStats.fromJson(
          json['directory_stats'] as Map<String, dynamic>,
        ),
  carryCategories:
      (json['carry_categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$PageDetailImplToJson(_$PageDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'slug': instance.slug,
      'handle': instance.handle,
      'description': instance.description,
      'description_en': instance.descriptionEn,
      'avatar_url': instance.avatarUrl,
      'cover_url': instance.coverUrl,
      'archetype': instance.archetype,
      'business_type_id': instance.businessTypeId,
      'business_type_name': instance.businessTypeName,
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'explore_category': instance.exploreCategory,
      'items_label_ar': instance.itemsLabelAr,
      'items_label_en': instance.itemsLabelEn,
      'store_type': instance.storeType,
      'engagement_level': instance.engagementLevel,
      'requires_approval': instance.requiresApproval,
      'trust_score': instance.trustScore,
      'trust_metrics': instance.trustMetrics,
      'response_time': instance.responseTime,
      'completion_rate': instance.completionRate,
      'total_orders': instance.totalOrders,
      'member_since': instance.memberSince,
      'is_verified': instance.isVerified,
      'is_open': instance.isOpen,
      'page_status': instance.pageStatus,
      'claim_status': instance.claimStatus,
      'temporarily_closed': instance.temporarilyClosed,
      'relocated': instance.relocated,
      'permanently_closed': instance.permanentlyClosed,
      'operating_hours': instance.operatingHours,
      'working_hours': instance.workingHours,
      'payment_methods': instance.paymentMethods,
      'cliq_alias': instance.cliqAlias,
      'bank_info': instance.bankInfo,
      'coverage_zones': instance.coverageZones,
      'branches': instance.branches,
      'coverage_zones_structured': instance.coverageZonesStructured,
      'return_policy': instance.returnPolicy,
      'cancellation_policy': instance.cancellationPolicy,
      'external_links': instance.externalLinks,
      'delivery_available': instance.deliveryAvailable,
      'pickup_available': instance.pickupAvailable,
      'booking_available': instance.bookingAvailable,
      'minimum_order_cents': instance.minimumOrderCents,
      'delivery_fee_cents': instance.deliveryFeeCents,
      'estimated_delivery_minutes': instance.estimatedDeliveryMinutes,
      'followers_count': instance.followersCount,
      'posts_count': instance.postsCount,
      'items_count': instance.itemsCount,
      'is_following': instance.isFollowing,
      'team_members_count': instance.teamMembersCount,
      'phone': instance.phone,
      'whatsapp': instance.whatsapp,
      'address': instance.address,
      'location': instance.location,
      'hours': instance.hours,
      'catalog_strategy': instance.catalogStrategy,
      'featured_items_count': instance.featuredItemsCount,
      'contact_methods': instance.contactMethods,
      'specials': instance.specials,
      'modifiers_note': instance.modifiersNote,
      'active_price_change': instance.activePriceChange,
      'packages': instance.packages,
      'gallery_images': instance.galleryImages,
      'amenities': instance.amenities,
      'pricing': instance.pricing,
      'house_rules': instance.houseRules,
      'check_in': instance.checkIn,
      'check_out': instance.checkOut,
      'max_guests': instance.maxGuests,
      'bedrooms': instance.bedrooms,
      'bathrooms': instance.bathrooms,
      'services_offered': instance.servicesOffered,
      'price_range': instance.priceRange,
      'service_areas': instance.serviceAreas,
      'alerts': instance.alerts,
      'about_extended': instance.aboutExtended,
      'services_links': instance.servicesLinks,
      'pinned_posts': instance.pinnedPosts,
      'stories': instance.stories,
      'weekly_schedule': instance.weeklySchedule,
      'blocked_dates': instance.blockedDates,
      'data_synced': instance.dataSynced,
      'venue_id': instance.venueId,
      'venue_unit': instance.venueUnit,
      'venue_floor': instance.venueFloor,
      'mall_announcements': instance.mallAnnouncements,
      'featured_tenant_ids': instance.featuredTenantIds,
      'directory_stats': instance.directoryStats,
      'carry_categories': instance.carryCategories,
    };
