// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  id: json['id'] as String,
  phone: json['phone'] as String,
  name: json['name'] as String,
  nameEn: json['name_en'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  bio: json['bio'] as String?,
  createdAt: (json['created_at'] as num?)?.toInt(),
  status: json['status'] as String? ?? 'active',
  needsProfileSetup: json['needs_profile_setup'] as bool? ?? false,
  pages:
      (json['pages'] as List<dynamic>?)
          ?.map((e) => UserPage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'name': instance.name,
      'name_en': instance.nameEn,
      'avatar_url': instance.avatarUrl,
      'bio': instance.bio,
      'created_at': instance.createdAt,
      'status': instance.status,
      'needs_profile_setup': instance.needsProfileSetup,
      'pages': instance.pages,
    };

_$UserPageImpl _$$UserPageImplFromJson(Map<String, dynamic> json) =>
    _$UserPageImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      avatarUrl: json['avatar_url'] as String?,
      businessTypeName: json['business_type_name'] as String?,
      businessTypeId: json['business_type_id'] as String?,
      isVerified: json['is_verified'] as bool? ?? false,
      role: json['role'] as String? ?? 'owner',
      permissions:
          (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserPageImplToJson(_$UserPageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'avatar_url': instance.avatarUrl,
      'business_type_name': instance.businessTypeName,
      'business_type_id': instance.businessTypeId,
      'is_verified': instance.isVerified,
      'role': instance.role,
      'permissions': instance.permissions,
    };
