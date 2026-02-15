// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PageDetail _$PageDetailFromJson(Map<String, dynamic> json) {
  return _PageDetail.fromJson(json);
}

/// @nodoc
mixin _$PageDetail {
  // Core
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_en')
  String? get nameEn => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String? get handle => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'description_en')
  String? get descriptionEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover_url')
  String? get coverUrl => throw _privateConstructorUsedError; // Business
  String? get archetype => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_type_id')
  String? get businessTypeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_type_name')
  String? get businessTypeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  String? get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'explore_category')
  String? get exploreCategory => throw _privateConstructorUsedError;
  @JsonKey(name: 'items_label_ar')
  String? get itemsLabelAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'items_label_en')
  String? get itemsLabelEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_type')
  String? get storeType => throw _privateConstructorUsedError;
  @JsonKey(name: 'engagement_level')
  String? get engagementLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'requires_approval')
  bool get requiresApproval => throw _privateConstructorUsedError; // Trust
  @JsonKey(name: 'trust_score')
  int get trustScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'trust_metrics')
  List<TrustMetric> get trustMetrics => throw _privateConstructorUsedError;
  @JsonKey(name: 'response_time')
  String? get responseTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'completion_rate')
  double? get completionRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_orders')
  int get totalOrders => throw _privateConstructorUsedError;
  @JsonKey(name: 'member_since')
  String? get memberSince => throw _privateConstructorUsedError; // Status
  @JsonKey(name: 'is_verified')
  bool get isVerified => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_open')
  bool get isOpen => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_status')
  String get pageStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'claim_status')
  String get claimStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'temporarily_closed')
  TemporarilyClosed? get temporarilyClosed =>
      throw _privateConstructorUsedError;
  Relocated? get relocated => throw _privateConstructorUsedError;
  @JsonKey(name: 'permanently_closed')
  bool get permanentlyClosed => throw _privateConstructorUsedError; // Operations
  @JsonKey(name: 'operating_hours')
  String? get operatingHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'working_hours')
  Map<String, dynamic>? get workingHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_methods')
  List<String> get paymentMethods => throw _privateConstructorUsedError;
  @JsonKey(name: 'cliq_alias')
  String? get cliqAlias => throw _privateConstructorUsedError;
  @JsonKey(name: 'bank_info')
  Map<String, dynamic>? get bankInfo => throw _privateConstructorUsedError;
  @JsonKey(name: 'coverage_zones')
  List<String> get coverageZones => throw _privateConstructorUsedError; // Enhanced operations
  List<Branch> get branches => throw _privateConstructorUsedError;
  @JsonKey(name: 'coverage_zones_structured')
  List<CoverageZone> get coverageZonesStructured =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'return_policy')
  ReturnPolicy? get returnPolicy => throw _privateConstructorUsedError;
  @JsonKey(name: 'cancellation_policy')
  String? get cancellationPolicy => throw _privateConstructorUsedError;
  @JsonKey(name: 'external_links')
  List<ExternalLink> get externalLinks => throw _privateConstructorUsedError; // Delivery
  @JsonKey(name: 'delivery_available')
  bool get deliveryAvailable => throw _privateConstructorUsedError;
  @JsonKey(name: 'pickup_available')
  bool get pickupAvailable => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_available')
  bool get bookingAvailable => throw _privateConstructorUsedError;
  @JsonKey(name: 'minimum_order_cents')
  int? get minimumOrderCents => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivery_fee_cents')
  int? get deliveryFeeCents => throw _privateConstructorUsedError;
  @JsonKey(name: 'estimated_delivery_minutes')
  int? get estimatedDeliveryMinutes => throw _privateConstructorUsedError; // Social
  @JsonKey(name: 'followers_count')
  int get followersCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'posts_count')
  int get postsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'items_count')
  int get itemsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_following')
  bool get isFollowing => throw _privateConstructorUsedError; // Team
  @JsonKey(name: 'team_members_count')
  int get teamMembersCount => throw _privateConstructorUsedError; // Contact
  String? get phone => throw _privateConstructorUsedError;
  String? get whatsapp => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  Location? get location => throw _privateConstructorUsedError;
  PageHours? get hours => throw _privateConstructorUsedError; // Catalog
  @JsonKey(name: 'catalog_strategy')
  String? get catalogStrategy => throw _privateConstructorUsedError;
  @JsonKey(name: 'featured_items_count')
  int get featuredItemsCount => throw _privateConstructorUsedError; // Contact methods
  @JsonKey(name: 'contact_methods')
  List<String> get contactMethods => throw _privateConstructorUsedError; // Catalog / Menu enhancements
  List<String> get specials => throw _privateConstructorUsedError;
  @JsonKey(name: 'modifiers_note')
  String? get modifiersNote => throw _privateConstructorUsedError;
  @JsonKey(name: 'active_price_change')
  PriceChange? get activePriceChange => throw _privateConstructorUsedError;
  List<Package> get packages =>
      throw _privateConstructorUsedError; // Villa / Reservation enhancements
  @JsonKey(name: 'gallery_images')
  List<String> get galleryImages => throw _privateConstructorUsedError;
  List<Amenity> get amenities => throw _privateConstructorUsedError;
  VillaPricing? get pricing => throw _privateConstructorUsedError;
  @JsonKey(name: 'seasonal_pricing')
  SeasonalPricing? get seasonalPricing => throw _privateConstructorUsedError;
  @JsonKey(name: 'house_rules')
  List<String> get houseRules => throw _privateConstructorUsedError;
  @JsonKey(name: 'check_in')
  String? get checkIn => throw _privateConstructorUsedError;
  @JsonKey(name: 'check_out')
  String? get checkOut => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_guests')
  int? get maxGuests => throw _privateConstructorUsedError;
  int? get bedrooms => throw _privateConstructorUsedError;
  int? get bathrooms =>
      throw _privateConstructorUsedError; // Quote enhancements
  @JsonKey(name: 'services_offered')
  List<ServiceOffered> get servicesOffered =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'price_range')
  PriceRange? get priceRange => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_areas')
  List<String> get serviceAreas => throw _privateConstructorUsedError; // Follow-only enhancements
  List<PageAlert> get alerts => throw _privateConstructorUsedError;
  @JsonKey(name: 'about_extended')
  String? get aboutExtended => throw _privateConstructorUsedError;
  @JsonKey(name: 'services_links')
  List<ServiceLink> get servicesLinks => throw _privateConstructorUsedError; // Activity enhancements
  @JsonKey(name: 'pinned_posts')
  List<String> get pinnedPosts => throw _privateConstructorUsedError; // Stories
  List<PageStory> get stories =>
      throw _privateConstructorUsedError; // Weekly schedule
  @JsonKey(name: 'weekly_schedule')
  Map<String, dynamic>? get weeklySchedule =>
      throw _privateConstructorUsedError; // Blocked dates
  @JsonKey(name: 'blocked_dates')
  List<BlockedDate> get blockedDates => throw _privateConstructorUsedError; // Data sync flag
  @JsonKey(name: 'data_synced')
  bool get dataSynced => throw _privateConstructorUsedError; // Venue tenant fields
  @JsonKey(name: 'venue_id')
  String? get venueId => throw _privateConstructorUsedError;
  @JsonKey(name: 'venue_name')
  String? get venueName => throw _privateConstructorUsedError;
  @JsonKey(name: 'venue_unit')
  String? get venueUnit => throw _privateConstructorUsedError;
  @JsonKey(name: 'venue_floor')
  String? get venueFloor => throw _privateConstructorUsedError; // Directory-specific
  @JsonKey(name: 'mall_announcements')
  List<MallAnnouncement> get mallAnnouncements =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'featured_tenant_ids')
  List<String> get featuredTenantIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'directory_stats')
  DirectoryStats? get directoryStats => throw _privateConstructorUsedError;
  @JsonKey(name: 'parking_info')
  String? get parkingInfo => throw _privateConstructorUsedError; // Catalog highlights
  @JsonKey(name: 'carry_categories')
  List<String> get carryCategories => throw _privateConstructorUsedError;

  /// Serializes this PageDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PageDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PageDetailCopyWith<PageDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageDetailCopyWith<$Res> {
  factory $PageDetailCopyWith(
    PageDetail value,
    $Res Function(PageDetail) then,
  ) = _$PageDetailCopyWithImpl<$Res, PageDetail>;
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'name_en') String? nameEn,
    String slug,
    String? handle,
    String? description,
    @JsonKey(name: 'description_en') String? descriptionEn,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'cover_url') String? coverUrl,
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
    @JsonKey(name: 'requires_approval') bool requiresApproval,
    @JsonKey(name: 'trust_score') int trustScore,
    @JsonKey(name: 'trust_metrics') List<TrustMetric> trustMetrics,
    @JsonKey(name: 'response_time') String? responseTime,
    @JsonKey(name: 'completion_rate') double? completionRate,
    @JsonKey(name: 'total_orders') int totalOrders,
    @JsonKey(name: 'member_since') String? memberSince,
    @JsonKey(name: 'is_verified') bool isVerified,
    @JsonKey(name: 'is_open') bool isOpen,
    @JsonKey(name: 'page_status') String pageStatus,
    @JsonKey(name: 'claim_status') String claimStatus,
    @JsonKey(name: 'temporarily_closed') TemporarilyClosed? temporarilyClosed,
    Relocated? relocated,
    @JsonKey(name: 'permanently_closed') bool permanentlyClosed,
    @JsonKey(name: 'operating_hours') String? operatingHours,
    @JsonKey(name: 'working_hours') Map<String, dynamic>? workingHours,
    @JsonKey(name: 'payment_methods') List<String> paymentMethods,
    @JsonKey(name: 'cliq_alias') String? cliqAlias,
    @JsonKey(name: 'bank_info') Map<String, dynamic>? bankInfo,
    @JsonKey(name: 'coverage_zones') List<String> coverageZones,
    List<Branch> branches,
    @JsonKey(name: 'coverage_zones_structured')
    List<CoverageZone> coverageZonesStructured,
    @JsonKey(name: 'return_policy') ReturnPolicy? returnPolicy,
    @JsonKey(name: 'cancellation_policy') String? cancellationPolicy,
    @JsonKey(name: 'external_links') List<ExternalLink> externalLinks,
    @JsonKey(name: 'delivery_available') bool deliveryAvailable,
    @JsonKey(name: 'pickup_available') bool pickupAvailable,
    @JsonKey(name: 'booking_available') bool bookingAvailable,
    @JsonKey(name: 'minimum_order_cents') int? minimumOrderCents,
    @JsonKey(name: 'delivery_fee_cents') int? deliveryFeeCents,
    @JsonKey(name: 'estimated_delivery_minutes') int? estimatedDeliveryMinutes,
    @JsonKey(name: 'followers_count') int followersCount,
    @JsonKey(name: 'posts_count') int postsCount,
    @JsonKey(name: 'items_count') int itemsCount,
    @JsonKey(name: 'is_following') bool isFollowing,
    @JsonKey(name: 'team_members_count') int teamMembersCount,
    String? phone,
    String? whatsapp,
    String? address,
    Location? location,
    PageHours? hours,
    @JsonKey(name: 'catalog_strategy') String? catalogStrategy,
    @JsonKey(name: 'featured_items_count') int featuredItemsCount,
    @JsonKey(name: 'contact_methods') List<String> contactMethods,
    List<String> specials,
    @JsonKey(name: 'modifiers_note') String? modifiersNote,
    @JsonKey(name: 'active_price_change') PriceChange? activePriceChange,
    List<Package> packages,
    @JsonKey(name: 'gallery_images') List<String> galleryImages,
    List<Amenity> amenities,
    VillaPricing? pricing,
    @JsonKey(name: 'seasonal_pricing') SeasonalPricing? seasonalPricing,
    @JsonKey(name: 'house_rules') List<String> houseRules,
    @JsonKey(name: 'check_in') String? checkIn,
    @JsonKey(name: 'check_out') String? checkOut,
    @JsonKey(name: 'max_guests') int? maxGuests,
    int? bedrooms,
    int? bathrooms,
    @JsonKey(name: 'services_offered') List<ServiceOffered> servicesOffered,
    @JsonKey(name: 'price_range') PriceRange? priceRange,
    @JsonKey(name: 'service_areas') List<String> serviceAreas,
    List<PageAlert> alerts,
    @JsonKey(name: 'about_extended') String? aboutExtended,
    @JsonKey(name: 'services_links') List<ServiceLink> servicesLinks,
    @JsonKey(name: 'pinned_posts') List<String> pinnedPosts,
    List<PageStory> stories,
    @JsonKey(name: 'weekly_schedule') Map<String, dynamic>? weeklySchedule,
    @JsonKey(name: 'blocked_dates') List<BlockedDate> blockedDates,
    @JsonKey(name: 'data_synced') bool dataSynced,
    @JsonKey(name: 'venue_id') String? venueId,
    @JsonKey(name: 'venue_name') String? venueName,
    @JsonKey(name: 'venue_unit') String? venueUnit,
    @JsonKey(name: 'venue_floor') String? venueFloor,
    @JsonKey(name: 'mall_announcements')
    List<MallAnnouncement> mallAnnouncements,
    @JsonKey(name: 'featured_tenant_ids') List<String> featuredTenantIds,
    @JsonKey(name: 'directory_stats') DirectoryStats? directoryStats,
    @JsonKey(name: 'parking_info') String? parkingInfo,
    @JsonKey(name: 'carry_categories') List<String> carryCategories,
  });

  $TemporarilyClosedCopyWith<$Res>? get temporarilyClosed;
  $RelocatedCopyWith<$Res>? get relocated;
  $ReturnPolicyCopyWith<$Res>? get returnPolicy;
  $LocationCopyWith<$Res>? get location;
  $PageHoursCopyWith<$Res>? get hours;
  $PriceChangeCopyWith<$Res>? get activePriceChange;
  $VillaPricingCopyWith<$Res>? get pricing;
  $SeasonalPricingCopyWith<$Res>? get seasonalPricing;
  $PriceRangeCopyWith<$Res>? get priceRange;
  $DirectoryStatsCopyWith<$Res>? get directoryStats;
}

