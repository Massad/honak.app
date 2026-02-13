// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PageSummary _$PageSummaryFromJson(Map<String, dynamic> json) {
  return _PageSummary.fromJson(json);
}

/// @nodoc
mixin _$PageSummary {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover_url')
  String? get coverUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_type_name')
  String? get businessTypeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_type_id')
  String? get businessTypeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'explore_category')
  String? get exploreCategory => throw _privateConstructorUsedError;
  String? get archetype => throw _privateConstructorUsedError;
  @JsonKey(name: 'engagement_level')
  String? get engagementLevel => throw _privateConstructorUsedError;
  String? get distance => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_open')
  bool get isOpen => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_type')
  String? get storeType => throw _privateConstructorUsedError;
  @JsonKey(name: 'accepts_returns')
  bool get acceptsReturns => throw _privateConstructorUsedError;
  @JsonKey(name: 'monthly_metric')
  String? get monthlyMetric => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_categories')
  List<String> get productCategories => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_active_stories')
  bool get hasActiveStories => throw _privateConstructorUsedError;
  @JsonKey(name: 'trust_metrics')
  List<TrustMetric> get trustMetrics => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_category')
  String? get subCategory => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_verified')
  bool get isVerified => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_following')
  bool get isFollowing => throw _privateConstructorUsedError;
  @JsonKey(name: 'followers_count')
  int get followersCount => throw _privateConstructorUsedError;
  Location? get location => throw _privateConstructorUsedError;

  /// Serializes this PageSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PageSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PageSummaryCopyWith<PageSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageSummaryCopyWith<$Res> {
  factory $PageSummaryCopyWith(
    PageSummary value,
    $Res Function(PageSummary) then,
  ) = _$PageSummaryCopyWithImpl<$Res, PageSummary>;
  @useResult
  $Res call({
    String id,
    String name,
    String slug,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'cover_url') String? coverUrl,
    @JsonKey(name: 'business_type_name') String? businessTypeName,
    @JsonKey(name: 'business_type_id') String? businessTypeId,
    @JsonKey(name: 'explore_category') String? exploreCategory,
    String? archetype,
    @JsonKey(name: 'engagement_level') String? engagementLevel,
    String? distance,
    @JsonKey(name: 'is_open') bool isOpen,
    @JsonKey(name: 'store_type') String? storeType,
    @JsonKey(name: 'accepts_returns') bool acceptsReturns,
    @JsonKey(name: 'monthly_metric') String? monthlyMetric,
    @JsonKey(name: 'product_categories') List<String> productCategories,
    @JsonKey(name: 'has_active_stories') bool hasActiveStories,
    @JsonKey(name: 'trust_metrics') List<TrustMetric> trustMetrics,
    @JsonKey(name: 'sub_category') String? subCategory,
    @JsonKey(name: 'is_verified') bool isVerified,
    @JsonKey(name: 'is_following') bool isFollowing,
    @JsonKey(name: 'followers_count') int followersCount,
    Location? location,
  });

  $LocationCopyWith<$Res>? get location;
}

