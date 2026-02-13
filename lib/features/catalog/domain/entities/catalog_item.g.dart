// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CatalogItemImpl _$$CatalogItemImplFromJson(Map<String, dynamic> json) =>
    _$CatalogItemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      nameEn: json['name_en'] as String?,
      description: json['description'] as String?,
      price: const MoneyConverter().fromJson(
        (json['price_cents'] as num).toInt(),
      ),
      compareAtPrice: json['compare_at_price_cents'] == null
          ? null
          : const MoneyNullableConverter().fromJson(
              (json['compare_at_price_cents'] as num?)?.toInt(),
            ),
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      variants:
          (json['variants'] as List<dynamic>?)
              ?.map((e) => CatalogVariant.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      category: json['category'] as String,
      categoryAr: json['category_ar'] as String?,
      brand: json['brand'] as String?,
      inStock: json['in_stock'] as bool? ?? true,
      stockCount: (json['stock_count'] as num?)?.toInt(),
      sku: json['sku'] as String?,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      pageId: json['page_id'] as String?,
    );

Map<String, dynamic> _$$CatalogItemImplToJson(_$CatalogItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'description': instance.description,
      'price_cents': const MoneyConverter().toJson(instance.price),
      'compare_at_price_cents': const MoneyNullableConverter().toJson(
        instance.compareAtPrice,
      ),
      'images': instance.images,
      'variants': instance.variants,
      'category': instance.category,
      'category_ar': instance.categoryAr,
      'brand': instance.brand,
      'in_stock': instance.inStock,
      'stock_count': instance.stockCount,
      'sku': instance.sku,
      'sort_order': instance.sortOrder,
      'page_id': instance.pageId,
    };

_$CatalogVariantImpl _$$CatalogVariantImplFromJson(Map<String, dynamic> json) =>
    _$CatalogVariantImpl(
      name: json['name'] as String,
      nameAr: json['name_ar'] as String?,
      values:
          (json['values'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      priceAdjustments:
          (json['priceAdjustments'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CatalogVariantImplToJson(
  _$CatalogVariantImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'name_ar': instance.nameAr,
  'values': instance.values,
  'priceAdjustments': instance.priceAdjustments,
};
