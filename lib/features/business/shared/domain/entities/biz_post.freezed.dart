// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biz_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BizPost _$BizPostFromJson(Map<String, dynamic> json) {
  return _BizPost.fromJson(json);
}

/// @nodoc
mixin _$BizPost {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get caption => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_color')
  String? get statusColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_id')
  String? get pageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  int get createdAt => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // draft | scheduled | published
  String? get audience =>
      throw _privateConstructorUsedError; // all | followers | area
  @JsonKey(name: 'scheduled_at')
  int? get scheduledAt => throw _privateConstructorUsedError;

  /// Serializes this BizPost to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BizPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BizPostCopyWith<BizPost> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BizPostCopyWith<$Res> {
  factory $BizPostCopyWith(BizPost value, $Res Function(BizPost) then) =
      _$BizPostCopyWithImpl<$Res, BizPost>;
  @useResult
  $Res call({
    String id,
    String type,
    String caption,
    String? image,
    @JsonKey(name: 'status_color') String? statusColor,
    @JsonKey(name: 'page_id') String? pageId,
    @JsonKey(name: 'created_at') int createdAt,
    String status,
    String? audience,
    @JsonKey(name: 'scheduled_at') int? scheduledAt,
  });
}

/// @nodoc
class _$BizPostCopyWithImpl<$Res, $Val extends BizPost>
    implements $BizPostCopyWith<$Res> {
  _$BizPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BizPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? caption = null,
    Object? image = freezed,
    Object? statusColor = freezed,
    Object? pageId = freezed,
    Object? createdAt = null,
    Object? status = null,
    Object? audience = freezed,
    Object? scheduledAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            caption: null == caption
                ? _value.caption
                : caption // ignore: cast_nullable_to_non_nullable
                      as String,
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String?,
            statusColor: freezed == statusColor
                ? _value.statusColor
                : statusColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            pageId: freezed == pageId
                ? _value.pageId
                : pageId // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            audience: freezed == audience
                ? _value.audience
                : audience // ignore: cast_nullable_to_non_nullable
                      as String?,
            scheduledAt: freezed == scheduledAt
                ? _value.scheduledAt
                : scheduledAt // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BizPostImplCopyWith<$Res> implements $BizPostCopyWith<$Res> {
  factory _$$BizPostImplCopyWith(
    _$BizPostImpl value,
    $Res Function(_$BizPostImpl) then,
  ) = __$$BizPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    String caption,
    String? image,
    @JsonKey(name: 'status_color') String? statusColor,
    @JsonKey(name: 'page_id') String? pageId,
    @JsonKey(name: 'created_at') int createdAt,
    String status,
    String? audience,
    @JsonKey(name: 'scheduled_at') int? scheduledAt,
  });
}

/// @nodoc
class __$$BizPostImplCopyWithImpl<$Res>
    extends _$BizPostCopyWithImpl<$Res, _$BizPostImpl>
    implements _$$BizPostImplCopyWith<$Res> {
  __$$BizPostImplCopyWithImpl(
    _$BizPostImpl _value,
    $Res Function(_$BizPostImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BizPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? caption = null,
    Object? image = freezed,
    Object? statusColor = freezed,
    Object? pageId = freezed,
    Object? createdAt = null,
    Object? status = null,
    Object? audience = freezed,
    Object? scheduledAt = freezed,
  }) {
    return _then(
      _$BizPostImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        caption: null == caption
            ? _value.caption
            : caption // ignore: cast_nullable_to_non_nullable
                  as String,
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String?,
        statusColor: freezed == statusColor
            ? _value.statusColor
            : statusColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        pageId: freezed == pageId
            ? _value.pageId
            : pageId // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        audience: freezed == audience
            ? _value.audience
            : audience // ignore: cast_nullable_to_non_nullable
                  as String?,
        scheduledAt: freezed == scheduledAt
            ? _value.scheduledAt
            : scheduledAt // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BizPostImpl implements _BizPost {
  const _$BizPostImpl({
    required this.id,
    required this.type,
    required this.caption,
    this.image,
    @JsonKey(name: 'status_color') this.statusColor,
    @JsonKey(name: 'page_id') this.pageId,
    @JsonKey(name: 'created_at') required this.createdAt,
    this.status = 'published',
    this.audience,
    @JsonKey(name: 'scheduled_at') this.scheduledAt,
  });

  factory _$BizPostImpl.fromJson(Map<String, dynamic> json) =>
      _$$BizPostImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String caption;
  @override
  final String? image;
  @override
  @JsonKey(name: 'status_color')
  final String? statusColor;
  @override
  @JsonKey(name: 'page_id')
  final String? pageId;
  @override
  @JsonKey(name: 'created_at')
  final int createdAt;
  @override
  @JsonKey()
  final String status;
  // draft | scheduled | published
  @override
  final String? audience;
  // all | followers | area
  @override
  @JsonKey(name: 'scheduled_at')
  final int? scheduledAt;

  @override
  String toString() {
    return 'BizPost(id: $id, type: $type, caption: $caption, image: $image, statusColor: $statusColor, pageId: $pageId, createdAt: $createdAt, status: $status, audience: $audience, scheduledAt: $scheduledAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BizPostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.statusColor, statusColor) ||
                other.statusColor == statusColor) &&
            (identical(other.pageId, pageId) || other.pageId == pageId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.audience, audience) ||
                other.audience == audience) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    caption,
    image,
    statusColor,
    pageId,
    createdAt,
    status,
    audience,
    scheduledAt,
  );

  /// Create a copy of BizPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BizPostImplCopyWith<_$BizPostImpl> get copyWith =>
      __$$BizPostImplCopyWithImpl<_$BizPostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BizPostImplToJson(this);
  }
}

abstract class _BizPost implements BizPost {
  const factory _BizPost({
    required final String id,
    required final String type,
    required final String caption,
    final String? image,
    @JsonKey(name: 'status_color') final String? statusColor,
    @JsonKey(name: 'page_id') final String? pageId,
    @JsonKey(name: 'created_at') required final int createdAt,
    final String status,
    final String? audience,
    @JsonKey(name: 'scheduled_at') final int? scheduledAt,
  }) = _$BizPostImpl;

  factory _BizPost.fromJson(Map<String, dynamic> json) = _$BizPostImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get caption;
  @override
  String? get image;
  @override
  @JsonKey(name: 'status_color')
  String? get statusColor;
  @override
  @JsonKey(name: 'page_id')
  String? get pageId;
  @override
  @JsonKey(name: 'created_at')
  int get createdAt;
  @override
  String get status; // draft | scheduled | published
  @override
  String? get audience; // all | followers | area
  @override
  @JsonKey(name: 'scheduled_at')
  int? get scheduledAt;

  /// Create a copy of BizPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BizPostImplCopyWith<_$BizPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
