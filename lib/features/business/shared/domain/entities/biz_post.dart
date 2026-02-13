import 'package:freezed_annotation/freezed_annotation.dart';

part 'biz_post.freezed.dart';
part 'biz_post.g.dart';

@freezed
class BizPost with _$BizPost {
  const factory BizPost({
    required String id,
    required String type,
    required String caption,
    String? image,
    @JsonKey(name: 'status_color') String? statusColor,
    @JsonKey(name: 'page_id') String? pageId,
    @JsonKey(name: 'created_at') required int createdAt,
    @Default('published') String status, // draft | scheduled | published
    String? audience, // all | followers | area
    @JsonKey(name: 'scheduled_at') int? scheduledAt,
  }) = _BizPost;

  factory BizPost.fromJson(Map<String, dynamic> json) =>
      _$BizPostFromJson(json);
}