/// @nodoc
class _$PageSummaryCopyWithImpl<$Res, $Val extends PageSummary>
    implements $PageSummaryCopyWith<$Res> {
  _$PageSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PageSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? avatarUrl = freezed,
    Object? coverUrl = freezed,
    Object? businessTypeName = freezed,
    Object? businessTypeId = freezed,
    Object? exploreCategory = freezed,
    Object? archetype = freezed,
    Object? engagementLevel = freezed,
    Object? distance = freezed,
    Object? isOpen = null,
    Object? storeType = freezed,
    Object? acceptsReturns = null,
    Object? monthlyMetric = freezed,
    Object? productCategories = null,
    Object? hasActiveStories = null,
    Object? trustMetrics = null,
    Object? subCategory = freezed,
    Object? isVerified = null,
    Object? isFollowing = null,
    Object? followersCount = null,
    Object? location = freezed,
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
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            coverUrl: freezed == coverUrl
                ? _value.coverUrl
                : coverUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            businessTypeName: freezed == businessTypeName
                ? _value.businessTypeName
                : businessTypeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            businessTypeId: freezed == businessTypeId
                ? _value.businessTypeId
                : businessTypeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            exploreCategory: freezed == exploreCategory
                ? _value.exploreCategory
                : exploreCategory // ignore: cast_nullable_to_non_nullable
                      as String?,
            archetype: freezed == archetype
                ? _value.archetype
                : archetype // ignore: cast_nullable_to_non_nullable
                      as String?,
            engagementLevel: freezed == engagementLevel
                ? _value.engagementLevel
                : engagementLevel // ignore: cast_nullable_to_non_nullable
                      as String?,
            distance: freezed == distance
                ? _value.distance
                : distance // ignore: cast_nullable_to_non_nullable
                      as String?,
            isOpen: null == isOpen
                ? _value.isOpen
                : isOpen // ignore: cast_nullable_to_non_nullable
                      as bool,
            storeType: freezed == storeType
                ? _value.storeType
                : storeType // ignore: cast_nullable_to_non_nullable
                      as String?,
            acceptsReturns: null == acceptsReturns
                ? _value.acceptsReturns
                : acceptsReturns // ignore: cast_nullable_to_non_nullable
                      as bool,
            monthlyMetric: freezed == monthlyMetric
                ? _value.monthlyMetric
                : monthlyMetric // ignore: cast_nullable_to_non_nullable
                      as String?,
            productCategories: null == productCategories
                ? _value.productCategories
                : productCategories // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            hasActiveStories: null == hasActiveStories
                ? _value.hasActiveStories
                : hasActiveStories // ignore: cast_nullable_to_non_nullable
                      as bool,
            trustMetrics: null == trustMetrics
                ? _value.trustMetrics
                : trustMetrics // ignore: cast_nullable_to_non_nullable
                      as List<TrustMetric>,
            subCategory: freezed == subCategory
                ? _value.subCategory
                : subCategory // ignore: cast_nullable_to_non_nullable
                      as String?,
            isVerified: null == isVerified
                ? _value.isVerified
                : isVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFollowing: null == isFollowing
                ? _value.isFollowing
                : isFollowing // ignore: cast_nullable_to_non_nullable
                      as bool,
            followersCount: null == followersCount
                ? _value.followersCount
                : followersCount // ignore: cast_nullable_to_non_nullable
                      as int,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as Location?,
          )
          as $Val,
    );
  }

  /// Create a copy of PageSummary
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
}

/// @nodoc
abstract class _$$PageSummaryImplCopyWith<$Res>
    implements $PageSummaryCopyWith<$Res> {
  factory _$$PageSummaryImplCopyWith(
    _$PageSummaryImpl value,
    $Res Function(_$PageSummaryImpl) then,
  ) = __$$PageSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String slug,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'cover_url') String? coverUrl,
    @JsonKey(name: 'business_type_name') String? businessTypeName,
    @JsonKey(name: 'business_type_id') String? businessTypeId,
    @JsonKey(name: 'explore_category') String? exploreCategory,
    String? archetype,
    @JsonKey(name: 'engagement_level') String? engagementLevel,
    String? distance,
    @JsonKey(name: 'is_open') bool isOpen,
    @JsonKey(name: 'store_type') String? storeType,
    @JsonKey(name: 'accepts_returns') bool acceptsReturns,
    @JsonKey(name: 'monthly_metric') String? monthlyMetric,
    @JsonKey(name: 'product_categories') List<String> productCategories,
    @JsonKey(name: 'has_active_stories') bool hasActiveStories,
    @JsonKey(name: 'trust_metrics') List<TrustMetric> trustMetrics,
    @JsonKey(name: 'sub_category') String? subCategory,
    @JsonKey(name: 'is_verified') bool isVerified,
    @JsonKey(name: 'is_following') bool isFollowing,
    @JsonKey(name: 'followers_count') int followersCount,
    Location? location,
  });

  @override
  $LocationCopyWith<$Res>? get location;
}

