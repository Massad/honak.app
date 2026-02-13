// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intake_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

IntakeQuestion _$IntakeQuestionFromJson(Map<String, dynamic> json) {
  return _IntakeQuestion.fromJson(json);
}

/// @nodoc
mixin _$IntakeQuestion {
  String get id => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  @JsonKey(name: 'field_type')
  String get fieldType => throw _privateConstructorUsedError;
  List<String> get options => throw _privateConstructorUsedError;
  @JsonKey(name: 'required')
  bool get isRequired => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;

  /// Serializes this IntakeQuestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntakeQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntakeQuestionCopyWith<IntakeQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntakeQuestionCopyWith<$Res> {
  factory $IntakeQuestionCopyWith(
    IntakeQuestion value,
    $Res Function(IntakeQuestion) then,
  ) = _$IntakeQuestionCopyWithImpl<$Res, IntakeQuestion>;
  @useResult
  $Res call({
    String id,
    String question,
    @JsonKey(name: 'field_type') String fieldType,
    List<String> options,
    @JsonKey(name: 'required') bool isRequired,
    @JsonKey(name: 'sort_order') int sortOrder,
    bool active,
  });
}

/// @nodoc
class _$IntakeQuestionCopyWithImpl<$Res, $Val extends IntakeQuestion>
    implements $IntakeQuestionCopyWith<$Res> {
  _$IntakeQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntakeQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? fieldType = null,
    Object? options = null,
    Object? isRequired = null,
    Object? sortOrder = null,
    Object? active = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            question: null == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                      as String,
            fieldType: null == fieldType
                ? _value.fieldType
                : fieldType // ignore: cast_nullable_to_non_nullable
                      as String,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isRequired: null == isRequired
                ? _value.isRequired
                : isRequired // ignore: cast_nullable_to_non_nullable
                      as bool,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IntakeQuestionImplCopyWith<$Res>
    implements $IntakeQuestionCopyWith<$Res> {
  factory _$$IntakeQuestionImplCopyWith(
    _$IntakeQuestionImpl value,
    $Res Function(_$IntakeQuestionImpl) then,
  ) = __$$IntakeQuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String question,
    @JsonKey(name: 'field_type') String fieldType,
    List<String> options,
    @JsonKey(name: 'required') bool isRequired,
    @JsonKey(name: 'sort_order') int sortOrder,
    bool active,
  });
}

/// @nodoc
class __$$IntakeQuestionImplCopyWithImpl<$Res>
    extends _$IntakeQuestionCopyWithImpl<$Res, _$IntakeQuestionImpl>
    implements _$$IntakeQuestionImplCopyWith<$Res> {
  __$$IntakeQuestionImplCopyWithImpl(
    _$IntakeQuestionImpl _value,
    $Res Function(_$IntakeQuestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IntakeQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? fieldType = null,
    Object? options = null,
    Object? isRequired = null,
    Object? sortOrder = null,
    Object? active = null,
  }) {
    return _then(
      _$IntakeQuestionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        question: null == question
            ? _value.question
            : question // ignore: cast_nullable_to_non_nullable
                  as String,
        fieldType: null == fieldType
            ? _value.fieldType
            : fieldType // ignore: cast_nullable_to_non_nullable
                  as String,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isRequired: null == isRequired
            ? _value.isRequired
            : isRequired // ignore: cast_nullable_to_non_nullable
                  as bool,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IntakeQuestionImpl implements _IntakeQuestion {
  const _$IntakeQuestionImpl({
    required this.id,
    required this.question,
    @JsonKey(name: 'field_type') this.fieldType = 'text',
    final List<String> options = const [],
    @JsonKey(name: 'required') this.isRequired = false,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    this.active = true,
  }) : _options = options;

  factory _$IntakeQuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntakeQuestionImplFromJson(json);

  @override
  final String id;
  @override
  final String question;
  @override
  @JsonKey(name: 'field_type')
  final String fieldType;
  final List<String> _options;
  @override
  @JsonKey()
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  @JsonKey(name: 'required')
  final bool isRequired;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey()
  final bool active;

  @override
  String toString() {
    return 'IntakeQuestion(id: $id, question: $question, fieldType: $fieldType, options: $options, isRequired: $isRequired, sortOrder: $sortOrder, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntakeQuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.fieldType, fieldType) ||
                other.fieldType == fieldType) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    question,
    fieldType,
    const DeepCollectionEquality().hash(_options),
    isRequired,
    sortOrder,
    active,
  );

  /// Create a copy of IntakeQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntakeQuestionImplCopyWith<_$IntakeQuestionImpl> get copyWith =>
      __$$IntakeQuestionImplCopyWithImpl<_$IntakeQuestionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$IntakeQuestionImplToJson(this);
  }
}

abstract class _IntakeQuestion implements IntakeQuestion {
  const factory _IntakeQuestion({
    required final String id,
    required final String question,
    @JsonKey(name: 'field_type') final String fieldType,
    final List<String> options,
    @JsonKey(name: 'required') final bool isRequired,
    @JsonKey(name: 'sort_order') final int sortOrder,
    final bool active,
  }) = _$IntakeQuestionImpl;

  factory _IntakeQuestion.fromJson(Map<String, dynamic> json) =
      _$IntakeQuestionImpl.fromJson;

  @override
  String get id;
  @override
  String get question;
  @override
  @JsonKey(name: 'field_type')
  String get fieldType;
  @override
  List<String> get options;
  @override
  @JsonKey(name: 'required')
  bool get isRequired;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  bool get active;

  /// Create a copy of IntakeQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntakeQuestionImplCopyWith<_$IntakeQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
