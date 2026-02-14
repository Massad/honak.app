import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/features/business/directory_management/domain/entities/directory_floor.dart';
import 'package:honak/features/business/directory_management/domain/entities/directory_manage_stats.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant.dart';

part 'directory_manage_data.freezed.dart';
part 'directory_manage_data.g.dart';

@freezed
class DirectoryManageData with _$DirectoryManageData {
  const factory DirectoryManageData({
    @Default([]) List<Tenant> tenants,
    @Default([]) List<DirectoryFloor> floors,
    @Default([]) List<String> categories,
    @Default([]) List<String> amenities,
    @JsonKey(name: 'featured_tenant_ids')
    @Default([])
    List<String> featuredTenantIds,
    DirectoryManageStats? stats,
  }) = _DirectoryManageData;

  factory DirectoryManageData.fromJson(Map<String, dynamic> json) =>
      _$DirectoryManageDataFromJson(json);
}
