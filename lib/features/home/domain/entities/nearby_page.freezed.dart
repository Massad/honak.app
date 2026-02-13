// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nearby_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NearbyPage _$NearbyPageFromJson(Map<String, dynamic> json) {
  return _NearbyPage.fromJson(json);
}

/// @nodoc
mixin _$NearbyPage {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover_url')
  String? get coverUrl => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'distance_km')
  double get distanceKm => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_following')
  bool get isFollowing => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_verified')
  bool get isVerified => throw _privateConstructorUsedError;
  @JsonKey(name: 'weekly_orders')
  int get weeklyOrders => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_open')
  bool get isOpen => throw _privateConstructorUsedError;
  @JsonKey(name: 'browse_only')
  bool get browseOnly => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_active_stories')
  bool get hasActiveStories => throw _privateConstructorUsedError;

  /// Serializes this NearbyPage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NearbyPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NearbyPageCopyWith<NearbyPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NearbyPageCopyWith<$Res> {
  factory $NearbyPageCopyWith(
    NearbyPage value,
    $Res Function(NearbyPage) then,
  ) = _$NearbyPageCopyWithImpl<$Res, NearbyPage>;
  @useResult
  $Res call({
    String id,
    String name,
    String slug,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'cover_url') String? coverUrl,
    String? category,
    @JsonKey(name: 'distance_km') double distanceKm,
    @JsonKey(name: 'is_following') bool isFollowing,
    @JsonKey(name: 'is_verified') bool isVerified,
    @JsonKey(name: 'weekly_orders') int weeklyOrders,
    @JsonKey(name: 'is_open') bool isOpen,
    @JsonKey(name: 'browse_only') bool browseOnly,
    @JsonKey(name: 'has_active_stories') bool hasActiveStories,
  });
}

/// @nodoc
class _$NearbyPageCopyWithImpl<$Res, $Val extends NearbyPage>
    implements $NearbyPageCopyWith<$Res> {
  _$NearbyPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NearbyPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? avatarUrl = freezed,
    Object? coverUrl = freezed,
    Object? category = freezed,
    Object? distanceKm = null,
    Object? isFollowing = null,
    Object? isVerified = null,
    Object? weeklyOrders = null,
    Object? isOpen = null,
    Object? browseOnly = null,
    Object? hasActiveStories = null,
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
            coverUrl: freezed == coverUrl
                ? _value.coverUrl
                : coverUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
            distanceKm: null == distanceKm
                ? _value.distanceKm
                : distanceKm // ignore: cast_nullable_to_non_nullable
                      as double,
            isFollowing: null == isFollowing
                ? _value.isFollowing
                : isFollowing // ignore: cast_nullable_to_non_nullable
                      as bool,
            isVerified: null == isVerified
                ? _value.isVerified
                : isVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            weeklyOrders: null == weeklyOrders
                ? _value.weeklyOrders
                : weeklyOrders // ignore: cast_nullable_to_non_nullable
                      as int,
            isOpen: null == isOpen
                ? _value.isOpen
                : isOpen // ignore: cast_nullable_to_non_nullable
                      as bool,
            browseOnly: null == browseOnly
                ? _value.browseOnly
                : browseOnly // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasActiveStories: null == hasActiveStories
                ? _value.hasActiveStories
                : hasActiveStories // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NearbyPageImplCopyWith<$Res>
    implements $NearbyPageCopyWith<$Res> {
  factory _$$NearbyPageImplCopyWith(
    _$NearbyPageImpl value,
    $Res Function(_$NearbyPageImpl) then,
  ) = __$$NearbyPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String slug,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'cover_url') String? coverUrl,
    String? category,
    @JsonKey(name: 'distance_km') double distanceKm,
    @JsonKey(name: 'is_following') bool isFollowing,
    @JsonKey(name: 'is_verified') bool isVerified,
    @JsonKey(name: 'weekly_orders') int weeklyOrders,
    @JsonKey(name: 'is_open') bool isOpen,
    @JsonKey(name: 'browse_only') bool browseOnly,
    @JsonKey(name: 'has_active_stories') bool hasActiveStories,
  });
}

