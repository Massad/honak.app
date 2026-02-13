import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_change.freezed.dart';
part 'price_change.g.dart';

@freezed
class PriceChange with _$PriceChange {
  const factory PriceChange({
    required String id,
    required String direction,
    required String method,
    required double value,
    @Default('all') String scope,
    @JsonKey(name: 'category_names') @Default([]) List<String> categoryNames,
    @JsonKey(name: 'item_ids') @Default([]) List<String> itemIds,
    @JsonKey(name: 'starts_at') required String startsAt,
    @JsonKey(name: 'ends_at') String? endsAt,
    @Default('') String reason,
    @JsonKey(name: 'is_public') @Default(true) bool isPublic,
    @Default('active') String status,
    @JsonKey(name: 'affected_count') @Default(0) int affectedCount,
  }) = _PriceChange;

  factory PriceChange.fromJson(Map<String, dynamic> json) =>
      _$PriceChangeFromJson(json);
}
