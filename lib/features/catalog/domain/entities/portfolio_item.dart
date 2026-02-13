import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/shared/entities/media.dart';

part 'portfolio_item.freezed.dart';
part 'portfolio_item.g.dart';

@freezed
class PortfolioItem with _$PortfolioItem {
  const factory PortfolioItem({
    required String id,
    required String title,
    @JsonKey(name: 'title_en') String? titleEn,
    String? description,
    @JsonKey(name: 'description_en') String? descriptionEn,
    @Default([]) List<Media> images,
    required String category,
    @JsonKey(name: 'category_ar') String? categoryAr,
    @Default([]) List<String> tags,
    String? date,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'page_id') String? pageId,
  }) = _PortfolioItem;

  factory PortfolioItem.fromJson(Map<String, dynamic> json) =>
      _$PortfolioItemFromJson(json);
}
