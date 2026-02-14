// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tenant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Tenant _$TenantFromJson(Map<String, dynamic> json) {
  return _Tenant.fromJson(json);
}

/// @nodoc
mixin _$Tenant {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_en')
  String? get nameEn => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'floor_id')
  String get floorId => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_open')
  bool get isOpen => throw _privateConstructorUsedError;
  @JsonKey(name: 'temporarily_closed')
  bool get temporarilyClosed => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_id')
  String? get pageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'logo_url')
  String? get logoUrl => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'linked_at')
  String? get linkedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'invited_at')
  String? get invitedAt => throw _privateConstructorUsedError;

  /// Serializes this Tenant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TenantCopyWith<Tenant> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TenantCopyWith<$Res> {
  factory $TenantCopyWith(Tenant value, $Res Function(Tenant) then) =
      _$TenantCopyWithImpl<$Res, Tenant>;
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'name_en') String? nameEn,
    String category,
    @JsonKey(name: 'floor_id') String floorId,
    String unit,
    @JsonKey(name: 'is_open') bool isOpen,
    @JsonKey(name: 'temporarily_closed') bool temporarilyClosed,
    @JsonKey(name: 'page_id') String? pageId,
    @JsonKey(name: 'logo_url') String? logoUrl,
    List<String> tags,
    @JsonKey(name: 'linked_at') String? linkedAt,
    @JsonKey(name: 'invited_at') String? invitedAt,
  });
}

/// @nodoc
class _$TenantCopyWithImpl<$Res, $Val extends Tenant>
    implements $TenantCopyWith<$Res> {
  _$TenantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = freezed,
    Object? category = null,
    Object? floorId = null,
    Object? unit = null,
    Object? isOpen = null,
    Object? temporarilyClosed = null,
    Object? pageId = freezed,
    Object? logoUrl = freezed,
    Object? tags = null,
    Object? linkedAt = freezed,
    Object? invitedAt = freezed,
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
            nameEn: freezed == nameEn
                ? _value.nameEn
                : nameEn // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            floorId: null == floorId
                ? _value.floorId
                : floorId // ignore: cast_nullable_to_non_nullable
                      as String,
            unit: null == unit
                ? _value.unit
                : unit // ignore: cast_nullable_to_non_nullable
                      as String,
            isOpen: null == isOpen
                ? _value.isOpen
                : isOpen // ignore: cast_nullable_to_non_nullable
                      as bool,
            temporarilyClosed: null == temporarilyClosed
                ? _value.temporarilyClosed
                : temporarilyClosed // ignore: cast_nullable_to_non_nullable
                      as bool,
            pageId: freezed == pageId
                ? _value.pageId
                : pageId // ignore: cast_nullable_to_non_nullable
                      as String?,
            logoUrl: freezed == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            linkedAt: freezed == linkedAt
                ? _value.linkedAt
                : linkedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            invitedAt: freezed == invitedAt
                ? _value.invitedAt
                : invitedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TenantImplCopyWith<$Res> implements $TenantCopyWith<$Res> {
  factory _$$TenantImplCopyWith(
    _$TenantImpl value,
    $Res Function(_$TenantImpl) then,
  ) = __$$TenantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'name_en') String? nameEn,
    String category,
    @JsonKey(name: 'floor_id') String floorId,
    String unit,
    @JsonKey(name: 'is_open') bool isOpen,
    @JsonKey(name: 'temporarily_closed') bool temporarilyClosed,
    @JsonKey(name: 'page_id') String? pageId,
    @JsonKey(name: 'logo_url') String? logoUrl,
    List<String> tags,
    @JsonKey(name: 'linked_at') String? linkedAt,
    @JsonKey(name: 'invited_at') String? invitedAt,
  });
}

