import 'package:freezed_annotation/freezed_annotation.dart';

part 'available_add_on.freezed.dart';
part 'available_add_on.g.dart';

@freezed
class AvailableAddOn with _$AvailableAddOn {
  const factory AvailableAddOn({
    required String id,
    @JsonKey(name: 'name_ar') required String nameAr,
    @JsonKey(name: 'price_cents') required int priceCents,
  }) = _AvailableAddOn;

  factory AvailableAddOn.fromJson(Map<String, dynamic> json) =>
      _$AvailableAddOnFromJson(json);
}
