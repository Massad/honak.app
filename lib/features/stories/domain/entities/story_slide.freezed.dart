// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_slide.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StorySlide _$StorySlideFromJson(Map<String, dynamic> json) {
  return _StorySlide.fromJson(json);
}

/// @nodoc
mixin _$StorySlide {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'text_position')
  String get textPosition => throw _privateConstructorUsedError;
  String get font => throw _privateConstructorUsedError;
  @JsonKey(name: 'text_color')
  String get textColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'text_layers')
  List<TextLayer> get textLayers => throw _privateConstructorUsedError;
  @JsonKey(name: 'bg_color')
  String? get bgColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'bg_gradient')
  List<String>? get bgGradient => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  bool get seen => throw _privateConstructorUsedError;

  /// Serializes this StorySlide to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StorySlide
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StorySlideCopyWith<StorySlide> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorySlideCopyWith<$Res> {
  factory $StorySlideCopyWith(
    StorySlide value,
    $Res Function(StorySlide) then,
  ) = _$StorySlideCopyWithImpl<$Res, StorySlide>;
  @useResult
  $Res call({
    String id,
    String type,
    String? image,
    String? text,
    @JsonKey(name: 'text_position') String textPosition,
    String font,
    @JsonKey(name: 'text_color') String textColor,
    @JsonKey(name: 'text_layers') List<TextLayer> textLayers,
    @JsonKey(name: 'bg_color') String? bgColor,
    @JsonKey(name: 'bg_gradient') List<String>? bgGradient,
    @JsonKey(name: 'created_at') String? createdAt,
    int duration,
    bool seen,
  });
}

/// @nodoc
class _$StorySlideCopyWithImpl<$Res, $Val extends StorySlide>
    implements $StorySlideCopyWith<$Res> {
  _$StorySlideCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StorySlide
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? image = freezed,
    Object? text = freezed,
    Object? textPosition = null,
    Object? font = null,
    Object? textColor = null,
    Object? textLayers = null,
    Object? bgColor = freezed,
    Object? bgGradient = freezed,
    Object? createdAt = freezed,
    Object? duration = null,
    Object? seen = null,
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
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String?,
            text: freezed == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String?,
            textPosition: null == textPosition
                ? _value.textPosition
                : textPosition // ignore: cast_nullable_to_non_nullable
                      as String,
            font: null == font
                ? _value.font
                : font // ignore: cast_nullable_to_non_nullable
                      as String,
            textColor: null == textColor
                ? _value.textColor
                : textColor // ignore: cast_nullable_to_non_nullable
                      as String,
            textLayers: null == textLayers
                ? _value.textLayers
                : textLayers // ignore: cast_nullable_to_non_nullable
                      as List<TextLayer>,
            bgColor: freezed == bgColor
                ? _value.bgColor
                : bgColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            bgGradient: freezed == bgGradient
                ? _value.bgGradient
                : bgGradient // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as int,
            seen: null == seen
                ? _value.seen
                : seen // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StorySlideImplCopyWith<$Res>
    implements $StorySlideCopyWith<$Res> {
  factory _$$StorySlideImplCopyWith(
    _$StorySlideImpl value,
    $Res Function(_$StorySlideImpl) then,
  ) = __$$StorySlideImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    String? image,
    String? text,
    @JsonKey(name: 'text_position') String textPosition,
    String font,
    @JsonKey(name: 'text_color') String textColor,
    @JsonKey(name: 'text_layers') List<TextLayer> textLayers,
    @JsonKey(name: 'bg_color') String? bgColor,
    @JsonKey(name: 'bg_gradient') List<String>? bgGradient,
    @JsonKey(name: 'created_at') String? createdAt,
    int duration,
    bool seen,
  });
}