/// @nodoc
class _$PageDetailCopyWithImpl<$Res, $Val extends PageDetail>
    implements $PageDetailCopyWith<$Res> {
  _$PageDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PageDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = freezed,
    Object? slug = null,
    Object? handle = freezed,
    Object? description = freezed,
    Object? descriptionEn = freezed,
    Object? avatarUrl = freezed,
    Object? coverUrl = freezed,
    Object? archetype = freezed,
    Object? businessTypeId = freezed,
    Object? businessTypeName = freezed,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? exploreCategory = freezed,
    Object? itemsLabelAr = freezed,
    Object? itemsLabelEn = freezed,
    Object? storeType = freezed,
    Object? engagementLevel = freezed,
    Object? requiresApproval = null,
    Object? trustScore = null,
    Object? trustMetrics = null,
    Object? responseTime = freezed,
    Object? completionRate = freezed,
    Object? totalOrders = null,
    Object? memberSince = freezed,
    Object? isVerified = null,
    Object? isOpen = null,
    Object? pageStatus = null,
    Object? claimStatus = null,
    Object? temporarilyClosed = freezed,
    Object? relocated = freezed,
    Object? permanentlyClosed = null,
    Object? operatingHours = freezed,
    Object? workingHours = freezed,
    Object? paymentMethods = null,
    Object? cliqAlias = freezed,
    Object? bankInfo = freezed,
    Object? coverageZones = null,
    Object? branches = null,
    Object? coverageZonesStructured = null,
    Object? returnPolicy = freezed,
    Object? cancellationPolicy = freezed,
    Object? externalLinks = null,
    Object? deliveryAvailable = null,
    Object? pickupAvailable = null,
    Object? bookingAvailable = null,
    Object? minimumOrderCents = freezed,
    Object? deliveryFeeCents = freezed,
    Object? estimatedDeliveryMinutes = freezed,
    Object? followersCount = null,
    Object? postsCount = null,
    Object? itemsCount = null,
    Object? isFollowing = null,
    Object? teamMembersCount = null,
    Object? phone = freezed,
    Object? whatsapp = freezed,
    Object? address = freezed,
    Object? location = freezed,
    Object? hours = freezed,
    Object? catalogStrategy = freezed,
    Object? featuredItemsCount = null,
    Object? contactMethods = null,
    Object? specials = null,
    Object? modifiersNote = freezed,
    Object? activePriceChange = freezed,
    Object? packages = null,
    Object? galleryImages = null,
    Object? amenities = null,
    Object? pricing = freezed,
    Object? seasonalPricing = freezed,
    Object? houseRules = null,
    Object? checkIn = freezed,
    Object? checkOut = freezed,
    Object? maxGuests = freezed,
    Object? bedrooms = freezed,
    Object? bathrooms = freezed,
    Object? servicesOffered = null,
    Object? priceRange = freezed,
    Object? serviceAreas = null,
    Object? alerts = null,
    Object? aboutExtended = freezed,
    Object? servicesLinks = null,
    Object? pinnedPosts = null,
    Object? stories = null,
    Object? weeklySchedule = freezed,
    Object? blockedDates = null,
    Object? dataSynced = null,
    Object? venueId = freezed,
    Object? venueName = freezed,
    Object? venueUnit = freezed,
    Object? venueFloor = freezed,
    Object? mallAnnouncements = null,
    Object? featuredTenantIds = null,
    Object? directoryStats = freezed,
    Object? parkingInfo = freezed,
    Object? carryCategories = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            nameEn: freezed == nameEn
                ? _value.nameEn
                : nameEn // ignore: cast_nullable_to_non_nullable
                      as String?,
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            handle: freezed == handle
                ? _value.handle
                : handle // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            descriptionEn: freezed == descriptionEn
                ? _value.descriptionEn
                : descriptionEn // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            coverUrl: freezed == coverUrl
                ? _value.coverUrl
                : coverUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            archetype: freezed == archetype
                ? _value.archetype
                : archetype // ignore: cast_nullable_to_non_nullable
                      as String?,
            businessTypeId: freezed == businessTypeId
                ? _value.businessTypeId
                : businessTypeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            businessTypeName: freezed == businessTypeName
                ? _value.businessTypeName
                : businessTypeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryName: freezed == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String?,
            exploreCategory: freezed == exploreCategory
                ? _value.exploreCategory
                : exploreCategory // ignore: cast_nullable_to_non_nullable
                      as String?,
            itemsLabelAr: freezed == itemsLabelAr
                ? _value.itemsLabelAr
                : itemsLabelAr // ignore: cast_nullable_to_non_nullable
                      as String?,
            itemsLabelEn: freezed == itemsLabelEn
                ? _value.itemsLabelEn
                : itemsLabelEn // ignore: cast_nullable_to_non_nullable
                      as String?,
            storeType: freezed == storeType
                ? _value.storeType
                : storeType // ignore: cast_nullable_to_non_nullable
                      as String?,
            engagementLevel: freezed == engagementLevel
                ? _value.engagementLevel
                : engagementLevel // ignore: cast_nullable_to_non_nullable
                      as String?,
            requiresApproval: null == requiresApproval
                ? _value.requiresApproval
                : requiresApproval // ignore: cast_nullable_to_non_nullable
                      as bool,
            trustScore: null == trustScore
                ? _value.trustScore
                : trustScore // ignore: cast_nullable_to_non_nullable
                      as int,
            trustMetrics: null == trustMetrics
                ? _value.trustMetrics
                : trustMetrics // ignore: cast_nullable_to_non_nullable
                      as List<TrustMetric>,
            responseTime: freezed == responseTime
                ? _value.responseTime
                : responseTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            completionRate: freezed == completionRate
                ? _value.completionRate
                : completionRate // ignore: cast_nullable_to_non_nullable
                      as double?,
            totalOrders: null == totalOrders
                ? _value.totalOrders
                : totalOrders // ignore: cast_nullable_to_non_nullable
                      as int,
            memberSince: freezed == memberSince
                ? _value.memberSince
                : memberSince // ignore: cast_nullable_to_non_nullable
                      as String?,
            isVerified: null == isVerified
                ? _value.isVerified
                : isVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            isOpen: null == isOpen
                ? _value.isOpen
                : isOpen // ignore: cast_nullable_to_non_nullable
                      as bool,
            pageStatus: null == pageStatus
                ? _value.pageStatus
                : pageStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            claimStatus: null == claimStatus
                ? _value.claimStatus
                : claimStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            temporarilyClosed: freezed == temporarilyClosed
                ? _value.temporarilyClosed
                : temporarilyClosed // ignore: cast_nullable_to_non_nullable
                      as TemporarilyClosed?,
            relocated: freezed == relocated
                ? _value.relocated
                : relocated // ignore: cast_nullable_to_non_nullable
                      as Relocated?,
            permanentlyClosed: null == permanentlyClosed
                ? _value.permanentlyClosed
                : permanentlyClosed // ignore: cast_nullable_to_non_nullable
                      as bool,
            operatingHours: freezed == operatingHours
                ? _value.operatingHours
                : operatingHours // ignore: cast_nullable_to_non_nullable
                      as String?,
            workingHours: freezed == workingHours
                ? _value.workingHours
                : workingHours // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            paymentMethods: null == paymentMethods
                ? _value.paymentMethods
                : paymentMethods // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            cliqAlias: freezed == cliqAlias
                ? _value.cliqAlias
                : cliqAlias // ignore: cast_nullable_to_non_nullable
                      as String?,
            bankInfo: freezed == bankInfo
                ? _value.bankInfo
                : bankInfo // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            coverageZones: null == coverageZones
                ? _value.coverageZones
                : coverageZones // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            branches: null == branches
                ? _value.branches
                : branches // ignore: cast_nullable_to_non_nullable
                      as List<Branch>,
            coverageZonesStructured: null == coverageZonesStructured
                ? _value.coverageZonesStructured
                : coverageZonesStructured // ignore: cast_nullable_to_non_nullable
                      as List<CoverageZone>,
            returnPolicy: freezed == returnPolicy
                ? _value.returnPolicy
                : returnPolicy // ignore: cast_nullable_to_non_nullable
                      as ReturnPolicy?,
            cancellationPolicy: freezed == cancellationPolicy
                ? _value.cancellationPolicy
                : cancellationPolicy // ignore: cast_nullable_to_non_nullable
                      as String?,
            externalLinks: null == externalLinks
                ? _value.externalLinks
                : externalLinks // ignore: cast_nullable_to_non_nullable
                      as List<ExternalLink>,
            deliveryAvailable: null == deliveryAvailable
                ? _value.deliveryAvailable
                : deliveryAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
            pickupAvailable: null == pickupAvailable
                ? _value.pickupAvailable
                : pickupAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
            bookingAvailable: null == bookingAvailable
                ? _value.bookingAvailable
                : bookingAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
            minimumOrderCents: freezed == minimumOrderCents
                ? _value.minimumOrderCents
                : minimumOrderCents // ignore: cast_nullable_to_non_nullable
                      as int?,
            deliveryFeeCents: freezed == deliveryFeeCents
                ? _value.deliveryFeeCents
                : deliveryFeeCents // ignore: cast_nullable_to_non_nullable
                      as int?,
            estimatedDeliveryMinutes: freezed == estimatedDeliveryMinutes
                ? _value.estimatedDeliveryMinutes
                : estimatedDeliveryMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            followersCount: null == followersCount
                ? _value.followersCount
                : followersCount // ignore: cast_nullable_to_non_nullable
                      as int,
            postsCount: null == postsCount
                ? _value.postsCount
                : postsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            itemsCount: null == itemsCount
                ? _value.itemsCount
                : itemsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isFollowing: null == isFollowing
                ? _value.isFollowing
                : isFollowing // ignore: cast_nullable_to_non_nullable
                      as bool,
            teamMembersCount: null == teamMembersCount
                ? _value.teamMembersCount
                : teamMembersCount // ignore: cast_nullable_to_non_nullable
                      as int,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            whatsapp: freezed == whatsapp
                ? _value.whatsapp
                : whatsapp // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as Location?,
            hours: freezed == hours
                ? _value.hours
                : hours // ignore: cast_nullable_to_non_nullable
                      as PageHours?,
            catalogStrategy: freezed == catalogStrategy
                ? _value.catalogStrategy
                : catalogStrategy // ignore: cast_nullable_to_non_nullable
                      as String?,
            featuredItemsCount: null == featuredItemsCount
                ? _value.featuredItemsCount
                : featuredItemsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            contactMethods: null == contactMethods
                ? _value.contactMethods
                : contactMethods // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            specials: null == specials
                ? _value.specials
                : specials // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            modifiersNote: freezed == modifiersNote
                ? _value.modifiersNote
                : modifiersNote // ignore: cast_nullable_to_non_nullable
                      as String?,
            activePriceChange: freezed == activePriceChange
                ? _value.activePriceChange
                : activePriceChange // ignore: cast_nullable_to_non_nullable
                      as PriceChange?,
            packages: null == packages
                ? _value.packages
                : packages // ignore: cast_nullable_to_non_nullable
                      as List<Package>,
            galleryImages: null == galleryImages
                ? _value.galleryImages
                : galleryImages // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            amenities: null == amenities
                ? _value.amenities
                : amenities // ignore: cast_nullable_to_non_nullable
                      as List<Amenity>,
            pricing: freezed == pricing
                ? _value.pricing
                : pricing // ignore: cast_nullable_to_non_nullable
                      as VillaPricing?,
            seasonalPricing: freezed == seasonalPricing
                ? _value.seasonalPricing
                : seasonalPricing // ignore: cast_nullable_to_non_nullable
                      as SeasonalPricing?,
            houseRules: null == houseRules
                ? _value.houseRules
                : houseRules // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            checkIn: freezed == checkIn
                ? _value.checkIn
                : checkIn // ignore: cast_nullable_to_non_nullable
                      as String?,
            checkOut: freezed == checkOut
                ? _value.checkOut
                : checkOut // ignore: cast_nullable_to_non_nullable
                      as String?,
            maxGuests: freezed == maxGuests
                ? _value.maxGuests
                : maxGuests // ignore: cast_nullable_to_non_nullable
                      as int?,
            bedrooms: freezed == bedrooms
                ? _value.bedrooms
                : bedrooms // ignore: cast_nullable_to_non_nullable
                      as int?,
            bathrooms: freezed == bathrooms
                ? _value.bathrooms
                : bathrooms // ignore: cast_nullable_to_non_nullable
                      as int?,
            servicesOffered: null == servicesOffered
                ? _value.servicesOffered
                : servicesOffered // ignore: cast_nullable_to_non_nullable
                      as List<ServiceOffered>,
            priceRange: freezed == priceRange
                ? _value.priceRange
                : priceRange // ignore: cast_nullable_to_non_nullable
                      as PriceRange?,
            serviceAreas: null == serviceAreas
                ? _value.serviceAreas
                : serviceAreas // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            alerts: null == alerts
                ? _value.alerts
                : alerts // ignore: cast_nullable_to_non_nullable
                      as List<PageAlert>,
            aboutExtended: freezed == aboutExtended
                ? _value.aboutExtended
                : aboutExtended // ignore: cast_nullable_to_non_nullable
                      as String?,
            servicesLinks: null == servicesLinks
                ? _value.servicesLinks
                : servicesLinks // ignore: cast_nullable_to_non_nullable
                      as List<ServiceLink>,
            pinnedPosts: null == pinnedPosts
                ? _value.pinnedPosts
                : pinnedPosts // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            stories: null == stories
                ? _value.stories
                : stories // ignore: cast_nullable_to_non_nullable
                      as List<PageStory>,
            weeklySchedule: freezed == weeklySchedule
                ? _value.weeklySchedule
                : weeklySchedule // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            blockedDates: null == blockedDates
                ? _value.blockedDates
                : blockedDates // ignore: cast_nullable_to_non_nullable
                      as List<BlockedDate>,
            dataSynced: null == dataSynced
                ? _value.dataSynced
                : dataSynced // ignore: cast_nullable_to_non_nullable
                      as bool,
            venueId: freezed == venueId
                ? _value.venueId
                : venueId // ignore: cast_nullable_to_non_nullable
                      as String?,
            venueName: freezed == venueName
                ? _value.venueName
                : venueName // ignore: cast_nullable_to_non_nullable
                      as String?,
            venueUnit: freezed == venueUnit
                ? _value.venueUnit
                : venueUnit // ignore: cast_nullable_to_non_nullable
                      as String?,
            venueFloor: freezed == venueFloor
                ? _value.venueFloor
                : venueFloor // ignore: cast_nullable_to_non_nullable
                      as String?,
            mallAnnouncements: null == mallAnnouncements
                ? _value.mallAnnouncements
                : mallAnnouncements // ignore: cast_nullable_to_non_nullable
                      as List<MallAnnouncement>,
            featuredTenantIds: null == featuredTenantIds
                ? _value.featuredTenantIds
                : featuredTenantIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            directoryStats: freezed == directoryStats
                ? _value.directoryStats
                : directoryStats // ignore: cast_nullable_to_non_nullable
                      as DirectoryStats?,
            parkingInfo: freezed == parkingInfo
                ? _value.parkingInfo
                : parkingInfo // ignore: cast_nullable_to_non_nullable
                      as String?,
            carryCategories: null == carryCategories
                ? _value.carryCategories
                : carryCategories // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }

  /// Create a copy of PageDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TemporarilyClosedCopyWith<$Res>? get temporarilyClosed {
    if (_value.temporarilyClosed == null) {
      return null;
    }

    return $TemporarilyClosedCopyWith<$Res>(_value.temporarilyClosed!, (value) {
      return _then(_value.copyWith(temporarilyClosed: value) as $Val);
    });
  }

  /// Create a copy of PageDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RelocatedCopyWith<$Res>? get relocated {
    if (_value.relocated == null) {
      return null;
    }

    return $RelocatedCopyWith<$Res>(_value.relocated!, (value) {
      return _then(_value.copyWith(relocated: value) as $Val);
    });
  }

  /// Create a copy of PageDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReturnPolicyCopyWith<$Res>? get returnPolicy {
    if (_value.returnPolicy == null) {
      return null;
    }

    return $ReturnPolicyCopyWith<$Res>(_value.returnPolicy!, (value) {
      return _then(_value.copyWith(returnPolicy: value) as $Val);
    });
  }

  /// Create a copy of PageDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $LocationCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  /// Create a copy of PageDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PageHoursCopyWith<$Res>? get hours {
    if (_value.hours == null) {
      return null;
    }

    return $PageHoursCopyWith<$Res>(_value.hours!, (value) {
      return _then(_value.copyWith(hours: value) as $Val);
    });
  }

  /// Create a copy of PageDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PriceChangeCopyWith<$Res>? get activePriceChange {
    if (_value.activePriceChange == null) {
      return null;
    }

    return $PriceChangeCopyWith<$Res>(_value.activePriceChange!, (value) {
      return _then(_value.copyWith(activePriceChange: value) as $Val);
    });
  }

  /// Create a copy of PageDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VillaPricingCopyWith<$Res>? get pricing {
    if (_value.pricing == null) {
      return null;
    }

    return $VillaPricingCopyWith<$Res>(_value.pricing!, (value) {
      return _then(_value.copyWith(pricing: value) as $Val);
    });
  }

  /// Create a copy of PageDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeasonalPricingCopyWith<$Res>? get seasonalPricing {
    if (_value.seasonalPricing == null) {
      return null;
    }

    return $SeasonalPricingCopyWith<$Res>(_value.seasonalPricing!, (value) {
      return _then(_value.copyWith(seasonalPricing: value) as $Val);
    });
  }

  /// Create a copy of PageDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PriceRangeCopyWith<$Res>? get priceRange {
    if (_value.priceRange == null) {
      return null;
    }

    return $PriceRangeCopyWith<$Res>(_value.priceRange!, (value) {
      return _then(_value.copyWith(priceRange: value) as $Val);
    });
  }

  /// Create a copy of PageDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DirectoryStatsCopyWith<$Res>? get directoryStats {
    if (_value.directoryStats == null) {
      return null;
    }

    return $DirectoryStatsCopyWith<$Res>(_value.directoryStats!, (value) {
      return _then(_value.copyWith(directoryStats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PageDetailImplCopyWith<$Res>
    implements $PageDetailCopyWith<$Res> {
  factory _$$PageDetailImplCopyWith(
    _$PageDetailImpl value,
    $Res Function(_$PageDetailImpl) then,
  ) = __$$PageDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'name_en') String? nameEn,
    String slug,
    String? handle,
    String? description,
    @JsonKey(name: 'description_en') String? descriptionEn,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'cover_url') String? coverUrl,
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
    @JsonKey(name: 'requires_approval') bool requiresApproval,
    @JsonKey(name: 'trust_score') int trustScore,
    @JsonKey(name: 'trust_metrics') List<TrustMetric> trustMetrics,
    @JsonKey(name: 'response_time') String? responseTime,
    @JsonKey(name: 'completion_rate') double? completionRate,
    @JsonKey(name: 'total_orders') int totalOrders,
    @JsonKey(name: 'member_since') String? memberSince,
    @JsonKey(name: 'is_verified') bool isVerified,
    @JsonKey(name: 'is_open') bool isOpen,
    @JsonKey(name: 'page_status') String pageStatus,
    @JsonKey(name: 'claim_status') String claimStatus,
    @JsonKey(name: 'temporarily_closed') TemporarilyClosed? temporarilyClosed,
    Relocated? relocated,
    @JsonKey(name: 'permanently_closed') bool permanentlyClosed,
    @JsonKey(name: 'operating_hours') String? operatingHours,
    @JsonKey(name: 'working_hours') Map<String, dynamic>? workingHours,
    @JsonKey(name: 'payment_methods') List<String> paymentMethods,
    @JsonKey(name: 'cliq_alias') String? cliqAlias,
    @JsonKey(name: 'bank_info') Map<String, dynamic>? bankInfo,
    @JsonKey(name: 'coverage_zones') List<String> coverageZones,
    List<Branch> branches,
    @JsonKey(name: 'coverage_zones_structured')
    List<CoverageZone> coverageZonesStructured,
    @JsonKey(name: 'return_policy') ReturnPolicy? returnPolicy,
    @JsonKey(name: 'cancellation_policy') String? cancellationPolicy,
    @JsonKey(name: 'external_links') List<ExternalLink> externalLinks,
    @JsonKey(name: 'delivery_available') bool deliveryAvailable,
    @JsonKey(name: 'pickup_available') bool pickupAvailable,
    @JsonKey(name: 'booking_available') bool bookingAvailable,
    @JsonKey(name: 'minimum_order_cents') int? minimumOrderCents,
    @JsonKey(name: 'delivery_fee_cents') int? deliveryFeeCents,
    @JsonKey(name: 'estimated_delivery_minutes') int? estimatedDeliveryMinutes,
    @JsonKey(name: 'followers_count') int followersCount,
    @JsonKey(name: 'posts_count') int postsCount,
    @JsonKey(name: 'items_count') int itemsCount,
    @JsonKey(name: 'is_following') bool isFollowing,
    @JsonKey(name: 'team_members_count') int teamMembersCount,
    String? phone,
    String? whatsapp,
    String? address,
    Location? location,
    PageHours? hours,
    @JsonKey(name: 'catalog_strategy') String? catalogStrategy,
    @JsonKey(name: 'featured_items_count') int featuredItemsCount,
    @JsonKey(name: 'contact_methods') List<String> contactMethods,
    List<String> specials,
    @JsonKey(name: 'modifiers_note') String? modifiersNote,
    @JsonKey(name: 'active_price_change') PriceChange? activePriceChange,
    List<Package> packages,
    @JsonKey(name: 'gallery_images') List<String> galleryImages,
    List<Amenity> amenities,
    VillaPricing? pricing,
    @JsonKey(name: 'seasonal_pricing') SeasonalPricing? seasonalPricing,
    @JsonKey(name: 'house_rules') List<String> houseRules,
    @JsonKey(name: 'check_in') String? checkIn,
    @JsonKey(name: 'check_out') String? checkOut,
    @JsonKey(name: 'max_guests') int? maxGuests,
    int? bedrooms,
    int? bathrooms,
    @JsonKey(name: 'services_offered') List<ServiceOffered> servicesOffered,
    @JsonKey(name: 'price_range') PriceRange? priceRange,
    @JsonKey(name: 'service_areas') List<String> serviceAreas,
    List<PageAlert> alerts,
    @JsonKey(name: 'about_extended') String? aboutExtended,
    @JsonKey(name: 'services_links') List<ServiceLink> servicesLinks,
    @JsonKey(name: 'pinned_posts') List<String> pinnedPosts,
    List<PageStory> stories,
    @JsonKey(name: 'weekly_schedule') Map<String, dynamic>? weeklySchedule,
    @JsonKey(name: 'blocked_dates') List<BlockedDate> blockedDates,
    @JsonKey(name: 'data_synced') bool dataSynced,
    @JsonKey(name: 'venue_id') String? venueId,
    @JsonKey(name: 'venue_name') String? venueName,
    @JsonKey(name: 'venue_unit') String? venueUnit,
    @JsonKey(name: 'venue_floor') String? venueFloor,
    @JsonKey(name: 'mall_announcements')
    List<MallAnnouncement> mallAnnouncements,
    @JsonKey(name: 'featured_tenant_ids') List<String> featuredTenantIds,
    @JsonKey(name: 'directory_stats') DirectoryStats? directoryStats,
    @JsonKey(name: 'parking_info') String? parkingInfo,
    @JsonKey(name: 'carry_categories') List<String> carryCategories,
  });

  @override
  $TemporarilyClosedCopyWith<$Res>? get temporarilyClosed;
  @override
  $RelocatedCopyWith<$Res>? get relocated;
  @override
  $ReturnPolicyCopyWith<$Res>? get returnPolicy;
  @override
  $LocationCopyWith<$Res>? get location;
  @override
  $PageHoursCopyWith<$Res>? get hours;
  @override
  $PriceChangeCopyWith<$Res>? get activePriceChange;
  @override
  $VillaPricingCopyWith<$Res>? get pricing;
  @override
  $SeasonalPricingCopyWith<$Res>? get seasonalPricing;
  @override
  $PriceRangeCopyWith<$Res>? get priceRange;
  @override
  $DirectoryStatsCopyWith<$Res>? get directoryStats;
}

