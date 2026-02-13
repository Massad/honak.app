import 'package:freezed_annotation/freezed_annotation.dart';

part 'nearby_page.freezed.dart';
part 'nearby_page.g.dart';

@freezed
class NearbyPage with _$NearbyPage {
  const factory NearbyPage({
    required String id,
    required String name,
    required String slug,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'cover_url') String? coverUrl,
    String? category,
    @JsonKey(name: 'distance_km') @Default(0.0) double distanceKm,
    @JsonKey(name: 'is_following') @Default(false) bool isFollowing,
    @JsonKey(name: 'is_verified') @Default(false) bool isVerified,
    @JsonKey(name: 'weekly_orders') @Default(0) int weeklyOrders,
    @JsonKey(name: 'is_open') @Default(true) bool isOpen,
    @JsonKey(name: 'browse_only') @Default(false) bool browseOnly,
  }) = _NearbyPage;

  factory NearbyPage.fromJson(Map<String, dynamic> json) =>
      _$NearbyPageFromJson(json);
}
