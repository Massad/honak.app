import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_package.freezed.dart';
part 'service_package.g.dart';

@freezed
class ServicePackage with _$ServicePackage {
  const factory ServicePackage({
    required String id,
    @JsonKey(name: 'name_ar') required String nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    @JsonKey(name: 'description_ar') String? descriptionAr,
    @JsonKey(name: 'price_cents') required int price,
    @JsonKey(name: 'duration_min') required int durationMin,
    @Default([]) List<String> features,
    String? icon,
    @Default(false) bool popular,
    String? color,
  }) = _ServicePackage;

  factory ServicePackage.fromJson(Map<String, dynamic> json) =>
      _$ServicePackageFromJson(json);
}