/// @nodoc
class __$$NearbyPageImplCopyWithImpl<$Res>
    extends _$NearbyPageCopyWithImpl<$Res, _$NearbyPageImpl>
    implements _$$NearbyPageImplCopyWith<$Res> {
  __$$NearbyPageImplCopyWithImpl(
    _$NearbyPageImpl _value,
    $Res Function(_$NearbyPageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NearbyPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? avatarUrl = freezed,
    Object? coverUrl = freezed,
    Object? category = freezed,
    Object? distanceKm = null,
    Object? isFollowing = null,
    Object? isVerified = null,
    Object? weeklyOrders = null,
    Object? isOpen = null,
    Object? browseOnly = null,
    Object? hasActiveStories = null,
  }) {
    return _then(
      _$NearbyPageImpl(
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
        coverUrl: freezed == coverUrl
            ? _value.coverUrl
            : coverUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
        distanceKm: null == distanceKm
            ? _value.distanceKm
            : distanceKm // ignore: cast_nullable_to_non_nullable
                  as double,
        isFollowing: null == isFollowing
            ? _value.isFollowing
            : isFollowing // ignore: cast_nullable_to_non_nullable
                  as bool,
        isVerified: null == isVerified
            ? _value.isVerified
            : isVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        weeklyOrders: null == weeklyOrders
            ? _value.weeklyOrders
            : weeklyOrders // ignore: cast_nullable_to_non_nullable
                  as int,
        isOpen: null == isOpen
            ? _value.isOpen
            : isOpen // ignore: cast_nullable_to_non_nullable
                  as bool,
        browseOnly: null == browseOnly
            ? _value.browseOnly
            : browseOnly // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasActiveStories: null == hasActiveStories
            ? _value.hasActiveStories
            : hasActiveStories // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NearbyPageImpl implements _NearbyPage {
  const _$NearbyPageImpl({
    required this.id,
    required this.name,
    required this.slug,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    @JsonKey(name: 'cover_url') this.coverUrl,
    this.category,
    @JsonKey(name: 'distance_km') this.distanceKm = 0.0,
    @JsonKey(name: 'is_following') this.isFollowing = false,
    @JsonKey(name: 'is_verified') this.isVerified = false,
    @JsonKey(name: 'weekly_orders') this.weeklyOrders = 0,
    @JsonKey(name: 'is_open') this.isOpen = true,
    @JsonKey(name: 'browse_only') this.browseOnly = false,
    @JsonKey(name: 'has_active_stories') this.hasActiveStories = false,
  });

  factory _$NearbyPageImpl.fromJson(Map<String, dynamic> json) =>
      _$$NearbyPageImplFromJson(json);

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
  @JsonKey(name: 'cover_url')
  final String? coverUrl;
  @override
  final String? category;
  @override
  @JsonKey(name: 'distance_km')
  final double distanceKm;
  @override
  @JsonKey(name: 'is_following')
  final bool isFollowing;
  @override
  @JsonKey(name: 'is_verified')
  final bool isVerified;
  @override
  @JsonKey(name: 'weekly_orders')
  final int weeklyOrders;
  @override
  @JsonKey(name: 'is_open')
  final bool isOpen;
  @override
  @JsonKey(name: 'browse_only')
  final bool browseOnly;
  @override
  @JsonKey(name: 'has_active_stories')
  final bool hasActiveStories;

  @override
  String toString() {
    return 'NearbyPage(id: $id, name: $name, slug: $slug, avatarUrl: $avatarUrl, coverUrl: $coverUrl, category: $category, distanceKm: $distanceKm, isFollowing: $isFollowing, isVerified: $isVerified, weeklyOrders: $weeklyOrders, isOpen: $isOpen, browseOnly: $browseOnly, hasActiveStories: $hasActiveStories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NearbyPageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm) &&
            (identical(other.isFollowing, isFollowing) ||
                other.isFollowing == isFollowing) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.weeklyOrders, weeklyOrders) ||
                other.weeklyOrders == weeklyOrders) &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen) &&
            (identical(other.browseOnly, browseOnly) ||
                other.browseOnly == browseOnly) &&
            (identical(other.hasActiveStories, hasActiveStories) ||
                other.hasActiveStories == hasActiveStories));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    slug,
    avatarUrl,
    coverUrl,
    category,
    distanceKm,
    isFollowing,
    isVerified,
    weeklyOrders,
    isOpen,
    browseOnly,
    hasActiveStories,
  );

  /// Create a copy of NearbyPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NearbyPageImplCopyWith<_$NearbyPageImpl> get copyWith =>
      __$$NearbyPageImplCopyWithImpl<_$NearbyPageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NearbyPageImplToJson(this);
  }
}

abstract class _NearbyPage implements NearbyPage {
  const factory _NearbyPage({
    required final String id,
    required final String name,
    required final String slug,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    @JsonKey(name: 'cover_url') final String? coverUrl,
    final String? category,
    @JsonKey(name: 'distance_km') final double distanceKm,
    @JsonKey(name: 'is_following') final bool isFollowing,
    @JsonKey(name: 'is_verified') final bool isVerified,
    @JsonKey(name: 'weekly_orders') final int weeklyOrders,
    @JsonKey(name: 'is_open') final bool isOpen,
    @JsonKey(name: 'browse_only') final bool browseOnly,
    @JsonKey(name: 'has_active_stories') final bool hasActiveStories,
  }) = _$NearbyPageImpl;

  factory _NearbyPage.fromJson(Map<String, dynamic> json) =
      _$NearbyPageImpl.fromJson;

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
  @JsonKey(name: 'cover_url')
  String? get coverUrl;
  @override
  String? get category;
  @override
  @JsonKey(name: 'distance_km')
  double get distanceKm;
  @override
  @JsonKey(name: 'is_following')
  bool get isFollowing;
  @override
  @JsonKey(name: 'is_verified')
  bool get isVerified;
  @override
  @JsonKey(name: 'weekly_orders')
  int get weeklyOrders;
  @override
  @JsonKey(name: 'is_open')
  bool get isOpen;
  @override
  @JsonKey(name: 'browse_only')
  bool get browseOnly;
  @override
  @JsonKey(name: 'has_active_stories')
  bool get hasActiveStories;

  /// Create a copy of NearbyPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NearbyPageImplCopyWith<_$NearbyPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
