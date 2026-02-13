// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Story _$StoryFromJson(Map<String, dynamic> json) {
  return _Story.fromJson(json);
}

/// @nodoc
mixin _$Story {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_id')
  String get pageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_name')
  String get pageName => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_avatar_url')
  String? get pageAvatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_new')
  bool get hasNew => throw _privateConstructorUsedError;
  @JsonKey(name: 'story_count')
  int get storyCount => throw _privateConstructorUsedError;

  /// Serializes this Story to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryCopyWith<Story> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryCopyWith<$Res> {
  factory $StoryCopyWith(Story value, $Res Function(Story) then) =
      _$StoryCopyWithImpl<$Res, Story>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'page_id') String pageId,
    @JsonKey(name: 'page_name') String pageName,
    @JsonKey(name: 'page_avatar_url') String? pageAvatarUrl,
    @JsonKey(name: 'has_new') bool hasNew,
    @JsonKey(name: 'story_count') int storyCount,
  });
}

/// @nodoc
class _$StoryCopyWithImpl<$Res, $Val extends Story>
    implements $StoryCopyWith<$Res> {
  _$StoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pageId = null,
    Object? pageName = null,
    Object? pageAvatarUrl = freezed,
    Object? hasNew = null,
    Object? storyCount = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            pageId: null == pageId
                ? _value.pageId
                : pageId // ignore: cast_nullable_to_non_nullable
                      as String,
            pageName: null == pageName
                ? _value.pageName
                : pageName // ignore: cast_nullable_to_non_nullable
                      as String,
            pageAvatarUrl: freezed == pageAvatarUrl
                ? _value.pageAvatarUrl
                : pageAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            hasNew: null == hasNew
                ? _value.hasNew
                : hasNew // ignore: cast_nullable_to_non_nullable
                      as bool,
            storyCount: null == storyCount
                ? _value.storyCount
                : storyCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoryImplCopyWith<$Res> implements $StoryCopyWith<$Res> {
  factory _$$StoryImplCopyWith(
    _$StoryImpl value,
    $Res Function(_$StoryImpl) then,
  ) = __$$StoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'page_id') String pageId,
    @JsonKey(name: 'page_name') String pageName,
    @JsonKey(name: 'page_avatar_url') String? pageAvatarUrl,
    @JsonKey(name: 'has_new') bool hasNew,
    @JsonKey(name: 'story_count') int storyCount,
  });
}

/// @nodoc
class __$$StoryImplCopyWithImpl<$Res>
    extends _$StoryCopyWithImpl<$Res, _$StoryImpl>
    implements _$$StoryImplCopyWith<$Res> {
  __$$StoryImplCopyWithImpl(
    _$StoryImpl _value,
    $Res Function(_$StoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pageId = null,
    Object? pageName = null,
    Object? pageAvatarUrl = freezed,
    Object? hasNew = null,
    Object? storyCount = null,
  }) {
    return _then(
      _$StoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        pageId: null == pageId
            ? _value.pageId
            : pageId // ignore: cast_nullable_to_non_nullable
                  as String,
        pageName: null == pageName
            ? _value.pageName
            : pageName // ignore: cast_nullable_to_non_nullable
                  as String,
        pageAvatarUrl: freezed == pageAvatarUrl
            ? _value.pageAvatarUrl
            : pageAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        hasNew: null == hasNew
            ? _value.hasNew
            : hasNew // ignore: cast_nullable_to_non_nullable
                  as bool,
        storyCount: null == storyCount
            ? _value.storyCount
            : storyCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryImpl implements _Story {
  const _$StoryImpl({
    required this.id,
    @JsonKey(name: 'page_id') required this.pageId,
    @JsonKey(name: 'page_name') required this.pageName,
    @JsonKey(name: 'page_avatar_url') this.pageAvatarUrl,
    @JsonKey(name: 'has_new') this.hasNew = false,
    @JsonKey(name: 'story_count') this.storyCount = 0,
  });

  factory _$StoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'page_id')
  final String pageId;
  @override
  @JsonKey(name: 'page_name')
  final String pageName;
  @override
  @JsonKey(name: 'page_avatar_url')
  final String? pageAvatarUrl;
  @override
  @JsonKey(name: 'has_new')
  final bool hasNew;
  @override
  @JsonKey(name: 'story_count')
  final int storyCount;

  @override
  String toString() {
    return 'Story(id: $id, pageId: $pageId, pageName: $pageName, pageAvatarUrl: $pageAvatarUrl, hasNew: $hasNew, storyCount: $storyCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pageId, pageId) || other.pageId == pageId) &&
            (identical(other.pageName, pageName) ||
                other.pageName == pageName) &&
            (identical(other.pageAvatarUrl, pageAvatarUrl) ||
                other.pageAvatarUrl == pageAvatarUrl) &&
            (identical(other.hasNew, hasNew) || other.hasNew == hasNew) &&
            (identical(other.storyCount, storyCount) ||
                other.storyCount == storyCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    pageId,
    pageName,
    pageAvatarUrl,
    hasNew,
    storyCount,
  );

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryImplCopyWith<_$StoryImpl> get copyWith =>
      __$$StoryImplCopyWithImpl<_$StoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryImplToJson(this);
  }
}

abstract class _Story implements Story {
  const factory _Story({
    required final String id,
    @JsonKey(name: 'page_id') required final String pageId,
    @JsonKey(name: 'page_name') required final String pageName,
    @JsonKey(name: 'page_avatar_url') final String? pageAvatarUrl,
    @JsonKey(name: 'has_new') final bool hasNew,
    @JsonKey(name: 'story_count') final int storyCount,
  }) = _$StoryImpl;

  factory _Story.fromJson(Map<String, dynamic> json) = _$StoryImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'page_id')
  String get pageId;
  @override
  @JsonKey(name: 'page_name')
  String get pageName;
  @override
  @JsonKey(name: 'page_avatar_url')
  String? get pageAvatarUrl;
  @override
  @JsonKey(name: 'has_new')
  bool get hasNew;
  @override
  @JsonKey(name: 'story_count')
  int get storyCount;

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryImplCopyWith<_$StoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
