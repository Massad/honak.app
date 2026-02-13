// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PortfolioItemImpl _$$PortfolioItemImplFromJson(Map<String, dynamic> json) =>
    _$PortfolioItemImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      titleEn: json['title_en'] as String?,
      description: json['description'] as String?,
      descriptionEn: json['description_en'] as String?,
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      category: json['category'] as String,
      categoryAr: json['category_ar'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      date: json['date'] as String?,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      pageId: json['page_id'] as String?,
    );

Map<String, dynamic> _$$PortfolioItemImplToJson(_$PortfolioItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'title_en': instance.titleEn,
      'description': instance.description,
      'description_en': instance.descriptionEn,
      'images': instance.images,
      'category': instance.category,
      'category_ar': instance.categoryAr,
      'tags': instance.tags,
      'date': instance.date,
      'sort_order': instance.sortOrder,
      'page_id': instance.pageId,
    };
