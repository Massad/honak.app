// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_reference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StoryReference _$StoryReferenceFromJson(Map<String, dynamic> json) {
  return _StoryReference.fromJson(json);
}

/// @nodoc
mixin _$StoryReference {
  @JsonKey(name: 'story_id')
  String get storyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_id')
  String get businessId => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_name')
  String get businessName => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_avatar')
  String? get businessAvatar => throw _privateConstructorUsedError;
  String? get thumbnail => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'bg_gradient')
  List<String>? get bgGradient => throw _privateConstructorUsedError;
  @JsonKey(name: 'bg_color')
  String? get bgColor => throw _privateConstructorUsedError;

  /// Serializes this StoryReference to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryReference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryReferenceCopyWith<StoryReference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryReferenceCopyWith<$Res> {
  factory $StoryReferenceCopyWith(
    StoryReference value,
    $Res Function(StoryReference) then,
  ) = _$StoryReferenceCopyWithImpl<$Res, StoryReference>;
  @useResult
  $Res call({
    @JsonKey(name: 'story_id') String storyId,
    @JsonKey(name: 'business_id') String businessId,
    @JsonKey(name: 'business_name') String businessName,
    @JsonKey(name: 'business_avatar') String? businessAvatar,
    String? thumbnail,
    String? text,
    @JsonKey(name: 'bg_gradient') List<String>? bgGradient,
    @JsonKey(name: 'bg_color') String? bgColor,
  });
}

/// @nodoc
class _$StoryReferenceCopyWithImpl<$Res, $Val extends StoryReference>
    implements $StoryReferenceCopyWith<$Res> {
  _$StoryReferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryReference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storyId = null,
    Object? businessId = null,
    Object? businessName = null,
    Object? businessAvatar = freezed,
    Object? thumbnail = freezed,
    Object? text = freezed,
    Object? bgGradient = freezed,
    Object? bgColor = freezed,
  }) {
    return _then(
      _value.copyWith(
            storyId: null == storyId
                ? _value.storyId
                : storyId // ignore: cast_nullable_to_non_nullable
                      as String,
            businessId: null == businessId
                ? _value.businessId
                : businessId // ignore: cast_nullable_to_non_nullable
                      as String,
            businessName: null == businessName
                ? _value.businessName
                : businessName // ignore: cast_nullable_to_non_nullable
                      as String,
            businessAvatar: freezed == businessAvatar
                ? _value.businessAvatar
                : businessAvatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            thumbnail: freezed == thumbnail
                ? _value.thumbnail
                : thumbnail // ignore: cast_nullable_to_non_nullable
                      as String?,
            text: freezed == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String?,
            bgGradient: freezed == bgGradient
                ? _value.bgGradient
                : bgGradient // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            bgColor: freezed == bgColor
                ? _value.bgColor
                : bgColor // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoryReferenceImplCopyWith<$Res>
    implements $StoryReferenceCopyWith<$Res> {
  factory _$$StoryReferenceImplCopyWith(
    _$StoryReferenceImpl value,
    $Res Function(_$StoryReferenceImpl) then,
  ) = __$$StoryReferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'story_id') String storyId,
    @JsonKey(name: 'business_id') String businessId,
    @JsonKey(name: 'business_name') String businessName,
    @JsonKey(name: 'business_avatar') String? businessAvatar,
    String? thumbnail,
    String? text,
    @JsonKey(name: 'bg_gradient') List<String>? bgGradient,
    @JsonKey(name: 'bg_color') String? bgColor,
  });
}

