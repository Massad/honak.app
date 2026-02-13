// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PageEntityImpl _$$PageEntityImplFromJson(Map<String, dynamic> json) =>
    _$PageEntityImpl(
      id: json['id'] as String,
      ownerId: json['owner_id'] as String,
      businessTypeId: json['business_type_id'] as String,
      businessTypeName: json['business_type_name'] as String?,
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      coverUrl: json['cover_url'] as String?,
      phone: json['phone'] as String?,
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      isVerified: json['is_verified'] as bool? ?? false,
      status: json['status'] as String? ?? 'active',
      followersCount: (json['followers_count'] as num?)?.toInt() ?? 0,
      productsCount: (json['products_count'] as num?)?.toInt() ?? 0,
      postsCount: (json['posts_count'] as num?)?.toInt() ?? 0,
      createdAt: (json['created_at'] as num?)?.toInt(),
      coverMedia: json['cover_media'] == null
          ? null
          : Media.fromJson(json['cover_media'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PageEntityImplToJson(_$PageEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.ownerId,
      'business_type_id': instance.businessTypeId,
      'business_type_name': instance.businessTypeName,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'avatar_url': instance.avatarUrl,
      'cover_url': instance.coverUrl,
      'phone': instance.phone,
      'location': instance.location,
      'is_verified': instance.isVerified,
      'status': instance.status,
      'followers_count': instance.followersCount,
      'products_count': instance.productsCount,
      'posts_count': instance.postsCount,
      'created_at': instance.createdAt,
      'cover_media': instance.coverMedia,
    };
