// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return _Conversation.fromJson(json);
}

/// @nodoc
mixin _$Conversation {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_id')
  String get pageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_name')
  String get pageName => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_avatar')
  String? get pageAvatar => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_handle')
  String? get pageHandle => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_id')
  String? get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_name')
  String? get customerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_avatar')
  String? get customerAvatar => throw _privateConstructorUsedError;
  @JsonKey(name: 'request_id')
  String? get requestId => throw _privateConstructorUsedError;
  @JsonKey(name: 'request_status')
  String? get requestStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'request_expires_at')
  int? get requestExpiresAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_message')
  String? get lastMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_message_at')
  int get lastMessageAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_message_from')
  String? get lastMessageFrom => throw _privateConstructorUsedError;
  @JsonKey(name: 'unread_count')
  int get unreadCount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_active_story')
  bool get hasActiveStory => throw _privateConstructorUsedError;
  @JsonKey(name: 'needs_info')
  bool get needsInfo => throw _privateConstructorUsedError;

  /// Serializes this Conversation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationCopyWith<Conversation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationCopyWith<$Res> {
  factory $ConversationCopyWith(
    Conversation value,
    $Res Function(Conversation) then,
  ) = _$ConversationCopyWithImpl<$Res, Conversation>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'page_id') String pageId,
    @JsonKey(name: 'page_name') String pageName,
    @JsonKey(name: 'page_avatar') String? pageAvatar,
    @JsonKey(name: 'page_handle') String? pageHandle,
    @JsonKey(name: 'customer_id') String? customerId,
    @JsonKey(name: 'customer_name') String? customerName,
    @JsonKey(name: 'customer_avatar') String? customerAvatar,
    @JsonKey(name: 'request_id') String? requestId,
    @JsonKey(name: 'request_status') String? requestStatus,
    @JsonKey(name: 'request_expires_at') int? requestExpiresAt,
    @JsonKey(name: 'last_message') String? lastMessage,
    @JsonKey(name: 'last_message_at') int lastMessageAt,
    @JsonKey(name: 'last_message_from') String? lastMessageFrom,
    @JsonKey(name: 'unread_count') int unreadCount,
    String status,
    String type,
    @JsonKey(name: 'has_active_story') bool hasActiveStory,
    @JsonKey(name: 'needs_info') bool needsInfo,
  });
}