/// @nodoc
class __$$TenantImplCopyWithImpl<$Res>
    extends _$TenantCopyWithImpl<$Res, _$TenantImpl>
    implements _$$TenantImplCopyWith<$Res> {
  __$$TenantImplCopyWithImpl(
    _$TenantImpl _value,
    $Res Function(_$TenantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = freezed,
    Object? category = null,
    Object? floorId = null,
    Object? unit = null,
    Object? isOpen = null,
    Object? temporarilyClosed = null,
    Object? pageId = freezed,
    Object? logoUrl = freezed,
    Object? tags = null,
    Object? linkedAt = freezed,
    Object? invitedAt = freezed,
  }) {
    return _then(
      _$TenantImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        nameEn: freezed == nameEn
            ? _value.nameEn
            : nameEn // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        floorId: null == floorId
            ? _value.floorId
            : floorId // ignore: cast_nullable_to_non_nullable
                  as String,
        unit: null == unit
            ? _value.unit
            : unit // ignore: cast_nullable_to_non_nullable
                  as String,
        isOpen: null == isOpen
            ? _value.isOpen
            : isOpen // ignore: cast_nullable_to_non_nullable
                  as bool,
        temporarilyClosed: null == temporarilyClosed
            ? _value.temporarilyClosed
            : temporarilyClosed // ignore: cast_nullable_to_non_nullable
                  as bool,
        pageId: freezed == pageId
            ? _value.pageId
            : pageId // ignore: cast_nullable_to_non_nullable
                  as String?,
        logoUrl: freezed == logoUrl
            ? _value.logoUrl
            : logoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        linkedAt: freezed == linkedAt
            ? _value.linkedAt
            : linkedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        invitedAt: freezed == invitedAt
            ? _value.invitedAt
            : invitedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TenantImpl extends _Tenant {
  const _$TenantImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'name_en') this.nameEn,
    required this.category,
    @JsonKey(name: 'floor_id') required this.floorId,
    required this.unit,
    @JsonKey(name: 'is_open') this.isOpen = true,
    @JsonKey(name: 'temporarily_closed') this.temporarilyClosed = false,
    @JsonKey(name: 'page_id') this.pageId,
    @JsonKey(name: 'logo_url') this.logoUrl,
    final List<String> tags = const [],
    @JsonKey(name: 'linked_at') this.linkedAt,
    @JsonKey(name: 'invited_at') this.invitedAt,
  }) : _tags = tags,
       super._();

  factory _$TenantImpl.fromJson(Map<String, dynamic> json) =>
      _$$TenantImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'name_en')
  final String? nameEn;
  @override
  final String category;
  @override
  @JsonKey(name: 'floor_id')
  final String floorId;
  @override
  final String unit;
  @override
  @JsonKey(name: 'is_open')
  final bool isOpen;
  @override
  @JsonKey(name: 'temporarily_closed')
  final bool temporarilyClosed;
  @override
  @JsonKey(name: 'page_id')
  final String? pageId;
  @override
  @JsonKey(name: 'logo_url')
  final String? logoUrl;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey(name: 'linked_at')
  final String? linkedAt;
  @override
  @JsonKey(name: 'invited_at')
  final String? invitedAt;

  @override
  String toString() {
    return 'Tenant(id: $id, name: $name, nameEn: $nameEn, category: $category, floorId: $floorId, unit: $unit, isOpen: $isOpen, temporarilyClosed: $temporarilyClosed, pageId: $pageId, logoUrl: $logoUrl, tags: $tags, linkedAt: $linkedAt, invitedAt: $invitedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TenantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.floorId, floorId) || other.floorId == floorId) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen) &&
            (identical(other.temporarilyClosed, temporarilyClosed) ||
                other.temporarilyClosed == temporarilyClosed) &&
            (identical(other.pageId, pageId) || other.pageId == pageId) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.linkedAt, linkedAt) ||
                other.linkedAt == linkedAt) &&
            (identical(other.invitedAt, invitedAt) ||
                other.invitedAt == invitedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    nameEn,
    category,
    floorId,
    unit,
    isOpen,
    temporarilyClosed,
    pageId,
    logoUrl,
    const DeepCollectionEquality().hash(_tags),
    linkedAt,
    invitedAt,
  );

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TenantImplCopyWith<_$TenantImpl> get copyWith =>
      __$$TenantImplCopyWithImpl<_$TenantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TenantImplToJson(this);
  }
}

abstract class _Tenant extends Tenant {
  const factory _Tenant({
    required final String id,
    required final String name,
    @JsonKey(name: 'name_en') final String? nameEn,
    required final String category,
    @JsonKey(name: 'floor_id') required final String floorId,
    required final String unit,
    @JsonKey(name: 'is_open') final bool isOpen,
    @JsonKey(name: 'temporarily_closed') final bool temporarilyClosed,
    @JsonKey(name: 'page_id') final String? pageId,
    @JsonKey(name: 'logo_url') final String? logoUrl,
    final List<String> tags,
    @JsonKey(name: 'linked_at') final String? linkedAt,
    @JsonKey(name: 'invited_at') final String? invitedAt,
  }) = _$TenantImpl;
  const _Tenant._() : super._();

  factory _Tenant.fromJson(Map<String, dynamic> json) = _$TenantImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'name_en')
  String? get nameEn;
  @override
  String get category;
  @override
  @JsonKey(name: 'floor_id')
  String get floorId;
  @override
  String get unit;
  @override
  @JsonKey(name: 'is_open')
  bool get isOpen;
  @override
  @JsonKey(name: 'temporarily_closed')
  bool get temporarilyClosed;
  @override
  @JsonKey(name: 'page_id')
  String? get pageId;
  @override
  @JsonKey(name: 'logo_url')
  String? get logoUrl;
  @override
  List<String> get tags;
  @override
  @JsonKey(name: 'linked_at')
  String? get linkedAt;
  @override
  @JsonKey(name: 'invited_at')
  String? get invitedAt;

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TenantImplCopyWith<_$TenantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
