import 'package:freezed_annotation/freezed_annotation.dart';

part 'biz_category.freezed.dart';
part 'biz_category.g.dart';

@freezed
class BizCategory with _$BizCategory {
  const factory BizCategory({
    required String id,
    required String name,
    @JsonKey(name: 'name_en') String? nameEn,
    @JsonKey(name: 'item_count') @Default(0) int itemCount,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
  }) = _BizCategory;

  factory BizCategory.fromJson(Map<String, dynamic> json) =>
      _$BizCategoryFromJson(json);
}