/// @nodoc
class __$$PageSummaryImplCopyWithImpl<$Res>
    extends _$PageSummaryCopyWithImpl<$Res, _$PageSummaryImpl>
    implements _$$PageSummaryImplCopyWith<$Res> {
  __$$PageSummaryImplCopyWithImpl(
    _$PageSummaryImpl _value,
    $Res Function(_$PageSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PageSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? avatarUrl = freezed,
    Object? coverUrl = freezed,
    Object? businessTypeName = freezed,
    Object? businessTypeId = freezed,
    Object? exploreCategory = freezed,
    Object? archetype = freezed,
    Object? engagementLevel = freezed,
    Object? distance = freezed,
    Object? isOpen = null,
    Object? storeType = freezed,
    Object? acceptsReturns = null,
    Object? monthlyMetric = freezed,
    Object? productCategories = null,
    Object? hasActiveStories = null,
    Object? trustMetrics = null,
    Object? subCategory = freezed,
    Object? isVerified = null,
    Object? isFollowing = null,
    Object? followersCount = null,
    Object? location = freezed,
  }) {
    return _then(
      _$PageSummaryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        coverUrl: freezed == coverUrl
            ? _value.coverUrl
            : coverUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        businessTypeName: freezed == businessTypeName
            ? _value.businessTypeName
            : businessTypeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        businessTypeId: freezed == businessTypeId
            ? _value.businessTypeId
            : businessTypeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        exploreCategory: freezed == exploreCategory
            ? _value.exploreCategory
            : exploreCategory // ignore: cast_nullable_to_non_nullable
                  as String?,
        archetype: freezed == archetype
            ? _value.archetype
            : archetype // ignore: cast_nullable_to_non_nullable
                  as String?,
        engagementLevel: freezed == engagementLevel
            ? _value.engagementLevel
            : engagementLevel // ignore: cast_nullable_to_non_nullable
                  as String?,
        distance: freezed == distance
            ? _value.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as String?,
        isOpen: null == isOpen
            ? _value.isOpen
            : isOpen // ignore: cast_nullable_to_non_nullable
                  as bool,
        storeType: freezed == storeType
            ? _value.storeType
            : storeType // ignore: cast_nullable_to_non_nullable
                  as String?,
        acceptsReturns: null == acceptsReturns
            ? _value.acceptsReturns
            : acceptsReturns // ignore: cast_nullable_to_non_nullable
                  as bool,
        monthlyMetric: freezed == monthlyMetric
            ? _value.monthlyMetric
            : monthlyMetric // ignore: cast_nullable_to_non_nullable
                  as String?,
        productCategories: null == productCategories
            ? _value._productCategories
            : productCategories // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        hasActiveStories: null == hasActiveStories
            ? _value.hasActiveStories
            : hasActiveStories // ignore: cast_nullable_to_non_nullable
                  as bool,
        trustMetrics: null == trustMetrics
            ? _value._trustMetrics
            : trustMetrics // ignore: cast_nullable_to_non_nullable
                  as List<TrustMetric>,
        subCategory: freezed == subCategory
            ? _value.subCategory
            : subCategory // ignore: cast_nullable_to_non_nullable
                  as String?,
        isVerified: null == isVerified
            ? _value.isVerified
            : isVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFollowing: null == isFollowing
            ? _value.isFollowing
            : isFollowing // ignore: cast_nullable_to_non_nullable
                  as bool,
        followersCount: null == followersCount
            ? _value.followersCount
            : followersCount // ignore: cast_nullable_to_non_nullable
                  as int,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as Location?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PageSummaryImpl implements _PageSummary {
  const _$PageSummaryImpl({
    required this.id,
    required this.name,
    required this.slug,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    @JsonKey(name: 'cover_url') this.coverUrl,
    @JsonKey(name: 'business_type_name') this.businessTypeName,
    @JsonKey(name: 'business_type_id') this.businessTypeId,
    @JsonKey(name: 'explore_category') this.exploreCategory,
    this.archetype,
    @JsonKey(name: 'engagement_level') this.engagementLevel,
    this.distance,
    @JsonKey(name: 'is_open') this.isOpen = true,
    @JsonKey(name: 'store_type') this.storeType,
    @JsonKey(name: 'accepts_returns') this.acceptsReturns = false,
    @JsonKey(name: 'monthly_metric') this.monthlyMetric,
    @JsonKey(name: 'product_categories')
    final List<String> productCategories = const [],
    @JsonKey(name: 'has_active_stories') this.hasActiveStories = false,
    @JsonKey(name: 'trust_metrics')
    final List<TrustMetric> trustMetrics = const [],
    @JsonKey(name: 'sub_category') this.subCategory,
    @JsonKey(name: 'is_verified') this.isVerified = false,
    @JsonKey(name: 'is_following') this.isFollowing = false,
    @JsonKey(name: 'followers_count') this.followersCount = 0,
    this.location,
  }) : _productCategories = productCategories,
       _trustMetrics = trustMetrics;

  factory _$PageSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PageSummaryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String slug;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'cover_url')
  final String? coverUrl;
  @override
  @JsonKey(name: 'business_type_name')
  final String? businessTypeName;
  @override
  @JsonKey(name: 'business_type_id')
  final String? businessTypeId;
  @override
  @JsonKey(name: 'explore_category')
  final String? exploreCategory;
  @override
  final String? archetype;
  @override
  @JsonKey(name: 'engagement_level')
  final String? engagementLevel;
  @override
  final String? distance;
  @override
  @JsonKey(name: 'is_open')
  final bool isOpen;
  @override
  @JsonKey(name: 'store_type')
  final String? storeType;
  @override
  @JsonKey(name: 'accepts_returns')
  final bool acceptsReturns;
  @override
  @JsonKey(name: 'monthly_metric')
  final String? monthlyMetric;
  final List<String> _productCategories;
  @override
  @JsonKey(name: 'product_categories')
  List<String> get productCategories {
    if (_productCategories is EqualUnmodifiableListView)
      return _productCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productCategories);
  }

  @override
  @JsonKey(name: 'has_active_stories')
  final bool hasActiveStories;
  final List<TrustMetric> _trustMetrics;
  @override
  @JsonKey(name: 'trust_metrics')
  List<TrustMetric> get trustMetrics {
    if (_trustMetrics is EqualUnmodifiableListView) return _trustMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trustMetrics);
  }

  @override
  @JsonKey(name: 'sub_category')
  final String? subCategory;
  @override
  @JsonKey(name: 'is_verified')
  final bool isVerified;
  @override
  @JsonKey(name: 'is_following')
  final bool isFollowing;
  @override
  @JsonKey(name: 'followers_count')
  final int followersCount;
  @override
  final Location? location;

  @override
  String toString() {
    return 'PageSummary(id: $id, name: $name, slug: $slug, avatarUrl: $avatarUrl, coverUrl: $coverUrl, businessTypeName: $businessTypeName, businessTypeId: $businessTypeId, exploreCategory: $exploreCategory, archetype: $archetype, engagementLevel: $engagementLevel, distance: $distance, isOpen: $isOpen, storeType: $storeType, acceptsReturns: $acceptsReturns, monthlyMetric: $monthlyMetric, productCategories: $productCategories, hasActiveStories: $hasActiveStories, trustMetrics: $trustMetrics, subCategory: $subCategory, isVerified: $isVerified, isFollowing: $isFollowing, followersCount: $followersCount, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PageSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl) &&
            (identical(other.businessTypeName, businessTypeName) ||
                other.businessTypeName == businessTypeName) &&
            (identical(other.businessTypeId, businessTypeId) ||
                other.businessTypeId == businessTypeId) &&
            (identical(other.exploreCategory, exploreCategory) ||
                other.exploreCategory == exploreCategory) &&
            (identical(other.archetype, archetype) ||
                other.archetype == archetype) &&
            (identical(other.engagementLevel, engagementLevel) ||
                other.engagementLevel == engagementLevel) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen) &&
            (identical(other.storeType, storeType) ||
                other.storeType == storeType) &&
            (identical(other.acceptsReturns, acceptsReturns) ||
                other.acceptsReturns == acceptsReturns) &&
            (identical(other.monthlyMetric, monthlyMetric) ||
                other.monthlyMetric == monthlyMetric) &&
            const DeepCollectionEquality().equals(
              other._productCategories,
              _productCategories,
            ) &&
            (identical(other.hasActiveStories, hasActiveStories) ||
                other.hasActiveStories == hasActiveStories) &&
            const DeepCollectionEquality().equals(
              other._trustMetrics,
              _trustMetrics,
            ) &&
            (identical(other.subCategory, subCategory) ||
                other.subCategory == subCategory) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.isFollowing, isFollowing) ||
                other.isFollowing == isFollowing) &&
            (identical(other.followersCount, followersCount) ||
                other.followersCount == followersCount) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    name,
    slug,
    avatarUrl,
    coverUrl,
    businessTypeName,
    businessTypeId,
    exploreCategory,
    archetype,
    engagementLevel,
    distance,
    isOpen,
    storeType,
    acceptsReturns,
    monthlyMetric,
    const DeepCollectionEquality().hash(_productCategories),
    hasActiveStories,
    const DeepCollectionEquality().hash(_trustMetrics),
    subCategory,
    isVerified,
    isFollowing,
    followersCount,
    location,
  ]);

  /// Create a copy of PageSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PageSummaryImplCopyWith<_$PageSummaryImpl> get copyWith =>
      __$$PageSummaryImplCopyWithImpl<_$PageSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PageSummaryImplToJson(this);
  }
}

