// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SavedPageImpl _$$SavedPageImplFromJson(Map<String, dynamic> json) =>
    _$SavedPageImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      handle: json['handle'] as String?,
      logoUrl: json['logo_url'] as String?,
      categoryName: json['category_name'] as String?,
      verified: json['verified'] as bool? ?? false,
      savedAt: (json['saved_at'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SavedPageImplToJson(_$SavedPageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'handle': instance.handle,
      'logo_url': instance.logoUrl,
      'category_name': instance.categoryName,
      'verified': instance.verified,
      'saved_at': instance.savedAt,
    };
