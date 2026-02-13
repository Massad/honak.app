// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  int? get createdAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'needs_profile_setup')
  bool get needsProfileSetup => throw _privateConstructorUsedError;
  List<UserPage> get pages => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call({
    String id,
    String phone,
    String name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    String? bio,
    @JsonKey(name: 'created_at') int? createdAt,
    String status,
    @JsonKey(name: 'needs_profile_setup') bool needsProfileSetup,
    List<UserPage> pages,
  });
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phone = null,
    Object? name = null,
    Object? avatarUrl = freezed,
    Object? bio = freezed,
    Object? createdAt = freezed,
    Object? status = null,
    Object? needsProfileSetup = null,
    Object? pages = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as int?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            needsProfileSetup: null == needsProfileSetup
                ? _value.needsProfileSetup
                : needsProfileSetup // ignore: cast_nullable_to_non_nullable
                      as bool,
            pages: null == pages
                ? _value.pages
                : pages // ignore: cast_nullable_to_non_nullable
                      as List<UserPage>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
    _$UserImpl value,
    $Res Function(_$UserImpl) then,
  ) = __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String phone,
    String name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    String? bio,
    @JsonKey(name: 'created_at') int? createdAt,
    String status,
    @JsonKey(name: 'needs_profile_setup') bool needsProfileSetup,
    List<UserPage> pages,
  });
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
    : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phone = null,
    Object? name = null,
    Object? avatarUrl = freezed,
    Object? bio = freezed,
    Object? createdAt = freezed,
    Object? status = null,
    Object? needsProfileSetup = null,
    Object? pages = null,
  }) {
    return _then(
      _$UserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as int?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        needsProfileSetup: null == needsProfileSetup
            ? _value.needsProfileSetup
            : needsProfileSetup // ignore: cast_nullable_to_non_nullable
                  as bool,
        pages: null == pages
            ? _value._pages
            : pages // ignore: cast_nullable_to_non_nullable
                  as List<UserPage>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl({
    required this.id,
    required this.phone,
    required this.name,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    this.bio,
    @JsonKey(name: 'created_at') this.createdAt,
    this.status = 'active',
    @JsonKey(name: 'needs_profile_setup') this.needsProfileSetup = false,
    final List<UserPage> pages = const [],
  }) : _pages = pages;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String phone;
  @override
  final String name;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  final String? bio;
  @override
  @JsonKey(name: 'created_at')
  final int? createdAt;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'needs_profile_setup')
  final bool needsProfileSetup;
  final List<UserPage> _pages;
  @override
  @JsonKey()
  List<UserPage> get pages {
    if (_pages is EqualUnmodifiableListView) return _pages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pages);
  }

  @override
  String toString() {
    return 'User(id: $id, phone: $phone, name: $name, avatarUrl: $avatarUrl, bio: $bio, createdAt: $createdAt, status: $status, needsProfileSetup: $needsProfileSetup, pages: $pages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.needsProfileSetup, needsProfileSetup) ||
                other.needsProfileSetup == needsProfileSetup) &&
            const DeepCollectionEquality().equals(other._pages, _pages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    phone,
    name,
    avatarUrl,
    bio,
    createdAt,
    status,
    needsProfileSetup,
    const DeepCollectionEquality().hash(_pages),
  );

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(this);
  }
}

abstract class _User implements User {
  const factory _User({
    required final String id,
    required final String phone,
    required final String name,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    final String? bio,
    @JsonKey(name: 'created_at') final int? createdAt,
    final String status,
    @JsonKey(name: 'needs_profile_setup') final bool needsProfileSetup,
    final List<UserPage> pages,
  }) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get phone;
  @override
  String get name;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  String? get bio;
  @override
  @JsonKey(name: 'created_at')
  int? get createdAt;
  @override
  String get status;
  @override
  @JsonKey(name: 'needs_profile_setup')
  bool get needsProfileSetup;
  @override
  List<UserPage> get pages;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserPage _$UserPageFromJson(Map<String, dynamic> json) {
  return _UserPage.fromJson(json);
}

/// @nodoc
mixin _$UserPage {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_type_name')
  String? get businessTypeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_type_id')
  String? get businessTypeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_verified')
  bool get isVerified => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  List<String> get permissions => throw _privateConstructorUsedError;

  /// Serializes this UserPage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserPageCopyWith<UserPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPageCopyWith<$Res> {
  factory $UserPageCopyWith(UserPage value, $Res Function(UserPage) then) =
      _$UserPageCopyWithImpl<$Res, UserPage>;
  @useResult
  $Res call({
    String id,
    String name,
    String slug,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'business_type_name') String? businessTypeName,
    @JsonKey(name: 'business_type_id') String? businessTypeId,
    @JsonKey(name: 'is_verified') bool isVerified,
    String role,
    List<String> permissions,
  });
}

