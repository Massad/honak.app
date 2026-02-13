import 'package:freezed_annotation/freezed_annotation.dart';

part 'package_model.freezed.dart';
part 'package_model.g.dart';

@freezed
class BusinessPackage with _$BusinessPackage {
  const factory BusinessPackage({
    required String id,
    required String name,
    @Default('') String description,
    required int price,
    required int credits,
    @JsonKey(name: 'credit_label') required String creditLabel,
    @JsonKey(name: 'validity_model')
    @Default('visits_date')
    String validityModel,
    @JsonKey(name: 'validity_months') int? validityMonths,
    @JsonKey(name: 'compare_price') int? comparePrice,
    @Default(true) bool active,
    @Default('package') String icon,
  }) = _BusinessPackage;

  factory BusinessPackage.fromJson(Map<String, dynamic> json) =>
      _$BusinessPackageFromJson(json);
}
