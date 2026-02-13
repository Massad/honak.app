// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PageEntity _$PageEntityFromJson(Map<String, dynamic> json) {
  return _PageEntity.fromJson(json);
}

/// @nodoc
mixin _$PageEntity {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'owner_id')
  String get ownerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_type_id')
  String get businessTypeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_type_name')
  String? get businessTypeName => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover_url')
  String? get coverUrl => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  Location? get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_verified')
  bool get isVerified => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'followers_count')
  int get followersCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'products_count')
  int get productsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'posts_count')
  int get postsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  int? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover_media')
  Media? get coverMedia => throw _privateConstructorUsedError;

  /// Serializes this PageEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PageEntityCopyWith<PageEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageEntityCopyWith<$Res> {
  factory $PageEntityCopyWith(
    PageEntity value,
    $Res Function(PageEntity) then,
  ) = _$PageEntityCopyWithImpl<$Res, PageEntity>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'owner_id') String ownerId,
    @JsonKey(name: 'business_type_id') String businessTypeId,
    @JsonKey(name: 'business_type_name') String? businessTypeName,
    String name,
    String slug,
    String? description,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'cover_url') String? coverUrl,
    String? phone,
    Location? location,
    @JsonKey(name: 'is_verified') bool isVerified,
    String status,
    @JsonKey(name: 'followers_count') int followersCount,
    @JsonKey(name: 'products_count') int productsCount,
    @JsonKey(name: 'posts_count') int postsCount,
    @JsonKey(name: 'created_at') int? createdAt,
    @JsonKey(name: 'cover_media') Media? coverMedia,
  });

  $LocationCopyWith<$Res>? get location;
  $MediaCopyWith<$Res>? get coverMedia;
}

/// @nodoc
class _$PageEntityCopyWithImpl<$Res, $Val extends PageEntity>
    implements $PageEntityCopyWith<$Res> {
  _$PageEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PageEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerId = null,
    Object? businessTypeId = null,
    Object? businessTypeName = freezed,
    Object? name = null,
    Object? slug = null,
    Object? description = freezed,
    Object? avatarUrl = freezed,
    Object? coverUrl = freezed,
    Object? phone = freezed,
    Object? location = freezed,
    Object? isVerified = null,
    Object? status = null,
    Object? followersCount = null,
    Object? productsCount = null,
    Object? postsCount = null,
    Object? createdAt = freezed,
    Object? coverMedia = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            ownerId: null == ownerId
                ? _value.ownerId
                : ownerId // ignore: cast_nullable_to_non_nullable
                      as String,
            businessTypeId: null == businessTypeId
                ? _value.businessTypeId
                : businessTypeId // ignore: cast_nullable_to_non_nullable
                      as String,
            businessTypeName: freezed == businessTypeName
                ? _value.businessTypeName
                : businessTypeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            coverUrl: freezed == coverUrl
                ? _value.coverUrl
                : coverUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as Location?,
            isVerified: null == isVerified
                ? _value.isVerified
                : isVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            followersCount: null == followersCount
                ? _value.followersCount
                : followersCount // ignore: cast_nullable_to_non_nullable
                      as int,
            productsCount: null == productsCount
                ? _value.productsCount
                : productsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            postsCount: null == postsCount
                ? _value.postsCount
                : postsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as int?,
            coverMedia: freezed == coverMedia
                ? _value.coverMedia
                : coverMedia // ignore: cast_nullable_to_non_nullable
                      as Media?,
          )
          as $Val,
    );
  }

  /// Create a copy of PageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $LocationCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  /// Create a copy of PageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MediaCopyWith<$Res>? get coverMedia {
    if (_value.coverMedia == null) {
      return null;
    }

    return $MediaCopyWith<$Res>(_value.coverMedia!, (value) {
      return _then(_value.copyWith(coverMedia: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PageEntityImplCopyWith<$Res>
    implements $PageEntityCopyWith<$Res> {
  factory _$$PageEntityImplCopyWith(
    _$PageEntityImpl value,
    $Res Function(_$PageEntityImpl) then,
  ) = __$$PageEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'owner_id') String ownerId,
    @JsonKey(name: 'business_type_id') String businessTypeId,
    @JsonKey(name: 'business_type_name') String? businessTypeName,
    String name,
    String slug,
    String? description,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'cover_url') String? coverUrl,
    String? phone,
    Location? location,
    @JsonKey(name: 'is_verified') bool isVerified,
    String status,
    @JsonKey(name: 'followers_count') int followersCount,
    @JsonKey(name: 'products_count') int productsCount,
    @JsonKey(name: 'posts_count') int postsCount,
    @JsonKey(name: 'created_at') int? createdAt,
    @JsonKey(name: 'cover_media') Media? coverMedia,
  });

  @override
  $LocationCopyWith<$Res>? get location;
  @override
  $MediaCopyWith<$Res>? get coverMedia;
}

