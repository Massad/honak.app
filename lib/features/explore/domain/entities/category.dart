import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class BusinessSubType with _$BusinessSubType {
  const factory BusinessSubType({
    required String id,
    required String name,
    @Default('') String icon,
  }) = _BusinessSubType;

  factory BusinessSubType.fromJson(Map<String, dynamic> json) =>
      _$BusinessSubTypeFromJson(json);
}

@freezed
class Category with _$Category {
  const factory Category({
    required String id,
    @JsonKey(name: 'name_ar') required String nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    @JsonKey(name: 'icon_name') required String iconName,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @Default([]) List<BusinessSubType> types,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