/// @nodoc
class __$$StoryReferenceImplCopyWithImpl<$Res>
    extends _$StoryReferenceCopyWithImpl<$Res, _$StoryReferenceImpl>
    implements _$$StoryReferenceImplCopyWith<$Res> {
  __$$StoryReferenceImplCopyWithImpl(
    _$StoryReferenceImpl _value,
    $Res Function(_$StoryReferenceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryReference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storyId = null,
    Object? businessId = null,
    Object? businessName = null,
    Object? businessAvatar = freezed,
    Object? thumbnail = freezed,
    Object? text = freezed,
    Object? bgGradient = freezed,
    Object? bgColor = freezed,
  }) {
    return _then(
      _$StoryReferenceImpl(
        storyId: null == storyId
            ? _value.storyId
            : storyId // ignore: cast_nullable_to_non_nullable
                  as String,
        businessId: null == businessId
            ? _value.businessId
            : businessId // ignore: cast_nullable_to_non_nullable
                  as String,
        businessName: null == businessName
            ? _value.businessName
            : businessName // ignore: cast_nullable_to_non_nullable
                  as String,
        businessAvatar: freezed == businessAvatar
            ? _value.businessAvatar
            : businessAvatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        thumbnail: freezed == thumbnail
            ? _value.thumbnail
            : thumbnail // ignore: cast_nullable_to_non_nullable
                  as String?,
        text: freezed == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String?,
        bgGradient: freezed == bgGradient
            ? _value._bgGradient
            : bgGradient // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        bgColor: freezed == bgColor
            ? _value.bgColor
            : bgColor // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryReferenceImpl implements _StoryReference {
  const _$StoryReferenceImpl({
    @JsonKey(name: 'story_id') required this.storyId,
    @JsonKey(name: 'business_id') required this.businessId,
    @JsonKey(name: 'business_name') required this.businessName,
    @JsonKey(name: 'business_avatar') this.businessAvatar,
    this.thumbnail,
    this.text,
    @JsonKey(name: 'bg_gradient') final List<String>? bgGradient,
    @JsonKey(name: 'bg_color') this.bgColor,
  }) : _bgGradient = bgGradient;

  factory _$StoryReferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryReferenceImplFromJson(json);

  @override
  @JsonKey(name: 'story_id')
  final String storyId;
  @override
  @JsonKey(name: 'business_id')
  final String businessId;
  @override
  @JsonKey(name: 'business_name')
  final String businessName;
  @override
  @JsonKey(name: 'business_avatar')
  final String? businessAvatar;
  @override
  final String? thumbnail;
  @override
  final String? text;
  final List<String>? _bgGradient;
  @override
  @JsonKey(name: 'bg_gradient')
  List<String>? get bgGradient {
    final value = _bgGradient;
    if (value == null) return null;
    if (_bgGradient is EqualUnmodifiableListView) return _bgGradient;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'bg_color')
  final String? bgColor;

  @override
  String toString() {
    return 'StoryReference(storyId: $storyId, businessId: $businessId, businessName: $businessName, businessAvatar: $businessAvatar, thumbnail: $thumbnail, text: $text, bgGradient: $bgGradient, bgColor: $bgColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryReferenceImpl &&
            (identical(other.storyId, storyId) || other.storyId == storyId) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.businessName, businessName) ||
                other.businessName == businessName) &&
            (identical(other.businessAvatar, businessAvatar) ||
                other.businessAvatar == businessAvatar) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(
              other._bgGradient,
              _bgGradient,
            ) &&
            (identical(other.bgColor, bgColor) || other.bgColor == bgColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    storyId,
    businessId,
    businessName,
    businessAvatar,
    thumbnail,
    text,
    const DeepCollectionEquality().hash(_bgGradient),
    bgColor,
  );

  /// Create a copy of StoryReference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryReferenceImplCopyWith<_$StoryReferenceImpl> get copyWith =>
      __$$StoryReferenceImplCopyWithImpl<_$StoryReferenceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryReferenceImplToJson(this);
  }
}

abstract class _StoryReference implements StoryReference {
  const factory _StoryReference({
    @JsonKey(name: 'story_id') required final String storyId,
    @JsonKey(name: 'business_id') required final String businessId,
    @JsonKey(name: 'business_name') required final String businessName,
    @JsonKey(name: 'business_avatar') final String? businessAvatar,
    final String? thumbnail,
    final String? text,
    @JsonKey(name: 'bg_gradient') final List<String>? bgGradient,
    @JsonKey(name: 'bg_color') final String? bgColor,
  }) = _$StoryReferenceImpl;

  factory _StoryReference.fromJson(Map<String, dynamic> json) =
      _$StoryReferenceImpl.fromJson;

  @override
  @JsonKey(name: 'story_id')
  String get storyId;
  @override
  @JsonKey(name: 'business_id')
  String get businessId;
  @override
  @JsonKey(name: 'business_name')
  String get businessName;
  @override
  @JsonKey(name: 'business_avatar')
  String? get businessAvatar;
  @override
  String? get thumbnail;
  @override
  String? get text;
  @override
  @JsonKey(name: 'bg_gradient')
  List<String>? get bgGradient;
  @override
  @JsonKey(name: 'bg_color')
  String? get bgColor;

  /// Create a copy of StoryReference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryReferenceImplCopyWith<_$StoryReferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
