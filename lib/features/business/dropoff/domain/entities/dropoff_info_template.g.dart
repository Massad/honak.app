// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropoff_info_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DropoffInfoTemplateImpl _$$DropoffInfoTemplateImplFromJson(
  Map<String, dynamic> json,
) => _$DropoffInfoTemplateImpl(
  id: json['id'] as String,
  labelAr: json['label_ar'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => DropoffInfoTemplateItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$DropoffInfoTemplateImplToJson(
  _$DropoffInfoTemplateImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'label_ar': instance.labelAr,
  'items': instance.items,
};

_$DropoffInfoTemplateItemImpl _$$DropoffInfoTemplateItemImplFromJson(
  Map<String, dynamic> json,
) => _$DropoffInfoTemplateItemImpl(
  id: json['id'] as String,
  labelAr: json['label_ar'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$$DropoffInfoTemplateItemImplToJson(
  _$DropoffInfoTemplateItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'label_ar': instance.labelAr,
  'type': instance.type,
};
