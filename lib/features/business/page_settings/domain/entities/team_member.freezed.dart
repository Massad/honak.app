// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TeamMember _$TeamMemberFromJson(Map<String, dynamic> json) {
  return _TeamMember.fromJson(json);
}

/// @nodoc
mixin _$TeamMember {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_owner')
  bool get isOwner => throw _privateConstructorUsedError;
  List<String> get permissions => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_ids')
  List<String> get locationIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_ids')
  List<String> get serviceIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'joined_at')
  String? get joinedAt => throw _privateConstructorUsedError;

  /// Serializes this TeamMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamMemberCopyWith<TeamMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamMemberCopyWith<$Res> {
  factory $TeamMemberCopyWith(
    TeamMember value,
    $Res Function(TeamMember) then,
  ) = _$TeamMemberCopyWithImpl<$Res, TeamMember>;
  @useResult
  $Res call({
    String id,
    String name,
    String? phone,
    String? role,
    bool active,
    @JsonKey(name: 'is_owner') bool isOwner,
    List<String> permissions,
    @JsonKey(name: 'location_ids') List<String> locationIds,
    @JsonKey(name: 'service_ids') List<String> serviceIds,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'joined_at') String? joinedAt,
  });
}

/// @nodoc
class _$TeamMemberCopyWithImpl<$Res, $Val extends TeamMember>
    implements $TeamMemberCopyWith<$Res> {
  _$TeamMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = freezed,
    Object? role = freezed,
    Object? active = null,
    Object? isOwner = null,
    Object? permissions = null,
    Object? locationIds = null,
    Object? serviceIds = null,
    Object? avatarUrl = freezed,
    Object? joinedAt = freezed,
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
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            role: freezed == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String?,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
            isOwner: null == isOwner
                ? _value.isOwner
                : isOwner // ignore: cast_nullable_to_non_nullable
                      as bool,
            permissions: null == permissions
                ? _value.permissions
                : permissions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            locationIds: null == locationIds
                ? _value.locationIds
                : locationIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            serviceIds: null == serviceIds
                ? _value.serviceIds
                : serviceIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            joinedAt: freezed == joinedAt
                ? _value.joinedAt
                : joinedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TeamMemberImplCopyWith<$Res>
    implements $TeamMemberCopyWith<$Res> {
  factory _$$TeamMemberImplCopyWith(
    _$TeamMemberImpl value,
    $Res Function(_$TeamMemberImpl) then,
  ) = __$$TeamMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? phone,
    String? role,
    bool active,
    @JsonKey(name: 'is_owner') bool isOwner,
    List<String> permissions,
    @JsonKey(name: 'location_ids') List<String> locationIds,
    @JsonKey(name: 'service_ids') List<String> serviceIds,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'joined_at') String? joinedAt,
  });
}

/// @nodoc
class __$$TeamMemberImplCopyWithImpl<$Res>
    extends _$TeamMemberCopyWithImpl<$Res, _$TeamMemberImpl>
    implements _$$TeamMemberImplCopyWith<$Res> {
  __$$TeamMemberImplCopyWithImpl(
    _$TeamMemberImpl _value,
    $Res Function(_$TeamMemberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TeamMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = freezed,
    Object? role = freezed,
    Object? active = null,
    Object? isOwner = null,
    Object? permissions = null,
    Object? locationIds = null,
    Object? serviceIds = null,
    Object? avatarUrl = freezed,
    Object? joinedAt = freezed,
  }) {
    return _then(
      _$TeamMemberImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: freezed == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String?,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
        isOwner: null == isOwner
            ? _value.isOwner
            : isOwner // ignore: cast_nullable_to_non_nullable
                  as bool,
        permissions: null == permissions
            ? _value._permissions
            : permissions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        locationIds: null == locationIds
            ? _value._locationIds
            : locationIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        serviceIds: null == serviceIds
            ? _value._serviceIds
            : serviceIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        joinedAt: freezed == joinedAt
            ? _value.joinedAt
            : joinedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamMemberImpl implements _TeamMember {
  const _$TeamMemberImpl({
    required this.id,
    required this.name,
    this.phone,
    this.role,
    this.active = true,
    @JsonKey(name: 'is_owner') this.isOwner = false,
    final List<String> permissions = const [],
    @JsonKey(name: 'location_ids') final List<String> locationIds = const [],
    @JsonKey(name: 'service_ids') final List<String> serviceIds = const [],
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    @JsonKey(name: 'joined_at') this.joinedAt,
  }) : _permissions = permissions,
       _locationIds = locationIds,
       _serviceIds = serviceIds;

  factory _$TeamMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamMemberImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? phone;
  @override
  final String? role;
  @override
  @JsonKey()
  final bool active;
  @override
  @JsonKey(name: 'is_owner')
  final bool isOwner;
  final List<String> _permissions;
  @override
  @JsonKey()
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  final List<String> _locationIds;
  @override
  @JsonKey(name: 'location_ids')
  List<String> get locationIds {
    if (_locationIds is EqualUnmodifiableListView) return _locationIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locationIds);
  }

  final List<String> _serviceIds;
  @override
  @JsonKey(name: 'service_ids')
  List<String> get serviceIds {
    if (_serviceIds is EqualUnmodifiableListView) return _serviceIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_serviceIds);
  }

  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'joined_at')
  final String? joinedAt;

  @override
  String toString() {
    return 'TeamMember(id: $id, name: $name, phone: $phone, role: $role, active: $active, isOwner: $isOwner, permissions: $permissions, locationIds: $locationIds, serviceIds: $serviceIds, avatarUrl: $avatarUrl, joinedAt: $joinedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamMemberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.isOwner, isOwner) || other.isOwner == isOwner) &&
            const DeepCollectionEquality().equals(
              other._permissions,
              _permissions,
            ) &&
            const DeepCollectionEquality().equals(
              other._locationIds,
              _locationIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._serviceIds,
              _serviceIds,
            ) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    phone,
    role,
    active,
    isOwner,
    const DeepCollectionEquality().hash(_permissions),
    const DeepCollectionEquality().hash(_locationIds),
    const DeepCollectionEquality().hash(_serviceIds),
    avatarUrl,
    joinedAt,
  );

  /// Create a copy of TeamMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamMemberImplCopyWith<_$TeamMemberImpl> get copyWith =>
      __$$TeamMemberImplCopyWithImpl<_$TeamMemberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamMemberImplToJson(this);
  }
}

abstract class _TeamMember implements TeamMember {
  const factory _TeamMember({
    required final String id,
    required final String name,
    final String? phone,
    final String? role,
    final bool active,
    @JsonKey(name: 'is_owner') final bool isOwner,
    final List<String> permissions,
    @JsonKey(name: 'location_ids') final List<String> locationIds,
    @JsonKey(name: 'service_ids') final List<String> serviceIds,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    @JsonKey(name: 'joined_at') final String? joinedAt,
  }) = _$TeamMemberImpl;

  factory _TeamMember.fromJson(Map<String, dynamic> json) =
      _$TeamMemberImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get phone;
  @override
  String? get role;
  @override
  bool get active;
  @override
  @JsonKey(name: 'is_owner')
  bool get isOwner;
  @override
  List<String> get permissions;
  @override
  @JsonKey(name: 'location_ids')
  List<String> get locationIds;
  @override
  @JsonKey(name: 'service_ids')
  List<String> get serviceIds;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  @JsonKey(name: 'joined_at')
  String? get joinedAt;

  /// Create a copy of TeamMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamMemberImplCopyWith<_$TeamMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
