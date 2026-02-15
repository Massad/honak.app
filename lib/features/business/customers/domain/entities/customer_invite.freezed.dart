// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_invite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CustomerInvite _$CustomerInviteFromJson(Map<String, dynamic> json) {
  return _CustomerInvite.fromJson(json);
}

/// @nodoc
mixin _$CustomerInvite {
  String get id => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'package_id')
  String? get packageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'package_name')
  String? get packageName => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  @JsonKey(name: 'sent_at')
  String get sentAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  String? get expiresAt => throw _privateConstructorUsedError;
  InviteStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_id')
  String? get customerId => throw _privateConstructorUsedError;

  /// Serializes this CustomerInvite to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomerInvite
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerInviteCopyWith<CustomerInvite> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerInviteCopyWith<$Res> {
  factory $CustomerInviteCopyWith(
    CustomerInvite value,
    $Res Function(CustomerInvite) then,
  ) = _$CustomerInviteCopyWithImpl<$Res, CustomerInvite>;
  @useResult
  $Res call({
    String id,
    String phone,
    String name,
    @JsonKey(name: 'package_id') String? packageId,
    @JsonKey(name: 'package_name') String? packageName,
    String method,
    @JsonKey(name: 'sent_at') String sentAt,
    @JsonKey(name: 'expires_at') String? expiresAt,
    InviteStatus status,
    @JsonKey(name: 'customer_id') String? customerId,
  });
}

/// @nodoc
class _$CustomerInviteCopyWithImpl<$Res, $Val extends CustomerInvite>
    implements $CustomerInviteCopyWith<$Res> {
  _$CustomerInviteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerInvite
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phone = null,
    Object? name = null,
    Object? packageId = freezed,
    Object? packageName = freezed,
    Object? method = null,
    Object? sentAt = null,
    Object? expiresAt = freezed,
    Object? status = null,
    Object? customerId = freezed,
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
            packageId: freezed == packageId
                ? _value.packageId
                : packageId // ignore: cast_nullable_to_non_nullable
                      as String?,
            packageName: freezed == packageName
                ? _value.packageName
                : packageName // ignore: cast_nullable_to_non_nullable
                      as String?,
            method: null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                      as String,
            sentAt: null == sentAt
                ? _value.sentAt
                : sentAt // ignore: cast_nullable_to_non_nullable
                      as String,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as InviteStatus,
            customerId: freezed == customerId
                ? _value.customerId
                : customerId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CustomerInviteImplCopyWith<$Res>
    implements $CustomerInviteCopyWith<$Res> {
  factory _$$CustomerInviteImplCopyWith(
    _$CustomerInviteImpl value,
    $Res Function(_$CustomerInviteImpl) then,
  ) = __$$CustomerInviteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String phone,
    String name,
    @JsonKey(name: 'package_id') String? packageId,
    @JsonKey(name: 'package_name') String? packageName,
    String method,
    @JsonKey(name: 'sent_at') String sentAt,
    @JsonKey(name: 'expires_at') String? expiresAt,
    InviteStatus status,
    @JsonKey(name: 'customer_id') String? customerId,
  });
}

/// @nodoc
class __$$CustomerInviteImplCopyWithImpl<$Res>
    extends _$CustomerInviteCopyWithImpl<$Res, _$CustomerInviteImpl>
    implements _$$CustomerInviteImplCopyWith<$Res> {
  __$$CustomerInviteImplCopyWithImpl(
    _$CustomerInviteImpl _value,
    $Res Function(_$CustomerInviteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CustomerInvite
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phone = null,
    Object? name = null,
    Object? packageId = freezed,
    Object? packageName = freezed,
    Object? method = null,
    Object? sentAt = null,
    Object? expiresAt = freezed,
    Object? status = null,
    Object? customerId = freezed,
  }) {
    return _then(
      _$CustomerInviteImpl(
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
        packageId: freezed == packageId
            ? _value.packageId
            : packageId // ignore: cast_nullable_to_non_nullable
                  as String?,
        packageName: freezed == packageName
            ? _value.packageName
            : packageName // ignore: cast_nullable_to_non_nullable
                  as String?,
        method: null == method
            ? _value.method
            : method // ignore: cast_nullable_to_non_nullable
                  as String,
        sentAt: null == sentAt
            ? _value.sentAt
            : sentAt // ignore: cast_nullable_to_non_nullable
                  as String,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as InviteStatus,
        customerId: freezed == customerId
            ? _value.customerId
            : customerId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerInviteImpl extends _CustomerInvite {
  const _$CustomerInviteImpl({
    required this.id,
    required this.phone,
    this.name = '',
    @JsonKey(name: 'package_id') this.packageId,
    @JsonKey(name: 'package_name') this.packageName,
    required this.method,
    @JsonKey(name: 'sent_at') required this.sentAt,
    @JsonKey(name: 'expires_at') this.expiresAt,
    required this.status,
    @JsonKey(name: 'customer_id') this.customerId,
  }) : super._();

  factory _$CustomerInviteImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerInviteImplFromJson(json);

  @override
  final String id;
  @override
  final String phone;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey(name: 'package_id')
  final String? packageId;
  @override
  @JsonKey(name: 'package_name')
  final String? packageName;
  @override
  final String method;
  @override
  @JsonKey(name: 'sent_at')
  final String sentAt;
  @override
  @JsonKey(name: 'expires_at')
  final String? expiresAt;
  @override
  final InviteStatus status;
  @override
  @JsonKey(name: 'customer_id')
  final String? customerId;

  @override
  String toString() {
    return 'CustomerInvite(id: $id, phone: $phone, name: $name, packageId: $packageId, packageName: $packageName, method: $method, sentAt: $sentAt, expiresAt: $expiresAt, status: $status, customerId: $customerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerInviteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.packageId, packageId) ||
                other.packageId == packageId) &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    phone,
    name,
    packageId,
    packageName,
    method,
    sentAt,
    expiresAt,
    status,
    customerId,
  );

  /// Create a copy of CustomerInvite
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerInviteImplCopyWith<_$CustomerInviteImpl> get copyWith =>
      __$$CustomerInviteImplCopyWithImpl<_$CustomerInviteImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerInviteImplToJson(this);
  }
}

abstract class _CustomerInvite extends CustomerInvite {
  const factory _CustomerInvite({
    required final String id,
    required final String phone,
    final String name,
    @JsonKey(name: 'package_id') final String? packageId,
    @JsonKey(name: 'package_name') final String? packageName,
    required final String method,
    @JsonKey(name: 'sent_at') required final String sentAt,
    @JsonKey(name: 'expires_at') final String? expiresAt,
    required final InviteStatus status,
    @JsonKey(name: 'customer_id') final String? customerId,
  }) = _$CustomerInviteImpl;
  const _CustomerInvite._() : super._();

  factory _CustomerInvite.fromJson(Map<String, dynamic> json) =
      _$CustomerInviteImpl.fromJson;

  @override
  String get id;
  @override
  String get phone;
  @override
  String get name;
  @override
  @JsonKey(name: 'package_id')
  String? get packageId;
  @override
  @JsonKey(name: 'package_name')
  String? get packageName;
  @override
  String get method;
  @override
  @JsonKey(name: 'sent_at')
  String get sentAt;
  @override
  @JsonKey(name: 'expires_at')
  String? get expiresAt;
  @override
  InviteStatus get status;
  @override
  @JsonKey(name: 'customer_id')
  String? get customerId;

  /// Create a copy of CustomerInvite
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerInviteImplCopyWith<_$CustomerInviteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
