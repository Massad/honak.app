import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/shared/entities/media.dart';
import 'package:honak/shared/entities/money.dart';

part 'space.freezed.dart';
part 'space.g.dart';

class _MoneyConverter implements JsonConverter<Money, int> {
  const _MoneyConverter();

  @override
  Money fromJson(int json) => Money(json);

  @override
  int toJson(Money object) => object.cents;
}

@freezed
class Space with _$Space {
  const factory Space({
    required String id,
    required String name,
    @JsonKey(name: 'name_en') String? nameEn,
    String? description,
    @Default([]) List<Media> images,
    @_MoneyConverter()
    @JsonKey(name: 'price_per_unit_cents')
    required Money pricePerUnit,
    @JsonKey(name: 'price_unit') @Default('per_night') String priceUnit,
    int? capacity,
    @JsonKey(name: 'min_capacity') int? minCapacity,
    @Default([]) List<String> amenities,
    @JsonKey(name: 'amenities_ar') @Default([]) List<String> amenitiesAr,
    @JsonKey(name: 'is_available') @Default(true) bool isAvailable,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'page_id') String? pageId,
  }) = _Space;

  factory Space.fromJson(Map<String, dynamic> json) => _$SpaceFromJson(json);
}