/// @nodoc
class __$$PageDetailImplCopyWithImpl<$Res>
    extends _$PageDetailCopyWithImpl<$Res, _$PageDetailImpl>
    implements _$$PageDetailImplCopyWith<$Res> {
  __$$PageDetailImplCopyWithImpl(
    _$PageDetailImpl _value,
    $Res Function(_$PageDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PageDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = freezed,
    Object? slug = null,
    Object? handle = freezed,
    Object? description = freezed,
    Object? descriptionEn = freezed,
    Object? avatarUrl = freezed,
    Object? coverUrl = freezed,
    Object? archetype = freezed,
    Object? businessTypeId = freezed,
    Object? businessTypeName = freezed,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? exploreCategory = freezed,
    Object? itemsLabelAr = freezed,
    Object? itemsLabelEn = freezed,
    Object? storeType = freezed,
    Object? engagementLevel = freezed,
    Object? requiresApproval = null,
    Object? trustScore = null,
    Object? trustMetrics = null,
    Object? responseTime = freezed,
    Object? completionRate = freezed,
    Object? totalOrders = null,
    Object? memberSince = freezed,
    Object? isVerified = null,
    Object? isOpen = null,
    Object? pageStatus = null,
    Object? claimStatus = null,
    Object? temporarilyClosed = freezed,
    Object? relocated = freezed,
    Object? permanentlyClosed = null,
    Object? operatingHours = freezed,
    Object? workingHours = freezed,
    Object? paymentMethods = null,
    Object? cliqAlias = freezed,
    Object? bankInfo = freezed,
    Object? coverageZones = null,
    Object? branches = null,
    Object? coverageZonesStructured = null,
    Object? returnPolicy = freezed,
    Object? cancellationPolicy = freezed,
    Object? externalLinks = null,
    Object? deliveryAvailable = null,
    Object? pickupAvailable = null,
    Object? bookingAvailable = null,
    Object? minimumOrderCents = freezed,
    Object? deliveryFeeCents = freezed,
    Object? estimatedDeliveryMinutes = freezed,
    Object? followersCount = null,
    Object? postsCount = null,
    Object? itemsCount = null,
    Object? isFollowing = null,
    Object? teamMembersCount = null,
    Object? phone = freezed,
    Object? whatsapp = freezed,
    Object? address = freezed,
    Object? location = freezed,
    Object? hours = freezed,
    Object? catalogStrategy = freezed,
    Object? featuredItemsCount = null,
    Object? contactMethods = null,
    Object? specials = null,
    Object? modifiersNote = freezed,
    Object? activePriceChange = freezed,
    Object? packages = null,
    Object? galleryImages = null,
    Object? amenities = null,
    Object? pricing = freezed,
    Object? seasonalPricing = freezed,
    Object? houseRules = null,
    Object? checkIn = freezed,
    Object? checkOut = freezed,
    Object? maxGuests = freezed,
    Object? bedrooms = freezed,
    Object? bathrooms = freezed,
    Object? servicesOffered = null,
    Object? priceRange = freezed,
    Object? serviceAreas = null,
    Object? alerts = null,
    Object? aboutExtended = freezed,
    Object? servicesLinks = null,
    Object? pinnedPosts = null,
    Object? stories = null,
    Object? weeklySchedule = freezed,
    Object? blockedDates = null,
    Object? dataSynced = null,
    Object? venueId = freezed,
    Object? venueName = freezed,
    Object? venueUnit = freezed,
    Object? venueFloor = freezed,
    Object? mallAnnouncements = null,
    Object? featuredTenantIds = null,
    Object? directoryStats = freezed,
    Object? parkingInfo = freezed,
    Object? carryCategories = null,
  }) {
    return _then(
      _$PageDetailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        nameEn: freezed == nameEn
            ? _value.nameEn
            : nameEn // ignore: cast_nullable_to_non_nullable
                  as String?,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        handle: freezed == handle
            ? _value.handle
            : handle // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        descriptionEn: freezed == descriptionEn
            ? _value.descriptionEn
            : descriptionEn // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        coverUrl: freezed == coverUrl
            ? _value.coverUrl
            : coverUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        archetype: freezed == archetype
            ? _value.archetype
            : archetype // ignore: cast_nullable_to_non_nullable
                  as String?,
        businessTypeId: freezed == businessTypeId
            ? _value.businessTypeId
            : businessTypeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        businessTypeName: freezed == businessTypeName
            ? _value.businessTypeName
            : businessTypeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryName: freezed == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String?,
        exploreCategory: freezed == exploreCategory
            ? _value.exploreCategory
            : exploreCategory // ignore: cast_nullable_to_non_nullable
                  as String?,
        itemsLabelAr: freezed == itemsLabelAr
            ? _value.itemsLabelAr
            : itemsLabelAr // ignore: cast_nullable_to_non_nullable
                  as String?,
        itemsLabelEn: freezed == itemsLabelEn
            ? _value.itemsLabelEn
            : itemsLabelEn // ignore: cast_nullable_to_non_nullable
                  as String?,
        storeType: freezed == storeType
            ? _value.storeType
            : storeType // ignore: cast_nullable_to_non_nullable
                  as String?,
        engagementLevel: freezed == engagementLevel
            ? _value.engagementLevel
            : engagementLevel // ignore: cast_nullable_to_non_nullable
                  as String?,
        requiresApproval: null == requiresApproval
            ? _value.requiresApproval
            : requiresApproval // ignore: cast_nullable_to_non_nullable
                  as bool,
        trustScore: null == trustScore
            ? _value.trustScore
            : trustScore // ignore: cast_nullable_to_non_nullable
                  as int,
        trustMetrics: null == trustMetrics
            ? _value._trustMetrics
            : trustMetrics // ignore: cast_nullable_to_non_nullable
                  as List<TrustMetric>,
        responseTime: freezed == responseTime
            ? _value.responseTime
            : responseTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        completionRate: freezed == completionRate
            ? _value.completionRate
            : completionRate // ignore: cast_nullable_to_non_nullable
                  as double?,
        totalOrders: null == totalOrders
            ? _value.totalOrders
            : totalOrders // ignore: cast_nullable_to_non_nullable
                  as int,
        memberSince: freezed == memberSince
            ? _value.memberSince
            : memberSince // ignore: cast_nullable_to_non_nullable
                  as String?,
        isVerified: null == isVerified
            ? _value.isVerified
            : isVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        isOpen: null == isOpen
            ? _value.isOpen
            : isOpen // ignore: cast_nullable_to_non_nullable
                  as bool,
        pageStatus: null == pageStatus
            ? _value.pageStatus
            : pageStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        claimStatus: null == claimStatus
            ? _value.claimStatus
            : claimStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        temporarilyClosed: freezed == temporarilyClosed
            ? _value.temporarilyClosed
            : temporarilyClosed // ignore: cast_nullable_to_non_nullable
                  as TemporarilyClosed?,
        relocated: freezed == relocated
            ? _value.relocated
            : relocated // ignore: cast_nullable_to_non_nullable
                  as Relocated?,
        permanentlyClosed: null == permanentlyClosed
            ? _value.permanentlyClosed
            : permanentlyClosed // ignore: cast_nullable_to_non_nullable
                  as bool,
        operatingHours: freezed == operatingHours
            ? _value.operatingHours
            : operatingHours // ignore: cast_nullable_to_non_nullable
                  as String?,
        workingHours: freezed == workingHours
            ? _value._workingHours
            : workingHours // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        paymentMethods: null == paymentMethods
            ? _value._paymentMethods
            : paymentMethods // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        cliqAlias: freezed == cliqAlias
            ? _value.cliqAlias
            : cliqAlias // ignore: cast_nullable_to_non_nullable
                  as String?,
        bankInfo: freezed == bankInfo
            ? _value._bankInfo
            : bankInfo // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        coverageZones: null == coverageZones
            ? _value._coverageZones
            : coverageZones // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        branches: null == branches
            ? _value._branches
            : branches // ignore: cast_nullable_to_non_nullable
                  as List<Branch>,
        coverageZonesStructured: null == coverageZonesStructured
            ? _value._coverageZonesStructured
            : coverageZonesStructured // ignore: cast_nullable_to_non_nullable
                  as List<CoverageZone>,
        returnPolicy: freezed == returnPolicy
            ? _value.returnPolicy
            : returnPolicy // ignore: cast_nullable_to_non_nullable
                  as ReturnPolicy?,
        cancellationPolicy: freezed == cancellationPolicy
            ? _value.cancellationPolicy
            : cancellationPolicy // ignore: cast_nullable_to_non_nullable
                  as String?,
        externalLinks: null == externalLinks
            ? _value._externalLinks
            : externalLinks // ignore: cast_nullable_to_non_nullable
                  as List<ExternalLink>,
        deliveryAvailable: null == deliveryAvailable
            ? _value.deliveryAvailable
            : deliveryAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
        pickupAvailable: null == pickupAvailable
            ? _value.pickupAvailable
            : pickupAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
        bookingAvailable: null == bookingAvailable
            ? _value.bookingAvailable
            : bookingAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
        minimumOrderCents: freezed == minimumOrderCents
            ? _value.minimumOrderCents
            : minimumOrderCents // ignore: cast_nullable_to_non_nullable
                  as int?,
        deliveryFeeCents: freezed == deliveryFeeCents
            ? _value.deliveryFeeCents
            : deliveryFeeCents // ignore: cast_nullable_to_non_nullable
                  as int?,
        estimatedDeliveryMinutes: freezed == estimatedDeliveryMinutes
            ? _value.estimatedDeliveryMinutes
            : estimatedDeliveryMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        followersCount: null == followersCount
            ? _value.followersCount
            : followersCount // ignore: cast_nullable_to_non_nullable
                  as int,
        postsCount: null == postsCount
            ? _value.postsCount
            : postsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        itemsCount: null == itemsCount
            ? _value.itemsCount
            : itemsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isFollowing: null == isFollowing
            ? _value.isFollowing
            : isFollowing // ignore: cast_nullable_to_non_nullable
                  as bool,
        teamMembersCount: null == teamMembersCount
            ? _value.teamMembersCount
            : teamMembersCount // ignore: cast_nullable_to_non_nullable
                  as int,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        whatsapp: freezed == whatsapp
            ? _value.whatsapp
            : whatsapp // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as Location?,
        hours: freezed == hours
            ? _value.hours
            : hours // ignore: cast_nullable_to_non_nullable
                  as PageHours?,
        catalogStrategy: freezed == catalogStrategy
            ? _value.catalogStrategy
            : catalogStrategy // ignore: cast_nullable_to_non_nullable
                  as String?,
        featuredItemsCount: null == featuredItemsCount
            ? _value.featuredItemsCount
            : featuredItemsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        contactMethods: null == contactMethods
            ? _value._contactMethods
            : contactMethods // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        specials: null == specials
            ? _value._specials
            : specials // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        modifiersNote: freezed == modifiersNote
            ? _value.modifiersNote
            : modifiersNote // ignore: cast_nullable_to_non_nullable
                  as String?,
        activePriceChange: freezed == activePriceChange
            ? _value.activePriceChange
            : activePriceChange // ignore: cast_nullable_to_non_nullable
                  as PriceChange?,
        packages: null == packages
            ? _value._packages
            : packages // ignore: cast_nullable_to_non_nullable
                  as List<Package>,
        galleryImages: null == galleryImages
            ? _value._galleryImages
            : galleryImages // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        amenities: null == amenities
            ? _value._amenities
            : amenities // ignore: cast_nullable_to_non_nullable
                  as List<Amenity>,
        pricing: freezed == pricing
            ? _value.pricing
            : pricing // ignore: cast_nullable_to_non_nullable
                  as VillaPricing?,
        seasonalPricing: freezed == seasonalPricing
            ? _value.seasonalPricing
            : seasonalPricing // ignore: cast_nullable_to_non_nullable
                  as SeasonalPricing?,
        houseRules: null == houseRules
            ? _value._houseRules
            : houseRules // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        checkIn: freezed == checkIn
            ? _value.checkIn
            : checkIn // ignore: cast_nullable_to_non_nullable
                  as String?,
        checkOut: freezed == checkOut
            ? _value.checkOut
            : checkOut // ignore: cast_nullable_to_non_nullable
                  as String?,
        maxGuests: freezed == maxGuests
            ? _value.maxGuests
            : maxGuests // ignore: cast_nullable_to_non_nullable
                  as int?,
        bedrooms: freezed == bedrooms
            ? _value.bedrooms
            : bedrooms // ignore: cast_nullable_to_non_nullable
                  as int?,
        bathrooms: freezed == bathrooms
            ? _value.bathrooms
            : bathrooms // ignore: cast_nullable_to_non_nullable
                  as int?,
        servicesOffered: null == servicesOffered
            ? _value._servicesOffered
            : servicesOffered // ignore: cast_nullable_to_non_nullable
                  as List<ServiceOffered>,
        priceRange: freezed == priceRange
            ? _value.priceRange
            : priceRange // ignore: cast_nullable_to_non_nullable
                  as PriceRange?,
        serviceAreas: null == serviceAreas
            ? _value._serviceAreas
            : serviceAreas // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        alerts: null == alerts
            ? _value._alerts
            : alerts // ignore: cast_nullable_to_non_nullable
                  as List<PageAlert>,
        aboutExtended: freezed == aboutExtended
            ? _value.aboutExtended
            : aboutExtended // ignore: cast_nullable_to_non_nullable
                  as String?,
        servicesLinks: null == servicesLinks
            ? _value._servicesLinks
            : servicesLinks // ignore: cast_nullable_to_non_nullable
                  as List<ServiceLink>,
        pinnedPosts: null == pinnedPosts
            ? _value._pinnedPosts
            : pinnedPosts // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        stories: null == stories
            ? _value._stories
            : stories // ignore: cast_nullable_to_non_nullable
                  as List<PageStory>,
        weeklySchedule: freezed == weeklySchedule
            ? _value._weeklySchedule
            : weeklySchedule // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        blockedDates: null == blockedDates
            ? _value._blockedDates
            : blockedDates // ignore: cast_nullable_to_non_nullable
                  as List<BlockedDate>,
        dataSynced: null == dataSynced
            ? _value.dataSynced
            : dataSynced // ignore: cast_nullable_to_non_nullable
                  as bool,
        venueId: freezed == venueId
            ? _value.venueId
            : venueId // ignore: cast_nullable_to_non_nullable
                  as String?,
        venueName: freezed == venueName
            ? _value.venueName
            : venueName // ignore: cast_nullable_to_non_nullable
                  as String?,
        venueUnit: freezed == venueUnit
            ? _value.venueUnit
            : venueUnit // ignore: cast_nullable_to_non_nullable
                  as String?,
        venueFloor: freezed == venueFloor
            ? _value.venueFloor
            : venueFloor // ignore: cast_nullable_to_non_nullable
                  as String?,
        mallAnnouncements: null == mallAnnouncements
            ? _value._mallAnnouncements
            : mallAnnouncements // ignore: cast_nullable_to_non_nullable
                  as List<MallAnnouncement>,
        featuredTenantIds: null == featuredTenantIds
            ? _value._featuredTenantIds
            : featuredTenantIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        directoryStats: freezed == directoryStats
            ? _value.directoryStats
            : directoryStats // ignore: cast_nullable_to_non_nullable
                  as DirectoryStats?,
        parkingInfo: freezed == parkingInfo
            ? _value.parkingInfo
            : parkingInfo // ignore: cast_nullable_to_non_nullable
                  as String?,
        carryCategories: null == carryCategories
            ? _value._carryCategories
            : carryCategories // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PageDetailImpl implements _PageDetail {
  const _$PageDetailImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'name_en') this.nameEn,
    required this.slug,
    this.handle,
    this.description,
    @JsonKey(name: 'description_en') this.descriptionEn,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    @JsonKey(name: 'cover_url') this.coverUrl,
    this.archetype,
    @JsonKey(name: 'business_type_id') this.businessTypeId,
    @JsonKey(name: 'business_type_name') this.businessTypeName,
    @JsonKey(name: 'category_id') this.categoryId,
    @JsonKey(name: 'category_name') this.categoryName,
    @JsonKey(name: 'explore_category') this.exploreCategory,
    @JsonKey(name: 'items_label_ar') this.itemsLabelAr,
    @JsonKey(name: 'items_label_en') this.itemsLabelEn,
    @JsonKey(name: 'store_type') this.storeType,
    @JsonKey(name: 'engagement_level') this.engagementLevel,
    @JsonKey(name: 'requires_approval') this.requiresApproval = false,
    @JsonKey(name: 'trust_score') this.trustScore = 0,
    @JsonKey(name: 'trust_metrics')
    final List<TrustMetric> trustMetrics = const [],
    @JsonKey(name: 'response_time') this.responseTime,
    @JsonKey(name: 'completion_rate') this.completionRate,
    @JsonKey(name: 'total_orders') this.totalOrders = 0,
    @JsonKey(name: 'member_since') this.memberSince,
    @JsonKey(name: 'is_verified') this.isVerified = false,
    @JsonKey(name: 'is_open') this.isOpen = true,
    @JsonKey(name: 'page_status') this.pageStatus = 'active',
    @JsonKey(name: 'claim_status') this.claimStatus = 'claimed',
    @JsonKey(name: 'temporarily_closed') this.temporarilyClosed,
    this.relocated,
    @JsonKey(name: 'permanently_closed') this.permanentlyClosed = false,
    @JsonKey(name: 'operating_hours') this.operatingHours,
    @JsonKey(name: 'working_hours') final Map<String, dynamic>? workingHours,
    @JsonKey(name: 'payment_methods')
    final List<String> paymentMethods = const [],
    @JsonKey(name: 'cliq_alias') this.cliqAlias,
    @JsonKey(name: 'bank_info') final Map<String, dynamic>? bankInfo,
    @JsonKey(name: 'coverage_zones')
    final List<String> coverageZones = const [],
    final List<Branch> branches = const [],
    @JsonKey(name: 'coverage_zones_structured')
    final List<CoverageZone> coverageZonesStructured = const [],
    @JsonKey(name: 'return_policy') this.returnPolicy,
    @JsonKey(name: 'cancellation_policy') this.cancellationPolicy,
    @JsonKey(name: 'external_links')
    final List<ExternalLink> externalLinks = const [],
    @JsonKey(name: 'delivery_available') this.deliveryAvailable = false,
    @JsonKey(name: 'pickup_available') this.pickupAvailable = false,
    @JsonKey(name: 'booking_available') this.bookingAvailable = false,
    @JsonKey(name: 'minimum_order_cents') this.minimumOrderCents,
    @JsonKey(name: 'delivery_fee_cents') this.deliveryFeeCents,
    @JsonKey(name: 'estimated_delivery_minutes') this.estimatedDeliveryMinutes,
    @JsonKey(name: 'followers_count') this.followersCount = 0,
    @JsonKey(name: 'posts_count') this.postsCount = 0,
    @JsonKey(name: 'items_count') this.itemsCount = 0,
    @JsonKey(name: 'is_following') this.isFollowing = false,
    @JsonKey(name: 'team_members_count') this.teamMembersCount = 0,
    this.phone,
    this.whatsapp,
    this.address,
    this.location,
    this.hours,
    @JsonKey(name: 'catalog_strategy') this.catalogStrategy,
    @JsonKey(name: 'featured_items_count') this.featuredItemsCount = 0,
    @JsonKey(name: 'contact_methods')
    final List<String> contactMethods = const [],
    final List<String> specials = const [],
    @JsonKey(name: 'modifiers_note') this.modifiersNote,
    @JsonKey(name: 'active_price_change') this.activePriceChange,
    final List<Package> packages = const [],
    @JsonKey(name: 'gallery_images')
    final List<String> galleryImages = const [],
    final List<Amenity> amenities = const [],
    this.pricing,
    @JsonKey(name: 'seasonal_pricing') this.seasonalPricing,
    @JsonKey(name: 'house_rules') final List<String> houseRules = const [],
    @JsonKey(name: 'check_in') this.checkIn,
    @JsonKey(name: 'check_out') this.checkOut,
    @JsonKey(name: 'max_guests') this.maxGuests,
    this.bedrooms,
    this.bathrooms,
    @JsonKey(name: 'services_offered')
    final List<ServiceOffered> servicesOffered = const [],
    @JsonKey(name: 'price_range') this.priceRange,
    @JsonKey(name: 'service_areas') final List<String> serviceAreas = const [],
    final List<PageAlert> alerts = const [],
    @JsonKey(name: 'about_extended') this.aboutExtended,
    @JsonKey(name: 'services_links')
    final List<ServiceLink> servicesLinks = const [],
    @JsonKey(name: 'pinned_posts') final List<String> pinnedPosts = const [],
    final List<PageStory> stories = const [],
    @JsonKey(name: 'weekly_schedule')
    final Map<String, dynamic>? weeklySchedule,
    @JsonKey(name: 'blocked_dates')
    final List<BlockedDate> blockedDates = const [],
    @JsonKey(name: 'data_synced') this.dataSynced = true,
    @JsonKey(name: 'venue_id') this.venueId,
    @JsonKey(name: 'venue_name') this.venueName,
    @JsonKey(name: 'venue_unit') this.venueUnit,
    @JsonKey(name: 'venue_floor') this.venueFloor,
    @JsonKey(name: 'mall_announcements')
    final List<MallAnnouncement> mallAnnouncements = const [],
    @JsonKey(name: 'featured_tenant_ids')
    final List<String> featuredTenantIds = const [],
    @JsonKey(name: 'directory_stats') this.directoryStats,
    @JsonKey(name: 'parking_info') this.parkingInfo,
    @JsonKey(name: 'carry_categories')
    final List<String> carryCategories = const [],
  }) : _trustMetrics = trustMetrics,
       _workingHours = workingHours,
       _paymentMethods = paymentMethods,
       _bankInfo = bankInfo,
       _coverageZones = coverageZones,
       _branches = branches,
       _coverageZonesStructured = coverageZonesStructured,
       _externalLinks = externalLinks,
       _contactMethods = contactMethods,
       _specials = specials,
       _packages = packages,
       _galleryImages = galleryImages,
       _amenities = amenities,
       _houseRules = houseRules,
       _servicesOffered = servicesOffered,
       _serviceAreas = serviceAreas,
       _alerts = alerts,
       _servicesLinks = servicesLinks,
       _pinnedPosts = pinnedPosts,
       _stories = stories,
       _weeklySchedule = weeklySchedule,
       _blockedDates = blockedDates,
       _mallAnnouncements = mallAnnouncements,
       _featuredTenantIds = featuredTenantIds,
       _carryCategories = carryCategories;

  factory _$PageDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$PageDetailImplFromJson(json);

  // Core
  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'name_en')
  final String? nameEn;
  @override
  final String slug;
  @override
  final String? handle;
  @override
  final String? description;
  @override
  @JsonKey(name: 'description_en')
  final String? descriptionEn;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'cover_url')
  final String? coverUrl;
  // Business
  @override
  final String? archetype;
  @override
  @JsonKey(name: 'business_type_id')
  final String? businessTypeId;
  @override
  @JsonKey(name: 'business_type_name')
  final String? businessTypeName;
  @override
  @JsonKey(name: 'category_id')
  final String? categoryId;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @override
  @JsonKey(name: 'explore_category')
  final String? exploreCategory;
  @override
  @JsonKey(name: 'items_label_ar')
  final String? itemsLabelAr;
  @override
  @JsonKey(name: 'items_label_en')
  final String? itemsLabelEn;
  @override
  @JsonKey(name: 'store_type')
  final String? storeType;
  @override
  @JsonKey(name: 'engagement_level')
  final String? engagementLevel;
  @override
  @JsonKey(name: 'requires_approval')
  final bool requiresApproval;
  // Trust
  @override
  @JsonKey(name: 'trust_score')
  final int trustScore;
  final List<TrustMetric> _trustMetrics;
  @override
  @JsonKey(name: 'trust_metrics')
  List<TrustMetric> get trustMetrics {
    if (_trustMetrics is EqualUnmodifiableListView) return _trustMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trustMetrics);
  }

  @override
  @JsonKey(name: 'response_time')
  final String? responseTime;
  @override
  @JsonKey(name: 'completion_rate')
  final double? completionRate;
  @override
  @JsonKey(name: 'total_orders')
  final int totalOrders;
  @override
  @JsonKey(name: 'member_since')
  final String? memberSince;
  // Status
  @override
  @JsonKey(name: 'is_verified')
  final bool isVerified;
  @override
  @JsonKey(name: 'is_open')
  final bool isOpen;
  @override
  @JsonKey(name: 'page_status')
  final String pageStatus;
  @override
  @JsonKey(name: 'claim_status')
  final String claimStatus;
  @override
  @JsonKey(name: 'temporarily_closed')
  final TemporarilyClosed? temporarilyClosed;
  @override
  final Relocated? relocated;
  @override
  @JsonKey(name: 'permanently_closed')
  final bool permanentlyClosed;
  // Operations
  @override
  @JsonKey(name: 'operating_hours')
  final String? operatingHours;
  final Map<String, dynamic>? _workingHours;
  @override
  @JsonKey(name: 'working_hours')
  Map<String, dynamic>? get workingHours {
    final value = _workingHours;
    if (value == null) return null;
    if (_workingHours is EqualUnmodifiableMapView) return _workingHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String> _paymentMethods;
  @override
  @JsonKey(name: 'payment_methods')
  List<String> get paymentMethods {
    if (_paymentMethods is EqualUnmodifiableListView) return _paymentMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentMethods);
  }

  @override
  @JsonKey(name: 'cliq_alias')
  final String? cliqAlias;
  final Map<String, dynamic>? _bankInfo;
  @override
  @JsonKey(name: 'bank_info')
  Map<String, dynamic>? get bankInfo {
    final value = _bankInfo;
    if (value == null) return null;
    if (_bankInfo is EqualUnmodifiableMapView) return _bankInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String> _coverageZones;
  @override
  @JsonKey(name: 'coverage_zones')
  List<String> get coverageZones {
    if (_coverageZones is EqualUnmodifiableListView) return _coverageZones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coverageZones);
  }

  // Enhanced operations
  final List<Branch> _branches;
  // Enhanced operations
  @override
  @JsonKey()
  List<Branch> get branches {
    if (_branches is EqualUnmodifiableListView) return _branches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_branches);
  }

  final List<CoverageZone> _coverageZonesStructured;
  @override
  @JsonKey(name: 'coverage_zones_structured')
  List<CoverageZone> get coverageZonesStructured {
    if (_coverageZonesStructured is EqualUnmodifiableListView)
      return _coverageZonesStructured;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coverageZonesStructured);
  }

  @override
  @JsonKey(name: 'return_policy')
  final ReturnPolicy? returnPolicy;
  @override
  @JsonKey(name: 'cancellation_policy')
  final String? cancellationPolicy;
  final List<ExternalLink> _externalLinks;
  @override
  @JsonKey(name: 'external_links')
  List<ExternalLink> get externalLinks {
    if (_externalLinks is EqualUnmodifiableListView) return _externalLinks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_externalLinks);
  }

  // Delivery
  @override
  @JsonKey(name: 'delivery_available')
  final bool deliveryAvailable;
  @override
  @JsonKey(name: 'pickup_available')
  final bool pickupAvailable;
  @override
  @JsonKey(name: 'booking_available')
  final bool bookingAvailable;
  @override
  @JsonKey(name: 'minimum_order_cents')
  final int? minimumOrderCents;
  @override
  @JsonKey(name: 'delivery_fee_cents')
  final int? deliveryFeeCents;
  @override
  @JsonKey(name: 'estimated_delivery_minutes')
  final int? estimatedDeliveryMinutes;
  // Social
  @override
  @JsonKey(name: 'followers_count')
  final int followersCount;
  @override
  @JsonKey(name: 'posts_count')
  final int postsCount;
  @override
  @JsonKey(name: 'items_count')
  final int itemsCount;
  @override
  @JsonKey(name: 'is_following')
  final bool isFollowing;
  // Team
  @override
  @JsonKey(name: 'team_members_count')
  final int teamMembersCount;
  // Contact
  @override
  final String? phone;
  @override
  final String? whatsapp;
  @override
  final String? address;
  @override
  final Location? location;
  @override
  final PageHours? hours;
  // Catalog
  @override
  @JsonKey(name: 'catalog_strategy')
  final String? catalogStrategy;
  @override
  @JsonKey(name: 'featured_items_count')
  final int featuredItemsCount;
  // Contact methods
  final List<String> _contactMethods;
  // Contact methods
  @override
  @JsonKey(name: 'contact_methods')
  List<String> get contactMethods {
    if (_contactMethods is EqualUnmodifiableListView) return _contactMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contactMethods);
  }

  // Catalog / Menu enhancements
  final List<String> _specials;
  // Catalog / Menu enhancements
  @override
  @JsonKey()
  List<String> get specials {
    if (_specials is EqualUnmodifiableListView) return _specials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_specials);
  }

  @override
  @JsonKey(name: 'modifiers_note')
  final String? modifiersNote;
  @override
  @JsonKey(name: 'active_price_change')
  final PriceChange? activePriceChange;
  final List<Package> _packages;
  @override
  @JsonKey()
  List<Package> get packages {
    if (_packages is EqualUnmodifiableListView) return _packages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_packages);
  }

  // Villa / Reservation enhancements
  final List<String> _galleryImages;
  // Villa / Reservation enhancements
  @override
  @JsonKey(name: 'gallery_images')
  List<String> get galleryImages {
    if (_galleryImages is EqualUnmodifiableListView) return _galleryImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_galleryImages);
  }

  final List<Amenity> _amenities;
  @override
  @JsonKey()
  List<Amenity> get amenities {
    if (_amenities is EqualUnmodifiableListView) return _amenities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_amenities);
  }

  @override
  final VillaPricing? pricing;
  @override
  @JsonKey(name: 'seasonal_pricing')
  final SeasonalPricing? seasonalPricing;
  final List<String> _houseRules;
  @override
  @JsonKey(name: 'house_rules')
  List<String> get houseRules {
    if (_houseRules is EqualUnmodifiableListView) return _houseRules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_houseRules);
  }

  @override
  @JsonKey(name: 'check_in')
  final String? checkIn;
  @override
  @JsonKey(name: 'check_out')
  final String? checkOut;
  @override
  @JsonKey(name: 'max_guests')
  final int? maxGuests;
  @override
  final int? bedrooms;
  @override
  final int? bathrooms;
  // Quote enhancements
  final List<ServiceOffered> _servicesOffered;
  // Quote enhancements
  @override
  @JsonKey(name: 'services_offered')
  List<ServiceOffered> get servicesOffered {
    if (_servicesOffered is EqualUnmodifiableListView) return _servicesOffered;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_servicesOffered);
  }

  @override
  @JsonKey(name: 'price_range')
  final PriceRange? priceRange;
  final List<String> _serviceAreas;
  @override
  @JsonKey(name: 'service_areas')
  List<String> get serviceAreas {
    if (_serviceAreas is EqualUnmodifiableListView) return _serviceAreas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_serviceAreas);
  }

  // Follow-only enhancements
  final List<PageAlert> _alerts;
  // Follow-only enhancements
  @override
  @JsonKey()
  List<PageAlert> get alerts {
    if (_alerts is EqualUnmodifiableListView) return _alerts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alerts);
  }

  @override
  @JsonKey(name: 'about_extended')
  final String? aboutExtended;
  final List<ServiceLink> _servicesLinks;
  @override
  @JsonKey(name: 'services_links')
  List<ServiceLink> get servicesLinks {
    if (_servicesLinks is EqualUnmodifiableListView) return _servicesLinks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_servicesLinks);
  }

  // Activity enhancements
  final List<String> _pinnedPosts;
  // Activity enhancements
  @override
  @JsonKey(name: 'pinned_posts')
  List<String> get pinnedPosts {
    if (_pinnedPosts is EqualUnmodifiableListView) return _pinnedPosts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pinnedPosts);
  }

  // Stories
  final List<PageStory> _stories;
  // Stories
  @override
  @JsonKey()
  List<PageStory> get stories {
    if (_stories is EqualUnmodifiableListView) return _stories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stories);
  }

  // Weekly schedule
  final Map<String, dynamic>? _weeklySchedule;
  // Weekly schedule
  @override
  @JsonKey(name: 'weekly_schedule')
  Map<String, dynamic>? get weeklySchedule {
    final value = _weeklySchedule;
    if (value == null) return null;
    if (_weeklySchedule is EqualUnmodifiableMapView) return _weeklySchedule;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  // Blocked dates
  final List<BlockedDate> _blockedDates;
  // Blocked dates
  @override
  @JsonKey(name: 'blocked_dates')
  List<BlockedDate> get blockedDates {
    if (_blockedDates is EqualUnmodifiableListView) return _blockedDates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blockedDates);
  }

  // Data sync flag
  @override
  @JsonKey(name: 'data_synced')
  final bool dataSynced;
  // Venue tenant fields
  @override
  @JsonKey(name: 'venue_id')
  final String? venueId;
  @override
  @JsonKey(name: 'venue_name')
  final String? venueName;
  @override
  @JsonKey(name: 'venue_unit')
  final String? venueUnit;
  @override
  @JsonKey(name: 'venue_floor')
  final String? venueFloor;
  // Directory-specific
  final List<MallAnnouncement> _mallAnnouncements;
  // Directory-specific
  @override
  @JsonKey(name: 'mall_announcements')
  List<MallAnnouncement> get mallAnnouncements {
    if (_mallAnnouncements is EqualUnmodifiableListView)
      return _mallAnnouncements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mallAnnouncements);
  }

  final List<String> _featuredTenantIds;
  @override
  @JsonKey(name: 'featured_tenant_ids')
  List<String> get featuredTenantIds {
    if (_featuredTenantIds is EqualUnmodifiableListView)
      return _featuredTenantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_featuredTenantIds);
  }

  @override
  @JsonKey(name: 'directory_stats')
  final DirectoryStats? directoryStats;
  @override
  @JsonKey(name: 'parking_info')
  final String? parkingInfo;
  // Catalog highlights
  final List<String> _carryCategories;
  // Catalog highlights
  @override
  @JsonKey(name: 'carry_categories')
  List<String> get carryCategories {
    if (_carryCategories is EqualUnmodifiableListView) return _carryCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_carryCategories);
  }

  @override
  String toString() {
    return 'PageDetail(id: $id, name: $name, nameEn: $nameEn, slug: $slug, handle: $handle, description: $description, descriptionEn: $descriptionEn, avatarUrl: $avatarUrl, coverUrl: $coverUrl, archetype: $archetype, businessTypeId: $businessTypeId, businessTypeName: $businessTypeName, categoryId: $categoryId, categoryName: $categoryName, exploreCategory: $exploreCategory, itemsLabelAr: $itemsLabelAr, itemsLabelEn: $itemsLabelEn, storeType: $storeType, engagementLevel: $engagementLevel, requiresApproval: $requiresApproval, trustScore: $trustScore, trustMetrics: $trustMetrics, responseTime: $responseTime, completionRate: $completionRate, totalOrders: $totalOrders, memberSince: $memberSince, isVerified: $isVerified, isOpen: $isOpen, pageStatus: $pageStatus, claimStatus: $claimStatus, temporarilyClosed: $temporarilyClosed, relocated: $relocated, permanentlyClosed: $permanentlyClosed, operatingHours: $operatingHours, workingHours: $workingHours, paymentMethods: $paymentMethods, cliqAlias: $cliqAlias, bankInfo: $bankInfo, coverageZones: $coverageZones, branches: $branches, coverageZonesStructured: $coverageZonesStructured, returnPolicy: $returnPolicy, cancellationPolicy: $cancellationPolicy, externalLinks: $externalLinks, deliveryAvailable: $deliveryAvailable, pickupAvailable: $pickupAvailable, bookingAvailable: $bookingAvailable, minimumOrderCents: $minimumOrderCents, deliveryFeeCents: $deliveryFeeCents, estimatedDeliveryMinutes: $estimatedDeliveryMinutes, followersCount: $followersCount, postsCount: $postsCount, itemsCount: $itemsCount, isFollowing: $isFollowing, teamMembersCount: $teamMembersCount, phone: $phone, whatsapp: $whatsapp, address: $address, location: $location, hours: $hours, catalogStrategy: $catalogStrategy, featuredItemsCount: $featuredItemsCount, contactMethods: $contactMethods, specials: $specials, modifiersNote: $modifiersNote, activePriceChange: $activePriceChange, packages: $packages, galleryImages: $galleryImages, amenities: $amenities, pricing: $pricing, seasonalPricing: $seasonalPricing, houseRules: $houseRules, checkIn: $checkIn, checkOut: $checkOut, maxGuests: $maxGuests, bedrooms: $bedrooms, bathrooms: $bathrooms, servicesOffered: $servicesOffered, priceRange: $priceRange, serviceAreas: $serviceAreas, alerts: $alerts, aboutExtended: $aboutExtended, servicesLinks: $servicesLinks, pinnedPosts: $pinnedPosts, stories: $stories, weeklySchedule: $weeklySchedule, blockedDates: $blockedDates, dataSynced: $dataSynced, venueId: $venueId, venueName: $venueName, venueUnit: $venueUnit, venueFloor: $venueFloor, mallAnnouncements: $mallAnnouncements, featuredTenantIds: $featuredTenantIds, directoryStats: $directoryStats, parkingInfo: $parkingInfo, carryCategories: $carryCategories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PageDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.handle, handle) || other.handle == handle) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.descriptionEn, descriptionEn) ||
                other.descriptionEn == descriptionEn) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl) &&
            (identical(other.archetype, archetype) ||
                other.archetype == archetype) &&
            (identical(other.businessTypeId, businessTypeId) ||
                other.businessTypeId == businessTypeId) &&
            (identical(other.businessTypeName, businessTypeName) ||
                other.businessTypeName == businessTypeName) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.exploreCategory, exploreCategory) ||
                other.exploreCategory == exploreCategory) &&
            (identical(other.itemsLabelAr, itemsLabelAr) ||
                other.itemsLabelAr == itemsLabelAr) &&
            (identical(other.itemsLabelEn, itemsLabelEn) ||
                other.itemsLabelEn == itemsLabelEn) &&
            (identical(other.storeType, storeType) ||
                other.storeType == storeType) &&
            (identical(other.engagementLevel, engagementLevel) ||
                other.engagementLevel == engagementLevel) &&
            (identical(other.requiresApproval, requiresApproval) ||
                other.requiresApproval == requiresApproval) &&
            (identical(other.trustScore, trustScore) ||
                other.trustScore == trustScore) &&
            const DeepCollectionEquality().equals(
              other._trustMetrics,
              _trustMetrics,
            ) &&
            (identical(other.responseTime, responseTime) ||
                other.responseTime == responseTime) &&
            (identical(other.completionRate, completionRate) ||
                other.completionRate == completionRate) &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            (identical(other.memberSince, memberSince) ||
                other.memberSince == memberSince) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen) &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.claimStatus, claimStatus) ||
                other.claimStatus == claimStatus) &&
            (identical(other.temporarilyClosed, temporarilyClosed) ||
                other.temporarilyClosed == temporarilyClosed) &&
            (identical(other.relocated, relocated) ||
                other.relocated == relocated) &&
            (identical(other.permanentlyClosed, permanentlyClosed) ||
                other.permanentlyClosed == permanentlyClosed) &&
            (identical(other.operatingHours, operatingHours) ||
                other.operatingHours == operatingHours) &&
            const DeepCollectionEquality().equals(
              other._workingHours,
              _workingHours,
            ) &&
            const DeepCollectionEquality().equals(
              other._paymentMethods,
              _paymentMethods,
            ) &&
            (identical(other.cliqAlias, cliqAlias) ||
                other.cliqAlias == cliqAlias) &&
            const DeepCollectionEquality().equals(other._bankInfo, _bankInfo) &&
            const DeepCollectionEquality().equals(
              other._coverageZones,
              _coverageZones,
            ) &&
            const DeepCollectionEquality().equals(other._branches, _branches) &&
            const DeepCollectionEquality().equals(
              other._coverageZonesStructured,
              _coverageZonesStructured,
            ) &&
            (identical(other.returnPolicy, returnPolicy) ||
                other.returnPolicy == returnPolicy) &&
            (identical(other.cancellationPolicy, cancellationPolicy) ||
                other.cancellationPolicy == cancellationPolicy) &&
            const DeepCollectionEquality().equals(
              other._externalLinks,
              _externalLinks,
            ) &&
            (identical(other.deliveryAvailable, deliveryAvailable) ||
                other.deliveryAvailable == deliveryAvailable) &&
            (identical(other.pickupAvailable, pickupAvailable) ||
                other.pickupAvailable == pickupAvailable) &&
            (identical(other.bookingAvailable, bookingAvailable) ||
                other.bookingAvailable == bookingAvailable) &&
            (identical(other.minimumOrderCents, minimumOrderCents) ||
                other.minimumOrderCents == minimumOrderCents) &&
            (identical(other.deliveryFeeCents, deliveryFeeCents) ||
                other.deliveryFeeCents == deliveryFeeCents) &&
            (identical(
                  other.estimatedDeliveryMinutes,
                  estimatedDeliveryMinutes,
                ) ||
                other.estimatedDeliveryMinutes == estimatedDeliveryMinutes) &&
            (identical(other.followersCount, followersCount) ||
                other.followersCount == followersCount) &&
            (identical(other.postsCount, postsCount) ||
                other.postsCount == postsCount) &&
            (identical(other.itemsCount, itemsCount) ||
                other.itemsCount == itemsCount) &&
            (identical(other.isFollowing, isFollowing) ||
                other.isFollowing == isFollowing) &&
            (identical(other.teamMembersCount, teamMembersCount) ||
                other.teamMembersCount == teamMembersCount) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.whatsapp, whatsapp) ||
                other.whatsapp == whatsapp) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.catalogStrategy, catalogStrategy) ||
                other.catalogStrategy == catalogStrategy) &&
            (identical(other.featuredItemsCount, featuredItemsCount) ||
                other.featuredItemsCount == featuredItemsCount) &&
            const DeepCollectionEquality().equals(
              other._contactMethods,
              _contactMethods,
            ) &&
            const DeepCollectionEquality().equals(other._specials, _specials) &&
            (identical(other.modifiersNote, modifiersNote) ||
                other.modifiersNote == modifiersNote) &&
            (identical(other.activePriceChange, activePriceChange) ||
                other.activePriceChange == activePriceChange) &&
            const DeepCollectionEquality().equals(other._packages, _packages) &&
            const DeepCollectionEquality().equals(
              other._galleryImages,
              _galleryImages,
            ) &&
            const DeepCollectionEquality().equals(
              other._amenities,
              _amenities,
            ) &&
            (identical(other.pricing, pricing) || other.pricing == pricing) &&
            (identical(other.seasonalPricing, seasonalPricing) ||
                other.seasonalPricing == seasonalPricing) &&
            const DeepCollectionEquality().equals(
              other._houseRules,
              _houseRules,
            ) &&
            (identical(other.checkIn, checkIn) || other.checkIn == checkIn) &&
            (identical(other.checkOut, checkOut) ||
                other.checkOut == checkOut) &&
            (identical(other.maxGuests, maxGuests) ||
                other.maxGuests == maxGuests) &&
            (identical(other.bedrooms, bedrooms) ||
                other.bedrooms == bedrooms) &&
            (identical(other.bathrooms, bathrooms) ||
                other.bathrooms == bathrooms) &&
            const DeepCollectionEquality().equals(
              other._servicesOffered,
              _servicesOffered,
            ) &&
            (identical(other.priceRange, priceRange) ||
                other.priceRange == priceRange) &&
            const DeepCollectionEquality().equals(
              other._serviceAreas,
              _serviceAreas,
            ) &&
            const DeepCollectionEquality().equals(other._alerts, _alerts) &&
            (identical(other.aboutExtended, aboutExtended) ||
                other.aboutExtended == aboutExtended) &&
            const DeepCollectionEquality().equals(
              other._servicesLinks,
              _servicesLinks,
            ) &&
            const DeepCollectionEquality().equals(
              other._pinnedPosts,
              _pinnedPosts,
            ) &&
            const DeepCollectionEquality().equals(other._stories, _stories) &&
            const DeepCollectionEquality().equals(
              other._weeklySchedule,
              _weeklySchedule,
            ) &&
            const DeepCollectionEquality().equals(
              other._blockedDates,
              _blockedDates,
            ) &&
            (identical(other.dataSynced, dataSynced) ||
                other.dataSynced == dataSynced) &&
            (identical(other.venueId, venueId) || other.venueId == venueId) &&
            (identical(other.venueName, venueName) ||
                other.venueName == venueName) &&
            (identical(other.venueUnit, venueUnit) ||
                other.venueUnit == venueUnit) &&
            (identical(other.venueFloor, venueFloor) ||
                other.venueFloor == venueFloor) &&
            const DeepCollectionEquality().equals(
              other._mallAnnouncements,
              _mallAnnouncements,
            ) &&
            const DeepCollectionEquality().equals(
              other._featuredTenantIds,
              _featuredTenantIds,
            ) &&
            (identical(other.directoryStats, directoryStats) ||
                other.directoryStats == directoryStats) &&
            (identical(other.parkingInfo, parkingInfo) ||
                other.parkingInfo == parkingInfo) &&
            const DeepCollectionEquality().equals(
              other._carryCategories,
              _carryCategories,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    name,
    nameEn,
    slug,
    handle,
    description,
    descriptionEn,
    avatarUrl,
    coverUrl,
    archetype,
    businessTypeId,
    businessTypeName,
    categoryId,
    categoryName,
    exploreCategory,
    itemsLabelAr,
    itemsLabelEn,
    storeType,
    engagementLevel,
    requiresApproval,
    trustScore,
    const DeepCollectionEquality().hash(_trustMetrics),
    responseTime,
    completionRate,
    totalOrders,
    memberSince,
    isVerified,
    isOpen,
    pageStatus,
    claimStatus,
    temporarilyClosed,
    relocated,
    permanentlyClosed,
    operatingHours,
    const DeepCollectionEquality().hash(_workingHours),
    const DeepCollectionEquality().hash(_paymentMethods),
    cliqAlias,
    const DeepCollectionEquality().hash(_bankInfo),
    const DeepCollectionEquality().hash(_coverageZones),
    const DeepCollectionEquality().hash(_branches),
    const DeepCollectionEquality().hash(_coverageZonesStructured),
    returnPolicy,
    cancellationPolicy,
    const DeepCollectionEquality().hash(_externalLinks),
    deliveryAvailable,
    pickupAvailable,
    bookingAvailable,
    minimumOrderCents,
    deliveryFeeCents,
    estimatedDeliveryMinutes,
    followersCount,
    postsCount,
    itemsCount,
    isFollowing,
    teamMembersCount,
    phone,
    whatsapp,
    address,
    location,
    hours,
    catalogStrategy,
    featuredItemsCount,
    const DeepCollectionEquality().hash(_contactMethods),
    const DeepCollectionEquality().hash(_specials),
    modifiersNote,
    activePriceChange,
    const DeepCollectionEquality().hash(_packages),
    const DeepCollectionEquality().hash(_galleryImages),
    const DeepCollectionEquality().hash(_amenities),
    pricing,
    seasonalPricing,
    const DeepCollectionEquality().hash(_houseRules),
    checkIn,
    checkOut,
    maxGuests,
    bedrooms,
    bathrooms,
    const DeepCollectionEquality().hash(_servicesOffered),
    priceRange,
    const DeepCollectionEquality().hash(_serviceAreas),
    const DeepCollectionEquality().hash(_alerts),
    aboutExtended,
    const DeepCollectionEquality().hash(_servicesLinks),
    const DeepCollectionEquality().hash(_pinnedPosts),
    const DeepCollectionEquality().hash(_stories),
    const DeepCollectionEquality().hash(_weeklySchedule),
    const DeepCollectionEquality().hash(_blockedDates),
    dataSynced,
    venueId,
    venueName,
    venueUnit,
    venueFloor,
    const DeepCollectionEquality().hash(_mallAnnouncements),
    const DeepCollectionEquality().hash(_featuredTenantIds),
    directoryStats,
    parkingInfo,
    const DeepCollectionEquality().hash(_carryCategories),
  ]);

  /// Create a copy of PageDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PageDetailImplCopyWith<_$PageDetailImpl> get copyWith =>
      __$$PageDetailImplCopyWithImpl<_$PageDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PageDetailImplToJson(this);
  }
}

