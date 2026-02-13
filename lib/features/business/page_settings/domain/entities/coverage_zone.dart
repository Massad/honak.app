import 'package:freezed_annotation/freezed_annotation.dart';

part 'coverage_zone.freezed.dart';
part 'coverage_zone.g.dart';

@freezed
class CoverageZone with _$CoverageZone {
  const factory CoverageZone({
    required String id,
    required String name,
    required String zone,
    @Default(true) bool active,
    @JsonKey(name: 'delivery_fee') int? deliveryFee,
  }) = _CoverageZone;

  factory CoverageZone.fromJson(Map<String, dynamic> json) =>
      _$CoverageZoneFromJson(json);
}