/// @nodoc
class _$UserPageCopyWithImpl<$Res, $Val extends UserPage>
    implements $UserPageCopyWith<$Res> {
  _$UserPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? avatarUrl = freezed,
    Object? businessTypeName = freezed,
    Object? businessTypeId = freezed,
    Object? isVerified = null,
    Object? role = null,
    Object? permissions = null,
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
            businessTypeName: freezed == businessTypeName
                ? _value.businessTypeName
                : businessTypeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            businessTypeId: freezed == businessTypeId
                ? _value.businessTypeId
                : businessTypeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            isVerified: null == isVerified
                ? _value.isVerified
                : isVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            permissions: null == permissions
                ? _value.permissions
                : permissions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserPageImplCopyWith<$Res>
    implements $UserPageCopyWith<$Res> {
  factory _$$UserPageImplCopyWith(
    _$UserPageImpl value,
    $Res Function(_$UserPageImpl) then,
  ) = __$$UserPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String slug,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'business_type_name') String? businessTypeName,
    @JsonKey(name: 'business_type_id') String? businessTypeId,
    @JsonKey(name: 'is_verified') bool isVerified,
    String role,
    List<String> permissions,
  });
}

/// @nodoc
class __$$UserPageImplCopyWithImpl<$Res>
    extends _$UserPageCopyWithImpl<$Res, _$UserPageImpl>
    implements _$$UserPageImplCopyWith<$Res> {
  __$$UserPageImplCopyWithImpl(
    _$UserPageImpl _value,
    $Res Function(_$UserPageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? avatarUrl = freezed,
    Object? businessTypeName = freezed,
    Object? businessTypeId = freezed,
    Object? isVerified = null,
    Object? role = null,
    Object? permissions = null,
  }) {
    return _then(
      _$UserPageImpl(
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
        businessTypeName: freezed == businessTypeName
            ? _value.businessTypeName
            : businessTypeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        businessTypeId: freezed == businessTypeId
            ? _value.businessTypeId
            : businessTypeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        isVerified: null == isVerified
            ? _value.isVerified
            : isVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        permissions: null == permissions
            ? _value._permissions
            : permissions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserPageImpl implements _UserPage {
  const _$UserPageImpl({
    required this.id,
    required this.name,
    required this.slug,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    @JsonKey(name: 'business_type_name') this.businessTypeName,
    @JsonKey(name: 'business_type_id') this.businessTypeId,
    @JsonKey(name: 'is_verified') this.isVerified = false,
    this.role = 'owner',
    final List<String> permissions = const [],
  }) : _permissions = permissions;

  factory _$UserPageImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPageImplFromJson(json);

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
  @JsonKey(name: 'business_type_name')
  final String? businessTypeName;
  @override
  @JsonKey(name: 'business_type_id')
  final String? businessTypeId;
  @override
  @JsonKey(name: 'is_verified')
  final bool isVerified;
  @override
  @JsonKey()
  final String role;
  final List<String> _permissions;
  @override
  @JsonKey()
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  @override
  String toString() {
    return 'UserPage(id: $id, name: $name, slug: $slug, avatarUrl: $avatarUrl, businessTypeName: $businessTypeName, businessTypeId: $businessTypeId, isVerified: $isVerified, role: $role, permissions: $permissions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.businessTypeName, businessTypeName) ||
                other.businessTypeName == businessTypeName) &&
            (identical(other.businessTypeId, businessTypeId) ||
                other.businessTypeId == businessTypeId) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality().equals(
              other._permissions,
              _permissions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    slug,
    avatarUrl,
    businessTypeName,
    businessTypeId,
    isVerified,
    role,
    const DeepCollectionEquality().hash(_permissions),
  );

  /// Create a copy of UserPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPageImplCopyWith<_$UserPageImpl> get copyWith =>
      __$$UserPageImplCopyWithImpl<_$UserPageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPageImplToJson(this);
  }
}

abstract class _UserPage implements UserPage {
  const factory _UserPage({
    required final String id,
    required final String name,
    required final String slug,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    @JsonKey(name: 'business_type_name') final String? businessTypeName,
    @JsonKey(name: 'business_type_id') final String? businessTypeId,
    @JsonKey(name: 'is_verified') final bool isVerified,
    final String role,
    final List<String> permissions,
  }) = _$UserPageImpl;

  factory _UserPage.fromJson(Map<String, dynamic> json) =
      _$UserPageImpl.fromJson;

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
  @JsonKey(name: 'business_type_name')
  String? get businessTypeName;
  @override
  @JsonKey(name: 'business_type_id')
  String? get businessTypeId;
  @override
  @JsonKey(name: 'is_verified')
  bool get isVerified;
  @override
  String get role;
  @override
  List<String> get permissions;

  /// Create a copy of UserPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserPageImplCopyWith<_$UserPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
