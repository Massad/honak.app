// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PageSettings _$PageSettingsFromJson(Map<String, dynamic> json) {
  return _PageSettings.fromJson(json);
}

/// @nodoc
mixin _$PageSettings {
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'close_reason')
  String? get closeReason => throw _privateConstructorUsedError;
  @JsonKey(name: 'temp_closed_message')
  String? get tempClosedMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'engagement_level')
  String get engagementLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_approval')
  String get orderApproval => throw _privateConstructorUsedError;
  @JsonKey(name: 'return_window_days')
  int get returnWindowDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'return_type')
  String get returnType => throw _privateConstructorUsedError;
  @JsonKey(name: 'return_cost')
  String get returnCost => throw _privateConstructorUsedError;
  @JsonKey(name: 'cancel_window_hours')
  int get cancelWindowHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'no_show_action')
  String get noShowAction => throw _privateConstructorUsedError;
  @JsonKey(name: 'late_cancel_fee_type')
  String get lateCancelFeeType => throw _privateConstructorUsedError;
  @JsonKey(name: 'late_cancel_fee_amount')
  int get lateCancelFeeAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'catalog_strategy')
  String get catalogStrategy => throw _privateConstructorUsedError;
  @JsonKey(name: 'highlight_categories')
  List<String> get highlightCategories => throw _privateConstructorUsedError;
  List<SafetyDisclaimer> get disclaimers => throw _privateConstructorUsedError;
  @JsonKey(name: 'post_booking_steps')
  List<PostBookingStep> get postBookingSteps =>
      throw _privateConstructorUsedError;

  /// Serializes this PageSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PageSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PageSettingsCopyWith<PageSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageSettingsCopyWith<$Res> {
  factory $PageSettingsCopyWith(
    PageSettings value,
    $Res Function(PageSettings) then,
  ) = _$PageSettingsCopyWithImpl<$Res, PageSettings>;
  @useResult
  $Res call({
    String status,
    @JsonKey(name: 'close_reason') String? closeReason,
    @JsonKey(name: 'temp_closed_message') String? tempClosedMessage,
    @JsonKey(name: 'engagement_level') String engagementLevel,
    @JsonKey(name: 'order_approval') String orderApproval,
    @JsonKey(name: 'return_window_days') int returnWindowDays,
    @JsonKey(name: 'return_type') String returnType,
    @JsonKey(name: 'return_cost') String returnCost,
    @JsonKey(name: 'cancel_window_hours') int cancelWindowHours,
    @JsonKey(name: 'no_show_action') String noShowAction,
    @JsonKey(name: 'late_cancel_fee_type') String lateCancelFeeType,
    @JsonKey(name: 'late_cancel_fee_amount') int lateCancelFeeAmount,
    @JsonKey(name: 'catalog_strategy') String catalogStrategy,
    @JsonKey(name: 'highlight_categories') List<String> highlightCategories,
    List<SafetyDisclaimer> disclaimers,
    @JsonKey(name: 'post_booking_steps') List<PostBookingStep> postBookingSteps,
  });
}