/// @nodoc
class __$$PageEntityImplCopyWithImpl<$Res>
    extends _$PageEntityCopyWithImpl<$Res, _$PageEntityImpl>
    implements _$$PageEntityImplCopyWith<$Res> {
  __$$PageEntityImplCopyWithImpl(
    _$PageEntityImpl _value,
    $Res Function(_$PageEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PageEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerId = null,
    Object? businessTypeId = null,
    Object? businessTypeName = freezed,
    Object? name = null,
    Object? slug = null,
    Object? description = freezed,
    Object? avatarUrl = freezed,
    Object? coverUrl = freezed,
    Object? phone = freezed,
    Object? location = freezed,
    Object? isVerified = null,
    Object? status = null,
    Object? followersCount = null,
    Object? productsCount = null,
    Object? postsCount = null,
    Object? createdAt = freezed,
    Object? coverMedia = freezed,
  }) {
    return _then(
      _$PageEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        ownerId: null == ownerId
            ? _value.ownerId
            : ownerId // ignore: cast_nullable_to_non_nullable
                  as String,
        businessTypeId: null == businessTypeId
            ? _value.businessTypeId
            : businessTypeId // ignore: cast_nullable_to_non_nullable
                  as String,
        businessTypeName: freezed == businessTypeName
            ? _value.businessTypeName
            : businessTypeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        coverUrl: freezed == coverUrl
            ? _value.coverUrl
            : coverUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as Location?,
        isVerified: null == isVerified
            ? _value.isVerified
            : isVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        followersCount: null == followersCount
            ? _value.followersCount
            : followersCount // ignore: cast_nullable_to_non_nullable
                  as int,
        productsCount: null == productsCount
            ? _value.productsCount
            : productsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        postsCount: null == postsCount
            ? _value.postsCount
            : postsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as int?,
        coverMedia: freezed == coverMedia
            ? _value.coverMedia
            : coverMedia // ignore: cast_nullable_to_non_nullable
                  as Media?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PageEntityImpl implements _PageEntity {
  const _$PageEntityImpl({
    required this.id,
    @JsonKey(name: 'owner_id') required this.ownerId,
    @JsonKey(name: 'business_type_id') required this.businessTypeId,
    @JsonKey(name: 'business_type_name') this.businessTypeName,
    required this.name,
    required this.slug,
    this.description,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    @JsonKey(name: 'cover_url') this.coverUrl,
    this.phone,
    this.location,
    @JsonKey(name: 'is_verified') this.isVerified = false,
    this.status = 'active',
    @JsonKey(name: 'followers_count') this.followersCount = 0,
    @JsonKey(name: 'products_count') this.productsCount = 0,
    @JsonKey(name: 'posts_count') this.postsCount = 0,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'cover_media') this.coverMedia,
  });

  factory _$PageEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$PageEntityImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'owner_id')
  final String ownerId;
  @override
  @JsonKey(name: 'business_type_id')
  final String businessTypeId;
  @override
  @JsonKey(name: 'business_type_name')
  final String? businessTypeName;
  @override
  final String name;
  @override
  final String slug;
  @override
  final String? description;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'cover_url')
  final String? coverUrl;
  @override
  final String? phone;
  @override
  final Location? location;
  @override
  @JsonKey(name: 'is_verified')
  final bool isVerified;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'followers_count')
  final int followersCount;
  @override
  @JsonKey(name: 'products_count')
  final int productsCount;
  @override
  @JsonKey(name: 'posts_count')
  final int postsCount;
  @override
  @JsonKey(name: 'created_at')
  final int? createdAt;
  @override
  @JsonKey(name: 'cover_media')
  final Media? coverMedia;

  @override
  String toString() {
    return 'PageEntity(id: $id, ownerId: $ownerId, businessTypeId: $businessTypeId, businessTypeName: $businessTypeName, name: $name, slug: $slug, description: $description, avatarUrl: $avatarUrl, coverUrl: $coverUrl, phone: $phone, location: $location, isVerified: $isVerified, status: $status, followersCount: $followersCount, productsCount: $productsCount, postsCount: $postsCount, createdAt: $createdAt, coverMedia: $coverMedia)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PageEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.businessTypeId, businessTypeId) ||
                other.businessTypeId == businessTypeId) &&
            (identical(other.businessTypeName, businessTypeName) ||
                other.businessTypeName == businessTypeName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.followersCount, followersCount) ||
                other.followersCount == followersCount) &&
            (identical(other.productsCount, productsCount) ||
                other.productsCount == productsCount) &&
            (identical(other.postsCount, postsCount) ||
                other.postsCount == postsCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.coverMedia, coverMedia) ||
                other.coverMedia == coverMedia));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    ownerId,
    businessTypeId,
    businessTypeName,
    name,
    slug,
    description,
    avatarUrl,
    coverUrl,
    phone,
    location,
    isVerified,
    status,
    followersCount,
    productsCount,
    postsCount,
    createdAt,
    coverMedia,
  );

  /// Create a copy of PageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PageEntityImplCopyWith<_$PageEntityImpl> get copyWith =>
      __$$PageEntityImplCopyWithImpl<_$PageEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PageEntityImplToJson(this);
  }
}