abstract class _PageDetail implements PageDetail {
  const factory _PageDetail({
    required final String id,
    required final String name,
    @JsonKey(name: 'name_en') final String? nameEn,
    required final String slug,
    final String? handle,
    final String? description,
    @JsonKey(name: 'description_en') final String? descriptionEn,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    @JsonKey(name: 'cover_url') final String? coverUrl,
    final String? archetype,
    @JsonKey(name: 'business_type_id') final String? businessTypeId,
    @JsonKey(name: 'business_type_name') final String? businessTypeName,
    @JsonKey(name: 'category_id') final String? categoryId,
    @JsonKey(name: 'category_name') final String? categoryName,
    @JsonKey(name: 'explore_category') final String? exploreCategory,
    @JsonKey(name: 'items_label_ar') final String? itemsLabelAr,
    @JsonKey(name: 'items_label_en') final String? itemsLabelEn,
    @JsonKey(name: 'store_type') final String? storeType,
    @JsonKey(name: 'engagement_level') final String? engagementLevel,
    @JsonKey(name: 'requires_approval') final bool requiresApproval,
    @JsonKey(name: 'trust_score') final int trustScore,
    @JsonKey(name: 'trust_metrics') final List<TrustMetric> trustMetrics,
    @JsonKey(name: 'response_time') final String? responseTime,
    @JsonKey(name: 'completion_rate') final double? completionRate,
    @JsonKey(name: 'total_orders') final int totalOrders,
    @JsonKey(name: 'member_since') final String? memberSince,
    @JsonKey(name: 'is_verified') final bool isVerified,
    @JsonKey(name: 'is_open') final bool isOpen,
    @JsonKey(name: 'page_status') final String pageStatus,
    @JsonKey(name: 'claim_status') final String claimStatus,
    @JsonKey(name: 'temporarily_closed')
    final TemporarilyClosed? temporarilyClosed,
    final Relocated? relocated,
    @JsonKey(name: 'permanently_closed') final bool permanentlyClosed,
    @JsonKey(name: 'operating_hours') final String? operatingHours,
    @JsonKey(name: 'working_hours') final Map<String, dynamic>? workingHours,
    @JsonKey(name: 'payment_methods') final List<String> paymentMethods,
    @JsonKey(name: 'cliq_alias') final String? cliqAlias,
    @JsonKey(name: 'bank_info') final Map<String, dynamic>? bankInfo,
    @JsonKey(name: 'coverage_zones') final List<String> coverageZones,
    final List<Branch> branches,
    @JsonKey(name: 'coverage_zones_structured')
    final List<CoverageZone> coverageZonesStructured,
    @JsonKey(name: 'return_policy') final ReturnPolicy? returnPolicy,
    @JsonKey(name: 'cancellation_policy') final String? cancellationPolicy,
    @JsonKey(name: 'external_links') final List<ExternalLink> externalLinks,
    @JsonKey(name: 'delivery_available') final bool deliveryAvailable,
    @JsonKey(name: 'pickup_available') final bool pickupAvailable,
    @JsonKey(name: 'booking_available') final bool bookingAvailable,
    @JsonKey(name: 'minimum_order_cents') final int? minimumOrderCents,
    @JsonKey(name: 'delivery_fee_cents') final int? deliveryFeeCents,
    @JsonKey(name: 'estimated_delivery_minutes')
    final int? estimatedDeliveryMinutes,
    @JsonKey(name: 'followers_count') final int followersCount,
    @JsonKey(name: 'posts_count') final int postsCount,
    @JsonKey(name: 'items_count') final int itemsCount,
    @JsonKey(name: 'is_following') final bool isFollowing,
    @JsonKey(name: 'team_members_count') final int teamMembersCount,
    final String? phone,
    final String? whatsapp,
    final String? address,
    final Location? location,
    final PageHours? hours,
    @JsonKey(name: 'catalog_strategy') final String? catalogStrategy,
    @JsonKey(name: 'featured_items_count') final int featuredItemsCount,
    @JsonKey(name: 'contact_methods') final List<String> contactMethods,
    final List<String> specials,
    @JsonKey(name: 'modifiers_note') final String? modifiersNote,
    @JsonKey(name: 'active_price_change') final PriceChange? activePriceChange,
    final List<Package> packages,
    @JsonKey(name: 'gallery_images') final List<String> galleryImages,
    final List<Amenity> amenities,
    final VillaPricing? pricing,
    @JsonKey(name: 'seasonal_pricing') final SeasonalPricing? seasonalPricing,
    @JsonKey(name: 'house_rules') final List<String> houseRules,
    @JsonKey(name: 'check_in') final String? checkIn,
    @JsonKey(name: 'check_out') final String? checkOut,
    @JsonKey(name: 'max_guests') final int? maxGuests,
    final int? bedrooms,
    final int? bathrooms,
    @JsonKey(name: 'services_offered')
    final List<ServiceOffered> servicesOffered,
    @JsonKey(name: 'price_range') final PriceRange? priceRange,
    @JsonKey(name: 'service_areas') final List<String> serviceAreas,
    final List<PageAlert> alerts,
    @JsonKey(name: 'about_extended') final String? aboutExtended,
    @JsonKey(name: 'services_links') final List<ServiceLink> servicesLinks,
    @JsonKey(name: 'pinned_posts') final List<String> pinnedPosts,
    final List<PageStory> stories,
    @JsonKey(name: 'weekly_schedule')
    final Map<String, dynamic>? weeklySchedule,
    @JsonKey(name: 'blocked_dates') final List<BlockedDate> blockedDates,
    @JsonKey(name: 'data_synced') final bool dataSynced,
    @JsonKey(name: 'venue_id') final String? venueId,
    @JsonKey(name: 'venue_name') final String? venueName,
    @JsonKey(name: 'venue_unit') final String? venueUnit,
    @JsonKey(name: 'venue_floor') final String? venueFloor,
    @JsonKey(name: 'mall_announcements')
    final List<MallAnnouncement> mallAnnouncements,
    @JsonKey(name: 'featured_tenant_ids') final List<String> featuredTenantIds,
    @JsonKey(name: 'directory_stats') final DirectoryStats? directoryStats,
    @JsonKey(name: 'parking_info') final String? parkingInfo,
    @JsonKey(name: 'carry_categories') final List<String> carryCategories,
  }) = _$PageDetailImpl;

