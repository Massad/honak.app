// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessAlertImpl _$$BusinessAlertImplFromJson(Map<String, dynamic> json) =>
    _$BusinessAlertImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      severity: json['severity'] as String? ?? 'info',
      expiresAt: (json['expires_at'] as num?)?.toInt(),
      active: json['active'] as bool? ?? true,
      createdAt: (json['created_at'] as num).toInt(),
      views: (json['views'] as num?)?.toInt() ?? 0,
      targetAreas:
          (json['target_areas'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$BusinessAlertImplToJson(_$BusinessAlertImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'severity': instance.severity,
      'expires_at': instance.expiresAt,
      'active': instance.active,
      'created_at': instance.createdAt,
      'views': instance.views,
      'target_areas': instance.targetAreas,
    };