/// @nodoc
class _$PageSettingsCopyWithImpl<$Res, $Val extends PageSettings>
    implements $PageSettingsCopyWith<$Res> {
  _$PageSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PageSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? closeReason = freezed,
    Object? tempClosedMessage = freezed,
    Object? engagementLevel = null,
    Object? orderApproval = null,
    Object? returnWindowDays = null,
    Object? returnType = null,
    Object? returnCost = null,
    Object? cancelWindowHours = null,
    Object? noShowAction = null,
    Object? lateCancelFeeType = null,
    Object? lateCancelFeeAmount = null,
    Object? catalogStrategy = null,
    Object? highlightCategories = null,
    Object? disclaimers = null,
    Object? postBookingSteps = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            closeReason: freezed == closeReason
                ? _value.closeReason
                : closeReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            tempClosedMessage: freezed == tempClosedMessage
                ? _value.tempClosedMessage
                : tempClosedMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            engagementLevel: null == engagementLevel
                ? _value.engagementLevel
                : engagementLevel // ignore: cast_nullable_to_non_nullable
                      as String,
            orderApproval: null == orderApproval
                ? _value.orderApproval
                : orderApproval // ignore: cast_nullable_to_non_nullable
                      as String,
            returnWindowDays: null == returnWindowDays
                ? _value.returnWindowDays
                : returnWindowDays // ignore: cast_nullable_to_non_nullable
                      as int,
            returnType: null == returnType
                ? _value.returnType
                : returnType // ignore: cast_nullable_to_non_nullable
                      as String,
            returnCost: null == returnCost
                ? _value.returnCost
                : returnCost // ignore: cast_nullable_to_non_nullable
                      as String,
            cancelWindowHours: null == cancelWindowHours
                ? _value.cancelWindowHours
                : cancelWindowHours // ignore: cast_nullable_to_non_nullable
                      as int,
            noShowAction: null == noShowAction
                ? _value.noShowAction
                : noShowAction // ignore: cast_nullable_to_non_nullable
                      as String,
            lateCancelFeeType: null == lateCancelFeeType
                ? _value.lateCancelFeeType
                : lateCancelFeeType // ignore: cast_nullable_to_non_nullable
                      as String,
            lateCancelFeeAmount: null == lateCancelFeeAmount
                ? _value.lateCancelFeeAmount
                : lateCancelFeeAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            catalogStrategy: null == catalogStrategy
                ? _value.catalogStrategy
                : catalogStrategy // ignore: cast_nullable_to_non_nullable
                      as String,
            highlightCategories: null == highlightCategories
                ? _value.highlightCategories
                : highlightCategories // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            disclaimers: null == disclaimers
                ? _value.disclaimers
                : disclaimers // ignore: cast_nullable_to_non_nullable
                      as List<SafetyDisclaimer>,
            postBookingSteps: null == postBookingSteps
                ? _value.postBookingSteps
                : postBookingSteps // ignore: cast_nullable_to_non_nullable
                      as List<PostBookingStep>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PageSettingsImplCopyWith<$Res>
    implements $PageSettingsCopyWith<$Res> {
  factory _$$PageSettingsImplCopyWith(
    _$PageSettingsImpl value,
    $Res Function(_$PageSettingsImpl) then,
  ) = __$$PageSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String status,
    @JsonKey(name: 'close_reason') String? closeReason,
    @JsonKey(name: 'temp_closed_message') String? tempClosedMessage,
    @JsonKey(name: 'engagement_level') String engagementLevel,
    @JsonKey(name: 'order_approval') String orderApproval,
    @JsonKey(name: 'return_window_days') int returnWindowDays,
    @JsonKey(name: 'return_type') String returnType,
    @JsonKey(name: 'return_cost') String returnCost,
    @JsonKey(name: 'cancel_window_hours') int cancelWindowHours,
    @JsonKey(name: 'no_show_action') String noShowAction,
    @JsonKey(name: 'late_cancel_fee_type') String lateCancelFeeType,
    @JsonKey(name: 'late_cancel_fee_amount') int lateCancelFeeAmount,
    @JsonKey(name: 'catalog_strategy') String catalogStrategy,
    @JsonKey(name: 'highlight_categories') List<String> highlightCategories,
    List<SafetyDisclaimer> disclaimers,
    @JsonKey(name: 'post_booking_steps') List<PostBookingStep> postBookingSteps,
  });
}