abstract class _PageSummary implements PageSummary {
  const factory _PageSummary({
    required final String id,
    required final String name,
    required final String slug,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    @JsonKey(name: 'cover_url') final String? coverUrl,
    @JsonKey(name: 'business_type_name') final String? businessTypeName,
    @JsonKey(name: 'business_type_id') final String? businessTypeId,
    @JsonKey(name: 'explore_category') final String? exploreCategory,
    final String? archetype,
    @JsonKey(name: 'engagement_level') final String? engagementLevel,
    final String? distance,
    @JsonKey(name: 'is_open') final bool isOpen,
    @JsonKey(name: 'store_type') final String? storeType,
    @JsonKey(name: 'accepts_returns') final bool acceptsReturns,
    @JsonKey(name: 'monthly_metric') final String? monthlyMetric,
    @JsonKey(name: 'product_categories') final List<String> productCategories,
    @JsonKey(name: 'has_active_stories') final bool hasActiveStories,
    @JsonKey(name: 'trust_metrics') final List<TrustMetric> trustMetrics,
    @JsonKey(name: 'sub_category') final String? subCategory,
    @JsonKey(name: 'is_verified') final bool isVerified,
    @JsonKey(name: 'is_following') final bool isFollowing,
    @JsonKey(name: 'followers_count') final int followersCount,
    final Location? location,
  }) = _$PageSummaryImpl;