/// @nodoc
class __$$StorySlideImplCopyWithImpl<$Res>
    extends _$StorySlideCopyWithImpl<$Res, _$StorySlideImpl>
    implements _$$StorySlideImplCopyWith<$Res> {
  __$$StorySlideImplCopyWithImpl(
    _$StorySlideImpl _value,
    $Res Function(_$StorySlideImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StorySlide
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? image = freezed,
    Object? text = freezed,
    Object? textPosition = null,
    Object? font = null,
    Object? textColor = null,
    Object? textLayers = null,
    Object? bgColor = freezed,
    Object? bgGradient = freezed,
    Object? createdAt = freezed,
    Object? duration = null,
    Object? seen = null,
  }) {
    return _then(
      _$StorySlideImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String?,
        text: freezed == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String?,
        textPosition: null == textPosition
            ? _value.textPosition
            : textPosition // ignore: cast_nullable_to_non_nullable
                  as String,
        font: null == font
            ? _value.font
            : font // ignore: cast_nullable_to_non_nullable
                  as String,
        textColor: null == textColor
            ? _value.textColor
            : textColor // ignore: cast_nullable_to_non_nullable
                  as String,
        textLayers: null == textLayers
            ? _value._textLayers
            : textLayers // ignore: cast_nullable_to_non_nullable
                  as List<TextLayer>,
        bgColor: freezed == bgColor
            ? _value.bgColor
            : bgColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        bgGradient: freezed == bgGradient
            ? _value._bgGradient
            : bgGradient // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int,
        seen: null == seen
            ? _value.seen
            : seen // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StorySlideImpl implements _StorySlide {
  const _$StorySlideImpl({
    required this.id,
    this.type = 'text',
    this.image,
    this.text,
    @JsonKey(name: 'text_position') this.textPosition = 'center',
    this.font = 'default',
    @JsonKey(name: 'text_color') this.textColor = '#FFFFFF',
    @JsonKey(name: 'text_layers') final List<TextLayer> textLayers = const [],
    @JsonKey(name: 'bg_color') this.bgColor,
    @JsonKey(name: 'bg_gradient') final List<String>? bgGradient,
    @JsonKey(name: 'created_at') this.createdAt,
    this.duration = 5,
    this.seen = false,
  }) : _textLayers = textLayers,
       _bgGradient = bgGradient;

  factory _$StorySlideImpl.fromJson(Map<String, dynamic> json) =>
      _$$StorySlideImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String type;
  @override
  final String? image;
  @override
  final String? text;
  @override
  @JsonKey(name: 'text_position')
  final String textPosition;
  @override
  @JsonKey()
  final String font;
  @override
  @JsonKey(name: 'text_color')
  final String textColor;
  final List<TextLayer> _textLayers;
  @override
  @JsonKey(name: 'text_layers')
  List<TextLayer> get textLayers {
    if (_textLayers is EqualUnmodifiableListView) return _textLayers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_textLayers);
  }

  @override
  @JsonKey(name: 'bg_color')
  final String? bgColor;
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
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey()
  final int duration;
  @override
  @JsonKey()
  final bool seen;

  @override
  String toString() {
    return 'StorySlide(id: $id, type: $type, image: $image, text: $text, textPosition: $textPosition, font: $font, textColor: $textColor, textLayers: $textLayers, bgColor: $bgColor, bgGradient: $bgGradient, createdAt: $createdAt, duration: $duration, seen: $seen)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorySlideImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.textPosition, textPosition) ||
                other.textPosition == textPosition) &&
            (identical(other.font, font) || other.font == font) &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor) &&
            const DeepCollectionEquality().equals(
              other._textLayers,
              _textLayers,
            ) &&
            (identical(other.bgColor, bgColor) || other.bgColor == bgColor) &&
            const DeepCollectionEquality().equals(
              other._bgGradient,
              _bgGradient,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.seen, seen) || other.seen == seen));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    image,
    text,
    textPosition,
    font,
    textColor,
    const DeepCollectionEquality().hash(_textLayers),
    bgColor,
    const DeepCollectionEquality().hash(_bgGradient),
    createdAt,
    duration,
    seen,
  );

  /// Create a copy of StorySlide
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StorySlideImplCopyWith<_$StorySlideImpl> get copyWith =>
      __$$StorySlideImplCopyWithImpl<_$StorySlideImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StorySlideImplToJson(this);
  }
}

abstract class _StorySlide implements StorySlide {
  const factory _StorySlide({
    required final String id,
    final String type,
    final String? image,
    final String? text,
    @JsonKey(name: 'text_position') final String textPosition,
    final String font,
    @JsonKey(name: 'text_color') final String textColor,
    @JsonKey(name: 'text_layers') final List<TextLayer> textLayers,
    @JsonKey(name: 'bg_color') final String? bgColor,
    @JsonKey(name: 'bg_gradient') final List<String>? bgGradient,
    @JsonKey(name: 'created_at') final String? createdAt,
    final int duration,
    final bool seen,
  }) = _$StorySlideImpl;

  factory _StorySlide.fromJson(Map<String, dynamic> json) =
      _$StorySlideImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String? get image;
  @override
  String? get text;
  @override
  @JsonKey(name: 'text_position')
  String get textPosition;
  @override
  String get font;
  @override
  @JsonKey(name: 'text_color')
  String get textColor;
  @override
  @JsonKey(name: 'text_layers')
  List<TextLayer> get textLayers;
  @override
  @JsonKey(name: 'bg_color')
  String? get bgColor;
  @override
  @JsonKey(name: 'bg_gradient')
  List<String>? get bgGradient;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  int get duration;
  @override
  bool get seen;

  /// Create a copy of StorySlide
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StorySlideImplCopyWith<_$StorySlideImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