/// @nodoc
class __$$PageSettingsImplCopyWithImpl<$Res>
    extends _$PageSettingsCopyWithImpl<$Res, _$PageSettingsImpl>
    implements _$$PageSettingsImplCopyWith<$Res> {
  __$$PageSettingsImplCopyWithImpl(
    _$PageSettingsImpl _value,
    $Res Function(_$PageSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PageSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? closeReason = freezed,
    Object? tempClosedMessage = freezed,
    Object? engagementLevel = null,
    Object? orderApproval = null,
    Object? returnWindowDays = null,
    Object? returnType = null,
    Object? returnCost = null,
    Object? cancelWindowHours = null,
    Object? noShowAction = null,
    Object? lateCancelFeeType = null,
    Object? lateCancelFeeAmount = null,
    Object? catalogStrategy = null,
    Object? highlightCategories = null,
    Object? disclaimers = null,
    Object? postBookingSteps = null,
  }) {
    return _then(
      _$PageSettingsImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        closeReason: freezed == closeReason
            ? _value.closeReason
            : closeReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        tempClosedMessage: freezed == tempClosedMessage
            ? _value.tempClosedMessage
            : tempClosedMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        engagementLevel: null == engagementLevel
            ? _value.engagementLevel
            : engagementLevel // ignore: cast_nullable_to_non_nullable
                  as String,
        orderApproval: null == orderApproval
            ? _value.orderApproval
            : orderApproval // ignore: cast_nullable_to_non_nullable
                  as String,
        returnWindowDays: null == returnWindowDays
            ? _value.returnWindowDays
            : returnWindowDays // ignore: cast_nullable_to_non_nullable
                  as int,
        returnType: null == returnType
            ? _value.returnType
            : returnType // ignore: cast_nullable_to_non_nullable
                  as String,
        returnCost: null == returnCost
            ? _value.returnCost
            : returnCost // ignore: cast_nullable_to_non_nullable
                  as String,
        cancelWindowHours: null == cancelWindowHours
            ? _value.cancelWindowHours
            : cancelWindowHours // ignore: cast_nullable_to_non_nullable
                  as int,
        noShowAction: null == noShowAction
            ? _value.noShowAction
            : noShowAction // ignore: cast_nullable_to_non_nullable
                  as String,
        lateCancelFeeType: null == lateCancelFeeType
            ? _value.lateCancelFeeType
            : lateCancelFeeType // ignore: cast_nullable_to_non_nullable
                  as String,
        lateCancelFeeAmount: null == lateCancelFeeAmount
            ? _value.lateCancelFeeAmount
            : lateCancelFeeAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        catalogStrategy: null == catalogStrategy
            ? _value.catalogStrategy
            : catalogStrategy // ignore: cast_nullable_to_non_nullable
                  as String,
        highlightCategories: null == highlightCategories
            ? _value._highlightCategories
            : highlightCategories // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        disclaimers: null == disclaimers
            ? _value._disclaimers
            : disclaimers // ignore: cast_nullable_to_non_nullable
                  as List<SafetyDisclaimer>,
        postBookingSteps: null == postBookingSteps
            ? _value._postBookingSteps
            : postBookingSteps // ignore: cast_nullable_to_non_nullable
                  as List<PostBookingStep>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PageSettingsImpl implements _PageSettings {
  const _$PageSettingsImpl({
    this.status = 'active',
    @JsonKey(name: 'close_reason') this.closeReason,
    @JsonKey(name: 'temp_closed_message') this.tempClosedMessage,
    @JsonKey(name: 'engagement_level') this.engagementLevel = 'full',
    @JsonKey(name: 'order_approval') this.orderApproval = 'manual',
    @JsonKey(name: 'return_window_days') this.returnWindowDays = 7,
    @JsonKey(name: 'return_type') this.returnType = 'both',
    @JsonKey(name: 'return_cost') this.returnCost = 'free',
    @JsonKey(name: 'cancel_window_hours') this.cancelWindowHours = 24,
    @JsonKey(name: 'no_show_action') this.noShowAction = 'warn',
    @JsonKey(name: 'late_cancel_fee_type') this.lateCancelFeeType = 'none',
    @JsonKey(name: 'late_cancel_fee_amount') this.lateCancelFeeAmount = 0,
    @JsonKey(name: 'catalog_strategy') this.catalogStrategy = 'full_catalog',
    @JsonKey(name: 'highlight_categories')
    final List<String> highlightCategories = const [],
    final List<SafetyDisclaimer> disclaimers = const [],
    @JsonKey(name: 'post_booking_steps')
    final List<PostBookingStep> postBookingSteps = const [],
  }) : _highlightCategories = highlightCategories,
       _disclaimers = disclaimers,
       _postBookingSteps = postBookingSteps;

  factory _$PageSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PageSettingsImplFromJson(json);

  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'close_reason')
  final String? closeReason;
  @override
  @JsonKey(name: 'temp_closed_message')
  final String? tempClosedMessage;
  @override
  @JsonKey(name: 'engagement_level')
  final String engagementLevel;
  @override
  @JsonKey(name: 'order_approval')
  final String orderApproval;
  @override
  @JsonKey(name: 'return_window_days')
  final int returnWindowDays;
  @override
  @JsonKey(name: 'return_type')
  final String returnType;
  @override
  @JsonKey(name: 'return_cost')
  final String returnCost;
  @override
  @JsonKey(name: 'cancel_window_hours')
  final int cancelWindowHours;
  @override
  @JsonKey(name: 'no_show_action')
  final String noShowAction;
  @override
  @JsonKey(name: 'late_cancel_fee_type')
  final String lateCancelFeeType;
  @override
  @JsonKey(name: 'late_cancel_fee_amount')
  final int lateCancelFeeAmount;
  @override
  @JsonKey(name: 'catalog_strategy')
  final String catalogStrategy;
  final List<String> _highlightCategories;
  @override
  @JsonKey(name: 'highlight_categories')
  List<String> get highlightCategories {
    if (_highlightCategories is EqualUnmodifiableListView)
      return _highlightCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_highlightCategories);
  }

  final List<SafetyDisclaimer> _disclaimers;
  @override
  @JsonKey()
  List<SafetyDisclaimer> get disclaimers {
    if (_disclaimers is EqualUnmodifiableListView) return _disclaimers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_disclaimers);
  }

  final List<PostBookingStep> _postBookingSteps;
  @override
  @JsonKey(name: 'post_booking_steps')
  List<PostBookingStep> get postBookingSteps {
    if (_postBookingSteps is EqualUnmodifiableListView)
      return _postBookingSteps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_postBookingSteps);
  }

  @override
  String toString() {
    return 'PageSettings(status: $status, closeReason: $closeReason, tempClosedMessage: $tempClosedMessage, engagementLevel: $engagementLevel, orderApproval: $orderApproval, returnWindowDays: $returnWindowDays, returnType: $returnType, returnCost: $returnCost, cancelWindowHours: $cancelWindowHours, noShowAction: $noShowAction, lateCancelFeeType: $lateCancelFeeType, lateCancelFeeAmount: $lateCancelFeeAmount, catalogStrategy: $catalogStrategy, highlightCategories: $highlightCategories, disclaimers: $disclaimers, postBookingSteps: $postBookingSteps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PageSettingsImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.closeReason, closeReason) ||
                other.closeReason == closeReason) &&
            (identical(other.tempClosedMessage, tempClosedMessage) ||
                other.tempClosedMessage == tempClosedMessage) &&
            (identical(other.engagementLevel, engagementLevel) ||
                other.engagementLevel == engagementLevel) &&
            (identical(other.orderApproval, orderApproval) ||
                other.orderApproval == orderApproval) &&
            (identical(other.returnWindowDays, returnWindowDays) ||
                other.returnWindowDays == returnWindowDays) &&
            (identical(other.returnType, returnType) ||
                other.returnType == returnType) &&
            (identical(other.returnCost, returnCost) ||
                other.returnCost == returnCost) &&
            (identical(other.cancelWindowHours, cancelWindowHours) ||
                other.cancelWindowHours == cancelWindowHours) &&
            (identical(other.noShowAction, noShowAction) ||
                other.noShowAction == noShowAction) &&
            (identical(other.lateCancelFeeType, lateCancelFeeType) ||
                other.lateCancelFeeType == lateCancelFeeType) &&
            (identical(other.lateCancelFeeAmount, lateCancelFeeAmount) ||
                other.lateCancelFeeAmount == lateCancelFeeAmount) &&
            (identical(other.catalogStrategy, catalogStrategy) ||
                other.catalogStrategy == catalogStrategy) &&
            const DeepCollectionEquality().equals(
              other._highlightCategories,
              _highlightCategories,
            ) &&
            const DeepCollectionEquality().equals(
              other._disclaimers,
              _disclaimers,
            ) &&
            const DeepCollectionEquality().equals(
              other._postBookingSteps,
              _postBookingSteps,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    closeReason,
    tempClosedMessage,
    engagementLevel,
    orderApproval,
    returnWindowDays,
    returnType,
    returnCost,
    cancelWindowHours,
    noShowAction,
    lateCancelFeeType,
    lateCancelFeeAmount,
    catalogStrategy,
    const DeepCollectionEquality().hash(_highlightCategories),
    const DeepCollectionEquality().hash(_disclaimers),
    const DeepCollectionEquality().hash(_postBookingSteps),
  );

  /// Create a copy of PageSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PageSettingsImplCopyWith<_$PageSettingsImpl> get copyWith =>
      __$$PageSettingsImplCopyWithImpl<_$PageSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PageSettingsImplToJson(this);
  }
}

