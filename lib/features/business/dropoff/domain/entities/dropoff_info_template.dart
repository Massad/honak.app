import 'package:freezed_annotation/freezed_annotation.dart';

part 'dropoff_info_template.freezed.dart';
part 'dropoff_info_template.g.dart';

@freezed
class DropoffInfoTemplate with _$DropoffInfoTemplate {
  const factory DropoffInfoTemplate({
    required String id,
    @JsonKey(name: 'label_ar') required String labelAr,
    required List<DropoffInfoTemplateItem> items,
  }) = _DropoffInfoTemplate;

  factory DropoffInfoTemplate.fromJson(Map<String, dynamic> json) =>
      _$DropoffInfoTemplateFromJson(json);
}

@freezed
class DropoffInfoTemplateItem with _$DropoffInfoTemplateItem {
  const factory DropoffInfoTemplateItem({
    required String id,
    @JsonKey(name: 'label_ar') required String labelAr,
    required String type,
  }) = _DropoffInfoTemplateItem;

  factory DropoffInfoTemplateItem.fromJson(Map<String, dynamic> json) =>
      _$DropoffInfoTemplateItemFromJson(json);
}