/// @nodoc
class _$ConversationCopyWithImpl<$Res, $Val extends Conversation>
    implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pageId = null,
    Object? pageName = null,
    Object? pageAvatar = freezed,
    Object? pageHandle = freezed,
    Object? customerId = freezed,
    Object? customerName = freezed,
    Object? customerAvatar = freezed,
    Object? requestId = freezed,
    Object? requestStatus = freezed,
    Object? requestExpiresAt = freezed,
    Object? lastMessage = freezed,
    Object? lastMessageAt = null,
    Object? lastMessageFrom = freezed,
    Object? unreadCount = null,
    Object? status = null,
    Object? type = null,
    Object? hasActiveStory = null,
    Object? needsInfo = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            pageId: null == pageId
                ? _value.pageId
                : pageId // ignore: cast_nullable_to_non_nullable
                      as String,
            pageName: null == pageName
                ? _value.pageName
                : pageName // ignore: cast_nullable_to_non_nullable
                      as String,
            pageAvatar: freezed == pageAvatar
                ? _value.pageAvatar
                : pageAvatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            pageHandle: freezed == pageHandle
                ? _value.pageHandle
                : pageHandle // ignore: cast_nullable_to_non_nullable
                      as String?,
            customerId: freezed == customerId
                ? _value.customerId
                : customerId // ignore: cast_nullable_to_non_nullable
                      as String?,
            customerName: freezed == customerName
                ? _value.customerName
                : customerName // ignore: cast_nullable_to_non_nullable
                      as String?,
            customerAvatar: freezed == customerAvatar
                ? _value.customerAvatar
                : customerAvatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            requestId: freezed == requestId
                ? _value.requestId
                : requestId // ignore: cast_nullable_to_non_nullable
                      as String?,
            requestStatus: freezed == requestStatus
                ? _value.requestStatus
                : requestStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            requestExpiresAt: freezed == requestExpiresAt
                ? _value.requestExpiresAt
                : requestExpiresAt // ignore: cast_nullable_to_non_nullable
                      as int?,
            lastMessage: freezed == lastMessage
                ? _value.lastMessage
                : lastMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastMessageAt: null == lastMessageAt
                ? _value.lastMessageAt
                : lastMessageAt // ignore: cast_nullable_to_non_nullable
                      as int,
            lastMessageFrom: freezed == lastMessageFrom
                ? _value.lastMessageFrom
                : lastMessageFrom // ignore: cast_nullable_to_non_nullable
                      as String?,
            unreadCount: null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            hasActiveStory: null == hasActiveStory
                ? _value.hasActiveStory
                : hasActiveStory // ignore: cast_nullable_to_non_nullable
                      as bool,
            needsInfo: null == needsInfo
                ? _value.needsInfo
                : needsInfo // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConversationImplCopyWith<$Res>
    implements $ConversationCopyWith<$Res> {
  factory _$$ConversationImplCopyWith(
    _$ConversationImpl value,
    $Res Function(_$ConversationImpl) then,
  ) = __$$ConversationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'page_id') String pageId,
    @JsonKey(name: 'page_name') String pageName,
    @JsonKey(name: 'page_avatar') String? pageAvatar,
    @JsonKey(name: 'page_handle') String? pageHandle,
    @JsonKey(name: 'customer_id') String? customerId,
    @JsonKey(name: 'customer_name') String? customerName,
    @JsonKey(name: 'customer_avatar') String? customerAvatar,
    @JsonKey(name: 'request_id') String? requestId,
    @JsonKey(name: 'request_status') String? requestStatus,
    @JsonKey(name: 'request_expires_at') int? requestExpiresAt,
    @JsonKey(name: 'last_message') String? lastMessage,
    @JsonKey(name: 'last_message_at') int lastMessageAt,
    @JsonKey(name: 'last_message_from') String? lastMessageFrom,
    @JsonKey(name: 'unread_count') int unreadCount,
    String status,
    String type,
    @JsonKey(name: 'has_active_story') bool hasActiveStory,
    @JsonKey(name: 'needs_info') bool needsInfo,
  });
}