abstract class _PageSettings implements PageSettings {
  const factory _PageSettings({
    final String status,
    @JsonKey(name: 'close_reason') final String? closeReason,
    @JsonKey(name: 'temp_closed_message') final String? tempClosedMessage,
    @JsonKey(name: 'engagement_level') final String engagementLevel,
    @JsonKey(name: 'order_approval') final String orderApproval,
    @JsonKey(name: 'return_window_days') final int returnWindowDays,
    @JsonKey(name: 'return_type') final String returnType,
    @JsonKey(name: 'return_cost') final String returnCost,
    @JsonKey(name: 'cancel_window_hours') final int cancelWindowHours,
    @JsonKey(name: 'no_show_action') final String noShowAction,
    @JsonKey(name: 'late_cancel_fee_type') final String lateCancelFeeType,
    @JsonKey(name: 'late_cancel_fee_amount') final int lateCancelFeeAmount,
    @JsonKey(name: 'catalog_strategy') final String catalogStrategy,
    @JsonKey(name: 'highlight_categories')
    final List<String> highlightCategories,
    final List<SafetyDisclaimer> disclaimers,
    @JsonKey(name: 'post_booking_steps')
    final List<PostBookingStep> postBookingSteps,
  }) = _$PageSettingsImpl;

  factory _PageSettings.fromJson(Map<String, dynamic> json) =
      _$PageSettingsImpl.fromJson;

