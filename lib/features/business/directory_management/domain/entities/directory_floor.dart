import 'package:freezed_annotation/freezed_annotation.dart';

part 'directory_floor.freezed.dart';
part 'directory_floor.g.dart';

@freezed
class DirectoryFloor with _$DirectoryFloor {
  const factory DirectoryFloor({
    required String id,
    required String name,
    String? label,
    @JsonKey(name: 'tenant_count') @Default(0) int tenantCount,
  }) = _DirectoryFloor;

  factory DirectoryFloor.fromJson(Map<String, dynamic> json) =>
      _$DirectoryFloorFromJson(json);
}
