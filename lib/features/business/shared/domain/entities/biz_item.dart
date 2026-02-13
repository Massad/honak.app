import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/entities/money_converter.dart';

part 'biz_item.freezed.dart';
part 'biz_item.g.dart';

@freezed
class BizItem with _$BizItem {
  const factory BizItem({
    required String id,
    required String name,
    @JsonKey(name: 'name_en') String? nameEn,
    String? description,
    @JsonKey(name: 'price_cents') @MoneyNullableConverter() Money? price,
    @JsonKey(name: 'price_text') String? priceText,
    @JsonKey(name: 'original_price_cents')
    @MoneyNullableConverter()
    Money? originalPrice,
    @JsonKey(name: 'discount_percent') int? discountPercent,
    @JsonKey(name: 'discount_ends') String? discountEnds,
    @Default([]) List<String> images,
    @JsonKey(name: 'category_id') String? categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @Default('active') String status,
    int? stock,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'page_id') String? pageId,
    @JsonKey(name: 'branch_ids') @Default([]) List<String> branchIds,
    @JsonKey(name: 'assigned_team_ids')
    @Default([])
    List<String> assignedTeamIds,
    @Default({}) Map<String, dynamic> properties,
  }) = _BizItem;

  factory BizItem.fromJson(Map<String, dynamic> json) =>
      _$BizItemFromJson(json);
}
