// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intake_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IntakeQuestionImpl _$$IntakeQuestionImplFromJson(Map<String, dynamic> json) =>
    _$IntakeQuestionImpl(
      id: json['id'] as String,
      question: json['question'] as String,
      fieldType: json['field_type'] as String? ?? 'text',
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isRequired: json['required'] as bool? ?? false,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      active: json['active'] as bool? ?? true,
    );

Map<String, dynamic> _$$IntakeQuestionImplToJson(
  _$IntakeQuestionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'question': instance.question,
  'field_type': instance.fieldType,
  'options': instance.options,
  'required': instance.isRequired,
  'sort_order': instance.sortOrder,
  'active': instance.active,
};
