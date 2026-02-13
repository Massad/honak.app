import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_member.freezed.dart';
part 'team_member.g.dart';

@freezed
class TeamMember with _$TeamMember {
  const factory TeamMember({
    required String id,
    required String name,
    String? phone,
    String? role,
    @Default(true) bool active,
    @JsonKey(name: 'is_owner') @Default(false) bool isOwner,
    @Default([]) List<String> permissions,
    @JsonKey(name: 'location_ids') @Default([]) List<String> locationIds,
    @JsonKey(name: 'service_ids') @Default([]) List<String> serviceIds,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'joined_at') String? joinedAt,
  }) = _TeamMember;

  factory TeamMember.fromJson(Map<String, dynamic> json) =>
      _$TeamMemberFromJson(json);
}
