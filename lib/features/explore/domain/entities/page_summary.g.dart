// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PageSummaryImpl _$$PageSummaryImplFromJson(Map<String, dynamic> json) =>
    _$PageSummaryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      avatarUrl: json['avatar_url'] as String?,
      coverUrl: json['cover_url'] as String?,
      businessTypeName: json['business_type_name'] as String?,
      businessTypeId: json['business_type_id'] as String?,
      exploreCategory: json['explore_category'] as String?,
      archetype: json['archetype'] as String?,
      engagementLevel: json['engagement_level'] as String?,
      distance: json['distance'] as String?,
      isOpen: json['is_open'] as bool? ?? true,
      storeType: json['store_type'] as String?,
      acceptsReturns: json['accepts_returns'] as bool? ?? false,
      monthlyMetric: json['monthly_metric'] as String?,
      productCategories:
          (json['product_categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      hasActiveStories: json['has_active_stories'] as bool? ?? false,
      trustMetrics:
          (json['trust_metrics'] as List<dynamic>?)
              ?.map((e) => TrustMetric.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      subCategory: json['sub_category'] as String?,
      isVerified: json['is_verified'] as bool? ?? false,
      isFollowing: json['is_following'] as bool? ?? false,
      followersCount: (json['followers_count'] as num?)?.toInt() ?? 0,
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PageSummaryImplToJson(_$PageSummaryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'avatar_url': instance.avatarUrl,
      'cover_url': instance.coverUrl,
      'business_type_name': instance.businessTypeName,
      'business_type_id': instance.businessTypeId,
      'explore_category': instance.exploreCategory,
      'archetype': instance.archetype,
      'engagement_level': instance.engagementLevel,
      'distance': instance.distance,
      'is_open': instance.isOpen,
      'store_type': instance.storeType,
      'accepts_returns': instance.acceptsReturns,
      'monthly_metric': instance.monthlyMetric,
      'product_categories': instance.productCategories,
      'has_active_stories': instance.hasActiveStories,
      'trust_metrics': instance.trustMetrics,
      'sub_category': instance.subCategory,
      'is_verified': instance.isVerified,
      'is_following': instance.isFollowing,
      'followers_count': instance.followersCount,
      'location': instance.location,
    };
