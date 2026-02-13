// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StoryContent _$StoryContentFromJson(Map<String, dynamic> json) {
  return _StoryContent.fromJson(json);
}

/// @nodoc
mixin _$StoryContent {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  List<StorySlide> get stories => throw _privateConstructorUsedError;

  /// Serializes this StoryContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryContentCopyWith<StoryContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryContentCopyWith<$Res> {
  factory $StoryContentCopyWith(
    StoryContent value,
    $Res Function(StoryContent) then,
  ) = _$StoryContentCopyWithImpl<$Res, StoryContent>;
  @useResult
  $Res call({String id, String name, String? avatar, List<StorySlide> stories});
}

/// @nodoc
class _$StoryContentCopyWithImpl<$Res, $Val extends StoryContent>
    implements $StoryContentCopyWith<$Res> {
  _$StoryContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = freezed,
    Object? stories = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            avatar: freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            stories: null == stories
                ? _value.stories
                : stories // ignore: cast_nullable_to_non_nullable
                      as List<StorySlide>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoryContentImplCopyWith<$Res>
    implements $StoryContentCopyWith<$Res> {
  factory _$$StoryContentImplCopyWith(
    _$StoryContentImpl value,
    $Res Function(_$StoryContentImpl) then,
  ) = __$$StoryContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String? avatar, List<StorySlide> stories});
}

/// @nodoc
class __$$StoryContentImplCopyWithImpl<$Res>
    extends _$StoryContentCopyWithImpl<$Res, _$StoryContentImpl>
    implements _$$StoryContentImplCopyWith<$Res> {
  __$$StoryContentImplCopyWithImpl(
    _$StoryContentImpl _value,
    $Res Function(_$StoryContentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = freezed,
    Object? stories = null,
  }) {
    return _then(
      _$StoryContentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        avatar: freezed == avatar
            ? _value.avatar
            : avatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        stories: null == stories
            ? _value._stories
            : stories // ignore: cast_nullable_to_non_nullable
                  as List<StorySlide>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryContentImpl implements _StoryContent {
  const _$StoryContentImpl({
    required this.id,
    required this.name,
    this.avatar,
    final List<StorySlide> stories = const [],
  }) : _stories = stories;

  factory _$StoryContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryContentImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? avatar;
  final List<StorySlide> _stories;
  @override
  @JsonKey()
  List<StorySlide> get stories {
    if (_stories is EqualUnmodifiableListView) return _stories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stories);
  }

  @override
  String toString() {
    return 'StoryContent(id: $id, name: $name, avatar: $avatar, stories: $stories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryContentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            const DeepCollectionEquality().equals(other._stories, _stories));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    avatar,
    const DeepCollectionEquality().hash(_stories),
  );

  /// Create a copy of StoryContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryContentImplCopyWith<_$StoryContentImpl> get copyWith =>
      __$$StoryContentImplCopyWithImpl<_$StoryContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryContentImplToJson(this);
  }
}

abstract class _StoryContent implements StoryContent {
  const factory _StoryContent({
    required final String id,
    required final String name,
    final String? avatar,
    final List<StorySlide> stories,
  }) = _$StoryContentImpl;

  factory _StoryContent.fromJson(Map<String, dynamic> json) =
      _$StoryContentImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get avatar;
  @override
  List<StorySlide> get stories;

  /// Create a copy of StoryContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryContentImplCopyWith<_$StoryContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