/// @nodoc
class __$$ConversationImplCopyWithImpl<$Res>
    extends _$ConversationCopyWithImpl<$Res, _$ConversationImpl>
    implements _$$ConversationImplCopyWith<$Res> {
  __$$ConversationImplCopyWithImpl(
    _$ConversationImpl _value,
    $Res Function(_$ConversationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pageId = null,
    Object? pageName = null,
    Object? pageAvatar = freezed,
    Object? pageHandle = freezed,
    Object? customerId = freezed,
    Object? customerName = freezed,
    Object? customerAvatar = freezed,
    Object? requestId = freezed,
    Object? requestStatus = freezed,
    Object? requestExpiresAt = freezed,
    Object? lastMessage = freezed,
    Object? lastMessageAt = null,
    Object? lastMessageFrom = freezed,
    Object? unreadCount = null,
    Object? status = null,
    Object? type = null,
    Object? hasActiveStory = null,
    Object? needsInfo = null,
  }) {
    return _then(
      _$ConversationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        pageId: null == pageId
            ? _value.pageId
            : pageId // ignore: cast_nullable_to_non_nullable
                  as String,
        pageName: null == pageName
            ? _value.pageName
            : pageName // ignore: cast_nullable_to_non_nullable
                  as String,
        pageAvatar: freezed == pageAvatar
            ? _value.pageAvatar
            : pageAvatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        pageHandle: freezed == pageHandle
            ? _value.pageHandle
            : pageHandle // ignore: cast_nullable_to_non_nullable
                  as String?,
        customerId: freezed == customerId
            ? _value.customerId
            : customerId // ignore: cast_nullable_to_non_nullable
                  as String?,
        customerName: freezed == customerName
            ? _value.customerName
            : customerName // ignore: cast_nullable_to_non_nullable
                  as String?,
        customerAvatar: freezed == customerAvatar
            ? _value.customerAvatar
            : customerAvatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        requestId: freezed == requestId
            ? _value.requestId
            : requestId // ignore: cast_nullable_to_non_nullable
                  as String?,
        requestStatus: freezed == requestStatus
            ? _value.requestStatus
            : requestStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        requestExpiresAt: freezed == requestExpiresAt
            ? _value.requestExpiresAt
            : requestExpiresAt // ignore: cast_nullable_to_non_nullable
                  as int?,
        lastMessage: freezed == lastMessage
            ? _value.lastMessage
            : lastMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastMessageAt: null == lastMessageAt
            ? _value.lastMessageAt
            : lastMessageAt // ignore: cast_nullable_to_non_nullable
                  as int,
        lastMessageFrom: freezed == lastMessageFrom
            ? _value.lastMessageFrom
            : lastMessageFrom // ignore: cast_nullable_to_non_nullable
                  as String?,
        unreadCount: null == unreadCount
            ? _value.unreadCount
            : unreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        hasActiveStory: null == hasActiveStory
            ? _value.hasActiveStory
            : hasActiveStory // ignore: cast_nullable_to_non_nullable
                  as bool,
        needsInfo: null == needsInfo
            ? _value.needsInfo
            : needsInfo // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationImpl extends _Conversation {
  const _$ConversationImpl({
    required this.id,
    @JsonKey(name: 'page_id') required this.pageId,
    @JsonKey(name: 'page_name') required this.pageName,
    @JsonKey(name: 'page_avatar') this.pageAvatar,
    @JsonKey(name: 'page_handle') this.pageHandle,
    @JsonKey(name: 'customer_id') this.customerId,
    @JsonKey(name: 'customer_name') this.customerName,
    @JsonKey(name: 'customer_avatar') this.customerAvatar,
    @JsonKey(name: 'request_id') this.requestId,
    @JsonKey(name: 'request_status') this.requestStatus,
    @JsonKey(name: 'request_expires_at') this.requestExpiresAt,
    @JsonKey(name: 'last_message') this.lastMessage,
    @JsonKey(name: 'last_message_at') required this.lastMessageAt,
    @JsonKey(name: 'last_message_from') this.lastMessageFrom,
    @JsonKey(name: 'unread_count') this.unreadCount = 0,
    this.status = 'active',
    this.type = 'message',
    @JsonKey(name: 'has_active_story') this.hasActiveStory = false,
    @JsonKey(name: 'needs_info') this.needsInfo = false,
  }) : super._();

  factory _$ConversationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'page_id')
  final String pageId;
  @override
  @JsonKey(name: 'page_name')
  final String pageName;
  @override
  @JsonKey(name: 'page_avatar')
  final String? pageAvatar;
  @override
  @JsonKey(name: 'page_handle')
  final String? pageHandle;
  @override
  @JsonKey(name: 'customer_id')
  final String? customerId;
  @override
  @JsonKey(name: 'customer_name')
  final String? customerName;
  @override
  @JsonKey(name: 'customer_avatar')
  final String? customerAvatar;
  @override
  @JsonKey(name: 'request_id')
  final String? requestId;
  @override
  @JsonKey(name: 'request_status')
  final String? requestStatus;
  @override
  @JsonKey(name: 'request_expires_at')
  final int? requestExpiresAt;
  @override
  @JsonKey(name: 'last_message')
  final String? lastMessage;
  @override
  @JsonKey(name: 'last_message_at')
  final int lastMessageAt;
  @override
  @JsonKey(name: 'last_message_from')
  final String? lastMessageFrom;
  @override
  @JsonKey(name: 'unread_count')
  final int unreadCount;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey(name: 'has_active_story')
  final bool hasActiveStory;
  @override
  @JsonKey(name: 'needs_info')
  final bool needsInfo;

  @override
  String toString() {
    return 'Conversation(id: $id, pageId: $pageId, pageName: $pageName, pageAvatar: $pageAvatar, pageHandle: $pageHandle, customerId: $customerId, customerName: $customerName, customerAvatar: $customerAvatar, requestId: $requestId, requestStatus: $requestStatus, requestExpiresAt: $requestExpiresAt, lastMessage: $lastMessage, lastMessageAt: $lastMessageAt, lastMessageFrom: $lastMessageFrom, unreadCount: $unreadCount, status: $status, type: $type, hasActiveStory: $hasActiveStory, needsInfo: $needsInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pageId, pageId) || other.pageId == pageId) &&
            (identical(other.pageName, pageName) ||
                other.pageName == pageName) &&
            (identical(other.pageAvatar, pageAvatar) ||
                other.pageAvatar == pageAvatar) &&
            (identical(other.pageHandle, pageHandle) ||
                other.pageHandle == pageHandle) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerAvatar, customerAvatar) ||
                other.customerAvatar == customerAvatar) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.requestStatus, requestStatus) ||
                other.requestStatus == requestStatus) &&
            (identical(other.requestExpiresAt, requestExpiresAt) ||
                other.requestExpiresAt == requestExpiresAt) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageAt, lastMessageAt) ||
                other.lastMessageAt == lastMessageAt) &&
            (identical(other.lastMessageFrom, lastMessageFrom) ||
                other.lastMessageFrom == lastMessageFrom) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.hasActiveStory, hasActiveStory) ||
                other.hasActiveStory == hasActiveStory) &&
            (identical(other.needsInfo, needsInfo) ||
                other.needsInfo == needsInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    pageId,
    pageName,
    pageAvatar,
    pageHandle,
    customerId,
    customerName,
    customerAvatar,
    requestId,
    requestStatus,
    requestExpiresAt,
    lastMessage,
    lastMessageAt,
    lastMessageFrom,
    unreadCount,
    status,
    type,
    hasActiveStory,
    needsInfo,
  ]);

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      __$$ConversationImplCopyWithImpl<_$ConversationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationImplToJson(this);
  }
}

