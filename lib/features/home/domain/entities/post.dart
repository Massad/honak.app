import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

enum PostType {
  product,
  offer,
  update,
  status,
  photo;

  static PostType fromString(String value) {
    return PostType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => PostType.update,
    );
  }
}

@freezed
class Post with _$Post {
  const Post._();

  const factory Post({
    required String id,
    required PostPage page,
    required String type,
    required String content,
    @Default([]) List<PostMedia> media,
    @JsonKey(name: 'created_at') required int createdAt,
    @JsonKey(name: 'is_following') @Default(false) bool isFollowing,
    @JsonKey(name: 'is_promoted') @Default(false) bool isPromoted,
    Map<String, dynamic>? metadata,
  }) = _Post;

  PostType get postType => PostType.fromString(type);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

@freezed
class PostPage with _$PostPage {
  const factory PostPage({
    required String id,
    required String name,
    required String slug,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'is_verified') @Default(false) bool isVerified,
  }) = _PostPage;

  factory PostPage.fromJson(Map<String, dynamic> json) =>
      _$PostPageFromJson(json);
}

@freezed
class PostMedia with _$PostMedia {
  const factory PostMedia({
    required String url,
    @Default('image') String type,
  }) = _PostMedia;

  factory PostMedia.fromJson(Map<String, dynamic> json) =>
      _$PostMediaFromJson(json);
}
