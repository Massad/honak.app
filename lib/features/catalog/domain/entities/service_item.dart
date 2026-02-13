import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/entities/money_converter.dart';

part 'service_item.freezed.dart';
part 'service_item.g.dart';

@freezed
class ServiceItem with _$ServiceItem {
  const factory ServiceItem({
    required String id,
    required String name,
    @JsonKey(name: 'name_en') String? nameEn,
    String? description,
    @MoneyConverter() @JsonKey(name: 'price_cents') required Money price,
    @MoneyNullableConverter()
    @JsonKey(name: 'price_from_cents')
    @Default(null)
    Money? priceFrom,
    @MoneyNullableConverter()
    @JsonKey(name: 'price_to_cents')
    @Default(null)
    Money? priceTo,
    @JsonKey(name: 'duration_minutes') int? durationMinutes,
    required String category,
    @JsonKey(name: 'category_ar') String? categoryAr,
    String? image,
    @JsonKey(name: 'requires_team_member') @Default(false) bool requiresTeamMember,
    @JsonKey(name: 'available_team_member_ids')
    @Default([])
    List<String> availableTeamMemberIds,
    @JsonKey(name: 'is_available') @Default(true) bool isAvailable,
    @JsonKey(name: 'is_popular') @Default(false) bool isPopular,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'page_id') String? pageId,
  }) = _ServiceItem;

  factory ServiceItem.fromJson(Map<String, dynamic> json) =>
      _$ServiceItemFromJson(json);
}