  @override
  String get status;
  @override
  @JsonKey(name: 'close_reason')
  String? get closeReason;
  @override
  @JsonKey(name: 'temp_closed_message')
  String? get tempClosedMessage;
  @override
  @JsonKey(name: 'engagement_level')
  String get engagementLevel;
  @override
  @JsonKey(name: 'order_approval')
  String get orderApproval;
  @override
  @JsonKey(name: 'return_window_days')
  int get returnWindowDays;
  @override
  @JsonKey(name: 'return_type')
  String get returnType;
  @override
  @JsonKey(name: 'return_cost')
  String get returnCost;
  @override
  @JsonKey(name: 'cancel_window_hours')
  int get cancelWindowHours;
  @override
  @JsonKey(name: 'no_show_action')
  String get noShowAction;
  @override
  @JsonKey(name: 'late_cancel_fee_type')
  String get lateCancelFeeType;
  @override
  @JsonKey(name: 'late_cancel_fee_amount')
  int get lateCancelFeeAmount;
  @override
  @JsonKey(name: 'catalog_strategy')
  String get catalogStrategy;
  @override
  @JsonKey(name: 'highlight_categories')
  List<String> get highlightCategories;
  @override
  List<SafetyDisclaimer> get disclaimers;
  @override
  @JsonKey(name: 'post_booking_steps')
  List<PostBookingStep> get postBookingSteps;

  /// Create a copy of PageSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PageSettingsImplCopyWith<_$PageSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SafetyDisclaimer _$SafetyDisclaimerFromJson(Map<String, dynamic> json) {
  return _SafetyDisclaimer.fromJson(json);
}

