// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpaceImpl _$$SpaceImplFromJson(Map<String, dynamic> json) => _$SpaceImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  nameEn: json['name_en'] as String?,
  description: json['description'] as String?,
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  pricePerUnit: const _MoneyConverter().fromJson(
    (json['price_per_unit_cents'] as num).toInt(),
  ),
  priceUnit: json['price_unit'] as String? ?? 'per_night',
  capacity: (json['capacity'] as num?)?.toInt(),
  minCapacity: (json['min_capacity'] as num?)?.toInt(),
  amenities:
      (json['amenities'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  amenitiesAr:
      (json['amenities_ar'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  isAvailable: json['is_available'] as bool? ?? true,
  sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
  pageId: json['page_id'] as String?,
);

Map<String, dynamic> _$$SpaceImplToJson(
  _$SpaceImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'name_en': instance.nameEn,
  'description': instance.description,
  'images': instance.images,
  'price_per_unit_cents': const _MoneyConverter().toJson(instance.pricePerUnit),
  'price_unit': instance.priceUnit,
  'capacity': instance.capacity,
  'min_capacity': instance.minCapacity,
  'amenities': instance.amenities,
  'amenities_ar': instance.amenitiesAr,
  'is_available': instance.isAvailable,
  'sort_order': instance.sortOrder,
  'page_id': instance.pageId,
};