abstract class _PageEntity implements PageEntity {
  const factory _PageEntity({
    required final String id,
    @JsonKey(name: 'owner_id') required final String ownerId,
    @JsonKey(name: 'business_type_id') required final String businessTypeId,
    @JsonKey(name: 'business_type_name') final String? businessTypeName,
    required final String name,
    required final String slug,
    final String? description,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    @JsonKey(name: 'cover_url') final String? coverUrl,
    final String? phone,
    final Location? location,
    @JsonKey(name: 'is_verified') final bool isVerified,
    final String status,
    @JsonKey(name: 'followers_count') final int followersCount,
    @JsonKey(name: 'products_count') final int productsCount,
    @JsonKey(name: 'posts_count') final int postsCount,
    @JsonKey(name: 'created_at') final int? createdAt,
    @JsonKey(name: 'cover_media') final Media? coverMedia,
  }) = _$PageEntityImpl;

  factory _PageEntity.fromJson(Map<String, dynamic> json) =
      _$PageEntityImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'owner_id')
  String get ownerId;
  @override
  @JsonKey(name: 'business_type_id')
  String get businessTypeId;
  @override
  @JsonKey(name: 'business_type_name')
  String? get businessTypeName;
  @override
  String get name;
  @override
  String get slug;
  @override
  String? get description;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  @JsonKey(name: 'cover_url')
  String? get coverUrl;
  @override
  String? get phone;
  @override
  Location? get location;
  @override
  @JsonKey(name: 'is_verified')
  bool get isVerified;
  @override
  String get status;
  @override
  @JsonKey(name: 'followers_count')
  int get followersCount;
  @override
  @JsonKey(name: 'products_count')
  int get productsCount;
  @override
  @JsonKey(name: 'posts_count')
  int get postsCount;
  @override
  @JsonKey(name: 'created_at')
  int? get createdAt;
  @override
  @JsonKey(name: 'cover_media')
  Media? get coverMedia;

  /// Create a copy of PageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PageEntityImplCopyWith<_$PageEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
