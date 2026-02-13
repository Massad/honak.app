// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SavedPage _$SavedPageFromJson(Map<String, dynamic> json) {
  return _SavedPage.fromJson(json);
}

/// @nodoc
mixin _$SavedPage {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get handle => throw _privateConstructorUsedError;
  @JsonKey(name: 'logo_url')
  String? get logoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  bool get verified => throw _privateConstructorUsedError;
  @JsonKey(name: 'saved_at')
  int? get savedAt => throw _privateConstructorUsedError;

  /// Serializes this SavedPage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SavedPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavedPageCopyWith<SavedPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedPageCopyWith<$Res> {
  factory $SavedPageCopyWith(SavedPage value, $Res Function(SavedPage) then) =
      _$SavedPageCopyWithImpl<$Res, SavedPage>;
  @useResult
  $Res call({
    String id,
    String name,
    String? handle,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'category_name') String? categoryName,
    bool verified,
    @JsonKey(name: 'saved_at') int? savedAt,
  });
}

/// @nodoc
class _$SavedPageCopyWithImpl<$Res, $Val extends SavedPage>
    implements $SavedPageCopyWith<$Res> {
  _$SavedPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavedPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? handle = freezed,
    Object? logoUrl = freezed,
    Object? categoryName = freezed,
    Object? verified = null,
    Object? savedAt = freezed,
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
            handle: freezed == handle
                ? _value.handle
                : handle // ignore: cast_nullable_to_non_nullable
                      as String?,
            logoUrl: freezed == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryName: freezed == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String?,
            verified: null == verified
                ? _value.verified
                : verified // ignore: cast_nullable_to_non_nullable
                      as bool,
            savedAt: freezed == savedAt
                ? _value.savedAt
                : savedAt // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SavedPageImplCopyWith<$Res>
    implements $SavedPageCopyWith<$Res> {
  factory _$$SavedPageImplCopyWith(
    _$SavedPageImpl value,
    $Res Function(_$SavedPageImpl) then,
  ) = __$$SavedPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? handle,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'category_name') String? categoryName,
    bool verified,
    @JsonKey(name: 'saved_at') int? savedAt,
  });
}

/// @nodoc
class __$$SavedPageImplCopyWithImpl<$Res>
    extends _$SavedPageCopyWithImpl<$Res, _$SavedPageImpl>
    implements _$$SavedPageImplCopyWith<$Res> {
  __$$SavedPageImplCopyWithImpl(
    _$SavedPageImpl _value,
    $Res Function(_$SavedPageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SavedPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? handle = freezed,
    Object? logoUrl = freezed,
    Object? categoryName = freezed,
    Object? verified = null,
    Object? savedAt = freezed,
  }) {
    return _then(
      _$SavedPageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        handle: freezed == handle
            ? _value.handle
            : handle // ignore: cast_nullable_to_non_nullable
                  as String?,
        logoUrl: freezed == logoUrl
            ? _value.logoUrl
            : logoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryName: freezed == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String?,
        verified: null == verified
            ? _value.verified
            : verified // ignore: cast_nullable_to_non_nullable
                  as bool,
        savedAt: freezed == savedAt
            ? _value.savedAt
            : savedAt // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SavedPageImpl implements _SavedPage {
  const _$SavedPageImpl({
    required this.id,
    required this.name,
    this.handle,
    @JsonKey(name: 'logo_url') this.logoUrl,
    @JsonKey(name: 'category_name') this.categoryName,
    this.verified = false,
    @JsonKey(name: 'saved_at') this.savedAt,
  });

  factory _$SavedPageImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavedPageImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? handle;
  @override
  @JsonKey(name: 'logo_url')
  final String? logoUrl;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @override
  @JsonKey()
  final bool verified;
  @override
  @JsonKey(name: 'saved_at')
  final int? savedAt;

  @override
  String toString() {
    return 'SavedPage(id: $id, name: $name, handle: $handle, logoUrl: $logoUrl, categoryName: $categoryName, verified: $verified, savedAt: $savedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedPageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.handle, handle) || other.handle == handle) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.verified, verified) ||
                other.verified == verified) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    handle,
    logoUrl,
    categoryName,
    verified,
    savedAt,
  );

  /// Create a copy of SavedPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedPageImplCopyWith<_$SavedPageImpl> get copyWith =>
      __$$SavedPageImplCopyWithImpl<_$SavedPageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SavedPageImplToJson(this);
  }
}

abstract class _SavedPage implements SavedPage {
  const factory _SavedPage({
    required final String id,
    required final String name,
    final String? handle,
    @JsonKey(name: 'logo_url') final String? logoUrl,
    @JsonKey(name: 'category_name') final String? categoryName,
    final bool verified,
    @JsonKey(name: 'saved_at') final int? savedAt,
  }) = _$SavedPageImpl;

  factory _SavedPage.fromJson(Map<String, dynamic> json) =
      _$SavedPageImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get handle;
  @override
  @JsonKey(name: 'logo_url')
  String? get logoUrl;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  bool get verified;
  @override
  @JsonKey(name: 'saved_at')
  int? get savedAt;

  /// Create a copy of SavedPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavedPageImplCopyWith<_$SavedPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
