import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/features/pages/domain/entities/trust_metric.dart';
import 'package:honak/shared/entities/location.dart';

part 'page_summary.freezed.dart';
part 'page_summary.g.dart';

@freezed
class PageSummary with _$PageSummary {
  const factory PageSummary({
    required String id,
    required String name,
    required String slug,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'cover_url') String? coverUrl,
    @JsonKey(name: 'business_type_name') String? businessTypeName,
    @JsonKey(name: 'business_type_id') String? businessTypeId,
    @JsonKey(name: 'explore_category') String? exploreCategory,
    String? archetype,
    @JsonKey(name: 'engagement_level') String? engagementLevel,
    String? distance,
    @JsonKey(name: 'is_open') @Default(true) bool isOpen,
    @JsonKey(name: 'store_type') String? storeType,
    @JsonKey(name: 'accepts_returns') @Default(false) bool acceptsReturns,
    @JsonKey(name: 'monthly_metric') String? monthlyMetric,
    @JsonKey(name: 'product_categories') @Default([]) List<String> productCategories,
    @JsonKey(name: 'has_active_stories') @Default(false) bool hasActiveStories,
    @JsonKey(name: 'trust_metrics') @Default([]) List<TrustMetric> trustMetrics,
    @JsonKey(name: 'sub_category') String? subCategory,
    @JsonKey(name: 'is_verified') @Default(false) bool isVerified,
    @JsonKey(name: 'is_following') @Default(false) bool isFollowing,
    @JsonKey(name: 'followers_count') @Default(0) int followersCount,
    Location? location,
  }) = _PageSummary;

  factory PageSummary.fromJson(Map<String, dynamic> json) =>
      _$PageSummaryFromJson(json);
}
