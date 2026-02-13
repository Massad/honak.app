// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  String get id => throw _privateConstructorUsedError;
  PostPage get page => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<PostMedia> get media => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  int get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_following')
  bool get isFollowing => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_promoted')
  bool get isPromoted => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this Post to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res, Post>;
  @useResult
  $Res call({
    String id,
    PostPage page,
    String type,
    String content,
    List<PostMedia> media,
    @JsonKey(name: 'created_at') int createdAt,
    @JsonKey(name: 'is_following') bool isFollowing,
    @JsonKey(name: 'is_promoted') bool isPromoted,
    Map<String, dynamic>? metadata,
  });

  $PostPageCopyWith<$Res> get page;
}

/// @nodoc
class _$PostCopyWithImpl<$Res, $Val extends Post>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? page = null,
    Object? type = null,
    Object? content = null,
    Object? media = null,
    Object? createdAt = null,
    Object? isFollowing = null,
    Object? isPromoted = null,
    Object? metadata = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as PostPage,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            media: null == media
                ? _value.media
                : media // ignore: cast_nullable_to_non_nullable
                      as List<PostMedia>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as int,
            isFollowing: null == isFollowing
                ? _value.isFollowing
                : isFollowing // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPromoted: null == isPromoted
                ? _value.isPromoted
                : isPromoted // ignore: cast_nullable_to_non_nullable
                      as bool,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostPageCopyWith<$Res> get page {
    return $PostPageCopyWith<$Res>(_value.page, (value) {
      return _then(_value.copyWith(page: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostImplCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$PostImplCopyWith(
    _$PostImpl value,
    $Res Function(_$PostImpl) then,
  ) = __$$PostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    PostPage page,
    String type,
    String content,
    List<PostMedia> media,
    @JsonKey(name: 'created_at') int createdAt,
    @JsonKey(name: 'is_following') bool isFollowing,
    @JsonKey(name: 'is_promoted') bool isPromoted,
    Map<String, dynamic>? metadata,
  });

  @override
  $PostPageCopyWith<$Res> get page;
}

/// @nodoc
class __$$PostImplCopyWithImpl<$Res>
    extends _$PostCopyWithImpl<$Res, _$PostImpl>
    implements _$$PostImplCopyWith<$Res> {
  __$$PostImplCopyWithImpl(_$PostImpl _value, $Res Function(_$PostImpl) _then)
    : super(_value, _then);

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? page = null,
    Object? type = null,
    Object? content = null,
    Object? media = null,
    Object? createdAt = null,
    Object? isFollowing = null,
    Object? isPromoted = null,
    Object? metadata = freezed,
  }) {
    return _then(
      _$PostImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as PostPage,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        media: null == media
            ? _value._media
            : media // ignore: cast_nullable_to_non_nullable
                  as List<PostMedia>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as int,
        isFollowing: null == isFollowing
            ? _value.isFollowing
            : isFollowing // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPromoted: null == isPromoted
            ? _value.isPromoted
            : isPromoted // ignore: cast_nullable_to_non_nullable
                  as bool,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PostImpl extends _Post {
  const _$PostImpl({
    required this.id,
    required this.page,
    required this.type,
    required this.content,
    final List<PostMedia> media = const [],
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'is_following') this.isFollowing = false,
    @JsonKey(name: 'is_promoted') this.isPromoted = false,
    final Map<String, dynamic>? metadata,
  }) : _media = media,
       _metadata = metadata,
       super._();

  factory _$PostImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostImplFromJson(json);

  @override
  final String id;
  @override
  final PostPage page;
  @override
  final String type;
  @override
  final String content;
  final List<PostMedia> _media;
  @override
  @JsonKey()
  List<PostMedia> get media {
    if (_media is EqualUnmodifiableListView) return _media;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_media);
  }

  @override
  @JsonKey(name: 'created_at')
  final int createdAt;
  @override
  @JsonKey(name: 'is_following')
  final bool isFollowing;
  @override
  @JsonKey(name: 'is_promoted')
  final bool isPromoted;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Post(id: $id, page: $page, type: $type, content: $content, media: $media, createdAt: $createdAt, isFollowing: $isFollowing, isPromoted: $isPromoted, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._media, _media) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isFollowing, isFollowing) ||
                other.isFollowing == isFollowing) &&
            (identical(other.isPromoted, isPromoted) ||
                other.isPromoted == isPromoted) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    page,
    type,
    content,
    const DeepCollectionEquality().hash(_media),
    createdAt,
    isFollowing,
    isPromoted,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      __$$PostImplCopyWithImpl<_$PostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostImplToJson(this);
  }
}

abstract class _Post extends Post {
  const factory _Post({
    required final String id,
    required final PostPage page,
    required final String type,
    required final String content,
    final List<PostMedia> media,
    @JsonKey(name: 'created_at') required final int createdAt,
    @JsonKey(name: 'is_following') final bool isFollowing,
    @JsonKey(name: 'is_promoted') final bool isPromoted,
    final Map<String, dynamic>? metadata,
  }) = _$PostImpl;
  const _Post._() : super._();

  factory _Post.fromJson(Map<String, dynamic> json) = _$PostImpl.fromJson;

