import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/shared/entities/money.dart';

part 'item.freezed.dart';
part 'item.g.dart';

class _MoneyConverter implements JsonConverter<Money, int> {
  const _MoneyConverter();

  @override
  Money fromJson(int json) => Money(json);

  @override
  int toJson(Money object) => object.cents;
}

@freezed
class Item with _$Item {
  const factory Item({
    required String id,
    @JsonKey(name: 'name_ar') required String nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    @JsonKey(name: 'description_ar') String? descriptionAr,
    @JsonKey(name: 'description_en') String? descriptionEn,
    @_MoneyConverter() @JsonKey(name: 'price_cents') required Money price,
    @Default([]) List<String> images,
    @JsonKey(name: 'option_groups') @Default([]) List<OptionGroup> optionGroups,
    @JsonKey(name: 'category_id') String? categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'in_stock') @Default(true) bool inStock,
    @JsonKey(name: 'page_id') String? pageId,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'team_member_ids') @Default([]) List<String> teamMemberIds,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@freezed
class OptionGroup with _$OptionGroup {
  const factory OptionGroup({
    required String id,
    @JsonKey(name: 'label_ar') required String labelAr,
    @JsonKey(name: 'label_en') String? labelEn,
    required String type,
    @JsonKey(name: 'required') @Default(false) bool isRequired,
    @Default([]) List<ItemOption> options,
  }) = _OptionGroup;

  factory OptionGroup.fromJson(Map<String, dynamic> json) =>
      _$OptionGroupFromJson(json);
}

@freezed
class ItemOption with _$ItemOption {
  const factory ItemOption({
    required String id,
    @JsonKey(name: 'label_ar') required String labelAr,
    @JsonKey(name: 'label_en') String? labelEn,
    @JsonKey(name: 'price_modifier') @Default(0) int priceModifier,
    @JsonKey(name: 'color_hex') String? colorHex,
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _ItemOption;

  factory ItemOption.fromJson(Map<String, dynamic> json) =>
      _$ItemOptionFromJson(json);
}
