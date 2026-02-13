import 'package:freezed_annotation/freezed_annotation.dart';

part 'branch.freezed.dart';
part 'branch.g.dart';

@freezed
class Branch with _$Branch {
  const factory Branch({
    required String id,
    required String name,
    String? address,
    String? phone,
    String? city,
    String? neighborhood,
    @Default('active') String status,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'is_main') @Default(false) bool isMain,
    @Default(true) bool active,
  }) = _Branch;

  factory Branch.fromJson(Map<String, dynamic> json) =>
      _$BranchFromJson(json);
}
