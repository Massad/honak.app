import 'package:freezed_annotation/freezed_annotation.dart';

part 'dropoff_item.freezed.dart';
part 'dropoff_item.g.dart';

@freezed
class DropoffItem with _$DropoffItem {
  const factory DropoffItem({
    required String id,
    required String name,
    required int quantity,
    required String service,
    @JsonKey(name: 'price_cents') required int price,
    @Default({}) Map<String, String> attributes,
    String? notes,
    @JsonKey(name: 'photo_before') String? photoBefore,
    @JsonKey(name: 'photo_after') String? photoAfter,
  }) = _DropoffItem;

  factory DropoffItem.fromJson(Map<String, dynamic> json) =>
      _$DropoffItemFromJson(json);
}
