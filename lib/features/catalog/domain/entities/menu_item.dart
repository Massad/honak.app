import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/entities/money_converter.dart';

part 'menu_item.freezed.dart';
part 'menu_item.g.dart';

@freezed
class MenuItem with _$MenuItem {
  const factory MenuItem({
    required String id,
    required String name,
    @JsonKey(name: 'name_en') String? nameEn,
    String? description,
    @MoneyConverter() @JsonKey(name: 'price_cents') required Money price,
    String? image,
    required String category,
    @JsonKey(name: 'category_ar') String? categoryAr,
    @Default([]) List<MenuItemSize> sizes,
    @Default([]) List<MenuItemModifier> modifiers,
    @JsonKey(name: 'is_available') @Default(true) bool isAvailable,
    @JsonKey(name: 'is_popular') @Default(false) bool isPopular,
    @JsonKey(name: 'preparation_time_minutes') int? preparationTimeMinutes,
    int? calories,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'page_id') String? pageId,
  }) = _MenuItem;

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);
}

@freezed
class MenuItemSize with _$MenuItemSize {
  const factory MenuItemSize({
    required String name,
    @JsonKey(name: 'name_ar') String? nameAr,
    @MoneyConverter() @JsonKey(name: 'price_cents') required Money price,
  }) = _MenuItemSize;

  factory MenuItemSize.fromJson(Map<String, dynamic> json) =>
      _$MenuItemSizeFromJson(json);
}

@freezed
class MenuItemModifier with _$MenuItemModifier {
  const factory MenuItemModifier({
    required String name,
    @JsonKey(name: 'name_ar') String? nameAr,
    @MoneyNullableConverter()
    @JsonKey(name: 'price_cents')
    @Default(null)
    Money? price,
  }) = _MenuItemModifier;

  factory MenuItemModifier.fromJson(Map<String, dynamic> json) =>
      _$MenuItemModifierFromJson(json);
}
