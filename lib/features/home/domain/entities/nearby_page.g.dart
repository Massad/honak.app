// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NearbyPageImpl _$$NearbyPageImplFromJson(Map<String, dynamic> json) =>
    _$NearbyPageImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      avatarUrl: json['avatar_url'] as String?,
      coverUrl: json['cover_url'] as String?,
      category: json['category'] as String?,
      distanceKm: (json['distance_km'] as num?)?.toDouble() ?? 0.0,
      isFollowing: json['is_following'] as bool? ?? false,
      isVerified: json['is_verified'] as bool? ?? false,
      weeklyOrders: (json['weekly_orders'] as num?)?.toInt() ?? 0,
      isOpen: json['is_open'] as bool? ?? true,
      browseOnly: json['browse_only'] as bool? ?? false,
    );

Map<String, dynamic> _$$NearbyPageImplToJson(_$NearbyPageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'avatar_url': instance.avatarUrl,
      'cover_url': instance.coverUrl,
      'category': instance.category,
      'distance_km': instance.distanceKm,
      'is_following': instance.isFollowing,
      'is_verified': instance.isVerified,
      'weekly_orders': instance.weeklyOrders,
      'is_open': instance.isOpen,
      'browse_only': instance.browseOnly,
    };