  factory _PageSummary.fromJson(Map<String, dynamic> json) =
      _$PageSummaryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get slug;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  @JsonKey(name: 'cover_url')
  String? get coverUrl;
  @override
  @JsonKey(name: 'business_type_name')
  String? get businessTypeName;
  @override
  @JsonKey(name: 'business_type_id')
  String? get businessTypeId;
  @override
  @JsonKey(name: 'explore_category')
  String? get exploreCategory;
  @override
  String? get archetype;
  @override
  @JsonKey(name: 'engagement_level')
  String? get engagementLevel;
  @override
  String? get distance;
  @override
  @JsonKey(name: 'is_open')
  bool get isOpen;
  @override
  @JsonKey(name: 'store_type')
  String? get storeType;
  @override
  @JsonKey(name: 'accepts_returns')
  bool get acceptsReturns;
  @override
  @JsonKey(name: 'monthly_metric')
  String? get monthlyMetric;
  @override
  @JsonKey(name: 'product_categories')
  List<String> get productCategories;
  @override
  @JsonKey(name: 'has_active_stories')
  bool get hasActiveStories;
  @override
  @JsonKey(name: 'trust_metrics')
  List<TrustMetric> get trustMetrics;
  @override
  @JsonKey(name: 'sub_category')
  String? get subCategory;
  @override
  @JsonKey(name: 'is_verified')
  bool get isVerified;
  @override
  @JsonKey(name: 'is_following')
  bool get isFollowing;
  @override
  @JsonKey(name: 'followers_count')
  int get followersCount;
  @override
  Location? get location;

  /// Create a copy of PageSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PageSummaryImplCopyWith<_$PageSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
