import 'package:freezed_annotation/freezed_annotation.dart';

part 'alert_model.freezed.dart';
part 'alert_model.g.dart';

@freezed
class BusinessAlert with _$BusinessAlert {
  const factory BusinessAlert({
    required String id,
    required String title,
    required String body,
    @Default('info') String severity,
    @JsonKey(name: 'expires_at') int? expiresAt,
    @Default(true) bool active,
    @JsonKey(name: 'created_at') required int createdAt,
    @Default(0) int views,
    @JsonKey(name: 'target_areas') @Default([]) List<String> targetAreas,
  }) = _BusinessAlert;

  factory BusinessAlert.fromJson(Map<String, dynamic> json) =>
      _$BusinessAlertFromJson(json);
}
