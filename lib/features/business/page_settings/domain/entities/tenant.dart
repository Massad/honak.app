import 'package:freezed_annotation/freezed_annotation.dart';

part 'tenant.freezed.dart';
part 'tenant.g.dart';

@freezed
class Tenant with _$Tenant {
  const factory Tenant({
    required String id,
    required String name,
    @Default('') String floor,
    @Default('') String unit,
    @JsonKey(name: 'business_type') @Default('') String businessType,
    @JsonKey(name: 'linked_page_id') String? linkedPageId,
    @Default('active') String status,
  }) = _Tenant;

  factory Tenant.fromJson(Map<String, dynamic> json) =>
      _$TenantFromJson(json);
}
