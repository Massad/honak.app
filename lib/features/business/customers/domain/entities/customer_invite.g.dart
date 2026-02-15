// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_invite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerInviteImpl _$$CustomerInviteImplFromJson(Map<String, dynamic> json) =>
    _$CustomerInviteImpl(
      id: json['id'] as String,
      phone: json['phone'] as String,
      name: json['name'] as String? ?? '',
      packageId: json['package_id'] as String?,
      packageName: json['package_name'] as String?,
      method: json['method'] as String,
      sentAt: json['sent_at'] as String,
      expiresAt: json['expires_at'] as String?,
      status: $enumDecode(_$InviteStatusEnumMap, json['status']),
      customerId: json['customer_id'] as String?,
    );

Map<String, dynamic> _$$CustomerInviteImplToJson(
  _$CustomerInviteImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'phone': instance.phone,
  'name': instance.name,
  'package_id': instance.packageId,
  'package_name': instance.packageName,
  'method': instance.method,
  'sent_at': instance.sentAt,
  'expires_at': instance.expiresAt,
  'status': _$InviteStatusEnumMap[instance.status]!,
  'customer_id': instance.customerId,
};

const _$InviteStatusEnumMap = {
  InviteStatus.pending: 'pending',
  InviteStatus.registered: 'registered',
  InviteStatus.subscribed: 'subscribed',
  InviteStatus.expired: 'expired',
  InviteStatus.withdrawn: 'withdrawn',
};