/// @nodoc
mixin _$SafetyDisclaimer {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this SafetyDisclaimer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SafetyDisclaimer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SafetyDisclaimerCopyWith<SafetyDisclaimer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SafetyDisclaimerCopyWith<$Res> {
  factory $SafetyDisclaimerCopyWith(
    SafetyDisclaimer value,
    $Res Function(SafetyDisclaimer) then,
  ) = _$SafetyDisclaimerCopyWithImpl<$Res, SafetyDisclaimer>;
  @useResult
  $Res call({
    String id,
    String type,
    String title,
    String text,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class _$SafetyDisclaimerCopyWithImpl<$Res, $Val extends SafetyDisclaimer>
    implements $SafetyDisclaimerCopyWith<$Res> {
  _$SafetyDisclaimerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SafetyDisclaimer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? text = null,
    Object? isActive = null,
    Object? sortOrder = null,
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
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SafetyDisclaimerImplCopyWith<$Res>
    implements $SafetyDisclaimerCopyWith<$Res> {
  factory _$$SafetyDisclaimerImplCopyWith(
    _$SafetyDisclaimerImpl value,
    $Res Function(_$SafetyDisclaimerImpl) then,
  ) = __$$SafetyDisclaimerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    String title,
    String text,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class __$$SafetyDisclaimerImplCopyWithImpl<$Res>
    extends _$SafetyDisclaimerCopyWithImpl<$Res, _$SafetyDisclaimerImpl>
    implements _$$SafetyDisclaimerImplCopyWith<$Res> {
  __$$SafetyDisclaimerImplCopyWithImpl(
    _$SafetyDisclaimerImpl _value,
    $Res Function(_$SafetyDisclaimerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SafetyDisclaimer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? text = null,
    Object? isActive = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _$SafetyDisclaimerImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SafetyDisclaimerImpl implements _SafetyDisclaimer {
  const _$SafetyDisclaimerImpl({
    required this.id,
    this.type = 'custom',
    this.title = '',
    required this.text,
    @JsonKey(name: 'is_active') this.isActive = true,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
  });

  factory _$SafetyDisclaimerImpl.fromJson(Map<String, dynamic> json) =>
      _$$SafetyDisclaimerImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey()
  final String title;
  @override
  final String text;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;

  @override
  String toString() {
    return 'SafetyDisclaimer(id: $id, type: $type, title: $title, text: $text, isActive: $isActive, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SafetyDisclaimerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, title, text, isActive, sortOrder);

  /// Create a copy of SafetyDisclaimer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SafetyDisclaimerImplCopyWith<_$SafetyDisclaimerImpl> get copyWith =>
      __$$SafetyDisclaimerImplCopyWithImpl<_$SafetyDisclaimerImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SafetyDisclaimerImplToJson(this);
  }
}

abstract class _SafetyDisclaimer implements SafetyDisclaimer {
  const factory _SafetyDisclaimer({
    required final String id,
    final String type,
    final String title,
    required final String text,
    @JsonKey(name: 'is_active') final bool isActive,
    @JsonKey(name: 'sort_order') final int sortOrder,
  }) = _$SafetyDisclaimerImpl;

  factory _SafetyDisclaimer.fromJson(Map<String, dynamic> json) =
      _$SafetyDisclaimerImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get title;
  @override
  String get text;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;

  /// Create a copy of SafetyDisclaimer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SafetyDisclaimerImplCopyWith<_$SafetyDisclaimerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PostBookingStep _$PostBookingStepFromJson(Map<String, dynamic> json) {
  return _PostBookingStep.fromJson(json);
}

/// @nodoc
mixin _$PostBookingStep {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this PostBookingStep to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostBookingStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostBookingStepCopyWith<PostBookingStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostBookingStepCopyWith<$Res> {
  factory $PostBookingStepCopyWith(
    PostBookingStep value,
    $Res Function(PostBookingStep) then,
  ) = _$PostBookingStepCopyWithImpl<$Res, PostBookingStep>;
  @useResult
  $Res call({
    String id,
    String text,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class _$PostBookingStepCopyWithImpl<$Res, $Val extends PostBookingStep>
    implements $PostBookingStepCopyWith<$Res> {
  _$PostBookingStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostBookingStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? isActive = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PostBookingStepImplCopyWith<$Res>
    implements $PostBookingStepCopyWith<$Res> {
  factory _$$PostBookingStepImplCopyWith(
    _$PostBookingStepImpl value,
    $Res Function(_$PostBookingStepImpl) then,
  ) = __$$PostBookingStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String text,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class __$$PostBookingStepImplCopyWithImpl<$Res>
    extends _$PostBookingStepCopyWithImpl<$Res, _$PostBookingStepImpl>
    implements _$$PostBookingStepImplCopyWith<$Res> {
  __$$PostBookingStepImplCopyWithImpl(
    _$PostBookingStepImpl _value,
    $Res Function(_$PostBookingStepImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostBookingStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? isActive = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _$PostBookingStepImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PostBookingStepImpl implements _PostBookingStep {
  const _$PostBookingStepImpl({
    required this.id,
    required this.text,
    @JsonKey(name: 'is_active') this.isActive = true,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
  });

  factory _$PostBookingStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostBookingStepImplFromJson(json);

  @override
  final String id;
  @override
  final String text;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;

  @override
  String toString() {
    return 'PostBookingStep(id: $id, text: $text, isActive: $isActive, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostBookingStepImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, text, isActive, sortOrder);

  /// Create a copy of PostBookingStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostBookingStepImplCopyWith<_$PostBookingStepImpl> get copyWith =>
      __$$PostBookingStepImplCopyWithImpl<_$PostBookingStepImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PostBookingStepImplToJson(this);
  }
}

abstract class _PostBookingStep implements PostBookingStep {
  const factory _PostBookingStep({
    required final String id,
    required final String text,
    @JsonKey(name: 'is_active') final bool isActive,
    @JsonKey(name: 'sort_order') final int sortOrder,
  }) = _$PostBookingStepImpl;

  factory _PostBookingStep.fromJson(Map<String, dynamic> json) =
      _$PostBookingStepImpl.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;

  /// Create a copy of PostBookingStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostBookingStepImplCopyWith<_$PostBookingStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
