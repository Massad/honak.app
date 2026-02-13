// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceItemImpl _$$ServiceItemImplFromJson(Map<String, dynamic> json) =>
    _$ServiceItemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      nameEn: json['name_en'] as String?,
      description: json['description'] as String?,
      price: const MoneyConverter().fromJson(
        (json['price_cents'] as num).toInt(),
      ),
      priceFrom: json['price_from_cents'] == null
          ? null
          : const MoneyNullableConverter().fromJson(
              (json['price_from_cents'] as num?)?.toInt(),
            ),
      priceTo: json['price_to_cents'] == null
          ? null
          : const MoneyNullableConverter().fromJson(
              (json['price_to_cents'] as num?)?.toInt(),
            ),
      durationMinutes: (json['duration_minutes'] as num?)?.toInt(),
      category: json['category'] as String,
      categoryAr: json['category_ar'] as String?,
      image: json['image'] as String?,
      requiresTeamMember: json['requires_team_member'] as bool? ?? false,
      availableTeamMemberIds:
          (json['available_team_member_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isAvailable: json['is_available'] as bool? ?? true,
      isPopular: json['is_popular'] as bool? ?? false,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      pageId: json['page_id'] as String?,
    );

Map<String, dynamic> _$$ServiceItemImplToJson(
  _$ServiceItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'name_en': instance.nameEn,
  'description': instance.description,
  'price_cents': const MoneyConverter().toJson(instance.price),
  'price_from_cents': const MoneyNullableConverter().toJson(instance.priceFrom),
  'price_to_cents': const MoneyNullableConverter().toJson(instance.priceTo),
  'duration_minutes': instance.durationMinutes,
  'category': instance.category,
  'category_ar': instance.categoryAr,
  'image': instance.image,
  'requires_team_member': instance.requiresTeamMember,
  'available_team_member_ids': instance.availableTeamMemberIds,
  'is_available': instance.isAvailable,
  'is_popular': instance.isPopular,
  'sort_order': instance.sortOrder,
  'page_id': instance.pageId,
};
