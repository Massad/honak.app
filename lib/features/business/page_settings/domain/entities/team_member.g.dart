// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamMemberImpl _$$TeamMemberImplFromJson(Map<String, dynamic> json) =>
    _$TeamMemberImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      active: json['active'] as bool? ?? true,
      isOwner: json['is_owner'] as bool? ?? false,
      permissions:
          (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      locationIds:
          (json['location_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      serviceIds:
          (json['service_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      avatarUrl: json['avatar_url'] as String?,
      joinedAt: json['joined_at'] as String?,
    );

Map<String, dynamic> _$$TeamMemberImplToJson(_$TeamMemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'role': instance.role,
      'active': instance.active,
      'is_owner': instance.isOwner,
      'permissions': instance.permissions,
      'location_ids': instance.locationIds,
      'service_ids': instance.serviceIds,
      'avatar_url': instance.avatarUrl,
      'joined_at': instance.joinedAt,
    };