abstract class _Conversation extends Conversation {
  const factory _Conversation({
    required final String id,
    @JsonKey(name: 'page_id') required final String pageId,
    @JsonKey(name: 'page_name') required final String pageName,
    @JsonKey(name: 'page_avatar') final String? pageAvatar,
    @JsonKey(name: 'page_handle') final String? pageHandle,
    @JsonKey(name: 'customer_id') final String? customerId,
    @JsonKey(name: 'customer_name') final String? customerName,
    @JsonKey(name: 'customer_avatar') final String? customerAvatar,
    @JsonKey(name: 'request_id') final String? requestId,
    @JsonKey(name: 'request_status') final String? requestStatus,
    @JsonKey(name: 'request_expires_at') final int? requestExpiresAt,
    @JsonKey(name: 'last_message') final String? lastMessage,
    @JsonKey(name: 'last_message_at') required final int lastMessageAt,
    @JsonKey(name: 'last_message_from') final String? lastMessageFrom,
    @JsonKey(name: 'unread_count') final int unreadCount,
    final String status,
    final String type,
    @JsonKey(name: 'has_active_story') final bool hasActiveStory,
    @JsonKey(name: 'needs_info') final bool needsInfo,
  }) = _$ConversationImpl;
  const _Conversation._() : super._();

  factory _Conversation.fromJson(Map<String, dynamic> json) =
      _$ConversationImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'page_id')
  String get pageId;
  @override
  @JsonKey(name: 'page_name')
  String get pageName;
  @override
  @JsonKey(name: 'page_avatar')
  String? get pageAvatar;
  @override
  @JsonKey(name: 'page_handle')
  String? get pageHandle;
  @override
  @JsonKey(name: 'customer_id')
  String? get customerId;
  @override
  @JsonKey(name: 'customer_name')
  String? get customerName;
  @override
  @JsonKey(name: 'customer_avatar')
  String? get customerAvatar;
  @override
  @JsonKey(name: 'request_id')
  String? get requestId;
  @override
  @JsonKey(name: 'request_status')
  String? get requestStatus;
  @override
  @JsonKey(name: 'request_expires_at')
  int? get requestExpiresAt;
  @override
  @JsonKey(name: 'last_message')
  String? get lastMessage;
  @override
  @JsonKey(name: 'last_message_at')
  int get lastMessageAt;
  @override
  @JsonKey(name: 'last_message_from')
  String? get lastMessageFrom;
  @override
  @JsonKey(name: 'unread_count')
  int get unreadCount;
  @override
  String get status;
  @override
  String get type;
  @override
  @JsonKey(name: 'has_active_story')
  bool get hasActiveStory;
  @override
  @JsonKey(name: 'needs_info')
  bool get needsInfo;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
