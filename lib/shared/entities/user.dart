import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String phone,
    required String name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    String? bio,
    @JsonKey(name: 'created_at') int? createdAt,
    @Default('active') String status,
    @JsonKey(name: 'needs_profile_setup') @Default(false) bool needsProfileSetup,
    @Default([]) List<UserPage> pages,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class UserPage with _$UserPage {
  const factory UserPage({
    required String id,
    required String name,
    required String slug,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'business_type_name') String? businessTypeName,
    @JsonKey(name: 'business_type_id') String? businessTypeId,
    @JsonKey(name: 'is_verified') @Default(false) bool isVerified,
    @Default('owner') String role,
    @Default([]) List<String> permissions,
  }) = _UserPage;

  factory UserPage.fromJson(Map<String, dynamic> json) =>
      _$UserPageFromJson(json);
}
