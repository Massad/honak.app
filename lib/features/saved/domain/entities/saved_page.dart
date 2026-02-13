import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_page.freezed.dart';
part 'saved_page.g.dart';

@freezed
class SavedPage with _$SavedPage {
  const factory SavedPage({
    required String id,
    required String name,
    String? handle,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'category_name') String? categoryName,
    @Default(false) bool verified,
    @JsonKey(name: 'saved_at') int? savedAt,
  }) = _SavedPage;

  factory SavedPage.fromJson(Map<String, dynamic> json) =>
      _$SavedPageFromJson(json);
}
