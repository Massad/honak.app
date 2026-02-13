import 'package:freezed_annotation/freezed_annotation.dart';

part 'dropoff_service.freezed.dart';
part 'dropoff_service.g.dart';

@freezed
class DropoffServiceCategory with _$DropoffServiceCategory {
  const factory DropoffServiceCategory({
    required String id,
    @JsonKey(name: 'name_ar') required String nameAr,
    required String icon,
    required List<DropoffService> services,
  }) = _DropoffServiceCategory;

  factory DropoffServiceCategory.fromJson(Map<String, dynamic> json) =>
      _$DropoffServiceCategoryFromJson(json);
}

@freezed
class DropoffService with _$DropoffService {
  const factory DropoffService({
    required String id,
    @JsonKey(name: 'name_ar') required String nameAr,
    @JsonKey(name: 'price_cents') required int price,
    @JsonKey(name: 'duration_days') required int durationDays,
  }) = _DropoffService;

  factory DropoffService.fromJson(Map<String, dynamic> json) =>
      _$DropoffServiceFromJson(json);
}

@freezed
class DropoffAttribute with _$DropoffAttribute {
  const factory DropoffAttribute({
    required String id,
    @JsonKey(name: 'label_ar') required String labelAr,
    required List<String> values,
    @Default(true) bool optional,
  }) = _DropoffAttribute;

  factory DropoffAttribute.fromJson(Map<String, dynamic> json) =>
      _$DropoffAttributeFromJson(json);
}
