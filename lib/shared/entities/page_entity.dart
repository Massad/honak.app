import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/shared/entities/location.dart';
import 'package:honak/shared/entities/media.dart';

part 'page_entity.freezed.dart';
part 'page_entity.g.dart';

@freezed
class PageEntity with _$PageEntity {
  const factory PageEntity({
    required String id,
    @JsonKey(name: 'owner_id') required String ownerId,
    @JsonKey(name: 'business_type_id') required String businessTypeId,
    @JsonKey(name: 'business_type_name') String? businessTypeName,
    required String name,
    required String slug,
    String? description,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'cover_url') String? coverUrl,
    String? phone,
    Location? location,
    @JsonKey(name: 'is_verified') @Default(false) bool isVerified,
    @Default('active') String status,
    @JsonKey(name: 'followers_count') @Default(0) int followersCount,
    @JsonKey(name: 'products_count') @Default(0) int productsCount,
    @JsonKey(name: 'posts_count') @Default(0) int postsCount,
    @JsonKey(name: 'created_at') int? createdAt,
    @JsonKey(name: 'cover_media') Media? coverMedia,
  }) = _PageEntity;

  factory PageEntity.fromJson(Map<String, dynamic> json) =>
      _$PageEntityFromJson(json);
}
