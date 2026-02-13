import 'package:freezed_annotation/freezed_annotation.dart';

part 'intake_question.freezed.dart';
part 'intake_question.g.dart';

@freezed
class IntakeQuestion with _$IntakeQuestion {
  const factory IntakeQuestion({
    required String id,
    required String question,
    @JsonKey(name: 'field_type') @Default('text') String fieldType,
    @Default([]) List<String> options,
    @JsonKey(name: 'required') @Default(false) bool isRequired,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @Default(true) bool active,
  }) = _IntakeQuestion;

  factory IntakeQuestion.fromJson(Map<String, dynamic> json) =>
      _$IntakeQuestionFromJson(json);
}
