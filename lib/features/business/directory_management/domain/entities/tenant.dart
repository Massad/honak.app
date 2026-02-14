import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant_status.dart';

part 'tenant.freezed.dart';
part 'tenant.g.dart';

@freezed
class Tenant with _$Tenant {
  const Tenant._();

  const factory Tenant({
    required String id,
    required String name,
    @JsonKey(name: 'name_en') String? nameEn,
    required String category,
    @JsonKey(name: 'floor_id') required String floorId,
    required String unit,
    @JsonKey(name: 'is_open') @Default(true) bool isOpen,
    @JsonKey(name: 'temporarily_closed') @Default(false) bool temporarilyClosed,
    @JsonKey(name: 'page_id') String? pageId,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @Default([]) List<String> tags,
    @JsonKey(name: 'linked_at') String? linkedAt,
    @JsonKey(name: 'invited_at') String? invitedAt,
  }) = _Tenant;

  factory Tenant.fromJson(Map<String, dynamic> json) => _$TenantFromJson(json);

  TenantStatus get status {
    if (pageId != null && linkedAt != null) {
      final linked = DateTime.tryParse(linkedAt!);
      if (linked != null) {
        final daysSinceLinked = DateTime.now().difference(linked).inDays;
        if (daysSinceLinked < 7) return TenantStatus.newTenant;
      }
      return TenantStatus.claimed;
    }
    if (invitedAt != null) return TenantStatus.invited;
    return TenantStatus.unclaimed;
  }
}