  factory _PageDetail.fromJson(Map<String, dynamic> json) =
      _$PageDetailImpl.fromJson;

  // Core
  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'name_en')
  String? get nameEn;
  @override
  String get slug;
  @override
  String? get handle;
  @override
  String? get description;
  @override
  @JsonKey(name: 'description_en')
  String? get descriptionEn;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  @JsonKey(name: 'cover_url')
  String? get coverUrl; // Business
  @override
  String? get archetype;
  @override
  @JsonKey(name: 'business_type_id')
  String? get businessTypeId;
  @override
  @JsonKey(name: 'business_type_name')
  String? get businessTypeName;
  @override
  @JsonKey(name: 'category_id')
  String? get categoryId;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  @JsonKey(name: 'explore_category')
  String? get exploreCategory;
  @override
  @JsonKey(name: 'items_label_ar')
  String? get itemsLabelAr;
  @override
  @JsonKey(name: 'items_label_en')
  String? get itemsLabelEn;
  @override
  @JsonKey(name: 'store_type')
  String? get storeType;
  @override
  @JsonKey(name: 'engagement_level')
  String? get engagementLevel;
  @override
  @JsonKey(name: 'requires_approval')
  bool get requiresApproval; // Trust
  @override
  @JsonKey(name: 'trust_score')
  int get trustScore;
  @override
  @JsonKey(name: 'trust_metrics')
  List<TrustMetric> get trustMetrics;
  @override
  @JsonKey(name: 'response_time')
  String? get responseTime;
  @override
  @JsonKey(name: 'completion_rate')
  double? get completionRate;
  @override
  @JsonKey(name: 'total_orders')
  int get totalOrders;
  @override
  @JsonKey(name: 'member_since')
  String? get memberSince; // Status
  @override
  @JsonKey(name: 'is_verified')
  bool get isVerified;
  @override
  @JsonKey(name: 'is_open')
  bool get isOpen;
  @override
  @JsonKey(name: 'page_status')
  String get pageStatus;
  @override
  @JsonKey(name: 'claim_status')
  String get claimStatus;
  @override
  @JsonKey(name: 'temporarily_closed')
  TemporarilyClosed? get temporarilyClosed;
  @override
  Relocated? get relocated;
  @override
  @JsonKey(name: 'permanently_closed')
  bool get permanentlyClosed; // Operations
  @override
  @JsonKey(name: 'operating_hours')
  String? get operatingHours;
  @override
  @JsonKey(name: 'working_hours')
  Map<String, dynamic>? get workingHours;
  @override
  @JsonKey(name: 'payment_methods')
  List<String> get paymentMethods;
  @override
  @JsonKey(name: 'cliq_alias')
  String? get cliqAlias;
  @override
  @JsonKey(name: 'bank_info')
  Map<String, dynamic>? get bankInfo;
  @override
  @JsonKey(name: 'coverage_zones')
  List<String> get coverageZones; // Enhanced operations
  @override
  List<Branch> get branches;
  @override
  @JsonKey(name: 'coverage_zones_structured')
  List<CoverageZone> get coverageZonesStructured;
  @override
  @JsonKey(name: 'return_policy')
  ReturnPolicy? get returnPolicy;
  @override
  @JsonKey(name: 'cancellation_policy')
  String? get cancellationPolicy;
  @override
  @JsonKey(name: 'external_links')
  List<ExternalLink> get externalLinks; // Delivery
  @override
  @JsonKey(name: 'delivery_available')
  bool get deliveryAvailable;
  @override
  @JsonKey(name: 'pickup_available')
  bool get pickupAvailable;
  @override
  @JsonKey(name: 'booking_available')
  bool get bookingAvailable;
  @override
  @JsonKey(name: 'minimum_order_cents')
  int? get minimumOrderCents;
  @override
  @JsonKey(name: 'delivery_fee_cents')
  int? get deliveryFeeCents;
  @override
  @JsonKey(name: 'estimated_delivery_minutes')
  int? get estimatedDeliveryMinutes; // Social
  @override
  @JsonKey(name: 'followers_count')
  int get followersCount;
  @override
  @JsonKey(name: 'posts_count')
  int get postsCount;
  @override
  @JsonKey(name: 'items_count')
  int get itemsCount;
  @override
  @JsonKey(name: 'is_following')
  bool get isFollowing; // Team
  @override
  @JsonKey(name: 'team_members_count')
  int get teamMembersCount; // Contact
  @override
  String? get phone;
  @override
  String? get whatsapp;
  @override
  String? get address;
  @override
  Location? get location;
  @override
  PageHours? get hours; // Catalog
  @override
  @JsonKey(name: 'catalog_strategy')
  String? get catalogStrategy;
  @override
  @JsonKey(name: 'featured_items_count')
  int get featuredItemsCount; // Contact methods
  @override
  @JsonKey(name: 'contact_methods')
  List<String> get contactMethods; // Catalog / Menu enhancements
  @override
  List<String> get specials;
  @override
  @JsonKey(name: 'modifiers_note')
  String? get modifiersNote;
  @override
  @JsonKey(name: 'active_price_change')
  PriceChange? get activePriceChange;
  @override
  List<Package> get packages; // Villa / Reservation enhancements
  @override
  @JsonKey(name: 'gallery_images')
  List<String> get galleryImages;
  @override
  List<Amenity> get amenities;
  @override
  VillaPricing? get pricing;
  @override
  @JsonKey(name: 'seasonal_pricing')
  SeasonalPricing? get seasonalPricing;
  @override
  @JsonKey(name: 'house_rules')
  List<String> get houseRules;
  @override
  @JsonKey(name: 'check_in')
  String? get checkIn;
  @override
  @JsonKey(name: 'check_out')
  String? get checkOut;
  @override
  @JsonKey(name: 'max_guests')
  int? get maxGuests;
  @override
  int? get bedrooms;
  @override
  int? get bathrooms; // Quote enhancements
  @override
  @JsonKey(name: 'services_offered')
  List<ServiceOffered> get servicesOffered;
  @override
  @JsonKey(name: 'price_range')
  PriceRange? get priceRange;
  @override
  @JsonKey(name: 'service_areas')
  List<String> get serviceAreas; // Follow-only enhancements
  @override
  List<PageAlert> get alerts;
  @override
  @JsonKey(name: 'about_extended')
  String? get aboutExtended;
  @override
  @JsonKey(name: 'services_links')
  List<ServiceLink> get servicesLinks; // Activity enhancements
  @override
  @JsonKey(name: 'pinned_posts')
  List<String> get pinnedPosts; // Stories
  @override
  List<PageStory> get stories; // Weekly schedule
  @override
  @JsonKey(name: 'weekly_schedule')
  Map<String, dynamic>? get weeklySchedule; // Blocked dates
  @override
  @JsonKey(name: 'blocked_dates')
  List<BlockedDate> get blockedDates; // Data sync flag
  @override
  @JsonKey(name: 'data_synced')
  bool get dataSynced; // Venue tenant fields
  @override
  @JsonKey(name: 'venue_id')
  String? get venueId;
  @override
  @JsonKey(name: 'venue_name')
  String? get venueName;
  @override
  @JsonKey(name: 'venue_unit')
  String? get venueUnit;
  @override
  @JsonKey(name: 'venue_floor')
  String? get venueFloor; // Directory-specific
  @override
  @JsonKey(name: 'mall_announcements')
  List<MallAnnouncement> get mallAnnouncements;
  @override
  @JsonKey(name: 'featured_tenant_ids')
  List<String> get featuredTenantIds;
  @override
  @JsonKey(name: 'directory_stats')
  DirectoryStats? get directoryStats;
  @override
  @JsonKey(name: 'parking_info')
  String? get parkingInfo; // Catalog highlights
  @override
  @JsonKey(name: 'carry_categories')
  List<String> get carryCategories;

  /// Create a copy of PageDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PageDetailImplCopyWith<_$PageDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