  @override
  String get id;
  @override
  PostPage get page;
  @override
  String get type;
  @override
  String get content;
  @override
  List<PostMedia> get media;
  @override
  @JsonKey(name: 'created_at')
  int get createdAt;
  @override
  @JsonKey(name: 'is_following')
  bool get isFollowing;
  @override
  @JsonKey(name: 'is_promoted')
  bool get isPromoted;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PostPage _$PostPageFromJson(Map<String, dynamic> json) {
  return _PostPage.fromJson(json);
}

/// @nodoc
mixin _$PostPage {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_verified')
  bool get isVerified => throw _privateConstructorUsedError;

  /// Serializes this PostPage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostPageCopyWith<PostPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostPageCopyWith<$Res> {
  factory $PostPageCopyWith(PostPage value, $Res Function(PostPage) then) =
      _$PostPageCopyWithImpl<$Res, PostPage>;
  @useResult
  $Res call({
    String id,
    String name,
    String slug,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'is_verified') bool isVerified,
  });
}

/// @nodoc
class _$PostPageCopyWithImpl<$Res, $Val extends PostPage>
    implements $PostPageCopyWith<$Res> {
  _$PostPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? avatarUrl = freezed,
    Object? isVerified = null,
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
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            isVerified: null == isVerified
                ? _value.isVerified
                : isVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PostPageImplCopyWith<$Res>
    implements $PostPageCopyWith<$Res> {
  factory _$$PostPageImplCopyWith(
    _$PostPageImpl value,
    $Res Function(_$PostPageImpl) then,
  ) = __$$PostPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String slug,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'is_verified') bool isVerified,
  });
}

/// @nodoc
class __$$PostPageImplCopyWithImpl<$Res>
    extends _$PostPageCopyWithImpl<$Res, _$PostPageImpl>
    implements _$$PostPageImplCopyWith<$Res> {
  __$$PostPageImplCopyWithImpl(
    _$PostPageImpl _value,
    $Res Function(_$PostPageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? avatarUrl = freezed,
    Object? isVerified = null,
  }) {
    return _then(
      _$PostPageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        isVerified: null == isVerified
            ? _value.isVerified
            : isVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PostPageImpl implements _PostPage {
  const _$PostPageImpl({
    required this.id,
    required this.name,
    required this.slug,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    @JsonKey(name: 'is_verified') this.isVerified = false,
  });

  factory _$PostPageImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostPageImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String slug;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'is_verified')
  final bool isVerified;

  @override
  String toString() {
    return 'PostPage(id: $id, name: $name, slug: $slug, avatarUrl: $avatarUrl, isVerified: $isVerified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostPageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, slug, avatarUrl, isVerified);

  /// Create a copy of PostPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostPageImplCopyWith<_$PostPageImpl> get copyWith =>
      __$$PostPageImplCopyWithImpl<_$PostPageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostPageImplToJson(this);
  }
}

abstract class _PostPage implements PostPage {
  const factory _PostPage({
    required final String id,
    required final String name,
    required final String slug,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    @JsonKey(name: 'is_verified') final bool isVerified,
  }) = _$PostPageImpl;

  factory _PostPage.fromJson(Map<String, dynamic> json) =
      _$PostPageImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get slug;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  @JsonKey(name: 'is_verified')
  bool get isVerified;

  /// Create a copy of PostPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostPageImplCopyWith<_$PostPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PostMedia _$PostMediaFromJson(Map<String, dynamic> json) {
  return _PostMedia.fromJson(json);
}

/// @nodoc
mixin _$PostMedia {
  String get url => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this PostMedia to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostMedia
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostMediaCopyWith<PostMedia> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostMediaCopyWith<$Res> {
  factory $PostMediaCopyWith(PostMedia value, $Res Function(PostMedia) then) =
      _$PostMediaCopyWithImpl<$Res, PostMedia>;
  @useResult
  $Res call({String url, String type});
}

/// @nodoc
class _$PostMediaCopyWithImpl<$Res, $Val extends PostMedia>
    implements $PostMediaCopyWith<$Res> {
  _$PostMediaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostMedia
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? url = null, Object? type = null}) {
    return _then(
      _value.copyWith(
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PostMediaImplCopyWith<$Res>
    implements $PostMediaCopyWith<$Res> {
  factory _$$PostMediaImplCopyWith(
    _$PostMediaImpl value,
    $Res Function(_$PostMediaImpl) then,
  ) = __$$PostMediaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, String type});
}

/// @nodoc
class __$$PostMediaImplCopyWithImpl<$Res>
    extends _$PostMediaCopyWithImpl<$Res, _$PostMediaImpl>
    implements _$$PostMediaImplCopyWith<$Res> {
  __$$PostMediaImplCopyWithImpl(
    _$PostMediaImpl _value,
    $Res Function(_$PostMediaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostMedia
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? url = null, Object? type = null}) {
    return _then(
      _$PostMediaImpl(
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PostMediaImpl implements _PostMedia {
  const _$PostMediaImpl({required this.url, this.type = 'image'});

  factory _$PostMediaImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostMediaImplFromJson(json);

  @override
  final String url;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'PostMedia(url: $url, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostMediaImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, type);

  /// Create a copy of PostMedia
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostMediaImplCopyWith<_$PostMediaImpl> get copyWith =>
      __$$PostMediaImplCopyWithImpl<_$PostMediaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostMediaImplToJson(this);
  }
}

abstract class _PostMedia implements PostMedia {
  const factory _PostMedia({required final String url, final String type}) =
      _$PostMediaImpl;

  factory _PostMedia.fromJson(Map<String, dynamic> json) =
      _$PostMediaImpl.fromJson;

  @override
  String get url;
  @override
  String get type;

  /// Create a copy of PostMedia
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostMediaImplCopyWith<_$PostMediaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
