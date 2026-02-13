import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/shared/entities/media.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/entities/money_converter.dart';

part 'catalog_item.freezed.dart';
part 'catalog_item.g.dart';

@freezed
class CatalogItem with _$CatalogItem {
  const factory CatalogItem({
    required String id,
    required String name,
    @JsonKey(name: 'name_en') String? nameEn,
    String? description,
    @MoneyConverter() @JsonKey(name: 'price_cents') required Money price,
    @MoneyNullableConverter()
    @JsonKey(name: 'compare_at_price_cents')
    @Default(null)
    Money? compareAtPrice,
    @Default([]) List<Media> images,
    @Default([]) List<CatalogVariant> variants,
    required String category,
    @JsonKey(name: 'category_ar') String? categoryAr,
    String? brand,
    @JsonKey(name: 'in_stock') @Default(true) bool inStock,
    @JsonKey(name: 'stock_count') int? stockCount,
    String? sku,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'page_id') String? pageId,
  }) = _CatalogItem;

  factory CatalogItem.fromJson(Map<String, dynamic> json) =>
      _$CatalogItemFromJson(json);
}

@freezed
class CatalogVariant with _$CatalogVariant {
  const factory CatalogVariant({
    required String name,
    @JsonKey(name: 'name_ar') String? nameAr,
    @Default([]) List<String> values,
    @Default([]) List<int> priceAdjustments,
  }) = _CatalogVariant;

  factory CatalogVariant.fromJson(Map<String, dynamic> json) =>
      _$CatalogVariantFromJson(json);
}
